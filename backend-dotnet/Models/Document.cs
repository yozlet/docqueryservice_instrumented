using System;

namespace DocumentQueryService.Api.Models;

public class Document
{
    public string Id { get; set; } = string.Empty;
    public string Title { get; set; } = string.Empty;
    public string? Abstract { get; set; }
    public DateTime? DocumentDate { get; set; }
    public string? DocumentType { get; set; }
    public string? MajorDocumentType { get; set; }
    public int? VolumeNumber { get; set; }
    public int? TotalVolumeNumber { get; set; }
    public string? Url { get; set; }
    public string? Language { get; set; }
    public string? Country { get; set; }
    public string? Author { get; set; }
    public string? Publisher { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime UpdatedAt { get; set; }
    public string? Content { get; set; }
    public string? Model { get; set; }
}
