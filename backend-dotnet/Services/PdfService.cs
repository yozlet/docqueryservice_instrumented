using System.Diagnostics;
using System.Text;
using iText.Kernel.Pdf;
using iText.Kernel.Pdf.Canvas.Parser;
using iText.Kernel.Pdf.Canvas.Parser.Listener;

namespace DocumentQueryService.Api.Services;

/// <summary>
/// Service for PDF downloading and text extraction
/// </summary>
public class PdfService : IPdfService
{
    private readonly HttpClient _httpClient;
    private readonly ILogger<PdfService> _logger;
    private readonly int _maxTokens;
    private static readonly ActivitySource ActivitySource = new("DocumentQueryService.PdfService");

    public PdfService(HttpClient httpClient, ILogger<PdfService> logger, IConfiguration configuration)
    {
        _httpClient = httpClient;
        _logger = logger;
        _maxTokens = configuration.GetValue<int>("MAX_TOKENS", 1000);
    }

    public async Task<string?> DownloadAndExtractTextAsync(string docId, string url, CancellationToken cancellationToken = default)
    {
        using var activity = ActivitySource.StartActivity("download_and_extract_text");
        activity?.SetTag("doc_id", docId);
        activity?.SetTag("url", url);

        // Validate URL
        if (!url.ToLowerInvariant().EndsWith(".pdf"))
        {
            throw new ArgumentException("URL does not point to a PDF file", nameof(url));
        }

        var tempPath = Path.GetTempFileName();
        try
        {
            // Download PDF
            using (var downloadActivity = ActivitySource.StartActivity("download_pdf"))
            {
                using var response = await _httpClient.GetAsync(url, cancellationToken);

                if (!response.IsSuccessStatusCode)
                {
                    throw new HttpRequestException($"Failed to download PDF: HTTP {response.StatusCode}");
                }

                // Check content type
                var contentType = response.Content.Headers.ContentType?.MediaType ?? "";
                if (!contentType.Contains("application/pdf", StringComparison.OrdinalIgnoreCase))
                {
                    throw new ArgumentException($"Invalid content type: {contentType}");
                }

                // Save to temp file
                using var fileStream = new FileStream(tempPath, FileMode.Create, FileAccess.Write);
                await response.Content.CopyToAsync(fileStream, cancellationToken);
            }

            // Extract text
            using var extractActivity = ActivitySource.StartActivity("extract_text");
            try
            {
                using var pdfReader = new PdfReader(tempPath);
                using var pdfDoc = new PdfDocument(pdfReader);

                var text = new StringBuilder();
                var tokenCount = 0;

                for (int i = 1; i <= pdfDoc.GetNumberOfPages(); i++)
                {
                    var page = pdfDoc.GetPage(i);
                    var strategy = new SimpleTextExtractionStrategy();
                    var pageText = PdfTextExtractor.GetTextFromPage(page, strategy);

                    text.AppendLine(pageText);

                    // Count words (rough token approximation)
                    var words = pageText.Split(new[] { ' ', '\t', '\n', '\r' }, StringSplitOptions.RemoveEmptyEntries);
                    tokenCount += words.Length;

                    if (tokenCount > _maxTokens)
                    {
                        _logger.LogInformation("Reached maximum token limit of {MaxTokens} for document {DocId}", _maxTokens, docId);
                        break;
                    }
                }

                var extractedText = text.ToString().Trim();

                extractActivity?.SetTag("extracted_length", extractedText.Length);
                extractActivity?.SetTag("token_count", tokenCount);

                return extractedText;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Failed to extract text from PDF {DocId}", docId);
                throw new InvalidOperationException($"Failed to extract text from PDF: {ex.Message}", ex);
            }
        }
        finally
        {
            // Clean up temp file
            try
            {
                if (File.Exists(tempPath))
                {
                    File.Delete(tempPath);
                }
            }
            catch (Exception ex)
            {
                _logger.LogWarning(ex, "Failed to delete temporary file {TempPath}", tempPath);
            }
        }
    }
}