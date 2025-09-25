# Azurite PDF Downloader

A specialized version of the World Bank PDF downloader that stores files directly in **Azurite blob storage** instead of the local filesystem. This is perfect for cloud-native development and testing scenarios.

## 🔵 Features

- **Azurite Integration**: Stores PDFs directly in Azurite blob storage emulator
- **Organized Blob Hierarchy**: Creates structured paths like `Country/DocumentType/Year/filename.pdf`
- **Parallel Downloads**: Supports concurrent downloads with configurable workers
- **Progress Tracking**: Shows download progress with reduced verbosity option
- **Retry Logic**: Automatic retry with exponential backoff for failed downloads
- **Metadata Support**: Stores blob metadata including upload timestamp and file size
- **Container Management**: Automatically creates containers if they don't exist

## 🚀 Quick Start

### Option 1: Automated Setup (Recommended)

Use the integrated setup script for a complete development environment:

```bash
# Complete setup with database + Azurite + sample data
./setup-database-azurite.sh

# Clean setup (removes existing data)
./setup-database-azurite.sh --clean

# Custom document count
./setup-database-azurite.sh --sample-docs=100
```

This automatically sets up:

- ✅ PostgreSQL database with schema
- ✅ Azurite blob storage emulator
- ✅ Python virtual environment
- ✅ Sample documents and PDFs
- ✅ All required dependencies

### Option 2: Manual Setup

For manual control over the setup process:

#### 1. Install Dependencies

```bash
pip install -r requirements_azurite.txt
```

#### 2. Start Azurite

```bash
# Option 1: Use the provided script
./utilities/start_azurite.sh

# Option 2: Start manually
mkdir -p azurite_data
azurite --silent --location ./azurite_data --debug ./azurite_data/debug.log
```

#### 3. Run the Downloader

```bash
# Download PDFs to Azurite (basic usage)
python3 pdf_downloader_azurite.py sample_data.sql

# Download with custom settings
python3 pdf_downloader_azurite.py sample_data.sql --container my-pdfs --max-downloads 10 --quiet

# Download with verbose output
python3 pdf_downloader_azurite.py sample_data.sql --max-downloads 5 --verbose
```

#### 4. Verify Uploads

```bash
# List all blobs in Azurite
python3 utilities/list_azurite_blobs.py

# Or use wrapper script
./list-blobs.sh
```

## 📋 Command Line Options

| Option                 | Default     | Description                       |
| ---------------------- | ----------- | --------------------------------- |
| `--container`          | `pdfs`      | Azurite blob container name       |
| `--max-workers`        | `3`         | Maximum concurrent downloads      |
| `--max-downloads`      | `unlimited` | Limit number of files to download |
| `--timeout`            | `30`        | Download timeout in seconds       |
| `--delay`              | `1.0`       | Delay between requests in seconds |
| `--quiet`              | `false`     | Reduce verbose output             |
| `--verbose`            | `false`     | Enable extra verbose output       |
| `--azurite-connection` | `default`   | Custom Azurite connection string  |

## 🔵 Azurite Configuration

### Default Connection String

```
DefaultEndpointsProtocol=http;AccountName=devstoreaccount1;AccountKey=Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==;BlobEndpoint=http://127.0.0.1:10000/devstoreaccount1;
```

### Custom Configuration

```bash
python3 pdf_downloader_azurite.py data.sql --azurite-connection "DefaultEndpointsProtocol=http;AccountName=myaccount;..."
```

## 🗂️ Blob Organization

Files are organized in a hierarchical structure:

```
Container: pdfs/
├── English/
│   ├── Project_Documents/
│   │   ├── 2023/
│   │   │   ├── document1.pdf
│   │   │   └── document2.pdf
│   │   └── 2024/
│   │       └── document3.pdf
│   └── Publications_Research/
│       └── 2023/
│           └── research1.pdf
├── Spanish/
│   └── Project_Documents/
│       └── 2023/
│           └── documento1.pdf
└── French/
    └── Publications_Research/
        └── 2024/
            └── publication1.pdf
```

## 📊 Output Examples

### Quiet Mode (Default)

```
🚀 Starting Azurite PDF Download Session
📊 Total documents to process: 10
🔵 Target container: pdfs
================================================================================
🔵 Working on documents 1-10 | ✅8 ⏭️2 ❌0 | 100.0% complete

📋 AZURITE DOWNLOAD COMPLETE - Session Summary
✅ Successfully downloaded: 8
⏭️  Skipped (already existed): 2
📈 Success rate: 100.0%
```

### Verbose Mode

