namespace DocQuery.Api.DTOs;

public class DocumentSearchResponse
{
    public IEnumerable<DocumentResult> Results { get; set; } = new List<DocumentResult>();
    public int ResultCount { get; set; }
    public int SearchTimeMs { get; set; }
}

public class DocumentResult
{
    public string Id { get; set; } = null!;
    public string Title { get; set; } = null!;
    public string? Abstract { get; set; }
    public DateTime? DocDate { get; set; }
    public string? DocType { get; set; }
    public string? Language { get; set; }
    public string? Country { get; set; }
}

