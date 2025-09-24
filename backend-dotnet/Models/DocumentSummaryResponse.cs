namespace DocumentQueryService.Api.Models;

/// <summary>
/// Response model for document summarization
/// </summary>
public class DocumentSummaryResponse
{
    /// <summary>
    /// Generated summary text
    /// </summary>
    public string SummaryText { get; set; } = string.Empty;

    /// <summary>
    /// Time taken to generate the summary in milliseconds
    /// </summary>
    public int SummaryTimeMs { get; set; }
}