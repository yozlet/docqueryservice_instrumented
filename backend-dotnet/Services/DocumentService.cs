using System;
using System.IO;
using System.Net.Http;
using System.Threading.Tasks;
using System.Data;
using System.Diagnostics;
using DocumentQueryService.Api.Models;
using iText.Kernel.Pdf;
using iText.Kernel.Pdf.Canvas.Parser;
using iText.Kernel.Pdf.Canvas.Parser.Listener;
using Microsoft.Extensions.Logging;
using Npgsql;
using System.Collections.Generic;
using System.Text;
using System.Net;

namespace DocumentQueryService.Api.Services;

public class DocumentService : IDocumentService
{
    private readonly NpgsqlConnection _connection;
    private readonly HttpClient _httpClient;
    private readonly ILogger<DocumentService> _logger;
    private readonly ILLMConfig _llmConfig;
    private static readonly ActivitySource ActivitySource = new("DocumentQueryService.DocumentService");
    private static readonly string SummarizationPrompt = @"You are a helpful assistant that creates comprehensive yet concise summaries of documents.
Focus on the main points, key findings, and important conclusions.
If the document appears to be a report or research paper, include methodology and results.

Please summarize the following document:

{0}

Summary:";
    private readonly int _maxTokens;

    public DocumentService(IHttpClientFactory httpClientFactory, NpgsqlConnection connection, ILogger<DocumentService> logger, ILLMConfig llmConfig)
    {
        _connection = connection;
        _httpClient = httpClientFactory.CreateClient("DocumentService");
        _logger = logger;
        _llmConfig = llmConfig;
        _maxTokens = int.Parse(Environment.GetEnvironmentVariable("MAX_TOKENS") ?? "1000");
    }

