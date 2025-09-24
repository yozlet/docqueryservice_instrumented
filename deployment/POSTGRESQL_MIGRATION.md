# PostgreSQL Migration Guide

This document outlines the migration from Azure SQL Database to Azure Database for PostgreSQL in the Document Query Service.

## Overview

The system has been converted from Microsoft SQL Server to PostgreSQL for better cost-effectiveness, open-source compatibility, and enhanced full-text search capabilities.

## Key Changes

### 🔄 **Infrastructure Changes**

**Azure Resources:**

- ❌ **Removed**: Azure SQL Database + SQL Server
- ✅ **Added**: Azure Database for PostgreSQL Flexible Server

**Deployment Script Updates:**

- `create_azure_sql()` → `create_azure_postgres()`
- Updated validation for PostgreSQL-specific variables
- Modified firewall rules for PostgreSQL server
- Updated help documentation

### 📊 **Database Schema Changes**

**Data Types Conversion:**

- `NVARCHAR(n)` → `VARCHAR(n)`
- `NTEXT` → `TEXT`
- `INT` → `INTEGER`
- `DATETIME2` → `TIMESTAMP`
- `IDENTITY(1,1)` → `SERIAL`

**PostgreSQL-Specific Features Added:**

- ✅ Full-text search with `TSVECTOR` and GIN indexes
- ✅ Automatic search vector updates via triggers
- ✅ Enhanced indexing strategy
- ✅ PostgreSQL-specific functions and procedures

### ⚙️ **Configuration Changes**

**Environment Variables (azure.env.template):**

**Old (SQL Server):**

```bash
AZURE_SQL_SERVER_NAME=docquery-sql-server
AZURE_SQL_DATABASE_NAME=DocQueryService
AZURE_SQL_ADMIN_USER=sqladmin
AZURE_SQL_ADMIN_PASSWORD=YourSecurePassword123!
AZURE_SQL_SKU=Basic
```

**New (PostgreSQL):**

```bash
AZURE_POSTGRES_SERVER_NAME=docquery-postgres-server
AZURE_POSTGRES_DATABASE_NAME=docqueryservice
AZURE_POSTGRES_ADMIN_USER=pgadmin
AZURE_POSTGRES_ADMIN_PASSWORD=YourSecurePassword123!
AZURE_POSTGRES_SKU=Standard_B1ms
AZURE_POSTGRES_TIER=Burstable
AZURE_POSTGRES_VERSION=14
AZURE_POSTGRES_STORAGE_SIZE=32
```

**Connection String Changes:**

**Old (SQL Server):**

```
Server=tcp:docquery-sql-server.database.windows.net,1433;Initial Catalog=DocQueryService;Persist Security Info=False;User ID=sqladmin;Password=YourSecurePassword123!;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;
```

**New (PostgreSQL):**

```
Host=docquery-postgres-server.postgres.database.azure.com;Database=docqueryservice;Username=pgladmin;Password=YourSecurePassword123!;SSL Mode=Require;Trust Server Certificate=true;
```

## PostgreSQL Advantages

### 💰 **Cost Benefits**

- **Lower licensing costs** (open-source vs. proprietary)
- **Better price/performance ratio** for Azure Database for PostgreSQL
- **Flexible pricing tiers** with burstable options

### 🔍 **Enhanced Search Capabilities**

- **Native full-text search** with `TSVECTOR` and GIN indexes
- **Advanced text search functions** (`to_tsvector`, `to_tsquery`, `ts_rank`)
- **Multi-language support** with built-in dictionaries
- **Automatic search vector maintenance** via triggers

### 🛠️ **Technical Advantages**

- **JSON/JSONB support** for flexible document metadata
- **Advanced indexing options** (GIN, GiST, BRIN)
- **Better concurrency** with MVCC
- **Extensibility** with custom functions and extensions

## Migration Steps

### 1. **Update Configuration**

Copy and customize the new environment template:

```bash
cp deployment/azure.env.template deployment/azure.env
# Edit azure.env with your PostgreSQL settings
```

### 2. **Deploy Infrastructure**

Deploy PostgreSQL resources:

```bash
./deployment/deploy-azure.sh --dry-run  # Preview changes
./deployment/deploy-azure.sh            # Deploy
```

### 3. **Initialize Database Schema**

Run the PostgreSQL schema:

```bash
psql -h your-postgres-server.postgres.database.azure.com \
     -U pgadmin \
     -d docqueryservice \
     -f scripts/sql/init-schema.sql
```

### 4. **Migrate Data (if needed)**

If migrating from existing SQL Server:

**Export from SQL Server:**

```sql
-- Export to CSV files
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 1;
RECONFIGURE;

-- Export documents table
EXEC xp_cmdshell 'bcp "SELECT * FROM DocQueryService.dbo.documents" queryout "documents.csv" -c -t, -S server -U user -P password'
```

**Import to PostgreSQL:**

```sql
-- Import from CSV
COPY documents FROM '/path/to/documents.csv' WITH CSV HEADER;
```

### 5. **Update Application Code**

If your .NET application needs updates:

**Install PostgreSQL NuGet package:**

```xml
<PackageReference Include="Npgsql.EntityFrameworkCore.PostgreSQL" Version="7.0.0" />
```

**Update connection string handling:**

