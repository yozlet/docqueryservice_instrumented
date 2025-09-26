using System;
using System.Text.Json.Serialization;

namespace DocumentQueryService.Api.Models;

public class Document
{
    [JsonPropertyName("id")]
    public string Id { get; set; } = string.Empty;

    [JsonPropertyName("title")]
    public string Title { get; set; } = string.Empty;

    [JsonPropertyName("abstract")]
    public string? Abstract { get; set; }

    [JsonPropertyName("document_date")]
    public DateTime? DocumentDate { get; set; }

    [JsonPropertyName("document_type")]
    public string? DocumentType { get; set; }

    [JsonPropertyName("major_document_type")]
    public string? MajorDocumentType { get; set; }

    [JsonPropertyName("volume_number")]
    public int? VolumeNumber { get; set; }

    [JsonPropertyName("total_volume_number")]
    public int? TotalVolumeNumber { get; set; }

    [JsonPropertyName("url")]
    public string? Url { get; set; }

    [JsonPropertyName("language")]
    public string? Language { get; set; }

    [JsonPropertyName("country")]
    public string? Country { get; set; }

    [JsonPropertyName("author")]
    public string? Author { get; set; }

    [JsonPropertyName("publisher")]
    public string? Publisher { get; set; }

    [JsonPropertyName("created_at")]
    public DateTime CreatedAt { get; set; }

    [JsonPropertyName("updated_at")]
    public DateTime UpdatedAt { get; set; }

    [JsonPropertyName("content")]
    public string? Content { get; set; }

    [JsonPropertyName("model")]
    public string? Model { get; set; }
}