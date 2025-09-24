namespace DocumentQueryService.Api.Models;

/// <summary>
/// Response model for document search results (Python backend style)
/// </summary>
public class PythonStyleDocumentSearchResponse
{
    /// <summary>
    /// List of matching documents
    /// </summary>
    public List<DocumentWithContent> Results { get; set; } = new();

    /// <summary>
    /// Total number of matching documents
    /// </summary>
    public int ResultCount { get; set; }

    /// <summary>
    /// Time taken to perform the search in milliseconds
    /// </summary>
    public int SearchTimeMs { get; set; }
}

/// <summary>
/// Document with additional content field for summarization
/// </summary>
public class DocumentWithContent : Document
{
    /// <summary>
    /// Document content to summarize
    /// </summary>
    public string? Content { get; set; }

    /// <summary>
    /// LLM model to use for processing
    /// </summary>
    public LLMModel Model { get; set; } = LLMModel.GPT35_TURBO;
}