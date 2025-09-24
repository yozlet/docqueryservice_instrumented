namespace DocQuery.Api.Models;

public class Language
{
    public int Id { get; set; }
    public string Name { get; set; } = null!;
    public string? Code { get; set; }
    public DateTime CreatedAt { get; set; }
}

