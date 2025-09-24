namespace DocQuery.Api.DTOs;

public class DocumentSummaryResponse
{
    public string SummaryText { get; set; } = null!;
    public int SummaryTimeMs { get; set; }
}

