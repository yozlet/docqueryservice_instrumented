#!/usr/bin/env python3
"""
World Bank Documents API Scraper
Fetches real document data from the World Bank API and generates SQL INSERT statements.
Can also directly insert into SQL Server database.
"""

import requests
import json
import argparse
import time
import sys
import os
import subprocess
import hashlib
import logging
import threading
import signal
from datetime import datetime
from typing import Dict, List, Optional, Any, Tuple
from pathlib import Path
from urllib.parse import urlparse, unquote
from concurrent.futures import ThreadPoolExecutor, as_completed
import urllib.parse
import re

# Try to import database utilities (optional)
try:
    # Import from utilities directory
    sys.path.insert(0, os.path.join(os.path.dirname(__file__), 'utilities'))
    from database import DatabaseManager, DatabaseConfig
    DATABASE_AVAILABLE = True
except ImportError:
    DATABASE_AVAILABLE = False
    print("Database utilities not available. Install psycopg2-binary to use database features.")

class PDFDownloader:
    """Handles PDF downloading with local storage."""
    
    def __init__(self, output_dir: str = "pdfs", max_workers: int = 3, timeout: int = 30, delay: float = 1.0):
        self.output_dir = Path(output_dir)
        self.max_workers = max_workers
        self.timeout = timeout
        self.delay = delay
        self.session = requests.Session()
        self.session.headers.update({
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
        })
        self.stats = {
            'processed': 0,
            'downloaded': 0,
            'skipped': 0,
            'failed': 0,
            'total_size': 0
        }
        self.interrupt_requested = False
        signal.signal(signal.SIGINT, self._signal_handler)
    
    def _signal_handler(self, signum, frame):
        """Handle interrupt signal."""
        print("\n🛑 Interrupt received. Finishing current downloads...")
        self.interrupt_requested = True
    
    def _generate_filename(self, url: str, doc_id: str) -> str:
        """Generate a consistent filename from URL and document ID."""
        try:
            parsed = urlparse(url)
            original_filename = os.path.basename(parsed.path)
            if original_filename and original_filename.endswith('.pdf'):
                # Use original filename if it's a PDF
                base_name = os.path.splitext(original_filename)[0]
                return f"{doc_id}-{hashlib.md5(url.encode()).hexdigest()[:8]}.pdf"
            else:
                # Generate filename from document ID and URL hash
                return f"{doc_id}-{hashlib.md5(url.encode()).hexdigest()[:8]}.pdf"
        except Exception:
            return f"{doc_id}-{hashlib.md5(url.encode()).hexdigest()[:8]}.pdf"
    
    def _download_single_pdf(self, doc_id: str, url: str, filename: str) -> Tuple[bool, str, int]:
        """Download a single PDF file."""
        try:
            if self.interrupt_requested:
                return False, "Interrupted", 0
            
            file_path = self.output_dir / filename
            
            # Check if file already exists
            if file_path.exists() and file_path.stat().st_size > 0:
                size = file_path.stat().st_size
                return True, f"Skipped (exists): {filename} ({size:,} bytes)", size
            
            # Create directory if needed
            file_path.parent.mkdir(parents=True, exist_ok=True)
            
            # Download the file
            response = self.session.get(url, timeout=self.timeout, stream=True)
            response.raise_for_status()
            
            # Check content type
            content_type = response.headers.get('content-type', '').lower()
            if 'pdf' not in content_type and not url.lower().endswith('.pdf'):
                return False, f"Not a PDF: {content_type}", 0
            
            # Save the file
            total_size = 0
            with open(file_path, 'wb') as f:
                for chunk in response.iter_content(chunk_size=8192):
                    if chunk:
                        f.write(chunk)
                        total_size += len(chunk)
            
            # Verify it's actually a PDF
            if total_size < 1024:  # Too small to be a valid PDF
                file_path.unlink(missing_ok=True)
                return False, "File too small", 0
            
            # Check PDF header
            with open(file_path, 'rb') as f:
                header = f.read(4)
                if header != b'%PDF':
                    file_path.unlink(missing_ok=True)
                    return False, "Invalid PDF header", 0
            
            time.sleep(self.delay)  # Rate limiting
            return True, f"Downloaded: {filename} ({total_size:,} bytes)", total_size
            
        except requests.exceptions.RequestException as e:
            return False, f"Download failed: {str(e)}", 0
        except Exception as e:
            return False, f"Error: {str(e)}", 0
    
    def download_pdfs(self, documents: List[Dict[str, Any]], quiet: bool = False) -> Dict[str, Any]:
        """Download PDFs for a list of documents."""
        if not quiet:
            print(f"📥 Downloading {len(documents)} PDFs...")
        
        results = []
        
        with ThreadPoolExecutor(max_workers=self.max_workers) as executor:
            # Submit download tasks
            future_to_doc = {}
            for doc in documents:
                if self.interrupt_requested:
                    break
                
                doc_id = str(doc.get('id', ''))
                # Prefer pdfurl over url for PDF downloads
                url = doc.get('pdfurl', '') or doc.get('url', '')
                
                if not url:
                    continue
                
                filename = self._generate_filename(url, doc_id)
                future = executor.submit(self._download_single_pdf, doc_id, url, filename)
                future_to_doc[future] = {'doc': doc, 'filename': filename}
            
            # Process completed downloads
            for future in as_completed(future_to_doc):
                if self.interrupt_requested:
                    break
                
                doc_info = future_to_doc[future]
                doc = doc_info['doc']
                filename = doc_info['filename']
                
                try:
                    success, message, size = future.result()
                    
                    self.stats['processed'] += 1
                    
                    if success:
                        if "Skipped" in message:
                            self.stats['skipped'] += 1
                        else:
                            self.stats['downloaded'] += 1
                        self.stats['total_size'] += size
                        
                        # Update document with local file path
                        doc['status'] = 'DOWNLOADED'
                        doc['location'] = filename
                        
                        if not quiet:
                            print(f"   ✓ {message}")
                    else:
                        self.stats['failed'] += 1
                        doc['status'] = 'FAILED'
                        if not quiet:
                            print(f"   ❌ {doc.get('id', 'Unknown')}: {message}")
                    
                    results.append(doc)
                    
                except Exception as e:
                    self.stats['failed'] += 1
                    if not quiet:
                        print(f"   ❌ {doc.get('id', 'Unknown')}: Exception: {str(e)}")
        
        return {
            'documents': results,
            'stats': self.stats.copy()
        }
    
    def print_summary(self):
        """Print download summary."""
        print(f"\n🎉 ============================================================================ 🎉")
        print(f"📋 DOWNLOAD COMPLETE - Session Summary")
        print(f"================================================================================")
        print(f"📊 Statistics:")
        print(f"   📥 Total documents processed: {self.stats['processed']}")
        print(f"   ✅ Successfully downloaded: {self.stats['downloaded']}")
        print(f"   ⏭️  Skipped (already existed): {self.stats['skipped']}")
        print(f"   ❌ Failed downloads: {self.stats['failed']}")
        
        success_rate = 0
        if self.stats['processed'] > 0:
            success_rate = ((self.stats['downloaded'] + self.stats['skipped']) / self.stats['processed']) * 100
        print(f"   📈 Success rate: {success_rate:.1f}%")
        
        print(f"\n⏱️  Performance:")
        print(f"   📦 Data transferred: ~{self.stats['total_size'] / (1024*1024):.1f} MB")
        
        print(f"\n📁 Output:")
        print(f"   🗂️  Main directory: {self.output_dir.absolute()}")
        print(f"================================================================================")
    
    def update_sql_file(self, sql_file: str, documents: List[Dict[str, Any]], quiet: bool = False):
        """Update SQL file with downloaded document locations and statuses."""
        if not quiet:
            print(f"📝 Updating SQL file: {sql_file}")
        
        try:
            # Read the original SQL file
            with open(sql_file, 'r', encoding='utf-8') as f:
                content = f.read()
            
            updated_count = 0
            
            # Update each document's status and location in the SQL
            for doc in documents:
                doc_id = str(doc.get('id', ''))
                status = doc.get('status', 'PENDING')
                location = doc.get('location', '')
                
                if status == 'DOWNLOADED' and location:
                    # Find and update the INSERT statement for this document
                    pattern = rf"INSERT INTO documents.*?VALUES\s*\(\s*{re.escape(doc_id)}.*?\);"
                    matches = re.finditer(pattern, content, re.IGNORECASE | re.DOTALL)
                    
                    for match in matches:
                        old_statement = match.group(0)
                        # Replace status and location in the VALUES clause
                        new_statement = re.sub(
                            r"'PENDING'", f"'{status}'", old_statement, count=1
                        )
                        new_statement = re.sub(
                            r"NULL(\s*\);\s*$)", f"'{location}'\\1", new_statement
                        )
                        
                        if new_statement != old_statement:
                            content = content.replace(old_statement, new_statement)
                            updated_count += 1
            
            # Write the updated SQL file
            with open(sql_file, 'w', encoding='utf-8') as f:
                f.write(content)
            
            if not quiet:
                print(f"   ✅ Updated {updated_count} document statuses in SQL file")
                
        except Exception as e:
            if not quiet:
                print(f"   ❌ Failed to update SQL file: {e}")

