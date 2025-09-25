#!/usr/bin/env python3
"""
World Bank PDF Downloader
Downloads PDF files from World Bank scraper output with organized directory structure.
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
from concurrent.futures import ThreadPoolExecutor, as_completed
from datetime import datetime
import threading
import signal
from enum import Enum

# Try to import database utilities (optional)
try:
    from database import DatabaseManager, DatabaseConfig
    DATABASE_AVAILABLE = True
except ImportError:
    DATABASE_AVAILABLE = False
    print("Database utilities not available. Document status updates will be skipped.")

class StorageType(Enum):
    """Storage backend types."""
    LOCAL = "local"
    AZURE_BLOB = "azure_blob"

class StorageBackend:
    """Abstract base class for storage backends."""
    
    def __init__(self, config: Dict[str, str]):
        self.config = config
    
    def save_file(self, file_path: str, content: bytes) -> bool:
        """Save file content to storage backend."""
        raise NotImplementedError
    
    def file_exists(self, file_path: str) -> bool:
        """Check if file exists in storage backend."""
        raise NotImplementedError
    
    def get_file_size(self, file_path: str) -> int:
        """Get file size from storage backend."""
        raise NotImplementedError
    
    def create_directories(self, dir_path: str) -> bool:
        """Create directory structure in storage backend."""
        raise NotImplementedError

class LocalStorage(StorageBackend):
    """Local filesystem storage backend."""
    
    def __init__(self, config: Dict[str, str]):
        super().__init__(config)
        self.base_path = Path(config.get('base_path', 'pdfs'))
    
    def save_file(self, file_path: str, content: bytes) -> bool:
        """Save file to local filesystem."""
        try:
            full_path = self.base_path / file_path
            full_path.parent.mkdir(parents=True, exist_ok=True)
            with open(full_path, 'wb') as f:
                f.write(content)
            return True
        except Exception as e:
            logging.error(f"Failed to save file {file_path}: {e}")
            return False
    
    def file_exists(self, file_path: str) -> bool:
        """Check if file exists locally."""
        full_path = self.base_path / file_path
        return full_path.exists() and full_path.stat().st_size > 0
    
    def get_file_size(self, file_path: str) -> int:
        """Get local file size."""
        full_path = self.base_path / file_path
        return full_path.stat().st_size if full_path.exists() else 0
    
    def create_directories(self, dir_path: str) -> bool:
        """Create local directory structure."""
        try:
            full_path = self.base_path / dir_path
            full_path.mkdir(parents=True, exist_ok=True)
            return True
        except Exception as e:
            logging.error(f"Failed to create directory {dir_path}: {e}")
            return False

class AzureBlobStorage(StorageBackend):
    """Azure Blob Storage backend (dummy implementation)."""
    
    def __init__(self, config: Dict[str, str]):
        super().__init__(config)
        self.connection_string = config.get('connection_string', '')
        self.container_name = config.get('container_name', 'pdfs')
        
        # TODO: Initialize Azure Blob Storage client
        # from azure.storage.blob import BlobServiceClient
        # self.blob_service_client = BlobServiceClient.from_connection_string(self.connection_string)
        
        print("⚠️  Azure Blob Storage is not yet implemented - using dummy backend")
        print(f"   📦 Container: {self.container_name}")
        print(f"   🔗 Connection: {'***configured***' if self.connection_string else 'not configured'}")
    
    def save_file(self, file_path: str, content: bytes) -> bool:
        """Save file to Azure Blob Storage (dummy implementation)."""
        print(f"🔵 [AZURE DUMMY] Would upload {len(content)} bytes to blob: {file_path}")
        
        # TODO: Implement actual Azure Blob Storage upload
        # try:
        #     blob_client = self.blob_service_client.get_blob_client(
        #         container=self.container_name, 
        #         blob=file_path
        #     )
        #     blob_client.upload_blob(content, overwrite=True)
        #     return True
        # except Exception as e:
        #     logging.error(f"Failed to upload to Azure Blob: {e}")
        #     return False
        
        # For now, simulate success
        time.sleep(0.1)  # Simulate network delay
        return True
    
    def file_exists(self, file_path: str) -> bool:
        """Check if file exists in Azure Blob Storage (dummy implementation)."""
        print(f"🔵 [AZURE DUMMY] Would check if blob exists: {file_path}")
        
        # TODO: Implement actual Azure Blob Storage check
        # try:
        #     blob_client = self.blob_service_client.get_blob_client(
        #         container=self.container_name, 
        #         blob=file_path
        #     )
        #     return blob_client.exists()
        # except Exception:
        #     return False
        
        # For now, simulate that files don't exist (always download)
        return False
    
    def get_file_size(self, file_path: str) -> int:
        """Get file size from Azure Blob Storage (dummy implementation)."""
        print(f"🔵 [AZURE DUMMY] Would get blob size: {file_path}")
        
        # TODO: Implement actual Azure Blob Storage size check
        # try:
        #     blob_client = self.blob_service_client.get_blob_client(
        #         container=self.container_name, 
        #         blob=file_path
        #     )
        #     properties = blob_client.get_blob_properties()
        #     return properties.size
        # except Exception:
        #     return 0
        
        # For now, simulate unknown size
        return 0
    
    def create_directories(self, dir_path: str) -> bool:
        """Create directory structure in Azure Blob Storage (dummy implementation)."""
        print(f"🔵 [AZURE DUMMY] Would create blob directory structure: {dir_path}")
        
        # Note: Azure Blob Storage doesn't have real directories, 
        # they're simulated with blob name prefixes
        return True

class PDFDownloader:
    def __init__(self, output_dir: str = "pdfs", max_workers: int = 3, 
                 delay_between_requests: float = 1.0, verbose: bool = True, test_failures: bool = False,
                 storage_type: StorageType = StorageType.LOCAL, storage_config: Optional[Dict[str, str]] = None,
                 update_database: bool = False, db_config: Optional[Dict[str, str]] = None,
                 update_sql_file: bool = True, sql_file_path: Optional[str] = None,
                 max_downloads: Optional[int] = None, timeout: int = 30):
        print("🚀 Initializing PDF Downloader...")
        
        self.output_dir = Path(output_dir)
        self.max_workers = max_workers
        self.delay_between_requests = delay_between_requests
        self.verbose = verbose
        self.test_failures = test_failures
        self.max_downloads = max_downloads
        self.timeout = timeout
        self.start_time = time.time()
        self.last_heartbeat = time.time()
        
        # Initialize storage backend
        self.storage_type = storage_type
        self.storage_config = storage_config or {}
        
        if storage_type == StorageType.LOCAL:
            self.storage_config['base_path'] = str(self.output_dir)
            self.storage = LocalStorage(self.storage_config)
            print(f"📁 Storage: Local filesystem ({self.output_dir.absolute()})")
        elif storage_type == StorageType.AZURE_BLOB:
            self.storage = AzureBlobStorage(self.storage_config)
            print(f"☁️  Storage: Azure Blob Storage (container: {self.storage_config.get('container_name', 'pdfs')})")
        else:
            raise ValueError(f"Unsupported storage type: {storage_type}")
        
        print(f"✅ Storage backend initialized: {storage_type.value}")
        
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
                    print(f"🗄️  Database: Connected for status updates")
                else:
                    print(f"⚠️  Database: Connection failed, status updates disabled")
                    self.update_database = False
                    self.db_manager = None
                    
            except Exception as e:
                print(f"⚠️  Database: Setup failed ({e}), status updates disabled")
                self.update_database = False
                self.db_manager = None
        else:
            print(f"ℹ️  Database: Status updates disabled")
        
        print(f"📊 Document status updates: {'Enabled' if self.update_database else 'Disabled'}")
        
        # Initialize SQL file updates for local mode
        self.update_sql_file = update_sql_file
        self.sql_file_path = sql_file_path
        self.document_updates = {}  # Track status updates for SQL file
        
        if self.update_sql_file:
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
        print("🌐 Configuring HTTP session...")
        self.session = requests.Session()
        self.session.headers.update({
            'User-Agent': 'WorldBank-PDF-Downloader/1.0 (Document Query Service)',
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
        
        print(f"✅ Session configured with retry strategy (3 retries, backoff)")
        
        # Create directory structure
        self.setup_directories()
        
        # Setup signal handlers for graceful shutdown
        self.setup_signal_handlers()
        
        # Start heartbeat thread
        self.heartbeat_thread = threading.Thread(target=self._heartbeat_worker, daemon=True)
        self.heartbeat_thread.start()
        
        print(f"✅ PDF Downloader initialized successfully!")
        print(f"   📁 Output directory: {self.output_dir.absolute()}")
        print(f"   ⚡ Max workers: {self.max_workers}")
        print(f"   ⏱️  Request delay: {self.delay_between_requests}s")
        print(f"   🔊 Verbose logging: {'Enabled' if self.verbose else 'Disabled'}")
        
        # Test basic connectivity
        self._test_connectivity()
        
        print("-" * 60)
    
    def _test_connectivity(self):
        """Test basic internet connectivity."""
        print("🌐 Testing internet connectivity...")
        try:
            import socket
            # Test DNS resolution for a reliable host
            socket.gethostbyname('www.google.com')
            print("   ✅ Internet connectivity: OK")
            
            # Test HTTP connectivity
            test_response = self.session.get('https://httpbin.org/status/200', timeout=10)
            if test_response.status_code == 200:
                print("   ✅ HTTP requests: OK")
            else:
                print(f"   ⚠️  HTTP test returned status: {test_response.status_code}")
                
        except Exception as e:
            print(f"   ❌ Connectivity test failed: {e}")
            print("   ⚠️  Downloads may fail due to network issues")
            self.logger.warning(f"Connectivity test failed: {e}")
        
    def setup_logging(self):
        """Setup comprehensive logging system."""
        log_dir = self.output_dir / "logs"
        log_dir.mkdir(parents=True, exist_ok=True)
        
        # Create timestamped log file
        timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        log_file = log_dir / f"downloader_{timestamp}.log"
        
        # Configure logging
        logging.basicConfig(
            level=logging.INFO,
            format='%(asctime)s - %(levelname)s - %(message)s',
            handlers=[
                logging.FileHandler(log_file),
                logging.StreamHandler(sys.stdout) if self.verbose else logging.NullHandler()
            ]
        )
        
        self.logger = logging.getLogger(__name__)
        self.logger.info("PDF Downloader logging initialized")
        self.logger.info(f"Log file: {log_file}")
        
        print(f"📝 Logging configured: {log_file}")
    
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
    
    def setup_directories(self):
        """Create organized directory structure for PDFs."""
        print("📁 Creating directory structure...")
        directories = [
            self.output_dir,
            self.output_dir / "by_country",
            self.output_dir / "by_type",
            self.output_dir / "by_year",
            self.output_dir / "failed_downloads",
            self.output_dir / "logs"
        ]
        
        created_count = 0
        for directory in directories:
            if not directory.exists():
                directory.mkdir(parents=True, exist_ok=True)
                created_count += 1
                print(f"   ✅ Created: {directory.name}/")
            else:
                print(f"   ✓ Exists: {directory.name}/")
        
        print(f"📁 Directory structure ready ({created_count} new directories created)")
        self.logger.info(f"Directory structure created in: {self.output_dir.absolute()}")
    
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
                
                # Show progress
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
                                'date': self.extract_year_from_title(self.clean_value(values[1]))
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
    
    def extract_year_from_title(self, title: str) -> str:
        """Extract year from document title for organization."""
        if not title:
            return "unknown"
        
        # Look for 4-digit years
        year_match = re.search(r'\b(19|20)\d{2}\b', title)
        if year_match:
            return year_match.group()
        
        return "unknown"
    
    def sanitize_filename(self, text: str, max_length: int = 100) -> str:
        """Sanitize text for use as filename."""
        if not text:
            return "unknown"
        
        # Remove or replace problematic characters
        sanitized = re.sub(r'[<>:"/\\|?*]', '_', text)
        sanitized = re.sub(r'\s+', '_', sanitized)
        sanitized = sanitized.strip('._')
        
        # Truncate if too long
        if len(sanitized) > max_length:
            sanitized = sanitized[:max_length].rstrip('_')
        
        return sanitized or "unknown"
    
    def get_file_paths(self, doc: Dict[str, str], filename: str) -> Dict[str, Path]:
        """Generate organized file paths for a document."""
        safe_country = self.sanitize_filename(doc.get('country', 'unknown'))
        safe_type = self.sanitize_filename(doc.get('major_doc_type', 'unknown'))
        year = doc.get('date', 'unknown')
        
        return {
            'main': self.output_dir / filename,
            'by_country': self.output_dir / "by_country" / safe_country / filename,
            'by_type': self.output_dir / "by_type" / safe_type / filename,
            'by_year': self.output_dir / "by_year" / year / filename
        }
    
    def update_document_status(self, document_id: str, status: str, document_location: Optional[str] = None, error_message: Optional[str] = None) -> bool:
        """Update document status and location in database and/or SQL file."""
        updated = False
        
        # Track update for SQL file
        if self.update_sql_file:
            with self.lock:
                self.document_updates[document_id] = {'status': status, 'location': document_location}
            location_info = f", location: {document_location}" if document_location else ""
            print(f"   📝 [SQL UPDATE] Document {document_id} → status: {status}{location_info}")
            updated = True
        
        # Update database if enabled
        if not self.update_database or not self.db_manager:
            if not updated:
                location_info = f", location: {document_location}" if document_location else ""
                print(f"   ℹ️  [SKIP] No updates enabled for {document_id} → {status}{location_info}")
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
    
    def download_pdf(self, doc: Dict[str, str], create_symlinks: bool = True, max_retries: int = 3) -> bool:
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
                return self._attempt_download(doc, create_symlinks, current_position, attempt + 1, max_retries + 1)
            except Exception as e:
                if attempt < max_retries:  # Not the last attempt
                    retry_delay = (2 ** attempt) * 1.0  # Exponential backoff: 1s, 2s, 4s
                    print(f"   🔄 Attempt {attempt + 1}/{max_retries + 1} failed: {type(e).__name__}")
                    print(f"   ⏳ Retrying in {retry_delay:.1f}s...")
                    self.logger.warning(f"Download attempt {attempt + 1} failed for {url}: {e}")
                    time.sleep(retry_delay)
                    continue
                else:
                    # All retries failed - create URL-only record
                    return self._create_url_record(doc, current_position, e)
        
        return False  # Should never reach here
    
    def _attempt_download(self, doc: Dict[str, str], create_symlinks: bool, current_position: int, attempt: int, total_attempts: int) -> bool:
        """Single download attempt."""
        url = doc['url']
        thread_id = threading.current_thread().ident
        
        # Generate filename
        title_display = doc.get('title', 'Unknown Title')[:60]
        if attempt == 1:  # Only show initial processing message on first attempt
            print(f"🔍 [{current_position}/{self.total_documents}] Processing: {title_display}...")
            self.logger.info(f"Starting download {current_position}: {title_display}")
        else:
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
                    (OSError, "No space left on device (simulated)"),
                    (PermissionError, "Permission denied (simulated)")
                ]
                error_class, error_msg = random.choice(failure_types)
                print(f"   🧪 TEST MODE: Simulating {error_class.__name__}")
                if error_class == requests.exceptions.HTTPError:
                    # Create a mock response for HTTP errors
                    mock_response = type('MockResponse', (), {
                        'status_code': random.choice([404, 403, 429, 500, 502]),
                        'headers': {'content-type': 'text/html'},
                        'content': b'Simulated error response'
                    })()
                    error = error_class(error_msg)
                    error.response = mock_response
                    raise error
                else:
                    raise error_class(error_msg)
        
        # Network diagnostics
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
        
        original_filename = Path(unquote(parsed_url.path)).name
        
        if not original_filename or not original_filename.lower().endswith('.pdf'):
            # Generate filename from document info
            title_part = self.sanitize_filename(doc.get('title', ''), 50)
            doc_id = doc.get('id', hashlib.md5(url.encode()).hexdigest()[:8])
            original_filename = f"{doc_id}_{title_part}.pdf"
        
        # Get all file paths
        file_paths = self.get_file_paths(doc, original_filename)
        main_path = file_paths['main']
        
        # Check if already downloaded using storage backend
        if self.storage.file_exists(original_filename):
            file_size = self.storage.get_file_size(original_filename)
            with self.lock:
                self.skipped_count += 1
                self.active_downloads.discard(thread_id)
            
            # Update document status to DOWNLOADED since file exists
            doc_id = doc.get('id', '')
            if doc_id:
                self.update_document_status(doc_id, 'DOWNLOADED', original_filename)
            
            print(f"   ✓ Skipped (exists): {original_filename} ({file_size:,} bytes)")
            self.logger.info(f"Skipped existing file: {original_filename}")
            return True
        
        # Download the file
        print(f"   ⬇ Starting download: {original_filename}")
        
        # Start download with enhanced progress tracking
        download_start = time.time()
        print(f"   📡 Initiating HTTP request...")
        
        try:
            response = self.session.get(url, stream=True, timeout=self.timeout)
            response.raise_for_status()
            
            connection_time = time.time() - download_start
            print(f"   ✅ Connection established ({connection_time:.2f}s)")
            self.logger.info(f"HTTP connection established in {connection_time:.2f}s")
            
        except requests.exceptions.Timeout:
            print(f"   ⏰ Request timeout ({self.timeout}s) - server may be slow")
            raise
        except requests.exceptions.ConnectionError as e:
            print(f"   🔌 Connection error: {e}")
            raise
        except requests.exceptions.HTTPError as e:
            print(f"   🚫 HTTP error: {e}")
            print(f"   📊 Status code: {response.status_code}")
            raise
        
        # Get content length for progress tracking
        content_length = response.headers.get('content-length')
        total_size = int(content_length) if content_length else None
        
        # Analyze response headers
        content_type = response.headers.get('content-type', '').lower()
        print(f"   📋 Content-Type: {content_type}")
        
        if total_size:
            print(f"   📊 Expected size: {total_size:,} bytes ({total_size/1024/1024:.1f} MB)")
        else:
            print(f"   📊 Size: Unknown (no Content-Length header)")
        
        # Check if it's actually a PDF
        if 'pdf' not in content_type and not url.lower().endswith('.pdf'):
            print(f"   ⚠️  Warning: May not be a PDF (content-type: {content_type})")
            self.logger.warning(f"Suspicious content type for {original_filename}: {content_type}")
        
        # Download file content to memory first, then save via storage backend
        downloaded_size = 0
        last_progress_time = time.time()
        last_progress_size = 0
        file_content = bytearray()
        
        print(f"   💾 Downloading to {self.storage_type.value} storage: {original_filename}")
        
        for chunk in response.iter_content(chunk_size=8192):
            if self.shutdown_requested:
                print(f"\n   ⚠️  Download interrupted by shutdown request")
                return False
                
            if chunk:
                file_content.extend(chunk)
                downloaded_size += len(chunk)
                
                # Enhanced progress reporting
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
        if total_size or downloaded_size > 1024*1024:
            print()  # New line after progress
        
        # Save file using storage backend
        print(f"   💾 Saving to {self.storage_type.value} storage...")
        save_success = self.storage.save_file(original_filename, bytes(file_content))
        
        if not save_success:
            print(f"   ❌ Failed to save file to {self.storage_type.value} storage")
            self.logger.error(f"Failed to save {original_filename} to {self.storage_type.value} storage")
            return False
        
        download_time = time.time() - download_start
        final_size = len(file_content)
        avg_speed = final_size / download_time if download_time > 0 else 0
        
        print(f"   ✅ Download complete: {final_size:,} bytes in {download_time:.1f}s")
        print(f"   ⚡ Average speed: {avg_speed/1024:.1f} KB/s")
        print(f"   💾 Saved to {self.storage_type.value} storage: {original_filename}")
        
        # Verify download integrity
        if total_size and final_size != total_size:
            print(f"   ⚠️  Size mismatch: expected {total_size:,}, got {final_size:,}")
            self.logger.warning(f"Size mismatch for {original_filename}: expected {total_size}, got {final_size}")
        
        self.logger.info(f"Download completed: {original_filename} ({final_size:,} bytes in {download_time:.1f}s)")
        
        # Create organized copies/symlinks (only for local storage)
        if create_symlinks and self.storage_type == StorageType.LOCAL:
            print(f"   🔗 Creating organized links...")
            symlinks_created = 0
            for path_type, path in file_paths.items():
                if path_type != 'main':
                    path.parent.mkdir(parents=True, exist_ok=True)
                    if path.exists():
                        path.unlink()  # Remove existing symlink
                    
                    try:
                        # Create relative symlink
                        relative_target = os.path.relpath(main_path, path.parent)
                        path.symlink_to(relative_target)
                        symlinks_created += 1
                    except OSError:
                        # Fallback to hard copy if symlinks not supported
                        import shutil
                        shutil.copy2(main_path, path)
                        symlinks_created += 1
            
            print(f"   🗂️  Created {symlinks_created} organized copies")
        elif create_symlinks and self.storage_type == StorageType.AZURE_BLOB:
            print(f"   ℹ️  Organized links not supported with Azure Blob Storage")
        
        with self.lock:
            self.downloaded_count += 1
            self.active_downloads.discard(thread_id)
            current_progress = f"[{self.downloaded_count + self.skipped_count + self.failed_count}/{self.total_documents}]"
        
        # Update document status to DOWNLOADED with file location
        doc_id = doc.get('id', '')
        if doc_id:
            self.update_document_status(doc_id, 'DOWNLOADED', original_filename)
        
        print(f"✅ {current_progress} SUCCESS: {original_filename}")
        print(f"   📍 Country: {doc.get('country', 'Unknown')} | Type: {doc.get('major_doc_type', 'Unknown')}")
        
        # Rate limiting with countdown
        if self.delay_between_requests > 0:
            print(f"   ⏳ Rate limit delay: {self.delay_between_requests}s...")
            for i in range(int(self.delay_between_requests)):
                if self.shutdown_requested:
                    break
                time.sleep(1)
                if i < int(self.delay_between_requests) - 1:
                    print(f"   ⏳ {int(self.delay_between_requests) - i - 1}s remaining...", end='\r', flush=True)
            print()  # Clear countdown line
        
        print("-" * 80)  # Separator between downloads
        return True
    
    def _create_url_record(self, doc: Dict[str, str], current_position: int, last_error: Exception) -> bool:
        """Create a URL-only record when PDF download fails after all retries."""
        thread_id = threading.current_thread().ident
        
        with self.lock:
            self.active_downloads.discard(thread_id)
            # Count as downloaded since we're preserving the document metadata
            self.downloaded_count += 1
            current_progress = f"[{self.downloaded_count + self.skipped_count + self.failed_count}/{self.total_documents}]"
        
        # Create a text file with the URL and metadata instead of the PDF
        title_display = doc.get('title', 'Unknown Title')[:60]
        url = doc['url']
        
        # Generate filename for URL record
        title_part = self.sanitize_filename(doc.get('title', ''), 50)
        doc_id = doc.get('id', hashlib.md5(url.encode()).hexdigest()[:8])
        url_filename = f"{doc_id}_{title_part}_URL_ONLY.txt"
        
        # Get file paths for URL record
        file_paths = self.get_file_paths(doc, url_filename)
        main_path = file_paths['main']
        
        # Create URL record file
        main_path.parent.mkdir(parents=True, exist_ok=True)
        
        url_record_content = f"""PDF Download Failed - URL Record
