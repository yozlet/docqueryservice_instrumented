namespace DocQuery.Api.Models;

public class Country
{
    public int Id { get; set; }
    public string Name { get; set; } = null!;
    public string? Code { get; set; }
    public string? Region { get; set; }
    public DateTime CreatedAt { get; set; }

    // Navigation properties
    public ICollection<Document> Documents { get; set; } = new List<Document>();
}

