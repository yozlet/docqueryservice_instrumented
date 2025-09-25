# PDF Downloader Storage Options

The PDF Downloader now supports multiple storage backends for downloaded files.

## Storage Types

### Local Storage (Default)

Files are saved to the local filesystem in the specified directory.

```bash
# Default behavior - saves to local 'pdfs' directory
python pdf_downloader.py --input worldbank_data.sql

# Custom local directory
python pdf_downloader.py --input worldbank_data.sql --output /path/to/pdfs
```

### Azure Blob Storage (Dummy Implementation)

Files are uploaded to Azure Blob Storage. **Note: This is currently a dummy implementation for testing purposes.**

```bash
# Azure Blob Storage
python pdf_downloader.py --input worldbank_data.sql \
  --storage azure_blob \
  --azure-connection-string "DefaultEndpointsProtocol=https;AccountName=myaccount;AccountKey=..." \
  --azure-container "documents"
```

## Command Line Options

- `--storage {local,azure_blob}`: Storage backend type (default: local)
- `--azure-connection-string`: Azure Blob Storage connection string (required for azure_blob)
- `--azure-container`: Azure Blob Storage container name (default: pdfs)

## Implementation Notes

### Local Storage

- Creates organized directory structure by country/type/year
- Supports symlinks for file organization
- Full file system operations supported

### Azure Blob Storage (Dummy)

- **Currently a dummy implementation for testing**
- Simulates upload operations with console output
- Does not support organized symlinks (blob storage limitation)
- Ready for real Azure SDK integration

## Future Enhancements

To implement real Azure Blob Storage support:

1. Install Azure SDK: `pip install azure-storage-blob`
2. Uncomment the Azure client code in `AzureBlobStorage` class
3. Remove dummy simulation code
4. Test with real Azure storage account

## Error Handling

Both storage backends include:

- File existence checking before download
- Progress tracking during download
- Error recovery and retry logic
- Detailed logging of operations

