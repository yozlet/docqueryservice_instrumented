# Database Setup for Document Query Service

This directory contains tools to set up and populate a PostgreSQL database for the Document Query Service.

## 🚀 Quick Start

**PostgreSQL + Local Storage:**

```bash
cd scripts
./setup-database.sh --clean
```

**PostgreSQL + Azurite Blob Storage:**

```bash
cd scripts
./setup-database-azurite.sh --clean
```

Both scripts will:

- Clean and initialize PostgreSQL database
- Load 10 sample documents from World Bank API
- Download PDFs (local storage or Azurite blob storage)
- Update database with correct document locations and DOWNLOADED status

## 🛠️ Connection Details

**Default Configuration:**

- **Server**: localhost:5432
- **Database**: docqueryservice
- **Username**: postgres
- **Password**: DevPassword123!

**Azurite Blob Storage:**

- **Endpoint**: http://127.0.0.1:10000/devstoreaccount1
- **Container**: pdfs

Your database is now ready with documents that have proper storage locations! 🎉
