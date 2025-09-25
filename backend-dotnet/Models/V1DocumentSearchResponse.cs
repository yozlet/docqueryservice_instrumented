using System.ComponentModel.DataAnnotations;

namespace DocumentQueryService.Api.Models;

/// <summary>
/// Document search response model matching Python backend implementation
/// </summary>
public class V1DocumentSearchResponse
{
    /// <summary>
    /// List of matching documents
    /// </summary>
    [Required]
    public List<Document> Results { get; set; } = new();

    /// <summary>
    /// Total number of matching documents
    /// </summary>
    [Required]
    public int ResultCount { get; set; }

    /// <summary>
    /// Time taken to perform the search in milliseconds
    /// </summary>
    [Required]
    public int SearchTimeMs { get; set; }
}