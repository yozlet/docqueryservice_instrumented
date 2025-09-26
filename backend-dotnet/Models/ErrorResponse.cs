using System.Collections.Generic;
using System.Text.Json.Serialization;

namespace DocumentQueryService.Api.Models;

public class ErrorResponse
{
    [JsonPropertyName("error")]
    public string Error { get; set; } = string.Empty;

    [JsonPropertyName("message")]
    public string Message { get; set; } = string.Empty;

    [JsonPropertyName("details")]
    public Dictionary<string, object>? Details { get; set; }
}