namespace DocumentQueryService.Api.Models;

/// <summary>
/// Represents a document in the World Bank-style document repository
/// </summary>
public class Document
{
    /// <summary>
    /// Unique document identifier
    /// </summary>
    public string Id { get; set; } = string.Empty;

    /// <summary>
    /// Document title
    /// </summary>
    public string Title { get; set; } = string.Empty;

    /// <summary>
    /// Document abstract or summary
    /// </summary>
    public string? Abstract { get; set; }

    /// <summary>
    /// Document date (docdt)
    /// </summary>
    public DateTime? DocumentDate { get; set; }

    /// <summary>
    /// Document type
    /// </summary>
    public string? DocumentType { get; set; }

    /// <summary>
    /// Major document type category
    /// </summary>
    public string? MajorDocumentType { get; set; }

    /// <summary>
    /// Volume number
    /// </summary>
    public int? VolumeNumber { get; set; }

    /// <summary>
    /// Total volume number
    /// </summary>
    public int? TotalVolumeNumber { get; set; }

    /// <summary>
    /// Document URL
    /// </summary>
    public string? Url { get; set; }

    /// <summary>
    /// Language code
    /// </summary>
    public string? Language { get; set; }

    /// <summary>
    /// Country
    /// </summary>
    public string? Country { get; set; }

    /// <summary>
    /// Author information
    /// </summary>
    public string? Author { get; set; }

    /// <summary>
    /// Publisher information
    /// </summary>
    public string? Publisher { get; set; }

    /// <summary>
    /// Creation timestamp
    /// </summary>
    public DateTime CreatedAt { get; set; }

    /// <summary>
    /// Last update timestamp
    /// </summary>
    public DateTime UpdatedAt { get; set; }

    /// <summary>
    /// Document content for summarization
    /// </summary>
    public string? Content { get; set; }

    /// <summary>
    /// LLM model to use for processing
    /// </summary>
    public string? Model { get; set; }
}