class WorldBankScraper:
    def __init__(self):
        self.base_url = "https://search.worldbank.org/api/v3/wds"
        self.session = requests.Session()
        self.session.headers.update({
            'User-Agent': 'WorldBank-Scraper/1.0 (Document Query Service Demo)'
        })
        
    def fetch_documents(self, count: int = 100, start_offset: int = 0, 
                       query_term: Optional[str] = None, country: Optional[str] = None) -> List[Dict[str, Any]]:
        """Fetch documents from the World Bank API."""
        all_docs: List[Dict[str, Any]] = []
        rows_per_request = min(100, count)  # API max is 100 per request
        current_offset = start_offset
        
        while len(all_docs) < count:
            remaining = count - len(all_docs)
            current_rows = min(rows_per_request, remaining)
            
            params = {
                'format': 'json',
                'rows': current_rows,
                'os': current_offset,
                'fl': 'id,display_title,docdt,abstract,docty,majdocty,volnb,totvolnb,url,pdfurl,lang,count,author,publisher,docna'
            }
            
            if query_term:
                params['qterm'] = query_term
            if country:
                params['count_exact'] = country
            
            # Calculate batch range for better progress indication
            batch_start = len(all_docs)
            batch_end = min(batch_start + current_rows, count)
            batch_num = (batch_start // 50) + 1
            total_batches = (count + 49) // 50  # Round up division
            
            print(f"📥 Working on documents {batch_start + 1}-{batch_end}...")
            
            try:
                response = self.session.get(self.base_url, params=params, timeout=30)
                response.raise_for_status()
                
                data = response.json()
                # Handle the actual API structure - documents is a dict keyed by doc IDs
                documents_dict = data.get('documents', {})
                
                if not documents_dict:
                    print(f"No more documents available. Retrieved {len(all_docs)} total.")
                    break
                
                # Convert dict values to list
                docs = list(documents_dict.values())
                
                if not docs:
                    print(f"No more documents available. Retrieved {len(all_docs)} total.")
                    break
                    
                all_docs.extend(docs)
                current_offset += len(docs)
                
                # Rate limiting - be respectful to the API
                time.sleep(1)
                
            except requests.RequestException as e:
                print(f"Error fetching data: {e}")
                if len(all_docs) > 0:
                    print(f"Partial data retrieved: {len(all_docs)} documents")
                    break
                else:
                    raise
                    
        return all_docs[:count]  # Ensure we don't exceed requested count

    def clean_text(self, text: Any) -> str:
        """Clean and sanitize text for SQL insertion."""
        if text is None:
            return ""
        
        text_str = str(text)
        # Remove null bytes and other problematic characters
        text_str = text_str.replace('\x00', '').replace('\r', ' ').replace('\n', ' ')
        # Normalize whitespace
        text_str = re.sub(r'\s+', ' ', text_str).strip()
        # Escape single quotes for SQL
        text_str = text_str.replace("'", "''")
        
        return text_str[:5000]  # Limit length to prevent issues

    def extract_countries_from_docs(self, docs: List[Dict[str, Any]]) -> List[str]:
        """Extract unique countries from documents."""
        countries = set()
        for doc in docs:
            country = doc.get('count')
            if country and isinstance(country, list):
                countries.update(country)
            elif country and isinstance(country, str):
                countries.add(country)
        return sorted(list(countries))

    def extract_languages_from_docs(self, docs: List[Dict[str, Any]]) -> List[str]:
        """Extract unique languages from documents."""
        languages = set()
        for doc in docs:
            lang = doc.get('lang')
            if lang and isinstance(lang, list):
                languages.update(lang)
            elif lang and isinstance(lang, str):
                languages.add(lang)
        return sorted(list(languages))

    def extract_doctypes_from_docs(self, docs: List[Dict[str, Any]]) -> List[Dict[str, Any]]:
        """Extract unique document types from documents."""
        doctypes = {}
        for doc in docs:
            docty = doc.get('docty')
            majdocty = doc.get('majdocty')
            
            if docty:
                if isinstance(docty, list):
                    for dt in docty:
                        if dt:
                            doctypes[dt] = majdocty[0] if isinstance(majdocty, list) and majdocty else majdocty
                elif isinstance(docty, str):
                    doctypes[docty] = majdocty[0] if isinstance(majdocty, list) and majdocty else majdocty
                    
        return [{'type_name': k, 'major_type': v} for k, v in doctypes.items()]

    def generate_sql_inserts(self, docs: List[Dict[str, Any]], output_file: str) -> None:
        """Generate SQL INSERT statements from document data."""
        
        # Extract reference data
        countries = self.extract_countries_from_docs(docs)
        languages = self.extract_languages_from_docs(docs)
        doctypes = self.extract_doctypes_from_docs(docs)
        
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write("-- World Bank Documents Data\n")
            f.write(f"-- Generated on {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
            f.write(f"-- Total documents: {len(docs)}\n\n")
            
            # Insert countries
            f.write("-- Insert countries\n")
            f.write("INSERT INTO countries (name, code, region) VALUES\n")
            country_values = []
            for i, country in enumerate(countries):
                clean_country = self.clean_text(country)
                # Generate a simple code (first 3 chars, uppercase)
                code = clean_country[:3].upper().replace(' ', '').replace(',', '')
                country_values.append(f"('{clean_country}', '{code}', 'Unknown')")
                
            f.write(',\n'.join(country_values))
            f.write("\nON CONFLICT (name) DO NOTHING;\n\n")
            
            # Insert languages
            f.write("-- Insert languages\n")
            f.write("INSERT INTO languages (name, code) VALUES\n")
            lang_values = []
            for lang in languages:
                clean_lang = self.clean_text(lang)
                code = clean_lang[:2].lower() if clean_lang else 'un'
                lang_values.append(f"('{clean_lang}', '{code}')")
                
            f.write(',\n'.join(lang_values))
            f.write("\nON CONFLICT (name) DO NOTHING;\n\n")
            
            # Insert document types
            f.write("-- Insert document types\n")
            f.write("INSERT INTO document_types (type_name, major_type) VALUES\n")
            doctype_values = []
            for doctype in doctypes:
                type_name = self.clean_text(doctype['type_name'])
                major_type = self.clean_text(doctype['major_type']) if doctype['major_type'] else 'Unknown'
                doctype_values.append(f"('{type_name}', '{major_type}')")
                
            f.write(',\n'.join(doctype_values))
            f.write("\nON CONFLICT (type_name) DO NOTHING;\n\n")
            
            # Insert documents
            f.write("-- Insert documents\n")
            for doc in docs:
                doc_id = self.clean_text(doc.get('id', ''))
                title = self.clean_text(doc.get('display_title', ''))
                
                # Try to get abstract from various possible fields
                abstract = self.clean_text(doc.get('abstract', ''))
                if not abstract:
                    # Sometimes abstract might be in other fields
                    abstract = self.clean_text(doc.get('summary', ''))
                if not abstract and doc.get('docna') and isinstance(doc.get('docna'), list) and len(doc['docna']) > 0:
                    # Try to get document name as fallback
                    docna_obj = doc['docna'][0]
                    if isinstance(docna_obj, dict):
                        abstract = self.clean_text(docna_obj.get('docna', ''))
                
                # Handle document date
                docdt = doc.get('docdt')
                if docdt:
                    # Parse various date formats from World Bank API
                    try:
                        if 'T' in str(docdt):
                            parsed_date = datetime.fromisoformat(str(docdt).replace('Z', '+00:00'))
                        else:
                            parsed_date = datetime.strptime(str(docdt)[:10], '%Y-%m-%d')
                        docdt_str = f"'{parsed_date.strftime('%Y-%m-%d')}'"
                    except:
                        docdt_str = "NULL"
                else:
                    docdt_str = "NULL"
                
                # Handle other fields
                docty = self.clean_text(doc.get('docty', ''))
                if isinstance(doc.get('docty'), list) and doc.get('docty'):
                    docty = self.clean_text(doc['docty'][0])
                    
                majdocty = self.clean_text(doc.get('majdocty', ''))
                if isinstance(doc.get('majdocty'), list) and doc.get('majdocty'):
                    majdocty = self.clean_text(doc['majdocty'][0])
                
                volnb = doc.get('volnb')
                volnb_str = str(volnb) if volnb and str(volnb).isdigit() else "NULL"
                
                totvolnb = doc.get('totvolnb')
                totvolnb_str = str(totvolnb) if totvolnb and str(totvolnb).isdigit() else "NULL"
                
                url = self.clean_text(doc.get('url', ''))
                # Prefer PDF URL if available
                if doc.get('pdfurl'):
                    url = self.clean_text(doc.get('pdfurl', ''))
                
                lang = self.clean_text(doc.get('lang', ''))
                if isinstance(doc.get('lang'), list) and doc.get('lang'):
                    lang = self.clean_text(doc['lang'][0])
                    
                country = self.clean_text(doc.get('count', ''))
                if isinstance(doc.get('count'), list) and doc.get('count'):
                    country = self.clean_text(doc['count'][0])
                    
                author = self.clean_text(doc.get('author', ''))
                publisher = self.clean_text(doc.get('publisher', ''))
                
                # Create content_text for full-text search
                content_parts = [title, abstract]
                if author:
                    content_parts.append(author)
                content_text = ' '.join(filter(None, content_parts))
                
                f.write(f"""INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
) VALUES (
    '{doc_id}',
    '{title}',
    {docdt_str},
    '{abstract}',
    '{docty}',
    '{majdocty}',
    {volnb_str},
    {totvolnb_str},
    '{url}',
    NULL,
    'PENDING',
    '{lang}',
    '{country}',
    '{author}',
    '{publisher}',
    '{content_text}'
) ON CONFLICT (id) DO NOTHING;

""")
                
        print(f"SQL INSERT statements generated in: {output_file}")
        print(f"Documents: {len(docs)}")
        print(f"Countries: {len(countries)}")
        print(f"Languages: {len(languages)}")
        print(f"Document Types: {len(doctypes)}")
    
    def insert_to_database(self, docs: List[Dict[str, Any]], db_config: Optional[Any] = None) -> bool:
        """Insert documents directly into SQL Server database"""
        if not DATABASE_AVAILABLE:
            print("Database functionality not available. Install pymssql to use this feature.")
            return False
        
        try:
            db_manager = DatabaseManager(db_config)
            
            # Test connection first
            if not db_manager.test_connection():
                print("Failed to connect to database")
                return False
            
            print("Connected to database successfully")
            
            # Process documents into database format
            db_docs = []
            for doc in docs:
                db_doc = {
                    'id': self.clean_text(doc.get('id', '')),
                    'title': self.clean_text(doc.get('display_title', '')),
                    'abstract': self.clean_text(doc.get('abstract', '')),
                    'docdt': doc.get('docdt'),
                    'docty': self.clean_text(doc.get('docty', '')) if not isinstance(doc.get('docty'), list) 
                            else self.clean_text(doc['docty'][0]) if doc.get('docty') else '',
                    'majdocty': self.clean_text(doc.get('majdocty', '')) if not isinstance(doc.get('majdocty'), list)
                               else self.clean_text(doc['majdocty'][0]) if doc.get('majdocty') else '',
                    'volnb': doc.get('volnb') if doc.get('volnb') and str(doc.get('volnb')).isdigit() else None,
                    'totvolnb': doc.get('totvolnb') if doc.get('totvolnb') and str(doc.get('totvolnb')).isdigit() else None,
                    'url': self.clean_text(doc.get('pdfurl', '') or doc.get('url', '')),
                    'lang': self.clean_text(doc.get('lang', '')) if not isinstance(doc.get('lang'), list)
                           else self.clean_text(doc['lang'][0]) if doc.get('lang') else '',
                    'count': self.clean_text(doc.get('count', '')) if not isinstance(doc.get('count'), list)
                            else self.clean_text(doc['count'][0]) if doc.get('count') else '',
                    'author': self.clean_text(doc.get('author', '')),
                    'publisher': self.clean_text(doc.get('publisher', ''))
                }
                
                # Handle date parsing
                if db_doc['docdt']:
                    try:
                        if 'T' in str(db_doc['docdt']):
                            parsed_date = datetime.fromisoformat(str(db_doc['docdt']).replace('Z', '+00:00'))
                        else:
                            parsed_date = datetime.strptime(str(db_doc['docdt'])[:10], '%Y-%m-%d')
                        db_doc['docdt'] = parsed_date.date()
                    except:
                        db_doc['docdt'] = None
                
                db_docs.append(db_doc)
            
            # Bulk insert documents
            inserted_count, failed_count = db_manager.bulk_insert_documents(db_docs)
            
            if inserted_count > 0:
                print(f"Successfully inserted {inserted_count} documents")
                if failed_count > 0:
                    print(f"Failed to insert {failed_count} documents")
                return True
            else:
                print("No documents were inserted")
                return False
                
        except Exception as e:
            print(f"Database insertion failed: {e}")
            return False

def main():
    parser = argparse.ArgumentParser(description='Scrape World Bank Documents API')
    parser.add_argument('--count', type=int, default=100, 
                       help='Number of documents to fetch (default: 100)')
    parser.add_argument('--output', type=str, default='sample_data.sql',
                       help='Output SQL file (default: sample_data.sql)')
    parser.add_argument('--query', type=str, 
                       help='Search query term (optional)')
    parser.add_argument('--country', type=str,
                       help='Filter by specific country (optional)')
    parser.add_argument('--offset', type=int, default=0,
                       help='Starting offset for pagination (default: 0)')
    parser.add_argument('--database', action='store_true',
                       help='Insert directly into PostgreSQL database (requires psycopg2-binary)')
    parser.add_argument('--db-host', type=str, default='localhost',
                       help='Database host (default: localhost)')
    parser.add_argument('--db-port', type=int, default=5432,
                       help='Database port (default: 5432)')
    parser.add_argument('--db-name', type=str, default='docqueryservice',
                       help='Database name (default: docqueryservice)')
    parser.add_argument('--sql-only', action='store_true',
                       help='Generate SQL file only (no PDF downloads). Default is to download PDFs to local storage.')
    
    args = parser.parse_args()
    
    print(f"World Bank Documents API Scraper")
    print(f"Fetching {args.count} documents...")
    if args.query:
        print(f"Query: {args.query}")
    if args.country:
        print(f"Country: {args.country}")
    if args.database:
        print(f"Database: {args.db_host}:{args.db_port}/{args.db_name}")
    print()
    
    scraper = WorldBankScraper()
    
    try:
        docs = scraper.fetch_documents(
            count=args.count,
            start_offset=args.offset,
            query_term=args.query,
            country=args.country
        )
        
        if docs:
            success = False
            
            # Insert to database if requested
            if args.database:
                if DATABASE_AVAILABLE:
                    db_config = {
                        'host': args.db_host,
                        'port': args.db_port,
                        'database': args.db_name
                    }
                    if scraper.insert_to_database(docs, db_config):
                        success = True
                        print(f"\nSuccess! Inserted {len(docs)} documents into database.")
                    else:
                        print("\nDatabase insertion failed, generating SQL file instead...")
                        scraper.generate_sql_inserts(docs, args.output)
                        print(f"Generated {args.output} with {len(docs)} documents.")
                        success = True
                else:
                    print("\nDatabase functionality not available. Install pyodbc to use --database option.")
                    print("Generating SQL file instead...")
                    scraper.generate_sql_inserts(docs, args.output)
                    print(f"Generated {args.output} with {len(docs)} documents.")
                    success = True
            else:
                # Generate SQL file
                scraper.generate_sql_inserts(docs, args.output)
                print(f"\nSuccess! Generated {args.output} with {len(docs)} documents.")
                
                # Default behavior: Download PDFs to local storage unless --sql-only is specified
                if args.sql_only:
                    print(f"Run this SQL file against your database to insert the data.")
                else:
                    print("Downloading PDFs to local storage...")
                    try:
                        # Initialize PDF downloader
                        downloader = PDFDownloader(
                            output_dir="pdfs",
                            max_workers=3,
                            timeout=30,
                            delay=1.0
                        )
                        
                        # Download PDFs
                        result = downloader.download_pdfs(docs, quiet=True)
                        updated_docs = result['documents']
                        stats = result['stats']
                        
                        # Update SQL file with download results
                        downloader.update_sql_file(args.output, updated_docs, quiet=True)
                        
                        # Print summary
                        if stats['processed'] > 0:
                            success_rate = ((stats['downloaded'] + stats['skipped']) / stats['processed']) * 100
                            print(f"PDF download completed! Downloaded: {stats['downloaded']}, Skipped: {stats['skipped']}, Failed: {stats['failed']} (Success rate: {success_rate:.1f}%)")
                        else:
                            print("No PDFs to download.")
                            
                    except Exception as e:
                        print(f"Failed to download PDFs: {e}")
                        print("SQL file generated successfully, but PDF download failed.")
                
                success = True
            
            if not success:
                sys.exit(1)
        else:
            print("No documents retrieved.")
            sys.exit(1)
            
    except Exception as e:
        print(f"Error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()