```csharp
// PostgreSQL connection string format
services.AddDbContext<ApplicationDbContext>(options =>
    options.UseNpgsql(connectionString));
```

## PostgreSQL Configuration Options

### **Server Tiers**

| Tier                 | Use Case                     | CPU         | Memory      | Storage     |
| -------------------- | ---------------------------- | ----------- | ----------- | ----------- |
| **Burstable**        | Development, light workloads | 1-2 vCores  | 0.5-4 GB    | 32-16384 GB |
| **General Purpose**  | Production workloads         | 2-64 vCores | 4-432 GB    | 32-16384 GB |
| **Memory Optimized** | Memory-intensive apps        | 2-64 vCores | 13.6-864 GB | 32-16384 GB |

### **Recommended SKUs**

| Environment     | SKU               | Tier            | vCores | Memory | Storage |
| --------------- | ----------------- | --------------- | ------ | ------ | ------- |
| **Development** | `Standard_B1ms`   | Burstable       | 1      | 2 GB   | 32 GB   |
| **Staging**     | `Standard_B2s`    | Burstable       | 2      | 4 GB   | 64 GB   |
| **Production**  | `Standard_D2s_v3` | General Purpose | 2      | 8 GB   | 128 GB  |

### **Version Support**

- ✅ **PostgreSQL 14** (recommended)
- ✅ **PostgreSQL 13** (stable)
- ✅ **PostgreSQL 12** (legacy support)
- ✅ **PostgreSQL 15** (latest features)

## Full-Text Search Features

### **Automatic Search Vector Updates**

The schema includes automatic search vector maintenance:

```sql
-- Search vector is automatically updated on INSERT/UPDATE
INSERT INTO documents (id, title, abstract, content_text)
VALUES ('doc1', 'Climate Change Report', 'Analysis of climate impacts...', 'Full document text...');

-- Search vector is automatically populated and indexed
```

### **Advanced Search Queries**

```sql
-- Simple text search
SELECT * FROM documents
WHERE search_vector @@ to_tsquery('english', 'climate & change');

-- Ranked search results
SELECT *, ts_rank(search_vector, to_tsquery('english', 'climate & change')) as rank
FROM documents
WHERE search_vector @@ to_tsquery('english', 'climate & change')
ORDER BY rank DESC;

-- Phrase search
SELECT * FROM documents
WHERE search_vector @@ phraseto_tsquery('english', 'climate change adaptation');
```

## Monitoring and Maintenance

### **Performance Monitoring**

Monitor key PostgreSQL metrics:

- **Connection count** and connection pooling
- **Query performance** with `pg_stat_statements`
- **Index usage** with `pg_stat_user_indexes`
- **Full-text search performance** with GIN index statistics

### **Backup Strategy**

Azure Database for PostgreSQL provides:

- ✅ **Automated backups** (7-35 days retention)
- ✅ **Point-in-time recovery**
- ✅ **Geo-redundant backups** (optional)

### **Maintenance Windows**

Configure maintenance windows for:

- **Minor version updates**
- **Security patches**
- **Performance optimizations**

## Troubleshooting

### **Common Issues**

**Connection Issues:**

```bash
# Test connection
psql -h your-server.postgres.database.azure.com -U pgadmin -d docqueryservice

# Check firewall rules
az postgres flexible-server firewall-rule list --server-name your-server --resource-group your-rg
```

**Performance Issues:**

```sql
-- Check slow queries
SELECT query, mean_time, calls
FROM pg_stat_statements
ORDER BY mean_time DESC
LIMIT 10;

-- Check index usage
SELECT schemaname, tablename, indexname, idx_scan, idx_tup_read, idx_tup_fetch
FROM pg_stat_user_indexes
ORDER BY idx_scan DESC;
```

**Full-text Search Issues:**

```sql
-- Rebuild search vectors if needed
UPDATE documents SET search_vector =
    setweight(to_tsvector('english', COALESCE(title, '')), 'A') ||
    setweight(to_tsvector('english', COALESCE(abstract, '')), 'B') ||
    setweight(to_tsvector('english', COALESCE(content_text, '')), 'C');

-- Check search vector statistics
SELECT COUNT(*) as total_docs,
       COUNT(search_vector) as docs_with_search_vector
FROM documents;
```

## Cost Optimization

### **Right-sizing**

Monitor and adjust:

- **CPU utilization** (target 60-80%)
- **Memory usage** (avoid swapping)
- **Storage growth** (plan for expansion)
- **Connection patterns** (use connection pooling)

### **Storage Optimization**

- Use **appropriate storage tier** (Hot vs Cool)
- Enable **storage auto-grow** for flexibility
- Monitor **IOPS usage** and upgrade if needed

## Next Steps

After migration:

1. ✅ **Test application functionality** thoroughly
2. ✅ **Verify full-text search** performance
3. ✅ **Monitor resource usage** and optimize
4. ✅ **Set up alerting** for key metrics
5. ✅ **Document any custom procedures** or functions
6. ✅ **Plan for regular maintenance** and updates

For more information:

- [Azure Database for PostgreSQL Documentation](https://docs.microsoft.com/en-us/azure/postgresql/)
- [PostgreSQL Full-Text Search](https://www.postgresql.org/docs/current/textsearch.html)
- [Deployment Guide](AZURE_DEPLOYMENT.md)
