using System.Diagnostics;
using DocQuery.Api.Data;
using DocQuery.Api.DTOs;
using DocQuery.Api.Models;
using Microsoft.EntityFrameworkCore;

namespace DocQuery.Api.Services;

public class DocumentService : IDocumentService
{
    private readonly DocQueryContext _context;
    private readonly ILogger<DocumentService> _logger;

    public DocumentService(DocQueryContext context, ILogger<DocumentService> logger)
    {
        _context = context;
        _logger = logger;
    }

    public async Task<DocumentSearchResponse> SearchDocumentsAsync(DocumentSearchRequest request)
    {
        var stopwatch = Stopwatch.StartNew();

        try
        {
            var query = _context.Documents.AsQueryable();

            // Apply filters
            if (!string.IsNullOrWhiteSpace(request.SearchText))
            {
                var searchText = request.SearchText.ToLower();
                query = query.Where(d =>
                    EF.Functions.ILike(d.Title, $"%{searchText}%") ||
                    EF.Functions.ILike(d.Abstract ?? "", $"%{searchText}%") ||
                    EF.Functions.ILike(d.ContentText ?? "", $"%{searchText}%"));
            }

            if (request.StartDate.HasValue)
            {
                query = query.Where(d => d.DocDate >= request.StartDate);
            }

            if (request.EndDate.HasValue)
            {
                query = query.Where(d => d.DocDate <= request.EndDate);
            }

            if (!string.IsNullOrWhiteSpace(request.DocType))
            {
                query = query.Where(d => d.DocType == request.DocType);
            }

            if (!string.IsNullOrWhiteSpace(request.Language))
            {
                query = query.Where(d => d.Language == request.Language);
            }

            if (!string.IsNullOrWhiteSpace(request.Country))
            {
                query = query.Where(d => d.Country == request.Country);
            }

            // Get total count
            var totalCount = await query.CountAsync();

            // Get results (limit to 100)
            var documents = await query
                .Take(100)
                .Select(d => new DocumentResult
                {
                    Id = d.Id,
                    Title = d.Title,
                    Abstract = d.Abstract,
                    DocDate = d.DocDate,
                    DocType = d.DocType,
                    Language = d.Language,
                    Country = d.Country
                })
                .ToListAsync();

            stopwatch.Stop();

            return new DocumentSearchResponse
            {
                Results = documents,
                ResultCount = totalCount,
                SearchTimeMs = (int)stopwatch.ElapsedMilliseconds
            };
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error searching documents");
            throw;
        }
    }
}

