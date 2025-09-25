namespace DocumentQueryService.Api.Models;

/// <summary>
/// Supported LLM models for document processing
/// </summary>
public enum LLMModel
{
    /// <summary>
    /// GPT-3.5 Turbo 16K
    /// </summary>
    GPT35Turbo,

    /// <summary>
    /// GPT-4 Turbo Preview
    /// </summary>
    GPT4Turbo,

    /// <summary>
    /// Claude 3 Sonnet
    /// </summary>
    Claude3Sonnet,

    /// <summary>
    /// Claude 3 Opus
    /// </summary>
    Claude3Opus
}

/// <summary>
/// Helper class for LLM model string conversion
/// </summary>
public static class LLMModelExtensions
{
    private static readonly Dictionary<string, LLMModel> StringToModel = new()
    {
        { "gpt-3.5-turbo-16k", LLMModel.GPT35Turbo },
        { "gpt-4-turbo-preview", LLMModel.GPT4Turbo },
        { "claude-3-sonnet", LLMModel.Claude3Sonnet },
        { "claude-3-opus", LLMModel.Claude3Opus }
    };

    private static readonly Dictionary<LLMModel, string> ModelToString = new()
    {
        { LLMModel.GPT35Turbo, "gpt-3.5-turbo-16k" },
        { LLMModel.GPT4Turbo, "gpt-4-turbo-preview" },
        { LLMModel.Claude3Sonnet, "claude-3-sonnet" },
        { LLMModel.Claude3Opus, "claude-3-opus" }
    };

    public static LLMModel FromString(string value)
    {
        return StringToModel.TryGetValue(value, out var model) ? model : LLMModel.GPT35Turbo;
    }

    public static string ToString(LLMModel model)
    {
        return ModelToString.TryGetValue(model, out var value) ? value : "gpt-3.5-turbo-16k";
    }
}