```
🔵 Testing Azurite connectivity...
   ✅ Azurite connection: OK (0 existing blobs)
   ✅ Test upload: OK
   ✅ Test cleanup: OK

🔍 [1/10] Processing: Official Documents- Amendment No. 2...
   🌐 URL: https://documents.worldbank.org/curated/en/...
   ✅ Connection established (0.65s)
   🔵 Downloading to Azurite blob storage: English/Project_Documents/unknown/document.pdf
   ✅ Download complete: 1,190,184 bytes in 1.2s
   🔵 Saved to Azurite blob: English/Project_Documents/unknown/document.pdf
```

## 🛠️ Utilities

### List Blobs

```bash
# Direct utility call
python3 utilities/list_azurite_blobs.py

# Or use wrapper script
./list-blobs.sh
```

Output:

```
🔵 Listing blobs in Azurite container: pdfs
📄 Found 2 blobs:

 1. English/Project_Documents/2026/P165557-f25f8ee3-ba39-43fe-a0eb-cd711d88eb49.pdf
    📊 Size: 1,190,184 bytes (1.14 MB)
    📅 Modified: 2025-09-25 01:44:57+00:00
    📋 Content Type: application/pdf

📊 Total: 2 blobs, 1,899,296 bytes (1.81 MB)
```

### Empty Azurite Storage

Clean up Azurite blob storage for testing and development:

```bash
# Empty specific container
python3 utilities/empty_azurite_blobs.py --container pdfs

# Empty all containers
python3 utilities/empty_azurite_blobs.py --all

# Quick cleanup with utility script
utilities/clean_azurite.sh --confirm

# Quiet mode (minimal output)
python3 utilities/empty_azurite_blobs.py --container pdfs --quiet --confirm
```

**Cleanup Options:**

| Option                | Description                      |
| --------------------- | -------------------------------- |
| `--container NAME`    | Empty specific container         |
| `--all`               | Empty all containers in Azurite  |
| `--quiet`             | Minimal output (errors only)     |
| `--confirm`           | Skip confirmation prompt         |
| `--connection STRING` | Custom Azurite connection string |

**Example Output:**

```
🗑️  Azurite Blob Storage Cleanup Tool
🔵 Connecting to Azurite container: pdfs
📄 Found 7 blobs to delete
📊 Total size to delete: 6,610,234 bytes (6.30 MB)
🗑️  Starting deletion process...
   🗑️  Deleted 7/7 blobs (100.0%)
✅ Deletion complete!
   💾 Space freed: 6.30 MB
🎉 Operation completed successfully!
```

## 🔧 Troubleshooting

### Azurite Not Running

```
❌ Failed to initialize Azurite connection: Connection refused
   Make sure Azurite is running: azurite --silent --location c:\azurite --debug c:\azurite\debug.log
```

**Solution**: Start Azurite using `./start_azurite.sh` or manually

### Missing Dependencies

```
Azure Storage libraries not available. Install azure-storage-blob to use this feature.
```

**Solution**: Install dependencies with `pip install -r requirements_azurite.txt`

### Connection Issues

- Ensure Azurite is running on `http://127.0.0.1:10000`
- Check firewall settings
- Verify the connection string is correct

## 🆚 Comparison with Regular PDF Downloader

| Feature          | Regular PDF Downloader        | Azurite PDF Downloader |
| ---------------- | ----------------------------- | ---------------------- |
| **Storage**      | Local filesystem              | Azurite blob storage   |
| **Organization** | Symlinks by country/type/year | Blob hierarchy         |
| **Cloud Ready**  | No                            | Yes                    |
| **Metadata**     | File system attributes        | Blob metadata          |
| **Scalability**  | Limited by disk space         | Scalable blob storage  |
| **Development**  | Local files                   | Cloud-native testing   |

## 📝 Notes

- **Container Creation**: Containers are created automatically if they don't exist
- **Overwrite Behavior**: Existing blobs are overwritten during upload
- **Metadata**: Each blob includes upload timestamp, original filename, and content size
- **Content Type**: All PDFs are stored with `application/pdf` content type
- **Error Handling**: Failed uploads are retried with exponential backoff
- **Progress Tracking**: Shows batch progress in non-verbose mode

## 🔗 Related Files

### Main Scripts

- `setup-database-azurite.sh` - **Automated setup script (recommended)**
- `pdf_downloader_azurite.py` - Main Azurite PDF downloader
- `requirements_azurite.txt` - Python dependencies
- `README_SETUP_AZURITE.md` - Detailed setup documentation
- `pdf_downloader.py` - Original filesystem-based downloader

### Utilities (`utilities/` directory)

- `start_azurite.sh` - Azurite startup script
- `list_azurite_blobs.py` - Blob listing utility
- `empty_azurite_blobs.py` - Blob cleanup utility
- `clean_azurite.sh` - Simple cleanup wrapper script
- `show_document_location_format.py` - Format demonstration
- `README.md` - Utilities documentation

### Convenience Wrappers

- `list-blobs.sh` - Quick blob listing
