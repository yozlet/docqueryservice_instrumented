using DocQuery.Api.DTOs;

namespace DocQuery.Api.Services;

public interface IDocumentService
{
    Task<DocumentSearchResponse> SearchDocumentsAsync(DocumentSearchRequest request);
}

