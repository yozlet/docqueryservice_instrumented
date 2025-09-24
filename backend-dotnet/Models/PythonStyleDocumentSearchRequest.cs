using System.ComponentModel.DataAnnotations;

namespace DocumentQueryService.Api.Models;

/// <summary>
/// Request model for document search (Python backend style)
/// </summary>
public class PythonStyleDocumentSearchRequest
{
    /// <summary>
    /// Search by document ID
    /// </summary>
    public string? Id { get; set; }

    /// <summary>
    /// Search by document title or abstract
    /// </summary>
    public string? SearchText { get; set; }

    /// <summary>
    /// Search by document title
    /// </summary>
    public string? Title { get; set; }

    /// <summary>
    /// Search by document abstract
    /// </summary>
    public string? Abstract { get; set; }

    /// <summary>
    /// Filter by document type
    /// </summary>
    public string? DocType { get; set; }

    /// <summary>
    /// Filter by major document type
    /// </summary>
    public string? MajorDocumentType { get; set; }

    /// <summary>
    /// Filter by language code
    /// </summary>
    public string? Language { get; set; }

    /// <summary>
    /// Filter by country
    /// </summary>
    public string? Country { get; set; }

    /// <summary>
    /// Filter by start date
    /// </summary>
    public DateTime? StartDate { get; set; }

    /// <summary>
    /// Filter by end date
    /// </summary>
    public DateTime? EndDate { get; set; }

    /// <summary>
    /// Maximum number of results to return (default: 3)
    /// </summary>
    [Range(1, int.MaxValue)]
    public int MaxResults { get; set; } = 3;
}