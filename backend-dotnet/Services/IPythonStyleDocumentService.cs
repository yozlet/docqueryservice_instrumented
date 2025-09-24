using DocumentQueryService.Api.Models;

namespace DocumentQueryService.Api.Services;

/// <summary>
/// Interface for Python backend style document operations
/// </summary>
public interface IPythonStyleDocumentService
{
    /// <summary>
    /// Search for documents based on the provided criteria (Python backend style)
    /// </summary>
    /// <param name="request">Search request parameters</param>
    /// <param name="cancellationToken">Cancellation token</param>
    /// <returns>Search response with documents and metadata</returns>
    Task<PythonStyleDocumentSearchResponse> SearchDocumentsAsync(PythonStyleDocumentSearchRequest request, CancellationToken cancellationToken = default);

    /// <summary>
    /// Generate AI-powered summaries for specified documents
    /// </summary>
    /// <param name="request">Summary request with document IDs and options</param>
    /// <param name="cancellationToken">Cancellation token</param>
    /// <returns>Generated summary response</returns>
    Task<DocumentSummaryResponse> GenerateSummaryAsync(DocumentSummaryRequest request, CancellationToken cancellationToken = default);
}