using System.ComponentModel.DataAnnotations;

namespace DocumentQueryService.Api.Models;

/// <summary>
/// Request model for document summarization
/// </summary>
public class DocumentSummaryRequest
{
    /// <summary>
    /// List of document IDs to summarize
    /// </summary>
    [Required]
    public List<string> Ids { get; set; } = new();

    /// <summary>
    /// AI model to use for summarization
    /// </summary>
    public string? Model { get; set; }

    /// <summary>
    /// Additional options for the AI model
    /// </summary>
    public Dictionary<string, string>? ModelOptions { get; set; }
}