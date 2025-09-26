namespace DocumentQueryService.Api.Models;

public class DocumentSummaryResponse
{
    public string SummaryText { get; set; } = string.Empty;
    public int SummaryTimeMs { get; set; }
}
