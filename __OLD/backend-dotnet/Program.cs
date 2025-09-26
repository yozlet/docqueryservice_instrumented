using Npgsql;
using OpenTelemetry.Resources;
using OpenTelemetry.Trace;
using OpenTelemetry.Metrics;
using DocumentQueryService.Api.Services;

var builder = WebApplication.CreateBuilder(args);

// Configure URLs - fully configurable via environment variables
var listenHost = Environment.GetEnvironmentVariable("LISTEN_HOST") ?? "localhost";
var listenPort = Environment.GetEnvironmentVariable("LISTEN_PORT") ?? "5001";

// In production environments, default to listening on all interfaces
if (builder.Environment.IsProduction() || Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT") == "Production")
{
    listenHost = Environment.GetEnvironmentVariable("LISTEN_HOST") ?? "0.0.0.0";
}

var urls = $"http://{listenHost}:{listenPort}";
builder.WebHost.UseUrls(urls);

Console.WriteLine($"Backend will listen on: {urls}");

// Add services to the container.
builder.Services.AddControllers();

// Add database connection - fully configurable via environment variables
var connectionString = Environment.GetEnvironmentVariable("DATABASE_CONNECTION_STRING")
    ?? builder.Configuration.GetConnectionString("DefaultConnection")
    ?? BuildDefaultConnectionString();

static string BuildDefaultConnectionString()
{
    var host = Environment.GetEnvironmentVariable("DB_HOST") ?? "localhost";
    var port = Environment.GetEnvironmentVariable("DB_PORT") ?? "5432";
    var database = Environment.GetEnvironmentVariable("DB_DATABASE") ?? "docqueryservice";
    var username = Environment.GetEnvironmentVariable("DB_USERNAME") ?? "postgres";
    var password = Environment.GetEnvironmentVariable("DB_PASSWORD") ?? "DevPassword123!";

    return $"Host={host};Port={port};Database={database};Username={username};Password={password}";
}

Console.WriteLine($"Database server: {connectionString.Split(';')[0]}");
builder.Services.AddScoped<NpgsqlConnection>(_ => new NpgsqlConnection(connectionString));

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
        .AddNpgsql()
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
        Description = "Multi-version API: World Bank-style endpoints (/api/v3/wds) and Python-compatible endpoints (/v1)"
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
