using System.Collections.Generic;

namespace DocumentQueryService.Api.Models;

public class DocumentSearchResponse
{
    public List<Document> Results { get; set; } = new();
    public int ResultCount { get; set; }
    public int SearchTimeMs { get; set; }
}
