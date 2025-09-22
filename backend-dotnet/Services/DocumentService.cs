using System.Diagnostics;
using System.Text;
using Dapper;
using DocumentQueryService.Api.Models;
using Microsoft.Data.SqlClient;

namespace DocumentQueryService.Api.Services;

/// <summary>
/// Service implementation for document operations using SQL Server and Dapper
/// </summary>
public class DocumentService : IDocumentService
{
    private readonly SqlConnection _connection;
    private readonly ILogger<DocumentService> _logger;
    private static readonly ActivitySource ActivitySource = new("DocumentQueryService.DocumentService");

    public DocumentService(SqlConnection connection, ILogger<DocumentService> logger)
    {
        _connection = connection;
        _logger = logger;
    }

    public async Task<DocumentSearchResponse> SearchDocumentsAsync(DocumentSearchRequest request, CancellationToken cancellationToken = default)
    {
        using var activity = ActivitySource.StartActivity("SearchDocuments");
        var stopwatch = Stopwatch.StartNew();
        
        activity?.SetTag("search.query", request.QueryTerm);
        activity?.SetTag("search.rows", request.Rows);
        activity?.SetTag("search.offset", request.Offset);

        try
        {
            var (whereClause, parameters) = BuildWhereClause(request);
            var fieldsList = BuildFieldsList(request.Fields);
            var fullTextUsed = !string.IsNullOrEmpty(request.QueryTerm);

            // Get total count
            var countSql = $"SELECT COUNT(*) FROM documents {whereClause}";
            var totalCount = await _connection.QuerySingleAsync<int>(countSql, parameters);

            // Get documents with pagination
            var sql = $@"
                SELECT {fieldsList}
                FROM documents 
                {whereClause}
                ORDER BY created_at DESC
                OFFSET @Offset ROWS FETCH NEXT @Rows ROWS ONLY";

            parameters.Add("Offset", request.Offset);
            parameters.Add("Rows", request.Rows);

            var documents = await _connection.QueryAsync<Document>(sql, parameters);

            stopwatch.Stop();

            // Build documents dictionary with document IDs as keys (World Bank API format)
            var documentsDict = new Dictionary<string, object>();
            foreach (var doc in documents)
            {
                // Use document ID as key, prefix with 'D' to match World Bank API format
                var key = $"D{doc.Id}";
                documentsDict[key] = doc;
            }

            // Calculate page number from offset and rows
            var page = request.Rows > 0 ? (request.Offset / request.Rows) + 1 : 1;

            var response = new DocumentSearchResponse
            {
                Total = totalCount,
                Rows = request.Rows,
                Os = request.Offset,
                Page = page,
                Documents = documentsDict
            };

            activity?.SetTag("search.results_count", documentsDict.Count);
            activity?.SetTag("search.total_count", response.Total);
            activity?.SetTag("search.query_time_ms", stopwatch.ElapsedMilliseconds);

            _logger.LogInformation("Search completed: {ResultCount}/{TotalCount} results in {QueryTime}ms", 
                documentsDict.Count, response.Total, stopwatch.ElapsedMilliseconds);

            return response;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error searching documents");
            activity?.SetStatus(ActivityStatusCode.Error, ex.Message);
            throw;
        }
    }

    public async Task<Document?> GetDocumentByIdAsync(string id, CancellationToken cancellationToken = default)
    {
        using var activity = ActivitySource.StartActivity("GetDocumentById");
        activity?.SetTag("document.id", id);

        try
        {
            const string sql = @"
                SELECT id, title, abstract, docdt as DocumentDate, docty as DocumentType, 
                       majdocty as MajorDocumentType, volnb as VolumeNumber, totvolnb as TotalVolumeNumber,
                       url, lang as Language, country, author, publisher, created_at as CreatedAt, updated_at as UpdatedAt
                FROM documents 
                WHERE id = @Id";

            var document = await _connection.QuerySingleOrDefaultAsync<Document>(sql, new { Id = id });
            
            activity?.SetTag("document.found", document != null);
            
            return document;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving document {DocumentId}", id);
            activity?.SetStatus(ActivityStatusCode.Error, ex.Message);
            throw;
        }
    }

    public async Task<Dictionary<string, List<FacetItem>>> GetSearchFacetsAsync(string? query = null, CancellationToken cancellationToken = default)
    {
        using var activity = ActivitySource.StartActivity("GetSearchFacets");
        
        try
        {
            var facets = new Dictionary<string, List<FacetItem>>();

            // Get country facets
            var countrySql = @"
                SELECT country as Value, COUNT(*) as Count 
                FROM documents 
                WHERE country IS NOT NULL AND country != ''
                GROUP BY country 
                ORDER BY COUNT(*) DESC";
            
            var countries = await _connection.QueryAsync<FacetItem>(countrySql);
            facets["countries"] = countries.ToList();

            // Get language facets  
            var languageSql = @"
                SELECT lang as Value, COUNT(*) as Count 
                FROM documents 
                WHERE lang IS NOT NULL AND lang != ''
                GROUP BY lang 
                ORDER BY COUNT(*) DESC";
                
            var languages = await _connection.QueryAsync<FacetItem>(languageSql);
            facets["languages"] = languages.ToList();

            // Get document type facets
            var docTypeSql = @"
                SELECT majdocty as Value, COUNT(*) as Count 
                FROM documents 
                WHERE majdocty IS NOT NULL AND majdocty != ''
                GROUP BY majdocty 
                ORDER BY COUNT(*) DESC";
                
            var docTypes = await _connection.QueryAsync<FacetItem>(docTypeSql);
            facets["document_types"] = docTypes.ToList();

            return facets;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving search facets");
            activity?.SetStatus(ActivityStatusCode.Error, ex.Message);
            throw;
        }
    }