    public async Task<(int totalCount, Document[] documents)> SearchDocumentsAsync(DocumentSearchRequest request)
    {
        using var activity = ActivitySource.StartActivity("DocumentService.SearchDocuments");
        try
        {
            var query = @"
                SELECT 
                    id, title, docdt as document_date, abstract, docty as document_type,
                    majdocty as major_document_type, volnb as volume_number, totvolnb as total_volume_number,
                    url, lang as language, country, author, publisher,
                    created_at, updated_at
                FROM documents
                WHERE 1=1";

            var parametersList = new List<(string name, object value)>();
            var paramIndex = 1;

            // Add search conditions
            if (!string.IsNullOrEmpty(request.Id))
            {
                query += $" AND id = @p{paramIndex}";
                parametersList.Add(($"@p{paramIndex++}", request.Id));
                activity?.SetTag("id", request.Id);
            }
            else
            {
                if (!string.IsNullOrEmpty(request.SearchText))
                {
                    query += $" AND (title ILIKE @p{paramIndex} OR abstract ILIKE @p{paramIndex})";
                    parametersList.Add(($"@p{paramIndex++}", $"%{request.SearchText}%"));
                    activity?.SetTag("search_text", request.SearchText);
                }

                if (!string.IsNullOrEmpty(request.Title))
                {
                    query += $" AND title ILIKE @p{paramIndex}";
                    parametersList.Add(($"@p{paramIndex++}", $"%{request.Title}%"));
                    activity?.SetTag("title", request.Title);
                }

                if (!string.IsNullOrEmpty(request.Abstract))
                {
                    query += $" AND abstract ILIKE @p{paramIndex}";
                    parametersList.Add(($"@p{paramIndex++}", $"%{request.Abstract}%"));
                    activity?.SetTag("abstract", request.Abstract);
                }

                if (!string.IsNullOrEmpty(request.DocType))
                {
                    query += $" AND docty = @p{paramIndex}";
                    parametersList.Add(($"@p{paramIndex++}", request.DocType));
                    activity?.SetTag("document_type", request.DocType);
                }

                if (!string.IsNullOrEmpty(request.MajorDocumentType))
                {
                    query += $" AND majdocty = @p{paramIndex}";
                    parametersList.Add(($"@p{paramIndex++}", request.MajorDocumentType));
                    activity?.SetTag("major_document_type", request.MajorDocumentType);
                }

                if (!string.IsNullOrEmpty(request.Language))
                {
                    query += $" AND lang = @p{paramIndex}";
                    parametersList.Add(($"@p{paramIndex++}", request.Language));
                    activity?.SetTag("language", request.Language);
                }

                if (!string.IsNullOrEmpty(request.Country))
                {
                    query += $" AND country = @p{paramIndex}";
                    parametersList.Add(($"@p{paramIndex++}", request.Country));
                    activity?.SetTag("country", request.Country);
                }

                if (request.StartDate.HasValue)
                {
                    query += $" AND created_at >= @p{paramIndex}";
                    parametersList.Add(($"@p{paramIndex++}", request.StartDate.Value));
                    activity?.SetTag("start_date", request.StartDate.Value.ToString("O"));
                }

                if (request.EndDate.HasValue)
                {
                    query += $" AND created_at <= @p{paramIndex}";
                    parametersList.Add(($"@p{paramIndex++}", request.EndDate.Value));
                    activity?.SetTag("end_date", request.EndDate.Value.ToString("O"));
                }
            }

            // Get total count
            var countQuery = $"SELECT COUNT(*) FROM ({query}) as subquery";

            // Add limit to the main query
            query += $" LIMIT {request.MaxResults}";

            await _connection.OpenAsync();

            // Get total count
            int totalCount;
            await using (var cmd = new NpgsqlCommand(countQuery, _connection))
            {
                foreach (var (name, value) in parametersList)
                {
                    cmd.Parameters.AddWithValue(name, value);
                }
                totalCount = Convert.ToInt32(await cmd.ExecuteScalarAsync());
            }

            // Get matching documents
            var documents = new List<Document>();
            await using (var cmd = new NpgsqlCommand(query, _connection))
            {
                foreach (var (name, value) in parametersList)
                {
                    cmd.Parameters.AddWithValue(name, value);
                }
                await using var reader = await cmd.ExecuteReaderAsync();
                while (await reader.ReadAsync())
                {
                    documents.Add(new Document
                    {
                        Id = reader.GetString(reader.GetOrdinal("id")),
                        Title = reader.GetString(reader.GetOrdinal("title")),
                        Abstract = reader.IsDBNull(reader.GetOrdinal("abstract")) ? null : reader.GetString(reader.GetOrdinal("abstract")),
                        DocumentDate = reader.IsDBNull(reader.GetOrdinal("document_date")) ? null : reader.GetDateTime(reader.GetOrdinal("document_date")),
                        DocumentType = reader.IsDBNull(reader.GetOrdinal("document_type")) ? null : reader.GetString(reader.GetOrdinal("document_type")),
                        MajorDocumentType = reader.IsDBNull(reader.GetOrdinal("major_document_type")) ? null : reader.GetString(reader.GetOrdinal("major_document_type")),
                        VolumeNumber = reader.IsDBNull(reader.GetOrdinal("volume_number")) ? null : reader.GetInt32(reader.GetOrdinal("volume_number")),
                        TotalVolumeNumber = reader.IsDBNull(reader.GetOrdinal("total_volume_number")) ? null : reader.GetInt32(reader.GetOrdinal("total_volume_number")),
                        Url = reader.IsDBNull(reader.GetOrdinal("url")) ? null : reader.GetString(reader.GetOrdinal("url")),
                        Language = reader.IsDBNull(reader.GetOrdinal("language")) ? null : reader.GetString(reader.GetOrdinal("language")),
                        Country = reader.IsDBNull(reader.GetOrdinal("country")) ? null : reader.GetString(reader.GetOrdinal("country")),
                        Author = reader.IsDBNull(reader.GetOrdinal("author")) ? null : reader.GetString(reader.GetOrdinal("author")),
                        Publisher = reader.IsDBNull(reader.GetOrdinal("publisher")) ? null : reader.GetString(reader.GetOrdinal("publisher")),
                        CreatedAt = reader.GetDateTime(reader.GetOrdinal("created_at")),
                        UpdatedAt = reader.GetDateTime(reader.GetOrdinal("updated_at"))
                    });
                }
            }

            return (totalCount, documents.ToArray());
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error searching documents");
            activity?.SetStatus(ActivityStatusCode.Error, ex.Message);
            throw;
        }
    }

    public async Task<string> SummarizeDocumentAsync(Document document)
    {
        using var activity = ActivitySource.StartActivity("DocumentService.SummarizeDocument");
        try
        {
            // Prepare text for summarization
            var textToSummarize = PrepareText(document);
            if (string.IsNullOrEmpty(textToSummarize))
            {
                throw new ArgumentException("No content provided for summarization");
            }

            activity?.SetTag("document_id", document.Id);
            activity?.SetTag("document_type", document.DocumentType);
            activity?.SetTag("model", document.Model);

            // Generate summary using the configured LLM
            var prompt = string.Format(SummarizationPrompt, textToSummarize);
            var summary = await _llmConfig.GenerateCompletionAsync(prompt, document.Model);

            return summary.Trim();
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error summarizing document");
            activity?.SetStatus(ActivityStatusCode.Error, ex.Message);
            throw;
        }
    }

