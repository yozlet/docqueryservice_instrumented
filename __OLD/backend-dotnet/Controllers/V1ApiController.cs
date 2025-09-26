using DocumentQueryService.Api.Models;
using DocumentQueryService.Api.Services;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;

namespace DocumentQueryService.Api.Controllers;

/// <summary>
/// V1 API controller matching Python backend implementation
/// </summary>
[ApiController]
[Route("v1")]
[Produces("application/json")]
[Tags("V1 API")]
public class V1ApiController : ControllerBase
{
    private readonly IDocumentService _documentService;
    private readonly ILogger<V1ApiController> _logger;

    public V1ApiController(IDocumentService documentService, ILogger<V1ApiController> logger)
    {
        _documentService = documentService;
        _logger = logger;
    }

    /// <summary>
    /// Search for documents based on the provided criteria
    /// </summary>
    /// <param name="searchRequest">Search criteria</param>
    /// <param name="cancellationToken">Cancellation token</param>
    /// <returns>Search results with documents and metadata</returns>
    [HttpPost("search")]
    [ProducesResponseType(typeof(V1DocumentSearchResponse), 200)]
    [ProducesResponseType(typeof(ErrorResponse), 400)]
    [ProducesResponseType(typeof(ErrorResponse), 500)]
    public async Task<ActionResult<V1DocumentSearchResponse>> SearchDocuments(
        [FromBody] V1DocumentSearchRequest searchRequest,
        CancellationToken cancellationToken = default)
    {
        var startTime = Stopwatch.StartNew();

        try
        {
            _logger.LogInformation("Searching documents: searchText='{SearchText}', maxResults={MaxResults}",
                searchRequest.SearchText, searchRequest.MaxResults);

            // Convert V1 request to internal format
            var internalRequest = MapToInternalSearchRequest(searchRequest);

            // Get search results from service
            var response = await _documentService.SearchDocumentsAsync(internalRequest, cancellationToken);

            // Map to V1 response format
            var documents = response.Documents.Values
                .OfType<Document>()
                .ToList();

            var v1Response = new V1DocumentSearchResponse
            {
                Results = documents,
                ResultCount = response.Total,
                SearchTimeMs = (int)startTime.ElapsedMilliseconds
            };

            return Ok(v1Response);
        }
        catch (ArgumentException ex)
        {
            _logger.LogWarning(ex, "Invalid search parameters");
            return BadRequest(new ErrorResponse
            {
                Error = "INVALID_PARAMETER",
                Message = ex.Message
            });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error processing document search request");
            return StatusCode(500, new ErrorResponse
            {
                Error = "INTERNAL_ERROR",
                Message = "An unexpected error occurred",
                Details = new Dictionary<string, object> { { "error", ex.Message } }
            });
        }
    }

    /// <summary>
    /// Generate AI-powered summaries for specified documents
    /// </summary>
    /// <param name="request">Summarization request</param>
    /// <param name="cancellationToken">Cancellation token</param>
    /// <returns>Generated summary</returns>
    [HttpPost("summary")]
    [ProducesResponseType(typeof(DocumentSummaryResponse), 200)]
    [ProducesResponseType(typeof(ErrorResponse), 400)]
    [ProducesResponseType(typeof(ErrorResponse), 500)]
    public async Task<ActionResult<DocumentSummaryResponse>> GenerateSummaries(
        [FromBody] DocumentSummaryRequest request,
        CancellationToken cancellationToken = default)
    {
        var startTime = Stopwatch.StartNew();

        try
        {
            if (request.Ids == null || !request.Ids.Any())
            {
                return BadRequest(new ErrorResponse
                {
                    Error = "INVALID_PARAMETER",
                    Message = "No document IDs provided"
                });
            }

            _logger.LogInformation("Generating summaries for {Count} documents", request.Ids.Count);

            // For now, get the first document (matching Python implementation)
            var docId = request.Ids[0];

            // Get document details
            var document = await _documentService.GetDocumentByIdAsync(docId, cancellationToken);

            if (document == null)
            {
                return BadRequest(new ErrorResponse
                {
                    Error = "INVALID_PARAMETER",
                    Message = $"Document not found: {docId}"
                });
            }

            // Generate summary (placeholder implementation)
            var summary = await GenerateDocumentSummary(document, request.Model);

            var response = new DocumentSummaryResponse
            {
                SummaryText = summary,
                SummaryTimeMs = (int)startTime.ElapsedMilliseconds
            };

            return Ok(response);
        }
        catch (ArgumentException ex)
        {
            _logger.LogWarning(ex, "Invalid summarization parameters");
            return BadRequest(new ErrorResponse
            {
                Error = "INVALID_PARAMETER",
                Message = ex.Message
            });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error processing document summarization request");
            return StatusCode(500, new ErrorResponse
            {
                Error = "INTERNAL_ERROR",
                Message = "An unexpected error occurred",
                Details = new Dictionary<string, object> { { "error", ex.Message } }
            });
        }
    }

    /// <summary>
    /// Health check endpoint
    /// </summary>
    /// <returns>Health status information</returns>
    [HttpGet("health")]
    [ProducesResponseType(typeof(object), 200)]
    public ActionResult<object> HealthCheck()
    {
        try
        {
            return Ok(new { status = "healthy" });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Health check failed");
            return StatusCode(500, new
            {
                status = "unhealthy",
                error = ex.Message
            });
        }
    }

    private DocumentSearchRequest MapToInternalSearchRequest(V1DocumentSearchRequest v1Request)
    {
        return new DocumentSearchRequest
        {
            QueryTerm = v1Request.SearchText,
            CountryExact = v1Request.Country,
            LanguageExact = v1Request.Language,
            StartDate = v1Request.StartDate,
            EndDate = v1Request.EndDate,
            DocumentType = v1Request.DocType,
            MajorDocumentType = v1Request.MajorDocumentType,
            Rows = v1Request.MaxResults,
            Offset = 0
        };
    }

    private async Task<string> GenerateDocumentSummary(Document document, string? model)
    {
        // Placeholder implementation - in a real implementation, this would:
        // 1. Download and extract PDF content if URL is provided
        // 2. Use the specified LLM model to generate a summary
        // 3. Handle different model types (GPT, Claude, etc.)

        await Task.Delay(100); // Simulate processing time

        var content = !string.IsNullOrEmpty(document.Content) ? document.Content : document.Abstract;

        if (string.IsNullOrEmpty(content))
        {
            throw new ArgumentException("No content available for summarization");
        }

        // Simple extractive summary (first 200 characters)
        var summary = content.Length > 200
            ? content.Substring(0, 200) + "..."
            : content;

        return $"Summary generated using {model ?? "gpt-3.5-turbo-16k"}: {summary}";
    }
}