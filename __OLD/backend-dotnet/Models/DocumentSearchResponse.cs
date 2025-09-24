namespace DocumentQueryService.Api.Models;

/// <summary>
/// Document search response following World Bank API structure
/// </summary>
public class DocumentSearchResponse
{
    /// <summary>
    /// Total number of documents found (World Bank API field)
    /// </summary>
    public int Total { get; set; }

    /// <summary>
    /// Number of documents requested per page (World Bank API field: rows)
    /// </summary>
    public int Rows { get; set; }

    /// <summary>
    /// Current offset/starting record number (World Bank API field: os)
    /// </summary>
    public int Os { get; set; }

    /// <summary>
    /// Current page number (World Bank API field: page)
    /// </summary>
    public int Page { get; set; }

    /// <summary>
    /// Documents as object with document IDs as keys (World Bank API structure)
    /// </summary>
    public Dictionary<string, object> Documents { get; set; } = new();
}

/// <summary>
/// Facet item for search filtering
/// </summary>
public class FacetItem
{
    /// <summary>
    /// Facet value
    /// </summary>
    public string Value { get; set; } = string.Empty;

    /// <summary>
    /// Number of documents with this facet value
    /// </summary>
    public int Count { get; set; }
}

/// <summary>
/// Search metadata
/// </summary>
public class SearchMetadata
{
    /// <summary>
    /// Query execution time in milliseconds
    /// </summary>
    public long QueryTimeMs { get; set; }

    /// <summary>
    /// Whether full-text search was used
    /// </summary>
    public bool FullTextSearchUsed { get; set; }

    /// <summary>
    /// Search timestamp
    /// </summary>
    public DateTime Timestamp { get; set; } = DateTime.UtcNow;

    /// <summary>
    /// Applied filters
    /// </summary>
    public Dictionary<string, object> AppliedFilters { get; set; } = new();
}