using DocumentQueryService.Api.Models;

namespace DocumentQueryService.Api.Services;

/// <summary>
/// Interface for Large Language Model services
/// </summary>
public interface ILlmService
{
    /// <summary>
    /// Generate a summary for the given document using the specified LLM model
    /// </summary>
    /// <param name="document">The document to summarize</param>
    /// <param name="cancellationToken">Cancellation token</param>
    /// <returns>Generated summary text</returns>
    /// <exception cref="ArgumentException">Thrown when no content is provided for summarization</exception>
    /// <exception cref="InvalidOperationException">Thrown when LLM service fails</exception>
    Task<string> SummarizeAsync(DocumentWithContent document, CancellationToken cancellationToken = default);

    /// <summary>
    /// Check if the specified LLM model is available (has required API keys)
    /// </summary>
    /// <param name="model">The LLM model to check</param>
    /// <returns>True if the model is available, false otherwise</returns>
    bool IsModelAvailable(LLMModel model);
}