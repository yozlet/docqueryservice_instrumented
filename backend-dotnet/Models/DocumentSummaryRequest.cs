using System.Collections.Generic;

namespace DocumentQueryService.Api.Models;

public class DocumentSummaryRequest
{
    public List<string> Ids { get; set; } = new();
    public string? Model { get; set; }
    public Dictionary<string, string>? ModelOptions { get; set; }
}