    public async Task<string> DownloadAndExtractTextAsync(string docId, string url)
    {
        using var activity = ActivitySource.StartActivity("DocumentService.DownloadAndExtractText");
        try
        {
            activity?.SetTag("doc_id", docId);
            activity?.SetTag("url", url);
            _logger.LogInformation("[{DocId}] received request to extract text from {Url}", docId, url);

            // Validate URL
            if (!url.EndsWith(".pdf", StringComparison.OrdinalIgnoreCase))
            {
                throw new ArgumentException("URL does not point to a PDF file");
            }

            // Create a request with proper headers
            using var request = new HttpRequestMessage(HttpMethod.Get, url);
            request.Headers.Add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36");
            request.Headers.Add("Accept", "application/pdf");
            request.Headers.Add("Accept-Language", "en-US,en;q=0.9");

            // Create temp file path
            var tempFile = Path.GetTempFileName();
            try
            {
                // Download the PDF
                using var downloadSpan = ActivitySource.StartActivity("download_pdf");
                var response = await _httpClient.SendAsync(request);

                // Handle redirects manually if needed
                if (response.StatusCode == HttpStatusCode.Found || response.StatusCode == HttpStatusCode.MovedPermanently)
                {
                    var redirectUrl = response.Headers.Location?.ToString();
                    if (string.IsNullOrEmpty(redirectUrl))
                    {
                        throw new InvalidOperationException("Redirect URL not found in response headers");
                    }

                    _logger.LogInformation("Following redirect to {RedirectUrl}", redirectUrl);
                    using var redirectRequest = new HttpRequestMessage(HttpMethod.Get, redirectUrl);
                    redirectRequest.Headers.Add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36");
                    redirectRequest.Headers.Add("Accept", "application/pdf");
                    redirectRequest.Headers.Add("Accept-Language", "en-US,en;q=0.9");
                    redirectRequest.Headers.Add("Referer", url);

                    response = await _httpClient.SendAsync(redirectRequest);
                }

                response.EnsureSuccessStatusCode();

                // Check content type
                var contentType = response.Content.Headers.ContentType?.MediaType ?? string.Empty;
                if (!contentType.Contains("application/pdf", StringComparison.OrdinalIgnoreCase))
                {
                    throw new InvalidOperationException($"Invalid content type: {contentType}");
                }

                // Save to temp file
                await using (var fileStream = File.Create(tempFile))
                {
                    _logger.LogDebug("save file started");
                    await response.Content.CopyToAsync(fileStream);
                }

                // Extract text
                using var extractSpan = ActivitySource.StartActivity("extract_text");
                _logger.LogDebug("extracting file..");
                using var pdfReader = new PdfReader(tempFile);
                using var pdfDocument = new PdfDocument(pdfReader);
                var strategy = new LocationTextExtractionStrategy();
                var textBuilder = new StringBuilder();
                var tokens = 0;

                for (int i = 1; i <= pdfDocument.GetNumberOfPages(); i++)
                {
                    var page = pdfDocument.GetPage(i);
                    string currentText = PdfTextExtractor.GetTextFromPage(page, strategy);
                    textBuilder.AppendLine(currentText);

                    // Count tokens (words) and check limit
                    tokens += currentText.Split((char[])null, StringSplitOptions.RemoveEmptyEntries).Length;
                    if (tokens > _maxTokens)
                    {
                        _logger.LogInformation("Reached token limit of {MaxTokens}, stopping extraction", _maxTokens);
                        break;
                    }
                }

                var text = textBuilder.ToString().Trim();
                _logger.LogDebug("extracted {TokenCount} tokens from {CharCount} characters", tokens, text.Length);
                return text;
            }
            finally
            {
                // Clean up temp file
                if (File.Exists(tempFile))
                {
                    File.Delete(tempFile);
                }
            }
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error downloading and extracting text from PDF");
            activity?.SetStatus(ActivityStatusCode.Error, ex.Message);
            throw;
        }
    }

    private static string PrepareText(Document document)
    {
        var parts = new List<string>
        {
            $"Title: {document.Title}"
        };

        if (!string.IsNullOrEmpty(document.Abstract))
        {
            parts.Add($"Abstract: {document.Abstract}");
        }

        if (!string.IsNullOrEmpty(document.Content))
        {
            parts.Add(document.Content);
        }

        return string.Join("\n\n", parts);
    }
}