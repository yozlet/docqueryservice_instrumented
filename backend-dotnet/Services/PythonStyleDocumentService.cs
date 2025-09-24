using System.Diagnostics;
using Dapper;
using DocumentQueryService.Api.Models;
using Npgsql;

namespace DocumentQueryService.Api.Services;

/// <summary>
/// Service implementation for Python backend style document operations
/// </summary>
public class PythonStyleDocumentService : IPythonStyleDocumentService
{
    private readonly NpgsqlConnection _connection;
    private readonly ILogger<PythonStyleDocumentService> _logger;
    private readonly IPdfService _pdfService;
    private readonly ILlmService _llmService;
    private static readonly ActivitySource ActivitySource = new("DocumentQueryService.PythonStyleDocumentService");

    public PythonStyleDocumentService(
        NpgsqlConnection connection,
        ILogger<PythonStyleDocumentService> logger,
        IPdfService pdfService,
        ILlmService llmService)
    {
        _connection = connection;
        _logger = logger;
        _pdfService = pdfService;
        _llmService = llmService;
    }

    public async Task<PythonStyleDocumentSearchResponse> SearchDocumentsAsync(PythonStyleDocumentSearchRequest request, CancellationToken cancellationToken = default)
    {
        using var activity = ActivitySource.StartActivity("search_documents");
        var stopwatch = Stopwatch.StartNew();

        activity?.SetTag("search_request", System.Text.Json.JsonSerializer.Serialize(request));

        try
        {
            // Build query
            var (whereClause, parameters) = BuildWhereClause(request);

            // Get total count
            var countSql = $"SELECT COUNT(*) FROM documents {whereClause}";
            var totalCount = await _connection.QuerySingleAsync<int>(countSql, parameters);

            // Get documents with limit
            var sql = $@"
                SELECT
                    id, title, docdt as document_date, abstract, docty as document_type,
                    majdocty as major_document_type, volnb as volume_number, totvolnb as total_volume_number,
                    url, lang as language, country, author, publisher,
                    created_at, updated_at
                FROM documents
                {whereClause}
                LIMIT {request.MaxResults}";

            var result = await _connection.QueryAsync(sql, parameters);
            var documents = new List<DocumentWithContent>();

            foreach (var row in result)
            {
                var doc = new DocumentWithContent
                {
                    Id = row.id,
                    Title = row.title,
                    Abstract = row.abstract,
                    DocumentDate = row.document_date,
                    DocumentType = row.document_type,
                    MajorDocumentType = row.major_document_type,
                    VolumeNumber = row.volume_number,
                    TotalVolumeNumber = row.total_volume_number,
                    Url = row.url,
                    Language = row.language,
                    Country = row.country,
                    Author = row.author,
                    Publisher = row.publisher,
                    CreatedAt = row.created_at,
                    UpdatedAt = row.updated_at,
                    Model = LLMModel.GPT35_TURBO // Default model
                };
                documents.Add(doc);
            }

            stopwatch.Stop();

            return new PythonStyleDocumentSearchResponse
            {
                Results = documents,
                ResultCount = totalCount,
                SearchTimeMs = (int)stopwatch.ElapsedMilliseconds
            };
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error searching documents");
            activity?.SetStatus(ActivityStatusCode.Error, ex.Message);
            throw new InvalidOperationException($"Database error: {ex.Message}", ex);
        }
    }

