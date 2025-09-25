# Utilities Directory

This directory contains utility scripts for managing Azurite blob storage and other helper functions.

## 🗄️ Database Utilities

### `database.py`

Core database connection utilities and operations.

```bash
python3 utilities/database.py
```

**Features:**

- Database connection testing
- Schema initialization
- Basic database operations
- Connection utilities for other scripts

### `cleanup-database.py`

Comprehensive database cleanup utility.

```bash
# Show current table counts
python3 utilities/cleanup-database.py --show-counts

# Clean PostgreSQL database
python3 utilities/cleanup-database.py --confirm

# Clean SQL Server database
python3 utilities/cleanup-database.py --confirm --db-type sqlserver
```

**Features:**

- Multi-database support (PostgreSQL, SQL Server)
- Table row counting
- Safe cleanup with confirmation
- Environment variable loading
- Detailed logging and progress tracking

### `cleanup-database.sh`

Shell wrapper for the database cleanup utility.

```bash
# Show usage
utilities/cleanup-database.sh

# Clean database with confirmation
utilities/cleanup-database.sh --confirm

# Clean SQL Server database
utilities/cleanup-database.sh --confirm --db-type sqlserver
```

**Features:**

- Automatic environment loading
- Python dependency checking
- Simple command-line interface
- Error handling and validation

## 🔵 Azurite Utilities

### `list_azurite_blobs.py`

Lists all blobs in Azurite storage with detailed information.

```bash
python3 list_azurite_blobs.py
```

**Output:**

- Blob names with hierarchical paths
- File sizes and modification dates
- Content types and metadata
- Total storage summary

### `empty_azurite_blobs.py`

Comprehensive cleanup tool for Azurite blob storage.

```bash
# Empty specific container
python3 empty_azurite_blobs.py --container pdfs

# Empty all containers
python3 empty_azurite_blobs.py --all

# Quiet mode with auto-confirm
python3 empty_azurite_blobs.py --container pdfs --quiet --confirm
```

**Features:**

- Container-specific or bulk cleanup
- Progress tracking with size reporting
- Safety confirmation prompts
- Detailed logging and error handling

### `clean_azurite.sh`

Simple wrapper script for easy Azurite cleanup.

```bash
# Clean default container (pdfs)
./clean_azurite.sh --confirm

# Clean specific container
./clean_azurite.sh --container=test1 --confirm

# Clean all containers
./clean_azurite.sh --all --confirm
```

### `start_azurite.sh`

Starts Azurite blob storage emulator with proper configuration.

```bash
./start_azurite.sh
```

**Features:**

- Automatic npm installation if needed
- Creates data directory structure
- Starts all Azurite services (blob, queue, table)
- Provides service endpoints and status

## 🛠️ Helper Utilities

### `show_document_location_format.py`

Demonstrates the difference between Azurite and filesystem document location formats.

```bash
python3 show_document_location_format.py
```

**Shows:**

- Azurite blob path examples
- Filesystem path examples
- Detection logic for distinguishing storage types
- Real-world usage patterns

## 📁 Directory Structure

```
utilities/
├── database.py                       # Database connection utilities
├── cleanup-database.py               # Database cleanup utility
├── cleanup-database.sh               # Database cleanup wrapper
├── database_requirements.txt         # Database Python dependencies
├── cleanup_requirements.txt          # Cleanup Python dependencies
├── list_azurite_blobs.py             # Blob listing utility
├── empty_azurite_blobs.py            # Blob cleanup utility
├── clean_azurite.sh                  # Azurite cleanup wrapper script
├── start_azurite.sh                  # Azurite startup script
├── list-blobs.sh                     # Quick blob listing wrapper
└── show_document_location_format.py  # Format demonstration
```

## 🚀 Quick Access from Main Directory

Wrapper scripts are available in the main scripts directory for convenience:

```bash
# From scripts/ directory

# Database utilities
utilities/cleanup-database.sh --confirm  # Database cleanup (direct call)
python3 database.py                      # → utilities/database.py (wrapper available)

# Azurite utilities
./list-blobs.sh                       # → utilities/list_azurite_blobs.py
utilities/clean_azurite.sh --confirm  # Direct utility call
```

## 🔧 Integration

These utilities are integrated into the main setup and workflow scripts:

- **`setup-database-azurite.sh`** - Uses utilities for cleanup and verification
- **`pdf_downloader_azurite.py`** - References blob listing for summaries
- **Main README files** - Document utility usage and examples

## 💡 Usage Tips

1. **Development Workflow**: Use `list_azurite_blobs.py` to verify uploads
2. **Testing Cycles**: Use `clean_azurite.sh --confirm` between test runs
3. **Troubleshooting**: Check Azurite logs in `./azurite_data/debug.log`
4. **Performance**: Utilities are optimized for both speed and detailed reporting

## 🔗 Related Documentation

- `../README_AZURITE.md` - Main Azurite PDF downloader documentation
- `../README_SETUP_AZURITE.md` - Comprehensive setup guide
- `../../docs/` - Project-wide documentation
