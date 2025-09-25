#!/usr/bin/env python3
"""
World Bank PDF Downloader - Azurite Blob Storage Version
Downloads PDF files from World Bank scraper output directly to Azurite blob storage.
Supports resuming interrupted downloads and parallel processing.
"""

import os
import re
import sys
import json
import time
import argparse
import requests
import sqlite3
import hashlib
import logging
from pathlib import Path
from typing import List, Dict, Optional, Tuple
from urllib.parse import urlparse, unquote

# Suppress verbose Azure SDK HTTP logging immediately
azure_loggers = [
    'azure.core.pipeline.policies.http_logging_policy',
    'azure.storage.blob',
    'azure.core',
    'azure.identity'
]
for logger_name in azure_loggers:
    logging.getLogger(logger_name).setLevel(logging.WARNING)
from concurrent.futures import ThreadPoolExecutor, as_completed
from datetime import datetime
import threading
import signal
from enum import Enum

# Azure Blob Storage imports
try:
    from azure.storage.blob import BlobServiceClient, BlobClient, ContainerClient
    from azure.core.exceptions import ResourceExistsError, ResourceNotFoundError
    AZURE_AVAILABLE = True
except ImportError:
    AZURE_AVAILABLE = False
    print("Azure Storage libraries not available. Install azure-storage-blob to use this feature.")

# Try to import database utilities (optional)
try:
    # Import from utilities directory
    sys.path.insert(0, os.path.join(os.path.dirname(__file__), 'utilities'))
    from database import DatabaseManager, DatabaseConfig
    DATABASE_AVAILABLE = True
except ImportError:
    DATABASE_AVAILABLE = False
    print("Database utilities not available. Document status updates will be skipped.")

class AzuriteStorage:
    """Azurite Blob Storage backend for local development."""
    
    def __init__(self, config: Dict[str, str]):
        self.config = config
        self.connection_string = config.get('connection_string', 'DefaultEndpointsProtocol=http;AccountName=devstoreaccount1;AccountKey=Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==;BlobEndpoint=http://127.0.0.1:10000/devstoreaccount1;')
        self.container_name = config.get('container_name', 'pdfs')
        
        if not AZURE_AVAILABLE:
            raise ImportError("Azure Storage libraries not available. Install azure-storage-blob: pip install azure-storage-blob")
        
        try:
            # Initialize Azure Blob Storage client for Azurite
            self.blob_service_client = BlobServiceClient.from_connection_string(self.connection_string)
            
            # Create container if it doesn't exist
            try:
                self.container_client = self.blob_service_client.create_container(self.container_name)
                print(f"✅ Created container: {self.container_name}")
            except ResourceExistsError:
                self.container_client = self.blob_service_client.get_container_client(self.container_name)
                print(f"✅ Using existing container: {self.container_name}")
            
            print(f"🔵 Azurite Blob Storage initialized")
            print(f"   📦 Container: {self.container_name}")
            print(f"   🔗 Endpoint: {self.connection_string.split('BlobEndpoint=')[1].split(';')[0] if 'BlobEndpoint=' in self.connection_string else 'default'}")
            
        except Exception as e:
            print(f"❌ Failed to initialize Azurite connection: {e}")
            print("   Make sure Azurite is running: azurite --silent --location c:\\azurite --debug c:\\azurite\\debug.log")
            raise
    
    def save_file(self, file_path: str, content: bytes) -> bool:
        """Save file to Azurite Blob Storage."""
        try:
            # Clean the file path for blob naming (no leading slashes)
            blob_name = file_path.lstrip('/')
            
            blob_client = self.blob_service_client.get_blob_client(
                container=self.container_name, 
                blob=blob_name
            )
            
            # Upload with metadata
            metadata = {
                'original_filename': Path(file_path).name,
                'upload_timestamp': datetime.utcnow().isoformat(),
                'content_size': str(len(content))
            }
            
            # Create content settings properly
            from azure.storage.blob import ContentSettings
            content_settings = ContentSettings(content_type='application/pdf')
            
            blob_client.upload_blob(
                content, 
                overwrite=True,
                metadata=metadata,
                content_settings=content_settings
            )
            
            return True
            
        except Exception as e:
            logging.error(f"Failed to upload to Azurite Blob: {e}")
            return False
    
    def file_exists(self, file_path: str) -> bool:
        """Check if file exists in Azurite Blob Storage."""
        try:
            blob_name = file_path.lstrip('/')
            blob_client = self.blob_service_client.get_blob_client(
                container=self.container_name, 
                blob=blob_name
            )
            return blob_client.exists()
        except Exception:
            return False
    
    def get_file_size(self, file_path: str) -> int:
        """Get file size from Azurite Blob Storage."""
        try:
            blob_name = file_path.lstrip('/')
            blob_client = self.blob_service_client.get_blob_client(
                container=self.container_name, 
                blob=blob_name
            )
            properties = blob_client.get_blob_properties()
            return properties.size
        except Exception:
            return 0
    
    def list_blobs(self, prefix: str = "") -> List[str]:
        """List all blobs with optional prefix filter."""
        try:
            blobs = self.container_client.list_blobs(name_starts_with=prefix)
            return [blob.name for blob in blobs]
        except Exception as e:
            logging.error(f"Failed to list blobs: {e}")
            return []
    
    def delete_blob(self, file_path: str) -> bool:
        """Delete a blob from storage."""
        try:
            blob_name = file_path.lstrip('/')
            blob_client = self.blob_service_client.get_blob_client(
                container=self.container_name, 
                blob=blob_name
            )
            blob_client.delete_blob()
            return True
        except Exception as e:
            logging.error(f"Failed to delete blob {file_path}: {e}")
            return False

