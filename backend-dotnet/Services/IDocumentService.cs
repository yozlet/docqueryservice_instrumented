using DocumentQueryService.Api.Models;

namespace DocumentQueryService.Api.Services;

/// <summary>
/// Service interface for document operations
/// </summary>
public interface IDocumentService
{
    /// <summary>
    /// Search documents based on the provided criteria
    /// </summary>
    /// <param name="request">Search request parameters</param>
    /// <param name="cancellationToken">Cancellation token</param>
    /// <returns>Search response with documents and metadata</returns>
    Task<DocumentSearchResponse> SearchDocumentsAsync(DocumentSearchRequest request, CancellationToken cancellationToken = default);

    /// <summary>
    /// Get a document by its ID
    /// </summary>
    /// <param name="id">Document ID</param>
    /// <param name="cancellationToken">Cancellation token</param>
    /// <returns>Document if found, null otherwise</returns>
    Task<Document?> GetDocumentByIdAsync(string id, CancellationToken cancellationToken = default);

    /// <summary>
    /// Get search facets for filtering
    /// </summary>
    /// <param name="query">Optional query to filter facets</param>
    /// <param name="cancellationToken">Cancellation token</param>
    /// <returns>Dictionary of facet categories and their values</returns>
    Task<Dictionary<string, List<FacetItem>>> GetSearchFacetsAsync(string? query = null, CancellationToken cancellationToken = default);

    /// <summary>
    /// Get database health status
    /// </summary>
    /// <param name="cancellationToken">Cancellation token</param>
    /// <returns>Health check information</returns>
    Task<object> GetHealthStatusAsync(CancellationToken cancellationToken = default);
}