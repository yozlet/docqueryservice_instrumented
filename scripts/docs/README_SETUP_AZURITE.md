# Database Setup - Azurite Integration

A comprehensive setup script that creates a complete development environment with PostgreSQL database and Azurite blob storage integration. Perfect for cloud-native document processing development.

## 🔵 Features

- **🗄️ PostgreSQL Database**: Sets up database with schema and sample data
- **🔵 Azurite Blob Storage**: Configures local Azure blob storage emulator
- **🐍 Python Environment**: Creates virtual environment with all dependencies
- **📄 Sample Documents**: Downloads real PDF documents to Azurite storage
- **🧹 Cleanup Integration**: Built-in cleanup for testing workflows
- **🔍 Verification**: Comprehensive setup validation and health checks

## 🚀 Quick Start

### Basic Setup

```bash
# Complete setup with defaults
./setup-database-azurite.sh

# Setup with custom document count
./setup-database-azurite.sh --sample-docs=100

# Clean setup (removes existing data)
./setup-database-azurite.sh --clean
```

### What Gets Created

```
Development Environment:
├── 🗄️  PostgreSQL Database
│   ├── docqueryservice database
│   ├── Complete schema (tables, indexes)
│   └── 200 sample documents (metadata)
├── 🔵 Azurite Blob Storage
│   ├── Running on http://127.0.0.1:10000
│   ├── pdfs container
│   └── 20 sample PDF files (organized by year/type)
├── 🐍 Python Environment
│   ├── Virtual environment (.venv)
│   ├── All required dependencies
│   └── Azure blob storage libraries
└── 🛠️  Development Tools
    ├── Database connection scripts
    ├── Blob management utilities
    └── Cleanup scripts
```

## 📋 Command Line Options

| Option            | Default | Description                             |
| ----------------- | ------- | --------------------------------------- |
| `--clean`         | `false` | Clean database and Azurite before setup |
| `--sample-docs=N` | `200`   | Number of sample documents to generate  |
| `--help`          | -       | Show help message and exit              |

## 🔄 Setup Process

The script performs these steps automatically:

### 1. 🐍 **Python Environment Setup**

- Creates virtual environment if needed
- Installs base requirements (`requirements.txt`)
- Installs Azurite requirements (`requirements_azurite.txt`)
- Activates environment for subsequent steps

### 2. 🔵 **Azurite Blob Storage**

- Checks if Azurite is running
- Installs Azurite via npm if needed
- Starts Azurite services in background
- Creates data directory (`./azurite_data`)
- Verifies blob service accessibility

### 3. 🗄️ **Database Setup**

- Starts PostgreSQL via Docker Compose
- Creates `docqueryservice` database
- Applies schema from `../docs/schema.sql`
- Verifies database connectivity

### 4. 📄 **Sample Data Generation**

- Runs World Bank scraper for sample documents
- Generates `sample_data.sql` with metadata
- Loads document metadata into database
- Creates 200 document records (configurable)

### 5. 📥 **PDF Download to Azurite**

- Downloads 20 sample PDFs to Azurite storage
- Organizes files by country/type/year hierarchy
- Updates database with blob storage locations
- Provides download progress tracking

### 6. 🔍 **Verification & Summary**

- Counts documents in database
- Verifies Azurite blob accessibility
- Checks Python environment status
- Displays setup summary and usage instructions

## 📊 Example Output

```bash
./setup-database-azurite.sh --sample-docs=50
```

```
╔══════════════════════════════════════════════════════════════════════════════╗
║                    🔵 Database Setup - Azurite Integration 🔵                 ║
║                                                                              ║
║  📊 Sets up PostgreSQL database for document management                      ║
║  🔵 Configures Azurite blob storage for PDF files                          ║
║  📄 Downloads sample documents to Azurite storage                           ║
║  🔄 Provides integrated development environment                              ║
║                                                                              ║
║  🚀 Ready for cloud-native document processing development                   ║
╚══════════════════════════════════════════════════════════════════════════════╝

🚀 Starting Azurite-integrated database setup...
📊 Sample documents: 50
🔵 Azurite data directory: ./azurite_data

Step 1: Python Environment
🐍 Setting up Python environment...
✅ Virtual environment created
✅ Virtual environment activated
📦 Installing Python dependencies...
✅ Base requirements installed
✅ Azurite requirements installed

Step 2: Azurite Blob Storage
🔵 Checking Azurite blob storage...
🚀 Starting Azurite blob storage...
📦 Installing Azurite...
✅ Azurite installed
🔵 Starting Azurite services...
⏳ Waiting for Azurite to initialize...
✅ Azurite started successfully (PID: 12345)
   📦 Blob service: http://127.0.0.1:10000
   📋 Queue service: http://127.0.0.1:10001
   📊 Table service: http://127.0.0.1:10002
   📁 Data directory: ./azurite_data

Step 3: Database Setup
🗄️  Setting up PostgreSQL database...
✅ Database is running
📊 Setting up database schema...
✅ Database schema applied

Step 4: Sample Data Generation
📄 Generating sample document data...
🌐 Fetching sample documents from World Bank API...
✅ Sample data generated (50 documents)
📊 Loading sample data into database...
✅ Sample data loaded into database

Step 5: PDF Download to Azurite
🔵 Downloading PDFs to Azurite blob storage...
📥 Downloading 20 sample PDFs to Azurite...
✅ PDFs downloaded to Azurite blob storage
📊 Azurite storage summary:
🔵 Listing blobs in Azurite container: pdfs
📄 Found 20 blobs
📊 Total: 20 blobs, 15,234,567 bytes (14.53 MB)

Step 6: Verification
🔍 Verifying setup...
✅ Database: 50 documents loaded
✅ Azurite: Blob storage accessible
✅ Azurite: 20 PDFs stored
✅ Python: Virtual environment ready

🎉 Setup completed successfully!
```

