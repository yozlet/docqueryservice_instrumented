namespace DocQuery.Api.DTOs;

public class DocumentSummaryRequest
{
    public IEnumerable<string> Ids { get; set; } = new List<string>();
    public string? Model { get; set; } = "gpt-4";
    public Dictionary<string, string>? ModelOptions { get; set; }
}

