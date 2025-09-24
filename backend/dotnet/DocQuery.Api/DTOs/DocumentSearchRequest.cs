namespace DocQuery.Api.DTOs;

public class DocumentSearchRequest
{
    public string? SearchText { get; set; }
    public DateTime? StartDate { get; set; }
    public DateTime? EndDate { get; set; }
    public string? DocType { get; set; }
    public string? Language { get; set; }
    public string? Country { get; set; }
}

