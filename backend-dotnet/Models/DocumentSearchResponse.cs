using System.Collections.Generic;
using System.Text.Json.Serialization;

namespace DocumentQueryService.Api.Models;

public class DocumentSearchResponse
{
    [JsonPropertyName("results")]
    public List<Document> Results { get; set; } = new();

    [JsonPropertyName("result_count")]
    public int ResultCount { get; set; }

    [JsonPropertyName("search_time_ms")]
    public int SearchTimeMs { get; set; }
}