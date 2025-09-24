using DocQuery.Api.DTOs;
using DocQuery.Api.Services;
using Microsoft.AspNetCore.Mvc;

namespace DocQuery.Api.Controllers;

[ApiController]
[Route("v1/[controller]")]
public class SummariesController : ControllerBase
{
    private readonly ISummaryService _summaryService;
    private readonly ILogger<SummariesController> _logger;

    public SummariesController(ISummaryService summaryService, ILogger<SummariesController> logger)
    {
        _summaryService = summaryService;
        _logger = logger;
    }

    [HttpPost]
    [ProducesResponseType(typeof(DocumentSummaryResponse), StatusCodes.Status200OK)]
    [ProducesResponseType(typeof(ProblemDetails), StatusCodes.Status400BadRequest)]
    [ProducesResponseType(typeof(ProblemDetails), StatusCodes.Status404NotFound)]
    [ProducesResponseType(typeof(ProblemDetails), StatusCodes.Status500InternalServerError)]
    public async Task<ActionResult<DocumentSummaryResponse>> GenerateSummaries([FromBody] DocumentSummaryRequest request)
    {
        try
        {
            var response = await _summaryService.GenerateSummariesAsync(request);
            return Ok(response);
        }
        catch (KeyNotFoundException ex)
        {
            return NotFound(new ProblemDetails
            {
                Status = 404,
                Title = "Not Found",
                Detail = ex.Message
            });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error generating summaries");
            return StatusCode(500, new ProblemDetails
            {
                Status = 500,
                Title = "Internal Server Error",
                Detail = "An error occurred while generating summaries"
            });
        }
    }
}

