using System;
using System.IO;
using System.Net.Http;
using System.Threading.Tasks;
using DocumentQueryService.Api.Models;
using iText.Kernel.Pdf;
using iText.Kernel.Pdf.Canvas.Parser;
using iText.Kernel.Pdf.Canvas.Parser.Listener;
using Microsoft.Extensions.Logging;
using OpenTelemetry.Trace;

namespace DocumentQueryService.Api.Services;

public class DocumentService : IDocumentService
{
    private readonly ILogger<DocumentService> _logger;
    private readonly HttpClient _httpClient;
    private readonly Tracer _tracer;

    public DocumentService(ILogger<DocumentService> logger, HttpClient httpClient, TracerProvider tracerProvider)
    {
        _logger = logger;
        _httpClient = httpClient;
        _tracer = tracerProvider.GetTracer(nameof(DocumentService));
    }

    public async Task<(int totalCount, Document[] documents)> SearchDocumentsAsync(DocumentSearchRequest request)
    {
        using var activity = _tracer.StartActiveSpan("DocumentService.SearchDocuments");
        try
        {
            // TODO: Implement actual search logic
            // For now, return a mock response
            var doc = new Document
            {
                Id = request.Id ?? "mock_doc_1",
                Title = "Mock Document",
                Abstract = "This is a mock document for testing purposes",
                DocumentDate = DateTime.UtcNow,
                DocumentType = "test",
                CreatedAt = DateTime.UtcNow.AddDays(-1),
                UpdatedAt = DateTime.UtcNow
            };

            return (1, new[] { doc });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error searching documents");
            activity?.SetStatus(Status.Error.WithDescription(ex.Message));
            throw;
        }
    }

    public async Task<string> SummarizeDocumentAsync(Document document)
    {
        using var activity = _tracer.StartActiveSpan("DocumentService.SummarizeDocument");
        try
        {
            // TODO: Implement actual summarization logic
            // For now, return a mock summary
            return $"This is a mock summary of document {document.Id}";
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error summarizing document");
            activity?.SetStatus(Status.Error.WithDescription(ex.Message));
            throw;
        }
    }

    public async Task<string> DownloadAndExtractTextAsync(string docId, string url)
    {
        using var activity = _tracer.StartActiveSpan("DocumentService.DownloadAndExtractText");
        try
        {
            // Download the PDF
            var response = await _httpClient.GetAsync(url);
            response.EnsureSuccessStatusCode();

            // Create a temporary file
            var tempFile = Path.GetTempFileName();
            await using (var fileStream = File.Create(tempFile))
            {
                await response.Content.CopyToAsync(fileStream);
            }

            // Extract text from PDF
            string text;
            using (var pdfReader = new PdfReader(tempFile))
            using (var pdfDocument = new PdfDocument(pdfReader))
            {
                var strategy = new LocationTextExtractionStrategy();
                var textBuilder = new System.Text.StringBuilder();

                for (int i = 1; i <= pdfDocument.GetNumberOfPages(); i++)
                {
                    var page = pdfDocument.GetPage(i);
                    string currentText = PdfTextExtractor.GetTextFromPage(page, strategy);
                    textBuilder.AppendLine(currentText);
                }

                text = textBuilder.ToString();
            }

            // Clean up
            File.Delete(tempFile);

            return text;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error downloading and extracting text from PDF");
            activity?.SetStatus(Status.Error.WithDescription(ex.Message));
            throw;
        }
    }
}
