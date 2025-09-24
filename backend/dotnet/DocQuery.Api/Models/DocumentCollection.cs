namespace DocQuery.Api.Models;

public class DocumentCollection
{
    public int Id { get; set; }
    public string Name { get; set; } = null!;
    public string? Description { get; set; }
    public DateTime CreatedAt { get; set; }

    // Navigation properties
    public ICollection<Document> Documents { get; set; } = new List<Document>();
}