    public async Task<DocumentSummaryResponse> GenerateSummaryAsync(DocumentSummaryRequest request, CancellationToken cancellationToken = default)
    {
        using var activity = ActivitySource.StartActivity("generate_summary");
        var stopwatch = Stopwatch.StartNew();

        try
        {
            // Get the first document (enhance later for multiple documents)
            var docId = request.Ids.FirstOrDefault();
            if (string.IsNullOrEmpty(docId))
            {
                throw new ArgumentException("No document IDs provided");
            }

            activity?.SetTag("document.id", docId);

            // Get document details from search
            var searchRequest = new PythonStyleDocumentSearchRequest { Id = docId };
            var searchResponse = await SearchDocumentsAsync(searchRequest, cancellationToken);

            if (!searchResponse.Results.Any())
            {
                throw new ArgumentException($"Document not found: {docId}");
            }

            var document = searchResponse.Results.First();

            // If URL is provided, download and extract text
            if (!string.IsNullOrEmpty(document.Url))
            {
                try
                {
                    document.Content = await _pdfService.DownloadAndExtractTextAsync(docId, document.Url, cancellationToken);
                }
                catch (Exception ex)
                {
                    _logger.LogWarning(ex, "Failed to download/extract PDF content for document {DocId}", docId);
                    // Continue with abstract if PDF processing fails
                }
            }

            // If no content available, use abstract
            if (string.IsNullOrEmpty(document.Content) && !string.IsNullOrEmpty(document.Abstract))
            {
                document.Content = document.Abstract;
            }

            if (string.IsNullOrEmpty(document.Content))
            {
                throw new ArgumentException("No content available for summarization");
            }

            // Update model if specified in request
            if (!string.IsNullOrEmpty(request.Model))
            {
                document.Model = LLMModelExtensions.FromModelName(request.Model);
            }

            activity?.SetTag("model", document.Model.ToModelName());

            // Generate summary
            var summary = await _llmService.SummarizeAsync(document, cancellationToken);

            stopwatch.Stop();

            return new DocumentSummaryResponse
            {
                SummaryText = summary,
                SummaryTimeMs = (int)stopwatch.ElapsedMilliseconds
            };
        }
        catch (ArgumentException)
        {
            throw; // Re-throw validation errors
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error generating summary");
            activity?.SetStatus(ActivityStatusCode.Error, ex.Message);
            throw new InvalidOperationException($"Summary generation failed: {ex.Message}", ex);
        }
    }

    private static (string whereClause, DynamicParameters parameters) BuildWhereClause(PythonStyleDocumentSearchRequest request)
    {
        var conditions = new List<string> { "1=1" };
        var parameters = new DynamicParameters();

        // ID search takes priority
        if (!string.IsNullOrEmpty(request.Id))
        {
            conditions.Add("id = @id");
            parameters.Add("id", request.Id);
        }
        else
        {
            if (!string.IsNullOrEmpty(request.SearchText))
            {
                conditions.Add("(title ILIKE @search_text OR abstract ILIKE @search_text)");
                parameters.Add("search_text", $"%{request.SearchText}%");
            }

            if (!string.IsNullOrEmpty(request.Title))
            {
                conditions.Add("title ILIKE @title");
                parameters.Add("title", $"%{request.Title}%");
            }

            if (!string.IsNullOrEmpty(request.Abstract))
            {
                conditions.Add("abstract ILIKE @abstract");
                parameters.Add("abstract", $"%{request.Abstract}%");
            }

            if (!string.IsNullOrEmpty(request.DocType))
            {
                conditions.Add("docty = @document_type");
                parameters.Add("document_type", request.DocType);
            }

            if (!string.IsNullOrEmpty(request.MajorDocumentType))
            {
                conditions.Add("majdocty = @major_document_type");
                parameters.Add("major_document_type", request.MajorDocumentType);
            }

            if (!string.IsNullOrEmpty(request.Language))
            {
                conditions.Add("lang = @language");
                parameters.Add("language", request.Language);
            }

            if (!string.IsNullOrEmpty(request.Country))
            {
                conditions.Add("country = @country");
                parameters.Add("country", request.Country);
            }

            if (request.StartDate.HasValue)
            {
                conditions.Add("created_at >= @start_date");
                parameters.Add("start_date", request.StartDate.Value);
            }

            if (request.EndDate.HasValue)
            {
                conditions.Add("created_at <= @end_date");
                parameters.Add("end_date", request.EndDate.Value);
            }
        }

        var whereClause = $"WHERE {string.Join(" AND ", conditions)}";
        return (whereClause, parameters);
    }
}