## 🛠️ Development Workflow

After setup, you can use these commands:

### 🔵 **Azurite Operations**

```bash
# List all blobs
python3 list_azurite_blobs.py

# Download more PDFs
python3 pdf_downloader_azurite.py sample_data.sql --max-downloads 50

# Clean Azurite storage
./clean_azurite.sh --confirm

# Check Azurite logs
tail -f ./azurite_data/debug.log
```

### 🗄️ **Database Operations**

```bash
# Connect to database
docker exec -it docquery-postgres psql -U postgres -d docqueryservice

# Test database operations
python3 database.py

# Add more documents
python3 worldbank_scraper.py --count 1000 --database
```

### 🐍 **Python Environment**

```bash
# Activate environment
source .venv/bin/activate

# Install additional packages
pip install package-name

# Run development scripts
python3 your_script.py
```

## 🧹 Cleanup & Maintenance

### Clean Everything

```bash
# Full cleanup and fresh setup
./setup-database-azurite.sh --clean
```

### Partial Cleanup

```bash
# Clean only Azurite storage
./clean_azurite.sh --confirm

# Clean only database
./cleanup-database.sh --confirm

# Remove sample data file
rm sample_data.sql
```

### Stop Services

```bash
# Stop database
docker-compose down

# Stop Azurite
pkill -f azurite

# Deactivate Python environment
deactivate
```

## 🔧 Troubleshooting

### Azurite Issues

```bash
# Check if Azurite is running
curl -s http://127.0.0.1:10000/devstoreaccount1

# Restart Azurite
pkill -f azurite
./start_azurite.sh

# Check Azurite logs
tail -f ./azurite_data/debug.log
```

### Database Issues

```bash
# Check database status
docker exec docquery-postgres pg_isready -U postgres

# Restart database
docker-compose restart postgres

# View database logs
docker logs docquery-postgres
```

### Python Environment Issues

```bash
# Recreate virtual environment
rm -rf .venv
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt -r requirements_azurite.txt
```

## 🆚 Comparison with Regular Setup

| Feature              | Regular Setup          | Azurite Setup            |
| -------------------- | ---------------------- | ------------------------ |
| **Storage**          | Local filesystem       | Azurite blob storage     |
| **PDF Organization** | Symlinks               | Blob hierarchy           |
| **Cloud Readiness**  | Limited                | Full Azure compatibility |
| **Development**      | Local files only       | Cloud-native testing     |
| **Scalability**      | Disk limited           | Cloud scalable           |
| **Dependencies**     | Basic Python           | Azure SDK included       |
| **Cleanup**          | File system operations | Blob operations          |

## 📝 Configuration

### Environment Variables

The script respects these environment variables:

```bash
# Database configuration
export DB_NAME="docqueryservice"
export SAMPLE_DOCS=200

# Azurite configuration
export AZURITE_PORT=10000
export AZURITE_DATA_DIR="./azurite_data"

# Python configuration
export PYTHON_CMD="python3"
export VENV_DIR=".venv"
```

### Customization

You can customize the setup by modifying these variables in the script:

- `SAMPLE_DOCS`: Number of sample documents to generate
- `AZURITE_DATA_DIR`: Directory for Azurite data storage
- `DOWNLOAD_COUNT`: Number of PDFs to download to Azurite

## 🔗 Related Files

- `setup-database-azurite.sh` - Main Azurite setup script
- `setup-database.sh` - Original filesystem-based setup
- `pdf_downloader_azurite.py` - Azurite PDF downloader
- `empty_azurite_blobs.py` - Azurite cleanup utility
- `start_azurite.sh` - Azurite startup script
- `worldbank_scraper.py` - Document metadata scraper
- `requirements_azurite.txt` - Azure dependencies

## 💡 Tips

- **First Time Setup**: Run with `--clean` to ensure fresh environment
- **Development Cycles**: Use `./clean_azurite.sh --confirm` between tests
- **Performance**: Adjust `DOWNLOAD_COUNT` based on your development needs
- **Debugging**: Check both Azurite and database logs for issues
- **Storage**: Azurite data persists in `./azurite_data` directory
