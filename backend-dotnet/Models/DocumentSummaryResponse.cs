using System.Text.Json.Serialization;

namespace DocumentQueryService.Api.Models;

public class DocumentSummaryResponse
{
    [JsonPropertyName("summary_text")]
    public string SummaryText { get; set; } = string.Empty;

    [JsonPropertyName("summary_time_ms")]
    public int SummaryTimeMs { get; set; }
}