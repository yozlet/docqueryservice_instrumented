using DocQuery.Api.Models;
using Microsoft.EntityFrameworkCore;

namespace DocQuery.Api.Data;

public class DocQueryContext : DbContext
{
    public DocQueryContext(DbContextOptions<DocQueryContext> options)
        : base(options)
    {
    }

    public DbSet<Document> Documents { get; set; } = null!;
    public DbSet<Country> Countries { get; set; } = null!;
    public DbSet<Language> Languages { get; set; } = null!;
    public DbSet<DocumentType> DocumentTypes { get; set; } = null!;
    public DbSet<DocumentTag> DocumentTags { get; set; } = null!;
    public DbSet<DocumentCollection> DocumentCollections { get; set; } = null!;

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        // Document configuration
        modelBuilder.Entity<Document>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.Property(e => e.Title).IsRequired();
            entity.Property(e => e.CreatedAt).HasDefaultValueSql("CURRENT_TIMESTAMP");
            entity.Property(e => e.UpdatedAt).HasDefaultValueSql("CURRENT_TIMESTAMP");

            // Configure many-to-many relationship with Country
            entity.HasMany(d => d.Countries)
                .WithMany(c => c.Documents)
                .UsingEntity(j => j.ToTable("document_countries"));

            // Configure many-to-many relationship with DocumentCollection
            entity.HasMany(d => d.Collections)
                .WithMany(c => c.Documents)
                .UsingEntity(j => j.ToTable("document_collection_memberships"));
        });

        // Country configuration
        modelBuilder.Entity<Country>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.Property(e => e.Name).IsRequired();
            entity.HasIndex(e => e.Name).IsUnique();
            entity.HasIndex(e => e.Code).IsUnique();
        });

        // Language configuration
        modelBuilder.Entity<Language>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.Property(e => e.Name).IsRequired();
            entity.HasIndex(e => e.Name).IsUnique();
            entity.HasIndex(e => e.Code).IsUnique();
        });

        // DocumentType configuration
        modelBuilder.Entity<DocumentType>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.Property(e => e.TypeName).IsRequired();
            entity.HasIndex(e => e.TypeName).IsUnique();
        });

        // DocumentTag configuration
        modelBuilder.Entity<DocumentTag>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.Property(e => e.Tag).IsRequired();
            entity.HasOne(d => d.Document)
                .WithMany(d => d.Tags)
                .HasForeignKey(d => d.DocumentId)
                .OnDelete(DeleteBehavior.Cascade);
        });

        // DocumentCollection configuration
        modelBuilder.Entity<DocumentCollection>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.Property(e => e.Name).IsRequired();
        });
    }
}

