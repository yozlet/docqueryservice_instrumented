using System.ComponentModel.DataAnnotations;

namespace DocumentQueryService.Api.Models;

/// <summary>
/// Document search request parameters following World Bank API style
/// </summary>
public class DocumentSearchRequest
{
    /// <summary>
    /// Response format (json, xml) - defaults to json
    /// </summary>
    public string Format { get; set; } = "json";

    /// <summary>
    /// Full-text search query term (qterm)
    /// </summary>
    public string? QueryTerm { get; set; }

    /// <summary>
    /// Comma-separated list of fields to return (fl)
    /// </summary>
    public string? Fields { get; set; }

    /// <summary>
    /// Number of results per page (rows) - max 100, default 10
    /// </summary>
    [Range(1, 100)]
    public int Rows { get; set; } = 10;

    /// <summary>
    /// Offset/starting record number for pagination (os)
    /// </summary>
    [Range(0, int.MaxValue)]
    public int Offset { get; set; } = 0;

    /// <summary>
    /// Exact country match (count_exact)
    /// </summary>
    public string? CountryExact { get; set; }

    /// <summary>
    /// Exact language match (lang_exact)
    /// </summary>
    public string? LanguageExact { get; set; }

    /// <summary>
    /// Start date filter (strdate) in YYYY-MM-DD format
    /// </summary>
    public DateTime? StartDate { get; set; }

    /// <summary>
    /// End date filter (enddate) in YYYY-MM-DD format
    /// </summary>
    public DateTime? EndDate { get; set; }

    /// <summary>
    /// Document type filter
    /// </summary>
    public string? DocumentType { get; set; }

    /// <summary>
    /// Major document type filter
    /// </summary>
    public string? MajorDocumentType { get; set; }
}