class AzuritePDFDownloader:
    def __init__(self, container_name: str = "pdfs", max_workers: int = 3, 
                 delay_between_requests: float = 1.0, verbose: bool = True, test_failures: bool = False,
                 azurite_connection_string: Optional[str] = None,
                 update_database: bool = False, db_config: Optional[Dict[str, str]] = None,
                 update_sql_file: bool = True, sql_file_path: Optional[str] = None,
                 max_downloads: Optional[int] = None, timeout: int = 30):
        if verbose:
            print("🚀 Initializing Azurite PDF Downloader...")
        else:
            print("🔵 Uploading to Azurite...")
        
        self.container_name = container_name
        self.max_workers = max_workers
        self.delay_between_requests = delay_between_requests
        self.verbose = verbose
        self.test_failures = test_failures
        self.max_downloads = max_downloads
        self.timeout = timeout
        self.start_time = time.time()
        self.last_heartbeat = time.time()
        
        # Initialize Azurite storage backend
        storage_config = {
            'container_name': container_name,
            'connection_string': azurite_connection_string or 'DefaultEndpointsProtocol=http;AccountName=devstoreaccount1;AccountKey=Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==;BlobEndpoint=http://127.0.0.1:10000/devstoreaccount1;'
        }
        
        self.storage = AzuriteStorage(storage_config)
        if self.verbose:
            print(f"✅ Azurite storage backend initialized")
        
        # Initialize database connection for status updates
        self.update_database = update_database and DATABASE_AVAILABLE
        self.db_manager = None
        
        if self.update_database:
            try:
                if db_config:
                    db_config_obj = DatabaseConfig(
                        server=db_config.get('server', 'localhost'),
                        port=int(db_config.get('port', 1433)),
                        database=db_config.get('database', 'DocQueryService'),
                        username=db_config.get('username', 'sa'),
                        password=db_config.get('password', 'DevPassword123!')
                    )
                else:
                    db_config_obj = DatabaseConfig.from_env()
                
                self.db_manager = DatabaseManager(db_config_obj)
                
                # Test database connection
                if self.db_manager.test_connection():
                    if self.verbose:
                        print(f"🗄️  Database: Connected for status updates")
                else:
                    if self.verbose:
                        print(f"⚠️  Database: Connection failed, status updates disabled")
                    self.update_database = False
                    self.db_manager = None
                    
            except Exception as e:
                if self.verbose:
                    print(f"⚠️  Database: Setup failed ({e}), status updates disabled")
                self.update_database = False
                self.db_manager = None
        else:
            if self.verbose:
                print(f"ℹ️  Database: Status updates disabled")
        
        if self.verbose:
            print(f"📊 Document status updates: {'Enabled' if self.update_database else 'Disabled'}")
        
        # Initialize SQL file updates
        self.update_sql_file = update_sql_file
        self.sql_file_path = sql_file_path
        self.document_updates = {}  # Track status updates for SQL file
        
        if self.update_sql_file:
            if self.verbose:
                if self.sql_file_path and os.path.exists(self.sql_file_path):
                    print(f"📝 SQL file updates: Will update {self.sql_file_path}")
                else:
                    print(f"📝 SQL file updates: Enabled but no valid file path provided")
        
        # Thread-safe counters and status
        self.lock = threading.Lock()
        self.downloaded_count = 0
        self.skipped_count = 0
        self.failed_count = 0
        self.active_downloads = set()  # Track active download threads
        self.total_documents = 0
        self.shutdown_requested = False
        
        # Setup logging
        self.setup_logging()
        
        # Setup session with better configuration
        if self.verbose:
            print("🌐 Configuring HTTP session...")
        self.session = requests.Session()
        self.session.headers.update({
            'User-Agent': 'WorldBank-PDF-Downloader-Azurite/1.0 (Document Query Service)',
            'Accept': 'application/pdf,*/*',
            'Accept-Encoding': 'gzip, deflate',
            'Connection': 'keep-alive'
        })
        
        # Configure session with retries and timeouts
        from requests.adapters import HTTPAdapter
        from urllib3.util.retry import Retry
        
        retry_strategy = Retry(
            total=3,
            backoff_factor=1,
            status_forcelist=[429, 500, 502, 503, 504],
        )
        adapter = HTTPAdapter(max_retries=retry_strategy)
        self.session.mount("http://", adapter)
        self.session.mount("https://", adapter)
        
        if self.verbose:
            print(f"✅ Session configured with retry strategy (3 retries, backoff)")
        
        # Setup signal handlers for graceful shutdown
        self.setup_signal_handlers()
        
        # Start heartbeat thread
        self.heartbeat_thread = threading.Thread(target=self._heartbeat_worker, daemon=True)
        self.heartbeat_thread.start()
        
        if self.verbose:
            print(f"✅ Azurite PDF Downloader initialized successfully!")
            print(f"   🔵 Container: {self.container_name}")
            print(f"   ⚡ Max workers: {self.max_workers}")
            print(f"   ⏱️  Request delay: {self.delay_between_requests}s")
            print(f"   🔊 Verbose logging: {'Enabled' if self.verbose else 'Disabled'}")
        
        # Test Azurite connectivity
        self._test_azurite_connectivity()
        
        if self.verbose:
            print("-" * 60)
    
    def _test_azurite_connectivity(self):
        """Test Azurite connectivity."""
        if self.verbose:
            print("🔵 Testing Azurite connectivity...")
        try:
            # Try to list blobs to test connection
            blobs = self.storage.list_blobs()
            if self.verbose:
                print(f"   ✅ Azurite connection: OK ({len(blobs)} existing blobs)")
            
            # Test upload/download with a small test file
            test_content = b"Azurite connectivity test"
            test_blob_name = f"test_connectivity_{int(time.time())}.txt"
            
            if self.storage.save_file(test_blob_name, test_content):
                if self.verbose:
                    print(f"   ✅ Test upload: OK")
                
                # Clean up test file
                if self.storage.delete_blob(test_blob_name):
                    if self.verbose:
                        print(f"   ✅ Test cleanup: OK")
                else:
                    if self.verbose:
                        print(f"   ⚠️  Test cleanup: Failed (non-critical)")
            else:
                if self.verbose:
                    print(f"   ❌ Test upload: Failed")
                
        except Exception as e:
            if self.verbose:
                print(f"   ❌ Azurite connectivity test failed: {e}")
                print("   ⚠️  Make sure Azurite is running:")
                print("      azurite --silent --location c:\\azurite --debug c:\\azurite\\debug.log")
            self.logger.warning(f"Azurite connectivity test failed: {e}")
    
    def setup_logging(self):
        """Setup comprehensive logging system."""
        # Create a simple in-memory log since we're not using local filesystem
        logging.basicConfig(
            level=logging.INFO,
            format='%(asctime)s - %(levelname)s - %(message)s',
            handlers=[
                logging.StreamHandler(sys.stdout) if self.verbose else logging.NullHandler()
            ]
        )
        
        self.logger = logging.getLogger(__name__)
        self.logger.info("Azurite PDF Downloader logging initialized")
    
    def setup_signal_handlers(self):
        """Setup signal handlers for immediate shutdown."""
        def signal_handler(signum, frame):
            print(f"\n⚠️  Received signal {signum} (Ctrl+C), shutting down immediately...")
            self.shutdown_requested = True
            self.logger.warning(f"Shutdown requested via signal {signum}")
            
            # Force exit if called again
            def force_exit(signum, frame):
                print(f"\n💥 Force shutdown requested, exiting immediately!")
                sys.exit(130)
            
            signal.signal(signal.SIGINT, force_exit)
            signal.signal(signal.SIGTERM, force_exit)
        
        signal.signal(signal.SIGINT, signal_handler)
        signal.signal(signal.SIGTERM, signal_handler)
        print("🛡️  Signal handlers configured (Ctrl+C for graceful shutdown, twice for immediate exit)")
    
    def _heartbeat_worker(self):
        """Background thread that provides periodic status updates."""
        while not self.shutdown_requested:
            try:
                time.sleep(30)  # Heartbeat every 30 seconds
                if not self.shutdown_requested:
                    self._log_heartbeat()
            except Exception as e:
                self.logger.error(f"Heartbeat worker error: {e}")
    
    def _log_heartbeat(self):
        """Log current status as heartbeat."""
        with self.lock:
            total_processed = self.downloaded_count + self.skipped_count + self.failed_count
            active_count = len(self.active_downloads)
            
        elapsed = time.time() - self.start_time
        
        if total_processed > 0 or active_count > 0:
            status_msg = (
                f"💓 HEARTBEAT - Elapsed: {elapsed:.0f}s | "
                f"Processed: {total_processed}/{self.total_documents} | "
                f"Active: {active_count} | "
                f"✅{self.downloaded_count} ⏭️{self.skipped_count} ❌{self.failed_count}"
            )
            print(status_msg)
            self.logger.info(status_msg)
    
    def parse_sql_file(self, sql_file: str) -> List[Dict[str, str]]:
        """Parse SQL file to extract document metadata and PDF URLs."""
        print(f"📖 Parsing SQL file: {sql_file}")
        self.logger.info(f"Starting to parse SQL file: {sql_file}")
        
        documents = []
        
        try:
            # Read file and show size
            file_path = Path(sql_file)
            file_size = file_path.stat().st_size
            print(f"   📊 File size: {file_size:,} bytes ({file_size/1024/1024:.1f} MB)")
            
            print("   📖 Reading file content...")
            with open(sql_file, 'r', encoding='utf-8') as f:
                content = f.read()
            
            print(f"   ✅ File loaded: {len(content):,} characters")
            
            # Use a much simpler approach - find INSERT blocks and extract URLs directly
            print("   🔍 Searching for document INSERT statements...")
            
            # Split content into chunks to process incrementally
            chunk_size = 50000  # Process 50KB chunks
            total_chunks = (len(content) + chunk_size - 1) // chunk_size
            print(f"   📦 Processing {total_chunks} chunks of ~{chunk_size/1000:.0f}KB each...")
            
            documents_found = 0
            pdf_count = 0
            
            # Pattern to find INSERT INTO documents blocks (handles ON CONFLICT clause)
            insert_pattern = r'INSERT INTO documents\s*\([^)]+\)\s*VALUES\s*\(.*?\)(?:\s*ON\s+CONFLICT[^;]*)?;'
            
            for chunk_num in range(total_chunks):
                if self.shutdown_requested:
                    print("   ⚠️  Parsing interrupted by shutdown request")
                    break
                
                start_pos = chunk_num * chunk_size
                end_pos = min((chunk_num + 1) * chunk_size, len(content))
                
                # Add overlap to avoid cutting statements in half
                if chunk_num > 0:
                    start_pos -= 2000  # 2KB overlap
                if end_pos < len(content):
                    end_pos += 2000  # 2KB overlap
                
                chunk = content[start_pos:end_pos]
                
                # Show progress only every 10 chunks to reduce verbosity
                if chunk_num % 10 == 0 or chunk_num == total_chunks - 1:
                    progress = ((chunk_num + 1) / total_chunks) * 100
                    print(f"   📈 Processing chunk {chunk_num + 1}/{total_chunks} ({progress:.1f}%) - Found {pdf_count} PDFs so far")
                
                # Find all INSERT statements in this chunk
                matches = re.finditer(insert_pattern, chunk, re.DOTALL | re.IGNORECASE)
                
                for match in matches:
                    if self.shutdown_requested:
                        break
                    
                    # Extract the VALUES part
                    full_match = match.group(0)
                    values_start = full_match.upper().find('VALUES')
                    if values_start == -1:
                        continue
                    
                    values_part = full_match[values_start + 6:].strip()
                    
                    # Find the VALUES parentheses content
                    paren_start = values_part.find('(')
                    if paren_start == -1:
                        continue
                    
                    # Find the matching closing parenthesis
                    paren_count = 0
                    paren_end = -1
                    for i, char in enumerate(values_part[paren_start:], paren_start):
                        if char == '(':
                            paren_count += 1
                        elif char == ')':
                            paren_count -= 1
                            if paren_count == 0:
                                paren_end = i
                                break
                    
                    if paren_end == -1:
                        continue
                    
                    values_str = values_part[paren_start + 1:paren_end]  # Extract content between parentheses
                    
                    # Quick check for URL field (8th field) containing PDF
                    if '.pdf' in values_str.lower() or 'documents.worldbank.org' in values_str.lower():
                        # Parse the full values
                        values = self.parse_sql_values(values_str)
                        
                        if len(values) >= 15:  # Ensure we have enough fields
                            doc = {
                                'id': self.clean_value(values[0]),
                                'title': self.clean_value(values[1]),
                                'doc_type': self.clean_value(values[4]) if len(values) > 4 else '',
                                'major_doc_type': self.clean_value(values[5]) if len(values) > 5 else '',
                                'url': self.clean_value(values[8]) if len(values) > 8 else '',
                                'language': self.clean_value(values[10]) if len(values) > 10 else '',
                                'country': self.clean_value(values[11]) if len(values) > 11 else '',
                                'author': self.clean_value(values[12]) if len(values) > 12 else '',
                                'publisher': self.clean_value(values[13]) if len(values) > 13 else '',
                                'date': self.extract_year_from_date_or_title(self.clean_value(values[2]), self.clean_value(values[1]))
                            }
                            
                            documents_found += 1
                            
                            # Only include documents with PDF URLs
                            if doc['url'] and ('.pdf' in doc['url'].lower() or 'documents.worldbank.org' in doc['url']):
                                documents.append(doc)
                                pdf_count += 1
            
            # Final progress update
            print(f"   ✅ Parsing complete: {documents_found:,} records processed")
            print(f"   📄 Found {len(documents)} documents with downloadable PDF URLs")
            
        except Exception as e:
            error_msg = f"Error parsing SQL file: {e}"
            print(f"   ❌ {error_msg}")
            self.logger.error(error_msg)
            return []
        
        self.logger.info(f"SQL parsing complete: {len(documents)} downloadable documents found")
        return documents
    
    def parse_sql_values(self, values_str: str) -> List[str]:
        """Parse SQL VALUES clause, handling quoted strings properly."""
        values = []
        current_value = ""
        in_quotes = False
        quote_char = None
        i = 0
        
        while i < len(values_str):
            char = values_str[i]
            
            if not in_quotes:
                if char in ["'", '"']:
                    in_quotes = True
                    quote_char = char
                elif char == ',':
                    values.append(current_value.strip())
                    current_value = ""
                    i += 1
                    continue
                else:
                    current_value += char
            else:
                if char == quote_char:
                    # Check for escaped quotes
                    if i + 1 < len(values_str) and values_str[i + 1] == quote_char:
                        current_value += char
                        i += 1  # Skip the next quote
                    else:
                        in_quotes = False
                        quote_char = None
                else:
                    current_value += char
            
            i += 1
        
        # Add the last value
        if current_value.strip():
            values.append(current_value.strip())
        
        return values
    
    def clean_value(self, value: str) -> str:
        """Clean SQL value by removing quotes and handling escapes."""
        if not value:
            return ""
        
        value = value.strip()
        if value.startswith("'") and value.endswith("'"):
            value = value[1:-1]
        elif value.startswith('"') and value.endswith('"'):
            value = value[1:-1]
        
        # Handle escaped quotes
        value = value.replace("''", "'").replace('""', '"')
        return value
    
    def extract_year_from_date_or_title(self, date_field: str, title: str) -> str:
        """Extract year from document date field or title for organization."""
        # First try to extract year from the date field
        if date_field and date_field.lower() != 'null':
            # Look for date patterns like '2026-12-31', '2023/01/15', etc.
            date_year_match = re.search(r'\b(19|20)\d{2}\b', date_field)
            if date_year_match:
                return date_year_match.group()
        
        # Fallback to extracting from title
        if title:
            # Look for 4-digit years in title
            title_year_match = re.search(r'\b(19|20)\d{2}\b', title)
            if title_year_match:
                return title_year_match.group()
        
        return "unknown"
    
    def extract_year_from_title(self, title: str) -> str:
        """Extract year from document title for organization (legacy method)."""
        if not title:
            return "unknown"
        
        # Look for 4-digit years
        year_match = re.search(r'\b(19|20)\d{2}\b', title)
        if year_match:
            return year_match.group()
        
        return "unknown"
    
    def sanitize_filename(self, text: str, max_length: int = 100) -> str:
        """Sanitize text for use as blob name."""
        if not text:
            return "unknown"
        
        # Remove or replace problematic characters for blob names
        sanitized = re.sub(r'[<>:"/\\|?*]', '_', text)
        sanitized = re.sub(r'\s+', '_', sanitized)
        sanitized = sanitized.strip('._')
        
        # Truncate if too long
        if len(sanitized) > max_length:
            sanitized = sanitized[:max_length].rstrip('_')
        
        return sanitized or "unknown"
    
    def get_blob_path(self, doc: Dict[str, str], filename: str) -> str:
        """Generate organized blob path for a document."""
        safe_country = self.sanitize_filename(doc.get('country', 'unknown'))
        safe_type = self.sanitize_filename(doc.get('major_doc_type', 'unknown'))
        year = doc.get('date', 'unknown')
        
        # Create hierarchical blob path
        return f"{safe_country}/{safe_type}/{year}/{filename}"
    
    def update_document_status(self, document_id: str, status: str, document_location: Optional[str] = None, error_message: Optional[str] = None) -> bool:
        """Update document status and location in database and/or SQL file."""
        updated = False
        
        # Track update for SQL file
        if self.update_sql_file:
            with self.lock:
                self.document_updates[document_id] = {'status': status, 'location': document_location}
            location_info = f", location: {document_location}" if document_location else ""
            if self.verbose:
                print(f"   📝 [SQL UPDATE] Document {document_id} → status: {status}{location_info}")
            updated = True
        
        # Update database if enabled
        if not self.update_database or not self.db_manager:
            return updated
        
        try:
            with self.db_manager.get_connection() as conn:
                cursor = conn.cursor()
                
                # Update document status and location
                if document_location:
                    sql = """
                    UPDATE documents 
                    SET document_status = %s, document_location = %s, updated_at = CURRENT_TIMESTAMP
                    WHERE id = %s
                    """
                    cursor.execute(sql, (status, document_location, document_id))
                else:
                    sql = """
                    UPDATE documents 
                    SET document_status = %s, updated_at = CURRENT_TIMESTAMP
                    WHERE id = %s
                    """
                    cursor.execute(sql, (status, document_id))
                
                rows_affected = cursor.rowcount
                conn.commit()
                
                if rows_affected > 0:
                    location_info = f" and location to {document_location}" if document_location else ""
                    self.logger.info(f"Updated document {document_id} status to {status}{location_info}")
                    return True
                else:
                    self.logger.warning(f"Document {document_id} not found for status update")
                    return False
                    
        except Exception as e:
            self.logger.error(f"Failed to update document {document_id} status: {e}")
            return False
    
    def update_sql_file_status(self) -> bool:
        """Update the SQL file with document status changes."""
        if not self.update_sql_file or not self.sql_file_path or not self.document_updates:
            return False
        
        try:
            print(f"\n📝 Updating SQL file: {self.sql_file_path}")
            
            # Read the SQL file
            with open(self.sql_file_path, 'r', encoding='utf-8') as f:
                content = f.read()
            
            updated_count = 0
            
            # Update each document status and location
            for document_id, update_info in self.document_updates.items():
                # Handle both old string format and new dict format for backwards compatibility
                if isinstance(update_info, str):
                    new_status = update_info
                    new_location = None
                else:
                    new_status = update_info.get('status', 'PENDING')
                    new_location = update_info.get('location')
                
                # Pattern to find this specific document's INSERT statement
                # Look for the document ID and then find the status field
                pattern = rf"(INSERT INTO documents[^;]+VALUES[^;]+'{document_id}'[^;]+)'PENDING'([^;]+;)"
                
                def replace_status(match):
                    nonlocal updated_count
                    updated_count += 1
                    # If we have a location, also try to update the document_location field
                    result = f"{match.group(1)}'{new_status}'{match.group(2)}"
                    if new_location:
                        # Try to update document_location field if it exists in the INSERT
                        # Need to be more specific - replace the document_location NULL, not volnb/totvolnb NULLs
                        # Look for the pattern: url, NULL, status and replace the NULL between them
                        # The status could be 'PENDING', 'DOWNLOADED', etc.
                        # Handle multi-line pattern with whitespace and newlines
                        url_location_pattern = r"('https?://[^']+'),\s*\n\s*NULL,\s*\n\s*('[^']*')"
                        if re.search(url_location_pattern, result, re.MULTILINE):
                            result = re.sub(url_location_pattern, rf"\1,\n    '{new_location}',\n    \2", result, flags=re.MULTILINE)
                    return result
                
                content = re.sub(pattern, replace_status, content, flags=re.DOTALL)
            
            # Write back to file
            with open(self.sql_file_path, 'w', encoding='utf-8') as f:
                f.write(content)
            
            print(f"   ✅ Updated {updated_count} document statuses in SQL file")
            self.logger.info(f"Updated SQL file with {updated_count} status changes")
            return True
            
        except Exception as e:
            print(f"   ❌ Failed to update SQL file: {e}")
            self.logger.error(f"Failed to update SQL file: {e}")
            return False
    
    def download_pdf(self, doc: Dict[str, str], max_retries: int = 3) -> bool:
        """Download a single PDF with organized storage and retry logic."""
        url = doc['url']
        thread_id = threading.current_thread().ident
        
        # Track this download
        with self.lock:
            self.active_downloads.add(thread_id)
            current_position = self.downloaded_count + self.skipped_count + self.failed_count + 1
        
        # Retry logic with exponential backoff
        for attempt in range(max_retries + 1):  # 0, 1, 2, 3 (4 total attempts)
            try:
                return self._attempt_download(doc, current_position, attempt + 1, max_retries + 1)
            except Exception as e:
                if attempt < max_retries:  # Not the last attempt
                    retry_delay = (2 ** attempt) * 1.0  # Exponential backoff: 1s, 2s, 4s
                    if self.verbose:
                        print(f"   🔄 Attempt {attempt + 1}/{max_retries + 1} failed: {type(e).__name__}")
                        print(f"   ⏳ Retrying in {retry_delay:.1f}s...")
                    self.logger.warning(f"Download attempt {attempt + 1} failed for {url}: {e}")
                    time.sleep(retry_delay)
                    continue
                else:
                    # All retries failed
                    with self.lock:
                        self.active_downloads.discard(thread_id)
                        self.failed_count += 1
                    
                    doc_id = doc.get('id', '')
                    if doc_id:
                        self.update_document_status(doc_id, 'FAILED', error_message=str(e))
                    
                    if self.verbose:
                        print(f"❌ [{current_position}/{self.total_documents}] FAILED: {doc.get('title', 'Unknown')[:60]}")
                        print(f"   🚫 All {max_retries + 1} attempts failed: {e}")
                    
                    self.logger.error(f"Download failed after {max_retries + 1} attempts: {url} - {e}")
                    return False
        
        return False  # Should never reach here
    
    def _attempt_download(self, doc: Dict[str, str], current_position: int, attempt: int, total_attempts: int) -> bool:
        """Single download attempt."""
        url = doc['url']
        thread_id = threading.current_thread().ident
        
        # Generate filename
        title_display = doc.get('title', 'Unknown Title')[:60]
        # Only log to file, no console output for individual downloads unless verbose
        if attempt == 1:
            self.logger.info(f"Starting download {current_position}: {title_display}")
        elif self.verbose:  # Only show retries in verbose mode
            print(f"🔄 [{current_position}/{self.total_documents}] Retry {attempt}/{total_attempts}: {title_display}...")
        
        # Test failure simulation
        if self.test_failures:
            import random
            failure_chance = random.random()
            if failure_chance < 0.1:  # 10% chance of simulated failure
                failure_types = [
                    (requests.exceptions.Timeout, "Simulated timeout"),
                    (requests.exceptions.ConnectionError, "Simulated connection error"),
                    (requests.exceptions.HTTPError, "Simulated HTTP error"),
                ]
                error_class, error_msg = random.choice(failure_types)
                if self.verbose:
                    print(f"   🧪 TEST MODE: Simulating {error_class.__name__}")
                raise error_class(error_msg)
        
        # Network diagnostics (only in verbose mode)
        if self.verbose:
            print(f"   🌐 URL: {url}")
            parsed_url = urlparse(url)
            print(f"   🏠 Host: {parsed_url.netloc}")
            
            # Test connectivity first
            print(f"   🔌 Testing connectivity to {parsed_url.netloc}...")
            try:
                import socket
                host = parsed_url.netloc.split(':')[0]  # Remove port if present
                socket.gethostbyname(host)
                print(f"   ✅ DNS resolution successful")
            except socket.gaierror as e:
                print(f"   ❌ DNS resolution failed: {e}")
                raise Exception(f"DNS resolution failed for {host}: {e}")
        else:
            parsed_url = urlparse(url)
            try:
                import socket
                host = parsed_url.netloc.split(':')[0]  # Remove port if present
                socket.gethostbyname(host)
            except socket.gaierror as e:
                if self.verbose:
                    print(f"   ❌ DNS resolution failed: {e}")
                raise Exception(f"DNS resolution failed for {host}: {e}")
        
        original_filename = Path(unquote(parsed_url.path)).name
        
        if not original_filename or not original_filename.lower().endswith('.pdf'):
            # Generate filename from document info
            title_part = self.sanitize_filename(doc.get('title', ''), 50)
            doc_id = doc.get('id', hashlib.md5(url.encode()).hexdigest()[:8])
            original_filename = f"{doc_id}_{title_part}.pdf"
        
        # Get blob path
        blob_path = self.get_blob_path(doc, original_filename)
        
        # Check if already downloaded using storage backend
        if self.storage.file_exists(blob_path):
            file_size = self.storage.get_file_size(blob_path)
            with self.lock:
                self.skipped_count += 1
                self.active_downloads.discard(thread_id)
            
            # Update document status to DOWNLOADED since file exists
            doc_id = doc.get('id', '')
            if doc_id:
                self.update_document_status(doc_id, 'DOWNLOADED', blob_path)
            
            # Only show skip message in verbose mode
            if self.verbose:
                print(f"   ✓ Skipped (exists): {blob_path} ({file_size:,} bytes)")
            self.logger.info(f"Skipped existing blob: {blob_path}")
            return True
        
        # Download the file
        if self.verbose:
            print(f"   ⬇ Starting download: {original_filename}")
            print(f"   🔵 Target blob: {blob_path}")
        
        # Start download with enhanced progress tracking
        download_start = time.time()
        
        try:
            response = self.session.get(url, stream=True, timeout=self.timeout)
            response.raise_for_status()
            
            connection_time = time.time() - download_start
            if self.verbose:
                print(f"   ✅ Connection established ({connection_time:.2f}s)")
            self.logger.info(f"HTTP connection established in {connection_time:.2f}s")
            
        except requests.exceptions.Timeout:
            if self.verbose:
                print(f"   ⏰ Request timeout ({self.timeout}s) - server may be slow")
            raise
        except requests.exceptions.ConnectionError as e:
            if self.verbose:
                print(f"   🔌 Connection error: {e}")
            raise
        except requests.exceptions.HTTPError as e:
            if self.verbose:
                print(f"   🚫 HTTP error: {e}")
                print(f"   📊 Status code: {response.status_code}")
            raise
        
        # Get content length for progress tracking
        content_length = response.headers.get('content-length')
        total_size = int(content_length) if content_length else None
        
        # Analyze response headers
        content_type = response.headers.get('content-type', '').lower()
        if self.verbose:
            print(f"   📋 Content-Type: {content_type}")
            
            if total_size:
                print(f"   📊 Expected size: {total_size:,} bytes ({total_size/1024/1024:.1f} MB)")
            else:
                print(f"   📊 Size: Unknown (no Content-Length header)")
        
        # Check if it's actually a PDF
        if 'pdf' not in content_type and not url.lower().endswith('.pdf'):
            if self.verbose:
                print(f"   ⚠️  Warning: May not be a PDF (content-type: {content_type})")
            self.logger.warning(f"Suspicious content type for {original_filename}: {content_type}")
        
        # Download file content to memory first, then save to Azurite
        downloaded_size = 0
        last_progress_time = time.time()
        last_progress_size = 0
        file_content = bytearray()
        
        if self.verbose:
            print(f"   🔵 Downloading to Azurite blob storage: {blob_path}")
        
        for chunk in response.iter_content(chunk_size=8192):
            if self.shutdown_requested:
                if self.verbose:
                    print(f"\n   ⚠️  Download interrupted by shutdown request")
                return False
                
            if chunk:
                file_content.extend(chunk)
                downloaded_size += len(chunk)
                
                # Enhanced progress reporting (only in verbose mode)
                if self.verbose:
                    current_time = time.time()
                    if current_time - last_progress_time >= 2.0:  # Update every 2 seconds
                        if total_size:
                            progress = (downloaded_size / total_size) * 100
                            speed = (downloaded_size - last_progress_size) / (current_time - last_progress_time)
                            eta = (total_size - downloaded_size) / speed if speed > 0 else 0
                            
                            print(f"\r   📈 Progress: {progress:.1f}% ({downloaded_size:,}/{total_size:,} bytes) "
                                  f"Speed: {speed/1024:.1f} KB/s ETA: {eta:.0f}s", end='', flush=True)
                        else:
                            speed = (downloaded_size - last_progress_size) / (current_time - last_progress_time)
                            print(f"\r   📈 Downloaded: {downloaded_size:,} bytes "
                                  f"Speed: {speed/1024:.1f} KB/s", end='', flush=True)
                        
                        last_progress_time = current_time
                        last_progress_size = downloaded_size
        
        # Clear progress line and show final stats
        if self.verbose and (total_size or downloaded_size > 1024*1024):
            print()  # New line after progress
        
        # Save file using Azurite storage backend
        if self.verbose:
            print(f"   🔵 Saving to Azurite blob storage...")
        save_success = self.storage.save_file(blob_path, bytes(file_content))
        
        if not save_success:
            if self.verbose:
                print(f"   ❌ Failed to save file to Azurite blob storage")
            self.logger.error(f"Failed to save {blob_path} to Azurite blob storage")
            return False
        
        download_time = time.time() - download_start
        final_size = len(file_content)
        avg_speed = final_size / download_time if download_time > 0 else 0
        
        if self.verbose:
            print(f"   ✅ Download complete: {final_size:,} bytes in {download_time:.1f}s")
            print(f"   ⚡ Average speed: {avg_speed/1024:.1f} KB/s")
            print(f"   🔵 Saved to Azurite blob: {blob_path}")
        
        # Verify download integrity
        if total_size and final_size != total_size:
            if self.verbose:
                print(f"   ⚠️  Size mismatch: expected {total_size:,}, got {final_size:,}")
            self.logger.warning(f"Size mismatch for {blob_path}: expected {total_size}, got {final_size}")
        
        self.logger.info(f"Download completed: {blob_path} ({final_size:,} bytes in {download_time:.1f}s)")
        
        with self.lock:
            self.downloaded_count += 1
            self.active_downloads.discard(thread_id)
            current_progress = f"[{self.downloaded_count + self.skipped_count + self.failed_count}/{self.total_documents}]"
        
        # Update document status to DOWNLOADED with blob location
        doc_id = doc.get('id', '')
        if doc_id:
            self.update_document_status(doc_id, 'DOWNLOADED', blob_path)
        
        # Only show success message in verbose mode
        if self.verbose:
            print(f"✅ {current_progress} SUCCESS: {blob_path}")
            print(f"   📍 Country: {doc.get('country', 'Unknown')} | Type: {doc.get('major_doc_type', 'Unknown')}")
        
        # Rate limiting (no countdown display unless verbose)
        if self.delay_between_requests > 0:
            if self.verbose:
                print(f"   ⏳ Rate limit delay: {self.delay_between_requests}s...")
                for i in range(int(self.delay_between_requests)):
                    if self.shutdown_requested:
                        break
                    time.sleep(1)
                    if i < int(self.delay_between_requests) - 1:
                        print(f"   ⏳ {int(self.delay_between_requests) - i - 1}s remaining...", end='\r', flush=True)
                print()  # Clear countdown line
            else:
                time.sleep(self.delay_between_requests)
        
        # Only show separator in verbose mode
        if self.verbose:
            print("-" * 80)  # Separator between downloads
        return True
    
    def download_documents(self, documents: List[Dict[str, str]]) -> Dict[str, int]:
        """Download multiple documents with threading."""
        # Apply max_downloads limit if specified
        if self.max_downloads and len(documents) > self.max_downloads:
            print(f"📊 Limiting downloads to {self.max_downloads} documents (out of {len(documents)} available)")
            documents = documents[:self.max_downloads]
        
        self.total_documents = len(documents)
        
        print(f"\n🚀 Starting Azurite PDF Download Session")
        print(f"📊 Total documents to process: {len(documents)}")
        print(f"🔵 Target container: {self.container_name}")
        print(f"⚡ Max concurrent downloads: {self.max_workers}")
        print(f"⏱️  Delay between requests: {self.delay_between_requests}s")
        print(f"⏰ Download timeout: {self.timeout}s")
        if self.max_downloads:
            print(f"🔢 Max downloads limit: {self.max_downloads}")
        print("=" * 80)
        
        self.logger.info(f"Starting Azurite download session: {len(documents)} documents, {self.max_workers} workers")
        
        # Analyze document types for preview
        countries = set(doc.get('country', 'Unknown') for doc in documents)
        doc_types = set(doc.get('major_doc_type', 'Unknown') for doc in documents)
        
        print(f"📈 Document Analysis:")
        print(f"   Countries: {len(countries)} ({', '.join(sorted(list(countries))[:5])}{'...' if len(countries) > 5 else ''})")
        print(f"   Document Types: {len(doc_types)} ({', '.join(sorted(list(doc_types))[:3])}{'...' if len(doc_types) > 3 else ''})")
        print("=" * 80)
        
        start_time = time.time()
        
        # Download with thread pool and enhanced monitoring
        print(f"🔄 Processing documents with {self.max_workers} concurrent workers...")
        
        with ThreadPoolExecutor(max_workers=self.max_workers) as executor:
            # Submit all tasks
            print(f"📋 Submitting {len(documents)} download tasks to thread pool...")
            futures = []
            for i, doc in enumerate(documents):
                if self.shutdown_requested:
                    print(f"⚠️  Shutdown requested, stopping task submission at {i}/{len(documents)}")
                    break
                future = executor.submit(self.download_pdf, doc)
                futures.append(future)
            
            print(f"✅ {len(futures)} tasks submitted to thread pool")
            print(f"🎯 Starting parallel execution...\n")
            
            completed = 0
            last_update_time = time.time()
            
            for future in as_completed(futures):
                if self.shutdown_requested:
                    print(f"⚠️  Shutdown requested, cancelling remaining tasks...")
                    for remaining_future in futures:
                        remaining_future.cancel()
                    break
                
                try:
                    future.result()
                    completed += 1
                    
                    # More frequent progress updates with thread status
                    current_time = time.time()
                    if completed % 5 == 0 or current_time - last_update_time >= 15:  # Every 5 downloads or 15 seconds
                        elapsed = time.time() - start_time
                        rate = completed / elapsed if elapsed > 0 else 0
                        remaining = len(documents) - completed
                        eta = remaining / rate if rate > 0 else 0
                        
                        with self.lock:
                            active_count = len(self.active_downloads)
                        
                        # Calculate current batch information
                        current_batch_start = (completed // 50) * 50
                        current_batch_end = min(current_batch_start + 50, len(documents))
                        
                        # Simplified progress output - just show which group is being worked on
                        print(f"🔵 Working on documents {current_batch_start + 1}-{current_batch_end} | ✅{self.downloaded_count} ⏭️{self.skipped_count} ❌{self.failed_count} | {(completed/len(documents)*100):.1f}% complete")
                        
                        last_update_time = current_time
                        
                except Exception as e:
                    print(f"💥 Unexpected thread pool error: {e}")
                    self.logger.error(f"Thread pool error: {e}")
                    completed += 1  # Count it as processed even if failed
        
        # Final summary
        total_time = time.time() - start_time
        total = len(documents)
        success_rate = (self.downloaded_count / total * 100) if total > 0 else 0
        
        print("\n" + "🎉 " + "=" * 76 + " 🎉")
        print(f"📋 AZURITE DOWNLOAD COMPLETE - Session Summary")
        print("=" * 80)
        print(f"📊 Statistics:")
        print(f"   📥 Total documents processed: {total:,}")
        print(f"   ✅ Successfully downloaded: {self.downloaded_count:,}")
        print(f"   ⏭️  Skipped (already existed): {self.skipped_count:,}")
        print(f"   ❌ Failed downloads: {self.failed_count:,}")
        print(f"   📈 Success rate: {success_rate:.1f}%")
        print(f"")
        print(f"⏱️  Performance:")
        print(f"   🕐 Total time: {total_time:.1f} seconds ({total_time/60:.1f} minutes)")
        print(f"   ⚡ Average rate: {total/total_time:.1f} documents/second")
        print(f"   📦 Data transferred: ~{self.downloaded_count * 0.5:.1f} MB (estimated)")
        print(f"")
        print(f"🔵 Azurite Output:")
        print(f"   📦 Container: {self.container_name}")
        print(f"   🔗 Endpoint: http://127.0.0.1:10000/devstoreaccount1")
        
        # List some blobs as examples
        try:
            sample_blobs = self.storage.list_blobs()[:5]
            if sample_blobs:
                print(f"   📄 Sample blobs:")
                for blob in sample_blobs:
                    print(f"      • {blob}")
                if len(sample_blobs) == 5:
                    print(f"      • ... and {max(0, self.downloaded_count - 5)} more")
        except Exception as e:
            print(f"   ⚠️  Could not list sample blobs: {e}")
        
        print("=" * 80)
        
        # Update SQL file with document status changes
        if self.update_sql_file and self.document_updates:
            self.update_sql_file_status()
        
        return {
            'downloaded': self.downloaded_count,
            'skipped': self.skipped_count,
            'failed': self.failed_count
        }

def print_banner(verbose=True):
    """Print startup banner."""
    if verbose:
        banner = """
╔══════════════════════════════════════════════════════════════════════════════╗
║                    🔵 World Bank PDF Downloader - Azurite 🔵                  ║
║                                                                              ║
║  📄 Downloads PDF documents from World Bank scraper output                   ║
║  🔵 Stores files directly in Azurite blob storage                           ║
║  🔄 Supports parallel downloads with progress tracking                       ║
║  📊 Provides detailed logging and network diagnostics                        ║
║  🗂️  Creates organized blob hierarchy by country/type/year                   ║
║                                                                              ║
║  🚀 Starting up... Please wait for initialization to complete               ║
╚══════════════════════════════════════════════════════════════════════════════╝
        """
        print(banner)
    else:
        print("🔵 World Bank PDF Downloader (Azurite) - Starting...")

def main():
    # Parse args to get verbose/quiet flags early for banner
    import sys
    verbose = '--verbose' in sys.argv
    quiet = '--quiet' in sys.argv
    
    # Default to quiet mode unless verbose is specified
    if not verbose and not quiet:
        quiet = True
    
    print_banner(verbose and not quiet)
    
    parser = argparse.ArgumentParser(
        description='Download PDFs from World Bank scraper output to Azurite blob storage',
        epilog="""
Examples:
  # Download from SQL file to Azurite (default container)
  python pdf_downloader_azurite.py sample_data.sql
  
  # Download with custom container and settings
  python pdf_downloader_azurite.py data.sql --container my-pdfs --max-workers 5
  
  # Download with custom Azurite connection
  python pdf_downloader_azurite.py data.sql --azurite-connection "DefaultEndpointsProtocol=http;AccountName=devstoreaccount1;..."
  
  # Run with limited downloads for testing
  python pdf_downloader_azurite.py data.sql --max-downloads 10 --verbose
        """,
        formatter_class=argparse.RawDescriptionHelpFormatter
    )
    parser.add_argument('input_file', nargs='?', 
                       help='Input SQL file path (positional argument)')
    parser.add_argument('--input', type=str, 
                       help='Input SQL file path (named argument)')
    parser.add_argument('--container', type=str, default='pdfs',
                       help='Azurite blob container name (default: pdfs)')
    parser.add_argument('--max-workers', type=int, default=3,
                       help='Maximum concurrent downloads (default: 3)')
    parser.add_argument('--max-downloads', type=int, 
                       help='Maximum number of files to download (default: no limit)')
    parser.add_argument('--timeout', type=int, default=30,
                       help='Timeout for each download in seconds (default: 30)')
    parser.add_argument('--delay', type=float, default=1.0,
                       help='Delay between requests in seconds (default: 1.0)')
    parser.add_argument('--quiet', action='store_true',
                       help='Reduce verbose output (only errors and final summary)')
    parser.add_argument('--verbose', action='store_true',
                       help='Enable extra verbose output (default: True unless --quiet)')
    parser.add_argument('--test-failures', action='store_true',
                       help='Test mode: simulate random failures for testing error handling')
    
    # Azurite configuration
    parser.add_argument('--azurite-connection', type=str,
                       help='Azurite connection string (default: local Azurite instance)')
    
    # Database configuration for status updates
    parser.add_argument('--enable-database-updates', action='store_true',
                       help='Enable document status updates in database (disabled by default)')
    parser.add_argument('--db-server', type=str, default='localhost',
                       help='Database server (default: localhost)')
    parser.add_argument('--db-port', type=int, default=1433,
                       help='Database port (default: 1433)')
    parser.add_argument('--db-name', type=str, default='DocQueryService',
                       help='Database name (default: DocQueryService)')
    parser.add_argument('--db-username', type=str, default='sa',
                       help='Database username (default: sa)')
    parser.add_argument('--db-password', type=str, default='DevPassword123!',
                       help='Database password (default: DevPassword123!)')
    parser.add_argument('--update-sql-file', action='store_true', default=True,
                       help='Update SQL file with document status (enabled by default)')
    parser.add_argument('--no-sql-file-updates', action='store_true',
                       help='Disable SQL file status updates')
    
    args = parser.parse_args()
    
    # Determine verbosity (use early parsed flags)
    verbose_mode = args.verbose and not args.quiet
    # Default to quiet mode unless verbose is specified
    if not args.verbose and not args.quiet:
        verbose_mode = False
    
    # Handle input file from positional argument or --input flag
    input_file = args.input_file or args.input
    
    if not input_file:
        # Try to find default files in common locations
        potential_files = [
            'sample_data.sql',           # Current directory
            'scripts/sample_data.sql',   # Scripts directory
            'worldbank_data.sql',        # Legacy name
            'scripts/worldbank_data.sql' # Legacy location
        ]
        
        for sql_file in potential_files:
            if os.path.exists(sql_file):
                input_file = sql_file
                print(f"📄 Using default SQL file: {sql_file}")
                break
        
        if not input_file:
            print("❌ Error: No input file specified and no default file found.")
            print("\nUsage:")
            print("  python pdf_downloader_azurite.py <input_file>")
            print("  python pdf_downloader_azurite.py --input <input_file>")
            print("\nSearched for these files:")
            for f in potential_files:
                print(f"  - {f}")
            sys.exit(1)
    
    if not os.path.exists(input_file):
        print(f"Error: Input file not found: {input_file}")
        sys.exit(1)
    
    # Configure database for status updates (disabled by default)
    update_database = args.enable_database_updates
    db_config = None
    
    if update_database:
        db_config = {
            'server': args.db_server,
            'port': args.db_port,
            'database': args.db_name,
            'username': args.db_username,
            'password': args.db_password
        }
        if verbose_mode:
            print(f"🗄️  Database updates: Enabled ({args.db_server}:{args.db_port}/{args.db_name})")
    else:
        if verbose_mode:
            print(f"🗄️  Database updates: Disabled")
    
    # Configure SQL file updates (enabled by default)
    update_sql_file = args.update_sql_file and not args.no_sql_file_updates
    if update_sql_file:
        if verbose_mode:
            print(f"📝 SQL file updates: Enabled")
    else:
        if verbose_mode:
            print(f"📝 SQL file updates: Disabled")
    
    # Create downloader with Azurite configuration
    downloader = AzuritePDFDownloader(
        container_name=args.container,
        max_workers=args.max_workers,
        delay_between_requests=args.delay,
        verbose=verbose_mode,
        test_failures=args.test_failures,
        azurite_connection_string=args.azurite_connection,
        update_database=update_database,
        db_config=db_config,
        update_sql_file=update_sql_file,
        sql_file_path=input_file if update_sql_file else None,
        max_downloads=args.max_downloads,
        timeout=args.timeout
    )
    
    # Download PDFs with timeout protection
    try:
        print(f"🎯 Starting processing (Ctrl+C to interrupt)...")
        
        print(f"📖 Parsing SQL file: {input_file}")
        documents = downloader.parse_sql_file(input_file)
        if not documents:
            print("❌ No downloadable documents found in the input file.")
            sys.exit(1)
        results = downloader.download_documents(documents)
        
        # Exit with appropriate code
        if results['failed'] > 0:
            sys.exit(2)  # Some downloads failed
        elif results['downloaded'] == 0:
            sys.exit(1)  # No new downloads
        else:
            sys.exit(0)  # Success
            
    except KeyboardInterrupt:
        print("\n⚠️  Download interrupted by user (Ctrl+C)")
        print("🛑 Shutting down gracefully...")
        downloader.shutdown_requested = True
        sys.exit(130)
    except Exception as e:
        print(f"💥 Unexpected error: {e}")
        downloader.logger.error(f"Unexpected error: {e}")
        sys.exit(1)

if __name__ == '__main__':
    main()
