namespace DocumentQueryService.Api.Services;

/// <summary>
/// Interface for PDF downloading and text extraction services
/// </summary>
public interface IPdfService
{
    /// <summary>
    /// Downloads a PDF file and extracts its text content
    /// </summary>
    /// <param name="docId">Document ID to use as filename</param>
    /// <param name="url">URL to download the PDF from</param>
    /// <param name="cancellationToken">Cancellation token</param>
    /// <returns>Extracted text from the PDF</returns>
    /// <exception cref="ArgumentException">Thrown when URL is invalid or doesn't point to a PDF</exception>
    /// <exception cref="HttpRequestException">Thrown when download fails</exception>
    /// <exception cref="InvalidOperationException">Thrown when PDF text extraction fails</exception>
    Task<string?> DownloadAndExtractTextAsync(string docId, string url, CancellationToken cancellationToken = default);
}