    public async Task<object> GetHealthStatusAsync(CancellationToken cancellationToken = default)
    {
        using var activity = ActivitySource.StartActivity("GetHealthStatus");
        
        try
        {
            var stopwatch = Stopwatch.StartNew();
            
            // Test database connection
            const string sql = "SELECT COUNT(*) FROM documents";
            var documentCount = await _connection.QuerySingleAsync<int>(sql);
            
            stopwatch.Stop();

            var status = new
            {
                status = "healthy",
                database = new
                {
                    connected = true,
                    document_count = documentCount,
                    response_time_ms = stopwatch.ElapsedMilliseconds
                },
                timestamp = DateTime.UtcNow,
                version = "1.0.0"
            };

            activity?.SetTag("health.status", "healthy");
            activity?.SetTag("health.document_count", documentCount);
            
            return status;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Health check failed");
            activity?.SetStatus(ActivityStatusCode.Error, ex.Message);
            
            return new
            {
                status = "unhealthy",
                database = new
                {
                    connected = false,
                    error = ex.Message
                },
                timestamp = DateTime.UtcNow
            };
        }
    }

    private static (string whereClause, DynamicParameters parameters) BuildWhereClause(DocumentSearchRequest request)
    {
        var conditions = new List<string>();
        var parameters = new DynamicParameters();

        // Full-text search
        if (!string.IsNullOrEmpty(request.QueryTerm))
        {
            // Try full-text search first, fall back to LIKE
            conditions.Add("(title LIKE @QueryPattern OR abstract LIKE @QueryPattern)");
            parameters.Add("QueryPattern", $"%{request.QueryTerm}%");
        }

        // Exact filters
        if (!string.IsNullOrEmpty(request.CountryExact))
        {
            conditions.Add("country = @Country");
            parameters.Add("Country", request.CountryExact);
        }

        if (!string.IsNullOrEmpty(request.LanguageExact))
        {
            conditions.Add("lang = @Language");
            parameters.Add("Language", request.LanguageExact);
        }

        if (!string.IsNullOrEmpty(request.DocumentType))
        {
            conditions.Add("docty = @DocumentType");
            parameters.Add("DocumentType", request.DocumentType);
        }

        if (!string.IsNullOrEmpty(request.MajorDocumentType))
        {
            conditions.Add("majdocty = @MajorDocumentType");
            parameters.Add("MajorDocumentType", request.MajorDocumentType);
        }

        // Date range filters
        if (request.StartDate.HasValue)
        {
            conditions.Add("docdt >= @StartDate");
            parameters.Add("StartDate", request.StartDate.Value);
        }

        if (request.EndDate.HasValue)
        {
            conditions.Add("docdt <= @EndDate");
            parameters.Add("EndDate", request.EndDate.Value);
        }

        var whereClause = conditions.Count > 0 ? $"WHERE {string.Join(" AND ", conditions)}" : "";
        return (whereClause, parameters);
    }

    private static string BuildFieldsList(string? fields)
    {
        if (string.IsNullOrEmpty(fields))
        {
            return @"id, title, abstract, docdt as DocumentDate, docty as DocumentType, 
                     majdocty as MajorDocumentType, volnb as VolumeNumber, totvolnb as TotalVolumeNumber,
                     url, lang as Language, country, author, publisher, created_at as CreatedAt, updated_at as UpdatedAt";
        }

        // Map requested fields to database columns
        var fieldMap = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase)
        {
            ["id"] = "id",
            ["title"] = "title", 
            ["abstract"] = "abstract",
            ["docdt"] = "docdt as DocumentDate",
            ["docty"] = "docty as DocumentType",
            ["majdocty"] = "majdocty as MajorDocumentType",
            ["volnb"] = "volnb as VolumeNumber",
            ["totvolnb"] = "totvolnb as TotalVolumeNumber",
            ["url"] = "url",
            ["lang"] = "lang as Language",
            ["country"] = "country",
            ["author"] = "author",
            ["publisher"] = "publisher"
        };

        var requestedFields = fields.Split(',', StringSplitOptions.RemoveEmptyEntries)
            .Select(f => f.Trim())
            .Where(f => fieldMap.ContainsKey(f))
            .Select(f => fieldMap[f])
            .ToList();

        // Always include id
        if (!requestedFields.Any(f => f.StartsWith("id")))
        {
            requestedFields.Insert(0, "id");
        }

        return string.Join(", ", requestedFields);
    }

    private static Dictionary<string, object> BuildAppliedFilters(DocumentSearchRequest request)
    {
        var filters = new Dictionary<string, object>();

        if (!string.IsNullOrEmpty(request.QueryTerm))
            filters["query_term"] = request.QueryTerm;
        if (!string.IsNullOrEmpty(request.CountryExact))
            filters["country"] = request.CountryExact;
        if (!string.IsNullOrEmpty(request.LanguageExact))
            filters["language"] = request.LanguageExact;
        if (!string.IsNullOrEmpty(request.DocumentType))
            filters["document_type"] = request.DocumentType;
        if (!string.IsNullOrEmpty(request.MajorDocumentType))
            filters["major_document_type"] = request.MajorDocumentType;
        if (request.StartDate.HasValue)
            filters["start_date"] = request.StartDate.Value.ToString("yyyy-MM-dd");
        if (request.EndDate.HasValue)
            filters["end_date"] = request.EndDate.Value.ToString("yyyy-MM-dd");

        return filters;
    }
}