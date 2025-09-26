using System;
using System.Diagnostics;
using System.Threading.Tasks;
using DocumentQueryService.Api.Models;
using DocumentQueryService.Api.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

namespace DocumentQueryService.Api.Controllers;

[ApiController]
[Route("v1")]
public class DocumentsController : ControllerBase
{
    private readonly ILogger<DocumentsController> _logger;
    private readonly IDocumentService _documentService;

    public DocumentsController(ILogger<DocumentsController> logger, IDocumentService documentService)
    {
        _logger = logger;
        _documentService = documentService;
    }

    [HttpPost("search")]
    public async Task<ActionResult<DocumentSearchResponse>> SearchDocuments([FromBody] DocumentSearchRequest request)
    {
        try
        {
            var sw = Stopwatch.StartNew();
            var (totalCount, documents) = await _documentService.SearchDocumentsAsync(request);
            sw.Stop();

            return Ok(new DocumentSearchResponse
            {
                Results = documents.ToList(),
                ResultCount = totalCount,
                SearchTimeMs = (int)sw.ElapsedMilliseconds
            });
        }
        catch (ArgumentException ex)
        {
            return BadRequest(new ErrorResponse
            {
                Error = "INVALID_PARAMETER",
                Message = ex.Message
            });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error searching documents");
            return StatusCode(500, new ErrorResponse
            {
                Error = "INTERNAL_ERROR",
                Message = "An unexpected error occurred",
                Details = new Dictionary<string, object>
                {
                    { "error", ex.Message }
                }
            });
        }
    }

    [HttpPost("summary")]
    public async Task<ActionResult<DocumentSummaryResponse>> GenerateSummaries([FromBody] DocumentSummaryRequest request)
    {
        try
        {
            var sw = Stopwatch.StartNew();

            // Get the first document (we'll enhance this for multiple documents later)
            var docId = request.Ids.FirstOrDefault();
            if (string.IsNullOrEmpty(docId))
            {
                throw new ArgumentException("No document IDs provided");
            }

            // Get document details from search
            var (_, documents) = await _documentService.SearchDocumentsAsync(new DocumentSearchRequest { Id = docId });
            if (!documents.Any())
            {
                throw new ArgumentException($"Document not found: {docId}");
            }

            var document = documents[0];

            // If URL is provided, download and extract text
            if (!string.IsNullOrEmpty(document.Url))
            {
                try
                {
                    document.Content = await _documentService.DownloadAndExtractTextAsync(docId, document.Url);
                }
                catch (Exception ex)
                {
                    return BadRequest(new ErrorResponse
                    {
                        Error = "PDF_PROCESSING_ERROR",
                        Message = ex.Message
                    });
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
                document.Model = request.Model;
            }

            // Generate summary
            var summary = await _documentService.SummarizeDocumentAsync(document);
            sw.Stop();

            return Ok(new DocumentSummaryResponse
            {
                SummaryText = summary,
                SummaryTimeMs = (int)sw.ElapsedMilliseconds
            });
        }
        catch (ArgumentException ex)
        {
            return BadRequest(new ErrorResponse
            {
                Error = "INVALID_PARAMETER",
                Message = ex.Message
            });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error generating summaries");
            return StatusCode(500, new ErrorResponse
            {
                Error = "INTERNAL_ERROR",
                Message = "An unexpected error occurred",
                Details = new Dictionary<string, object>
                {
                    { "error", ex.Message }
                }
            });
        }
    }

    [HttpGet("health")]
    public ActionResult<object> HealthCheck()
    {
        return Ok(new { status = "healthy" });
    }
}
