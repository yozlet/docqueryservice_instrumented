using Microsoft.Data.SqlClient;
using OpenTelemetry.Resources;
using OpenTelemetry.Trace;
using OpenTelemetry.Metrics;
using DocumentQueryService.Api.Services;

var builder = WebApplication.CreateBuilder(args);

// Configure URLs (use port 5001 to avoid conflict with macOS Control Center on 5000)
// In Docker: listen on all interfaces, outside Docker: listen on localhost only
var urls = Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT") == "Production"
    ? "http://0.0.0.0:5001"
    : "http://localhost:5001";
builder.WebHost.UseUrls(urls);

// Add services to the container.
builder.Services.AddControllers();

// Add database connection
var connectionString = builder.Configuration.GetConnectionString("DefaultConnection") 
    ?? "Server=localhost,1433;Database=DocQueryService;User Id=sa;Password=DevPassword123!;TrustServerCertificate=true;";
builder.Services.AddScoped<SqlConnection>(_ => new SqlConnection(connectionString));

// Add our services
builder.Services.AddScoped<IDocumentService, DocumentService>();

// Add CORS
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", policy =>
    {
        policy.AllowAnyOrigin()
              .AllowAnyMethod()
              .AllowAnyHeader();
    });
});

// Add OpenTelemetry
builder.Services.AddOpenTelemetry()
    .ConfigureResource(resource => resource
        .AddService("DocumentQueryService.Api", "1.0.0")
        .AddAttributes([
            new("deployment.environment", builder.Environment.EnvironmentName),
            new("service.namespace", "DocumentQueryService")
        ]))
    .WithTracing(tracing => tracing
        .AddAspNetCoreInstrumentation()
        .AddSqlClientInstrumentation(options =>
        {
            options.SetDbStatementForText = true;
            options.RecordException = true;
        })
        .AddOtlpExporter())
    .WithMetrics(metrics => metrics
        .AddAspNetCoreInstrumentation()
        .AddRuntimeInstrumentation()
        .AddOtlpExporter());

// Add OpenAPI/Swagger
builder.Services.AddOpenApi();
builder.Services.AddSwaggerGen(c =>
{
    c.SwaggerDoc("v1", new() { 
        Title = "Document Query Service API", 
        Version = "v1",
        Description = "A World Bank-style document search and retrieval API"
    });
});

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI(c =>
    {
        c.SwaggerEndpoint("/swagger/v1/swagger.json", "Document Query Service API v1");
        c.RoutePrefix = string.Empty; // Serve Swagger UI at root
    });
    app.MapOpenApi();
}

app.UseCors("AllowAll");

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

// Add health check endpoint
app.MapGet("/health", () => new { status = "healthy", timestamp = DateTime.UtcNow });

app.Run();
