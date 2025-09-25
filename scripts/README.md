# Database Setup for Document Query Service

This directory contains tools to set up and populate a PostgreSQL database for the Document Query Service.

## 🚀 Quick Start

**⚠️ IMPORTANT: Always run setup scripts with `--clean` flag!**

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

**Why `--clean` is required:**

- Ensures fresh database and storage state
- Removes conflicting existing data
- Guarantees proper PDF download counts
- Prevents azurite blob storage issues

Both scripts will:

- Clean and initialize PostgreSQL database
- Load 500 sample documents from World Bank API (configurable)
- Download over 480+ PDFs (local storage or Azurite blob storage)
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

## 📊 What You Get

After running the setup script:

- **📄 500 sample documents** from World Bank API (metadata in database)
- **📥 Over 480+ downloaded PDFs** stored in organized structure
- **🔵 Azurite blob storage** with hierarchical organization (Language/Type/Year/)
- **✅ 99%+ success rate** for PDF downloads
- **🗄️ PostgreSQL database** with proper document locations and statuses

Your database is now ready with documents that have proper storage locations! 🎉
