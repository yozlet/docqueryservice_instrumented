using DocumentQueryService.Api.Models;
using DocumentQueryService.Api.Services;
using Microsoft.AspNetCore.Mvc;
using System.ComponentModel.DataAnnotations;

namespace DocumentQueryService.Api.Controllers;

/// <summary>
/// Python backend style API controller for document search and summarization
/// </summary>
[ApiController]
[Route("v1")]
[Produces("application/json")]
[Tags("Python Style API")]
public class PythonStyleController : ControllerBase
{
    private readonly IPythonStyleDocumentService _documentService;
    private readonly ILogger<PythonStyleController> _logger;

    public PythonStyleController(IPythonStyleDocumentService documentService, ILogger<PythonStyleController> logger)
    {
        _documentService = documentService;
        _logger = logger;
    }

    /// <summary>
    /// Search for documents based on the provided criteria
    /// </summary>
    /// <param name="request">Document search request</param>
    /// <param name="cancellationToken">Cancellation token</param>
    /// <returns>Search results with documents and metadata</returns>
    [HttpPost("search")]
    [ProducesResponseType(typeof(PythonStyleDocumentSearchResponse), 200)]
    [ProducesResponseType(typeof(ErrorResponse), 400)]
    [ProducesResponseType(typeof(ErrorResponse), 500)]
    public async Task<ActionResult<PythonStyleDocumentSearchResponse>> SearchDocuments(
        [FromBody] PythonStyleDocumentSearchRequest request,
        CancellationToken cancellationToken = default)
    {
        try
        {
            var response = await _documentService.SearchDocumentsAsync(request, cancellationToken);
            return Ok(response);
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
            _logger.LogError(ex, "Error processing document search request");
            return StatusCode(500, new ErrorResponse
            {
                Error = "INTERNAL_ERROR",
                Message = "An unexpected error occurred",
                Details = new Dictionary<string, object> { ["error"] = ex.Message }
            });
        }
    }

    /// <summary>
    /// Generate AI-powered summaries for specified documents
    /// </summary>
    /// <param name="request">Document summary request</param>
    /// <param name="cancellationToken">Cancellation token</param>
    /// <returns>Generated summary response</returns>
    [HttpPost("summary")]
    [ProducesResponseType(typeof(DocumentSummaryResponse), 200)]
    [ProducesResponseType(typeof(ErrorResponse), 400)]
    [ProducesResponseType(typeof(ErrorResponse), 500)]
    public async Task<ActionResult<DocumentSummaryResponse>> GenerateSummaries(
        [FromBody] DocumentSummaryRequest request,
        CancellationToken cancellationToken = default)
    {
        try
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(new ErrorResponse
                {
                    Error = "INVALID_PARAMETER",
                    Message = "Invalid request parameters"
                });
            }

            var response = await _documentService.GenerateSummaryAsync(request, cancellationToken);
            return Ok(response);
        }
        catch (ArgumentException ex)
        {
            return BadRequest(new ErrorResponse
            {
                Error = "INVALID_PARAMETER",
                Message = ex.Message
            });
        }
        catch (InvalidOperationException ex) when (ex.Message.Contains("PDF"))
        {
            return BadRequest(new ErrorResponse
            {
                Error = "PDF_PROCESSING_ERROR",
                Message = ex.Message
            });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error processing summary request");
            return StatusCode(500, new ErrorResponse
            {
                Error = "INTERNAL_ERROR",
                Message = "An unexpected error occurred",
                Details = new Dictionary<string, object> { ["error"] = ex.Message }
            });
        }
    }

    /// <summary>
    /// Health check endpoint
    /// </summary>
    /// <returns>Health status information</returns>
    [HttpGet("health")]
    [ProducesResponseType(typeof(object), 200)]
    public ActionResult<object> GetHealth()
    {
        return Ok(new { status = "healthy" });
    }
}