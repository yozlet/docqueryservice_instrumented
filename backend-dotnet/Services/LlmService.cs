using System.Diagnostics;
using System.Text;
using System.Text.Json;
using DocumentQueryService.Api.Models;

namespace DocumentQueryService.Api.Services;

/// <summary>
/// Service for interacting with Large Language Models for document summarization
/// </summary>
public class LlmService : ILlmService
{
    private readonly HttpClient _httpClient;
    private readonly ILogger<LlmService> _logger;
    private readonly IConfiguration _configuration;
    private static readonly ActivitySource ActivitySource = new("DocumentQueryService.LlmService");

    private readonly string? _openAiApiKey;
    private readonly string? _anthropicApiKey;

    public LlmService(HttpClient httpClient, ILogger<LlmService> logger, IConfiguration configuration)
    {
        _httpClient = httpClient;
        _logger = logger;
        _configuration = configuration;

        _openAiApiKey = Environment.GetEnvironmentVariable("OPENAI_API_KEY");
        _anthropicApiKey = Environment.GetEnvironmentVariable("ANTHROPIC_API_KEY");

        if (string.IsNullOrEmpty(_openAiApiKey) && string.IsNullOrEmpty(_anthropicApiKey))
        {
            _logger.LogWarning("No LLM API keys found. Summarization functionality will be limited.");
        }
    }

    public async Task<string> SummarizeAsync(DocumentWithContent document, CancellationToken cancellationToken = default)
    {
        using var activity = ActivitySource.StartActivity("summarize_document");
        activity?.SetTag("document.id", document.Id);
        activity?.SetTag("model", document.Model.ToModelName());

        // Prepare text for summarization
        var textToSummarize = PrepareText(document);
        if (string.IsNullOrEmpty(textToSummarize))
        {
            throw new ArgumentException("No content provided for summarization");
        }

        activity?.SetTag("text_length", textToSummarize.Length);

        // Check if model is available
        if (!IsModelAvailable(document.Model))
        {
            throw new InvalidOperationException($"Model {document.Model.ToModelName()} is not available. Missing API key.");
        }

        try
        {
            return document.Model switch
            {
                LLMModel.GPT35_TURBO or LLMModel.GPT4_TURBO => await SummarizeWithOpenAi(document.Model, textToSummarize, cancellationToken),
                LLMModel.CLAUDE_3_SONNET or LLMModel.CLAUDE_3_OPUS => await SummarizeWithAnthropic(document.Model, textToSummarize, cancellationToken),
                _ => throw new ArgumentOutOfRangeException(nameof(document.Model), document.Model, "Unsupported model")
            };
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error during summarization with model {Model}", document.Model.ToModelName());
            activity?.SetStatus(ActivityStatusCode.Error, ex.Message);
            throw new InvalidOperationException($"Summarization failed: {ex.Message}", ex);
        }
    }

    public bool IsModelAvailable(LLMModel model)
    {
        return model switch
        {
            LLMModel.GPT35_TURBO or LLMModel.GPT4_TURBO => !string.IsNullOrEmpty(_openAiApiKey),
            LLMModel.CLAUDE_3_SONNET or LLMModel.CLAUDE_3_OPUS => !string.IsNullOrEmpty(_anthropicApiKey),
            _ => false
        };
    }

    private static string PrepareText(DocumentWithContent document)
    {
        var parts = new List<string>
        {
            $"Title: {document.Title}"
        };

        if (!string.IsNullOrEmpty(document.Abstract))
        {
            parts.Add($"Abstract: {document.Abstract}");
        }

        if (!string.IsNullOrEmpty(document.Content))
        {
            parts.Add(document.Content);
        }

        return string.Join("\n\n", parts);
    }

    private async Task<string> SummarizeWithOpenAi(LLMModel model, string text, CancellationToken cancellationToken)
    {
        using var activity = ActivitySource.StartActivity("openai_summarization");

        var request = new
        {
            model = model.ToModelName(),
            messages = new[]
            {
                new
                {
                    role = "system",
                    content = "You are a helpful assistant that creates comprehensive yet concise summaries of documents. Focus on the main points, key findings, and important conclusions. If the document appears to be a report or research paper, include methodology and results."
                },
                new
                {
                    role = "user",
                    content = $"Please summarize the following document:\n\n{text}\n\nSummary:"
                }
            },
            temperature = 0,
            max_tokens = 500
        };

        var jsonRequest = JsonSerializer.Serialize(request);
        using var content = new StringContent(jsonRequest, Encoding.UTF8, "application/json");

        _httpClient.DefaultRequestHeaders.Clear();
        _httpClient.DefaultRequestHeaders.Add("Authorization", $"Bearer {_openAiApiKey}");

        var response = await _httpClient.PostAsync("https://api.openai.com/v1/chat/completions", content, cancellationToken);

        if (!response.IsSuccessStatusCode)
        {
            var errorContent = await response.Content.ReadAsStringAsync(cancellationToken);
            throw new HttpRequestException($"OpenAI API request failed: {response.StatusCode}, {errorContent}");
        }

        var responseContent = await response.Content.ReadAsStringAsync(cancellationToken);
        using var jsonDoc = JsonDocument.Parse(responseContent);

        var choices = jsonDoc.RootElement.GetProperty("choices");
        if (choices.GetArrayLength() == 0)
        {
            throw new InvalidOperationException("No response from OpenAI API");
        }

        var messageContent = choices[0].GetProperty("message").GetProperty("content").GetString();
        return messageContent?.Trim() ?? string.Empty;
    }

    private async Task<string> SummarizeWithAnthropic(LLMModel model, string text, CancellationToken cancellationToken)
    {
        using var activity = ActivitySource.StartActivity("anthropic_summarization");

        var prompt = $"""
                     You are a helpful assistant that creates comprehensive yet concise summaries of documents.
                     Focus on the main points, key findings, and important conclusions.
                     If the document appears to be a report or research paper, include methodology and results.

                     Please summarize the following document:

                     {text}

                     Summary:
                     """;

        var request = new
        {
            model = model.ToModelName(),
            max_tokens = 500,
            temperature = 0,
            messages = new[]
            {
                new
                {
                    role = "user",
                    content = prompt
                }
            }
        };

        var jsonRequest = JsonSerializer.Serialize(request);
        using var content = new StringContent(jsonRequest, Encoding.UTF8, "application/json");

        _httpClient.DefaultRequestHeaders.Clear();
        _httpClient.DefaultRequestHeaders.Add("x-api-key", _anthropicApiKey);
        _httpClient.DefaultRequestHeaders.Add("anthropic-version", "2023-06-01");

        var response = await _httpClient.PostAsync("https://api.anthropic.com/v1/messages", content, cancellationToken);

        if (!response.IsSuccessStatusCode)
        {
            var errorContent = await response.Content.ReadAsStringAsync(cancellationToken);
            throw new HttpRequestException($"Anthropic API request failed: {response.StatusCode}, {errorContent}");
        }

        var responseContent = await response.Content.ReadAsStringAsync(cancellationToken);
        using var jsonDoc = JsonDocument.Parse(responseContent);

        var contentArray = jsonDoc.RootElement.GetProperty("content");
        if (contentArray.GetArrayLength() == 0)
        {
            throw new InvalidOperationException("No response from Anthropic API");
        }

        var messageContent = contentArray[0].GetProperty("text").GetString();
        return messageContent?.Trim() ?? string.Empty;
    }
}