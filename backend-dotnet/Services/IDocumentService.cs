using System.Threading.Tasks;
using DocumentQueryService.Api.Models;

namespace DocumentQueryService.Api.Services;

public interface IDocumentService
{
    Task<(int totalCount, Document[] documents)> SearchDocumentsAsync(DocumentSearchRequest request);
    Task<string> SummarizeDocumentAsync(Document document);
    Task<string> DownloadAndExtractTextAsync(string docId, string url);
}
