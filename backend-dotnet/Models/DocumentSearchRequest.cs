using System;

namespace DocumentQueryService.Api.Models;

public class DocumentSearchRequest
{
    public string? Id { get; set; }
    public string? SearchText { get; set; }
    public string? Title { get; set; }
    public string? Abstract { get; set; }
    public string? DocType { get; set; }
    public string? MajorDocumentType { get; set; }
    public string? Language { get; set; }
    public string? Country { get; set; }
    public DateTime? StartDate { get; set; }
    public DateTime? EndDate { get; set; }
    public int MaxResults { get; set; } = 3;
}
