namespace DocQuery.Api.Models;

public class DocumentTag
{
    public int Id { get; set; }
    public string DocumentId { get; set; } = null!;
    public string Tag { get; set; } = null!;
    public string? TagType { get; set; }
    public DateTime CreatedAt { get; set; }

    // Navigation properties
    public Document Document { get; set; } = null!;
}