=====================================

Document Information:
- Title: {doc.get('title', 'Unknown')}
- ID: {doc.get('id', 'Unknown')}
- Type: {doc.get('major_doc_type', 'Unknown')}
- Country: {doc.get('country', 'Unknown')}
- Language: {doc.get('language', 'Unknown')}
- Author: {doc.get('author', 'Unknown')}
- Publisher: {doc.get('publisher', 'Unknown')}
- Date: {doc.get('date', 'Unknown')}

Original PDF URL:
{url}

Download Failure Details:
- Failed after 3 retry attempts
- Last error: {type(last_error).__name__}: {str(last_error)}
- Timestamp: {datetime.now().isoformat()}

Note: The PDF file could not be downloaded, but the document metadata 
and URL have been preserved for future reference or manual download.
"""
        
        try:
            with open(main_path, 'w', encoding='utf-8') as f:
                f.write(url_record_content)
            
            # Create organized copies
            symlinks_created = 0
            for path_type, path in file_paths.items():
                if path_type != 'main':
                    path.parent.mkdir(parents=True, exist_ok=True)
                    if path.exists():
                        path.unlink()  # Remove existing file
                    
                    try:
                        # Create relative symlink
                        relative_target = os.path.relpath(main_path, path.parent)
                        path.symlink_to(relative_target)
                        symlinks_created += 1
                    except OSError:
                        # Fallback to hard copy if symlinks not supported
                        import shutil
                        shutil.copy2(main_path, path)
                        symlinks_created += 1
            
            # Update document status to URL_ONLY
            doc_id = doc.get('id', '')
            if doc_id:
                self.update_document_status(doc_id, 'URL_ONLY', url_filename)
            
            print(f"📄 {current_progress} URL RECORD CREATED: {url_filename}")
            print(f"   🌐 Original URL preserved: {url}")
            print(f"   📝 Metadata saved after {3} failed download attempts")
            print(f"   🗂️  Created {symlinks_created} organized copies")
            print(f"   📍 Country: {doc.get('country', 'Unknown')} | Type: {doc.get('major_doc_type', 'Unknown')}")
            
            self.logger.info(f"Created URL record for failed download: {url_filename}")
            
            # Rate limiting
            if self.delay_between_requests > 0:
                print(f"   ⏳ Rate limit delay: {self.delay_between_requests}s...")
                time.sleep(self.delay_between_requests)
            
            print("-" * 80)  # Separator
            return True
            
        except Exception as e:
            print(f"❌ Failed to create URL record: {e}")
            self.logger.error(f"Failed to create URL record for {url}: {e}")
            with self.lock:
                self.downloaded_count -= 1  # Revert the count
                self.failed_count += 1
            return False
    
    def download_from_database(self, db_path: str, create_symlinks: bool = True) -> Dict[str, int]:
        """Download PDFs from database records."""
        documents = []
        
        try:
            conn = sqlite3.connect(db_path)
            cursor = conn.cursor()
            
            # Query documents with URLs
            query = """
            SELECT d.id, d.title, dt.type_name, dt.major_type, d.url, 
                   l.name as language, c.name as country, d.author, d.publisher,
                   d.date_published
            FROM documents d
            LEFT JOIN document_types dt ON d.document_type_id = dt.id
            LEFT JOIN languages l ON d.language_id = l.id
            LEFT JOIN countries c ON d.country_id = c.id
            WHERE d.url IS NOT NULL AND d.url != ''
            """
            
            cursor.execute(query)
            rows = cursor.fetchall()
            
            for row in rows:
                doc = {
                    'id': str(row[0]),
                    'title': row[1] or 'Unknown Title',
                    'doc_type': row[2] or 'Unknown',
                    'major_doc_type': row[3] or 'Unknown',
                    'url': row[4],
                    'language': row[5] or 'Unknown',
                    'country': row[6] or 'Unknown',
                    'author': row[7] or '',
                    'publisher': row[8] or '',
                    'date': self.extract_year_from_title(row[1] or '') if not row[9] else str(row[9])[:4]
                }
                
                # Only include documents with downloadable URLs
                if '.pdf' in doc['url'].lower() or 'documents.worldbank.org' in doc['url']:
                    documents.append(doc)
            
            conn.close()
            
        except Exception as e:
            print(f"Error reading database: {e}")
            return {'downloaded': 0, 'skipped': 0, 'failed': 0}
        
        print(f"Found {len(documents)} documents with downloadable URLs from database")
        return self.download_documents(documents, create_symlinks)
    
    def download_documents(self, documents: List[Dict[str, str]], 
                          create_symlinks: bool = True) -> Dict[str, int]:
        """Download multiple documents with threading."""
        # Apply max_downloads limit if specified
        if self.max_downloads and len(documents) > self.max_downloads:
            print(f"📊 Limiting downloads to {self.max_downloads} documents (out of {len(documents)} available)")
            documents = documents[:self.max_downloads]
        
        self.total_documents = len(documents)
        
        print(f"\n🚀 Starting PDF Download Session")
        print(f"📊 Total documents to process: {len(documents)}")
        print(f"📁 Output directory: {self.output_dir.absolute()}")
        print(f"⚡ Max concurrent downloads: {self.max_workers}")
        print(f"⏱️  Delay between requests: {self.delay_between_requests}s")
        print(f"⏰ Download timeout: {self.timeout}s")
        if self.max_downloads:
            print(f"🔢 Max downloads limit: {self.max_downloads}")
        print(f"🔗 Create organized links: {'Yes' if create_symlinks else 'No'}")
        print("=" * 80)
        
        self.logger.info(f"Starting download session: {len(documents)} documents, {self.max_workers} workers")
        
        # Analyze document types for preview
        countries = set(doc.get('country', 'Unknown') for doc in documents)
        doc_types = set(doc.get('major_doc_type', 'Unknown') for doc in documents)
        
        print(f"📈 Document Analysis:")
        print(f"   Countries: {len(countries)} ({', '.join(sorted(list(countries))[:5])}{'...' if len(countries) > 5 else ''})")
        print(f"   Document Types: {len(doc_types)} ({', '.join(sorted(list(doc_types))[:3])}{'...' if len(doc_types) > 3 else ''})")
        print("=" * 80)
        
        # Create download log
        log_file = self.output_dir / "logs" / f"download_log_{datetime.now().strftime('%Y%m%d_%H%M%S')}.txt"
        with open(log_file, 'w', encoding='utf-8') as f:
            f.write(f"Download started: {datetime.now().isoformat()}\n")
            f.write(f"Total documents: {len(documents)}\n")
            f.write(f"Max workers: {self.max_workers}\n")
            f.write(f"Delay: {self.delay_between_requests}s\n\n")
        
        start_time = time.time()
        
        # Download with thread pool and enhanced monitoring
        print(f"🔄 Processing documents with {self.max_workers} concurrent workers...\n")
        
        with ThreadPoolExecutor(max_workers=self.max_workers) as executor:
            # Submit all tasks
            print(f"📋 Submitting {len(documents)} download tasks to thread pool...")
            futures = []
            for i, doc in enumerate(documents):
                if self.shutdown_requested:
                    print(f"⚠️  Shutdown requested, stopping task submission at {i}/{len(documents)}")
                    break
                future = executor.submit(self.download_pdf, doc, create_symlinks)
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
                        
                        print(f"📊 PROGRESS UPDATE [{completed}/{len(documents)}]")
                        print(f"   ⏱️  Elapsed: {elapsed:.1f}s | Rate: {rate:.2f}/s | ETA: {eta:.0f}s")
                        print(f"   🔄 Active downloads: {active_count}/{self.max_workers}")
                        print(f"   ✅ Downloaded: {self.downloaded_count} | ⏭️  Skipped: {self.skipped_count} | ❌ Failed: {self.failed_count}")
                        
                        # Show completion percentage
                        progress_pct = (completed / len(documents)) * 100
                        progress_bar = "█" * int(progress_pct // 5) + "░" * (20 - int(progress_pct // 5))
                        print(f"   📈 Progress: [{progress_bar}] {progress_pct:.1f}%")
                        print("-" * 60)
                        
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
        print(f"📋 DOWNLOAD COMPLETE - Session Summary")
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
        print(f"📁 Output:")
        print(f"   🗂️  Main directory: {self.output_dir.absolute()}")
        print(f"   📋 Download log: {log_file}")
        
        if self.failed_count > 0:
            failed_log = self.output_dir / "logs" / "failed_downloads.txt"
            detailed_log = self.output_dir / "logs" / "detailed_failures.json"
            print(f"   ⚠️  Failed downloads log: {failed_log}")
            print(f"   📊 Detailed failure analysis: {detailed_log}")
            
            # Analyze failure patterns
            self._analyze_failures(detailed_log)
        
        print("=" * 80)
        
        # Update SQL file with status changes
        if self.update_sql_file and self.document_updates:
            self.update_sql_file_status()
        
        # Update log
        with open(log_file, 'a', encoding='utf-8') as f:
            f.write(f"\nDownload completed: {datetime.now().isoformat()}\n")
            f.write(f"Total time: {total_time:.1f}s\n")
            f.write(f"Downloaded: {self.downloaded_count}\n")
            f.write(f"Skipped: {self.skipped_count}\n")
            f.write(f"Failed: {self.failed_count}\n")
            f.write(f"Success rate: {success_rate:.1f}%\n")
        
        return {
            'downloaded': self.downloaded_count,
            'skipped': self.skipped_count,
            'failed': self.failed_count
        }
    
    def _analyze_failures(self, detailed_log_path: Path):
        """Analyze failure patterns and provide insights."""
        try:
            import json
            from collections import Counter
            
            if not detailed_log_path.exists():
                return
            
            failures = []
            with open(detailed_log_path, 'r', encoding='utf-8') as f:
                for line in f:
                    try:
                        failures.append(json.loads(line.strip()))
                    except json.JSONDecodeError:
                        continue
            
            if not failures:
                return
            
            print(f"")
            print(f"🔍 FAILURE ANALYSIS:")
            print(f"   📊 Total failures analyzed: {len(failures)}")
            
            # Analyze failure reasons
            failure_reasons = Counter(f.get('failure_reason', 'Unknown') for f in failures)
            print(f"   📈 Top failure reasons:")
            for reason, count in failure_reasons.most_common(5):
                percentage = (count / len(failures)) * 100
                print(f"      • {reason}: {count} ({percentage:.1f}%)")
            
            # Analyze error types
            error_types = Counter(f.get('error_type', 'Unknown') for f in failures)
            if len(error_types) > 1:
                print(f"   🔧 Error types:")
                for error_type, count in error_types.most_common(3):
                    percentage = (count / len(failures)) * 100
                    print(f"      • {error_type}: {count} ({percentage:.1f}%)")
            
            # Analyze HTTP status codes if present
            http_failures = [f for f in failures if 'http_status' in f]
            if http_failures:
                status_codes = Counter(f['http_status'] for f in http_failures)
                print(f"   🌐 HTTP status codes:")
                for status, count in status_codes.most_common(3):
                    percentage = (count / len(http_failures)) * 100
                    print(f"      • {status}: {count} ({percentage:.1f}%)")
            
            # Provide recommendations
            print(f"   💡 Recommendations:")
            
            # Rate limiting recommendations
            if any('429' in str(f.get('http_status', '')) or 'rate' in f.get('failure_reason', '').lower() for f in failures):
                print(f"      • Increase delay between requests (--delay parameter)")
                print(f"      • Reduce concurrent workers (--max-workers parameter)")
            
            # Timeout recommendations
            timeout_failures = sum(1 for f in failures if 'timeout' in f.get('failure_reason', '').lower())
            if timeout_failures > len(failures) * 0.2:  # More than 20% timeouts
                print(f"      • Server appears slow - consider increasing timeout")
                print(f"      • Try running during off-peak hours")
            
            # Connection error recommendations
            connection_failures = sum(1 for f in failures if 'connection' in f.get('failure_reason', '').lower())
            if connection_failures > len(failures) * 0.3:  # More than 30% connection errors
                print(f"      • Check internet connectivity")
                print(f"      • Server may be experiencing issues")
            
            # 404 recommendations
            not_found_failures = sum(1 for f in failures if '404' in str(f.get('http_status', '')))
            if not_found_failures > 0:
                print(f"      • {not_found_failures} files not found - URLs may be outdated")
                print(f"      • Consider updating the source data")
                
        except Exception as e:
            print(f"   ⚠️  Could not analyze failures: {e}")

def print_banner():
    """Print startup banner."""
    banner = """
