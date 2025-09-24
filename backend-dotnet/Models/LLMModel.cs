namespace DocumentQueryService.Api.Models;

/// <summary>
/// Supported LLM models for document processing
/// </summary>
public enum LLMModel
{
    /// <summary>
    /// GPT-3.5 Turbo 16K model
    /// </summary>
    GPT35_TURBO,

    /// <summary>
    /// GPT-4 Turbo Preview model
    /// </summary>
    GPT4_TURBO,

    /// <summary>
    /// Claude 3 Sonnet model
    /// </summary>
    CLAUDE_3_SONNET,

    /// <summary>
    /// Claude 3 Opus model
    /// </summary>
    CLAUDE_3_OPUS
}

/// <summary>
/// Extension methods for LLMModel enum
/// </summary>
public static class LLMModelExtensions
{
    /// <summary>
    /// Convert LLMModel enum to string representation
    /// </summary>
    public static string ToModelName(this LLMModel model)
    {
        return model switch
        {
            LLMModel.GPT35_TURBO => "gpt-3.5-turbo-16k",
            LLMModel.GPT4_TURBO => "gpt-4-turbo-preview",
            LLMModel.CLAUDE_3_SONNET => "claude-3-sonnet",
            LLMModel.CLAUDE_3_OPUS => "claude-3-opus",
            _ => throw new ArgumentOutOfRangeException(nameof(model), model, null)
        };
    }

    /// <summary>
    /// Parse string model name to LLMModel enum
    /// </summary>
    public static LLMModel FromModelName(string modelName)
    {
        return modelName?.ToLowerInvariant() switch
        {
            "gpt-3.5-turbo-16k" => LLMModel.GPT35_TURBO,
            "gpt-4-turbo-preview" => LLMModel.GPT4_TURBO,
            "claude-3-sonnet" => LLMModel.CLAUDE_3_SONNET,
            "claude-3-opus" => LLMModel.CLAUDE_3_OPUS,
            _ => LLMModel.GPT35_TURBO // Default
        };
    }
}