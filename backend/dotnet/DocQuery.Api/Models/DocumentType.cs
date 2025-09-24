namespace DocQuery.Api.Models;

public class DocumentType
{
    public int Id { get; set; }
    public string TypeName { get; set; } = null!;
    public string? MajorType { get; set; }
    public string? Description { get; set; }
    public DateTime CreatedAt { get; set; }
}

