using System;
using System.Net.Http;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;
using Azure.AI.OpenAI;
using Microsoft.Extensions.Logging;

namespace DocumentQueryService.Api.Services;

public interface ILLMConfig
{
    Task<string> GenerateCompletionAsync(string prompt, string? model = null);
}

public class LLMConfig : ILLMConfig
{
    private readonly ILogger<LLMConfig> _logger;
    private readonly HttpClient _httpClient;
    private readonly OpenAIClient? _openAIClient;
    private readonly string? _anthropicApiKey;

    public LLMConfig(ILogger<LLMConfig> logger, HttpClient httpClient)
    {
        _logger = logger;
        _httpClient = httpClient;

        var openAiKey = Environment.GetEnvironmentVariable("OPENAI_API_KEY");
        var anthropicKey = Environment.GetEnvironmentVariable("ANTHROPIC_API_KEY");

        if (string.IsNullOrEmpty(openAiKey) && string.IsNullOrEmpty(anthropicKey))
        {
            throw new InvalidOperationException("Either OPENAI_API_KEY or ANTHROPIC_API_KEY must be provided");
        }

        if (!string.IsNullOrEmpty(openAiKey))
        {
            _openAIClient = new OpenAIClient(openAiKey);
        }

        _anthropicApiKey = anthropicKey;
    }

    public async Task<string> GenerateCompletionAsync(string prompt, string? model = null)
    {
        model ??= Models.LLMModel.GPT35Turbo16k; // Default model

        return model switch
        {
            Models.LLMModel.GPT35Turbo16k or Models.LLMModel.GPT4TurboPreview => await GenerateOpenAICompletionAsync(prompt, model),
            Models.LLMModel.Claude3Sonnet or Models.LLMModel.Claude3Opus => await GenerateAnthropicCompletionAsync(prompt, model),
            _ => throw new ArgumentException($"Unsupported model: {model}")
        };
    }

    private async Task<string> GenerateOpenAICompletionAsync(string prompt, string model)
    {
        if (_openAIClient == null)
        {
            throw new InvalidOperationException("OpenAI API key not configured");
        }

        try
        {
            var options = new ChatCompletionsOptions
            {
                Messages = { new ChatRequestUserMessage(prompt) },
                Temperature = 0,
                DeploymentName = model
            };

            var chatCompletions = await _openAIClient.GetChatCompletionsAsync(options);
            return chatCompletions.Value.Choices[0].Message.Content;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error generating OpenAI completion");
            throw;
        }
    }

    private async Task<string> GenerateAnthropicCompletionAsync(string prompt, string model)
    {
        if (string.IsNullOrEmpty(_anthropicApiKey))
        {
            throw new InvalidOperationException("Anthropic API key not configured");
        }

        var modelName = model switch
        {
            Models.LLMModel.Claude3Sonnet => "claude-3-sonnet-20240229",
            Models.LLMModel.Claude3Opus => "claude-3-opus-20240229",
            _ => throw new ArgumentException($"Unsupported Anthropic model: {model}")
        };

        try
        {
            var request = new
            {
                model = modelName,
                messages = new[]
                {
                    new { role = "user", content = prompt }
                },
                temperature = 0
            };

            var content = new StringContent(
                JsonSerializer.Serialize(request),
                Encoding.UTF8,
                "application/json");

            _httpClient.DefaultRequestHeaders.Clear();
            _httpClient.DefaultRequestHeaders.Add("x-api-key", _anthropicApiKey);
            _httpClient.DefaultRequestHeaders.Add("anthropic-version", "2023-06-01");

            var response = await _httpClient.PostAsync("https://api.anthropic.com/v1/messages", content);
            response.EnsureSuccessStatusCode();

            var responseContent = await response.Content.ReadAsStringAsync();
            using var doc = JsonDocument.Parse(responseContent);
            return doc.RootElement.GetProperty("content").GetProperty("text").GetString() ?? string.Empty;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error generating Anthropic completion");
            throw;
        }
    }
}