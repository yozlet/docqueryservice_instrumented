using System.Diagnostics;
using DocQuery.Api.Data;
using DocQuery.Api.DTOs;
using Microsoft.EntityFrameworkCore;

namespace DocQuery.Api.Services;

public class SummaryService : ISummaryService
{
    private readonly DocQueryContext _context;
    private readonly ILogger<SummaryService> _logger;

    public SummaryService(DocQueryContext context, ILogger<SummaryService> logger)
    {
        _context = context;
        _logger = logger;
    }

    public async Task<DocumentSummaryResponse> GenerateSummariesAsync(DocumentSummaryRequest request)
    {
        var stopwatch = Stopwatch.StartNew();

        try
        {
            var documents = await _context.Documents
                .Where(d => request.Ids.Contains(d.Id))
                .ToListAsync();

            if (!documents.Any())
            {
                throw new KeyNotFoundException("No documents found with the provided IDs");
            }

            // Prepare document content for summarization
            var content = string.Join("\n\n", documents.Select(d =>
                $"Title: {d.Title}\n" +
                $"Abstract: {d.Abstract ?? "N/A"}\n" +
                $"Content: {d.ContentText ?? "N/A"}"));

            // TODO: Implement actual AI summarization
            // For now, return a placeholder summary
            var summary = $"This is a placeholder summary. In a production environment, " +
                         $"this would be generated using the specified AI model: {request.Model}";

            stopwatch.Stop();

            return new DocumentSummaryResponse
            {
                SummaryText = summary,
                SummaryTimeMs = (int)stopwatch.ElapsedMilliseconds
            };
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error generating summaries");
            throw;
        }
    }
}

