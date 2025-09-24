using DocQuery.Api.DTOs;

namespace DocQuery.Api.Services;

public interface ISummaryService
{
    Task<DocumentSummaryResponse> GenerateSummariesAsync(DocumentSummaryRequest request);
}