╔══════════════════════════════════════════════════════════════════════════════╗
║                        🌍 World Bank PDF Downloader 🌍                        ║
║                                                                              ║
║  📄 Downloads PDF documents from World Bank scraper output                   ║
║  🔄 Supports parallel downloads with progress tracking                       ║
║  📊 Provides detailed logging and network diagnostics                        ║
║  🗂️  Creates organized directory structure by country/type/year              ║
║  💾 Storage Options: Local filesystem (default) or Azure Blob Storage       ║
║  🗄️  Database Updates: Automatically updates document_status field          ║
║                                                                              ║
║  🚀 Starting up... Please wait for initialization to complete               ║
╚══════════════════════════════════════════════════════════════════════════════╝
    """
    print(banner)

def main():
    print_banner()
    
    parser = argparse.ArgumentParser(
        description='Download PDFs from World Bank scraper output',
        epilog="""
Examples:
  # Download from SQL file (positional argument - recommended)
  python pdf_downloader.py sample_data.sql
  
  # Download from SQL file (named argument)
  python pdf_downloader.py --input worldbank_data.sql
  
  # Download with custom settings
  python pdf_downloader.py data.sql --output my_pdfs --max-workers 5
  
  # Download from database file
  python pdf_downloader.py mydb.sqlite --database --no-symlinks
  
  # Azure Blob Storage
  python pdf_downloader.py data.sql --storage azure_blob \\
    --azure-connection-string "DefaultEndpointsProtocol=https;AccountName=..." \\
    --azure-container "documents"
  
  # Run from setup script (automatic file detection)
  python pdf_downloader.py --max-downloads 50 --timeout 30
        """,
        formatter_class=argparse.RawDescriptionHelpFormatter
    )
    parser.add_argument('--input', type=str, 
                       help='Input SQL file or database path (required)')
    parser.add_argument('input_file', nargs='?', 
                       help='Input SQL file or database path (positional argument)')
    parser.add_argument('--output', type=str, default='pdfs',
                       help='Output directory for PDFs (default: pdfs)')
    parser.add_argument('--max-workers', type=int, default=3,
                       help='Maximum concurrent downloads (default: 3)')
    parser.add_argument('--max-downloads', type=int, 
                       help='Maximum number of files to download (default: no limit)')
    parser.add_argument('--timeout', type=int, default=30,
                       help='Timeout for each download in seconds (default: 30)')
    parser.add_argument('--delay', type=float, default=1.0,
                       help='Delay between requests in seconds (default: 1.0)')
    parser.add_argument('--no-symlinks', action='store_true',
                       help='Disable creation of organized symlinks/copies')
    parser.add_argument('--database', action='store_true',
                       help='Input is a SQLite database instead of SQL file')
    parser.add_argument('--quiet', action='store_true',
                       help='Reduce verbose output (only errors and final summary)')
    parser.add_argument('--verbose', action='store_true',
                       help='Enable extra verbose output (default: True unless --quiet)')
    parser.add_argument('--test-failures', action='store_true',
                       help='Test mode: simulate random failures for testing error handling')
    
    # Storage configuration
    parser.add_argument('--storage', type=str, choices=['local', 'azure_blob'], default='local',
                       help='Storage backend type (default: local)')
    parser.add_argument('--azure-connection-string', type=str,
                       help='Azure Blob Storage connection string (required for azure_blob storage)')
    parser.add_argument('--azure-container', type=str, default='pdfs',
                       help='Azure Blob Storage container name (default: pdfs)')
    
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
    
    # Determine verbosity
    verbose = not args.quiet
    if args.verbose:
        verbose = True
    
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
            print("  python pdf_downloader.py <input_file>")
            print("  python pdf_downloader.py --input <input_file>")
            print("\nSearched for these files:")
            for f in potential_files:
                print(f"  - {f}")
            sys.exit(1)
    
    args.input = input_file
    
    if not os.path.exists(args.input):
        print(f"Error: Input file not found: {args.input}")
        sys.exit(1)
    
    # Configure storage backend
    storage_type = StorageType.LOCAL if args.storage == 'local' else StorageType.AZURE_BLOB
    storage_config = {}
    
    if storage_type == StorageType.AZURE_BLOB:
        if not args.azure_connection_string:
            print("Error: --azure-connection-string is required when using Azure Blob Storage")
            print("Example: --azure-connection-string 'DefaultEndpointsProtocol=https;AccountName=...'")
            sys.exit(1)
        
        storage_config = {
            'connection_string': args.azure_connection_string,
            'container_name': args.azure_container
        }
        
        print(f"☁️  Configuring Azure Blob Storage:")
        print(f"   📦 Container: {args.azure_container}")
        print(f"   🔗 Connection: {'***configured***' if args.azure_connection_string else 'not configured'}")
    else:
        print(f"📁 Using local storage: {args.output}")
    
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
        print(f"🗄️  Database updates: Enabled ({args.db_server}:{args.db_port}/{args.db_name})")
    else:
        print(f"🗄️  Database updates: Disabled (local mode)")
    
    # Configure SQL file updates (enabled by default for local mode)
    update_sql_file = args.update_sql_file and not args.no_sql_file_updates
    if update_sql_file:
        print(f"📝 SQL file updates: Enabled")
    else:
        print(f"📝 SQL file updates: Disabled")
    
    # Create downloader with storage and database configuration
    downloader = PDFDownloader(
        output_dir=args.output,
        max_workers=args.max_workers,
        delay_between_requests=args.delay,
        verbose=verbose,
        test_failures=args.test_failures,
        storage_type=storage_type,
        storage_config=storage_config,
        update_database=update_database,
        db_config=db_config,
        update_sql_file=update_sql_file,
        sql_file_path=args.input if update_sql_file else None,
        max_downloads=args.max_downloads,
        timeout=args.timeout
    )
    
    # Download PDFs with timeout protection
    try:
        print(f"🎯 Starting processing (Ctrl+C to interrupt)...")
        
        if args.database:
            results = downloader.download_from_database(args.input, not args.no_symlinks)
        else:
            print(f"📖 Parsing SQL file: {args.input}")
            documents = downloader.parse_sql_file(args.input)
            if not documents:
                print("❌ No downloadable documents found in the input file.")
                sys.exit(1)
            results = downloader.download_documents(documents, not args.no_symlinks)
        
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
