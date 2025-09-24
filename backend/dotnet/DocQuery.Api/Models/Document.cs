namespace DocQuery.Api.Models;

public class Document
{
    public string Id { get; set; } = null!;
    public string Title { get; set; } = null!;
    public DateTime? DocDate { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime UpdatedAt { get; set; }
    
    public string? Abstract { get; set; }
    public string? ContentText { get; set; }
    
    public string? DocType { get; set; }
    public string? MajorDocType { get; set; }
    
    public int? VolumeNumber { get; set; }
    public int? TotalVolumes { get; set; }
    public string? Url { get; set; }
    
    public string? Language { get; set; }
    public string? Country { get; set; }
    
    public string? Author { get; set; }
    public string? Publisher { get; set; }
    public string? ISBN { get; set; }
    public string? ISSN { get; set; }
    
    // Navigation properties
    public ICollection<Country> Countries { get; set; } = new List<Country>();
    public ICollection<DocumentTag> Tags { get; set; } = new List<DocumentTag>();
    public ICollection<DocumentCollection> Collections { get; set; } = new List<DocumentCollection>();
}

