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
from datetime import datetime
from typing import Dict, List, Optional, Any
import urllib.parse
import re

# Try to import database utilities (optional)
try:
    from database import DatabaseManager, DatabaseConfig
    DATABASE_AVAILABLE = True
except ImportError:
    DATABASE_AVAILABLE = False
    DatabaseConfig = None  # Define as None when not available
    print("Database utilities not available. Install pymssql to use database features.")

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
                
            print(f"Fetching documents {current_offset + 1}-{current_offset + current_rows}...")
            
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
    
    def generate_document_location(self, doc: Dict[str, Any]) -> str:
        """Generate the expected document location for a document's PDF."""
        import hashlib
        from urllib.parse import urlparse, unquote
        from pathlib import Path
        
        url = doc.get('pdfurl', '') or doc.get('url', '')
        if not url:
            return ""
        
        # Generate filename similar to pdf_downloader.py logic
        try:
            parsed_url = urlparse(url)
            original_filename = Path(unquote(parsed_url.path)).name
            
            if not original_filename or not original_filename.lower().endswith('.pdf'):
                # Generate filename from document info
                title = self.clean_text(doc.get('display_title', ''))
                # Sanitize title for filename
                title_part = re.sub(r'[<>:"/\\|?*]', '_', title)
                title_part = re.sub(r'\s+', '_', title_part)
                title_part = title_part.strip('._')[:50]  # Limit length
                
                doc_id = doc.get('id', hashlib.md5(url.encode()).hexdigest()[:8])
                original_filename = f"{doc_id}_{title_part}.pdf"
            
            # Return the main file path (matches pdf_downloader.py structure)
            return f"pdfs/{original_filename}"
            
        except Exception:
            # Fallback to simple filename
            doc_id = doc.get('id', 'unknown')
            return f"pdfs/{doc_id}.pdf"

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
                
                # Generate document location
                document_location = self.generate_document_location(doc)
                
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
    '{document_location}',
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
                    'document_location': self.generate_document_location(doc),
                    'document_status': 'PENDING',  # Default status for new documents
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
    parser.add_argument('--output', type=str, default='worldbank_data.sql',
                       help='Output SQL file (default: worldbank_data.sql)')
    parser.add_argument('--query', type=str, 
                       help='Search query term (optional)')
    parser.add_argument('--country', type=str,
                       help='Filter by specific country (optional)')
    parser.add_argument('--offset', type=int, default=0,
                       help='Starting offset for pagination (default: 0)')
    parser.add_argument('--database', action='store_true',
                       help='Insert directly into SQL Server database (requires pyodbc)')
    parser.add_argument('--db-server', type=str, default='localhost',
                       help='Database server (default: localhost)')
    parser.add_argument('--db-port', type=int, default=1433,
                       help='Database port (default: 1433)')
    parser.add_argument('--db-name', type=str, default='DocQueryService',
                       help='Database name (default: DocQueryService)')
    
    args = parser.parse_args()
    
    # Ensure output file is saved in the current working directory
    import os
    from pathlib import Path
    
    # Get just the filename from the output path (remove any directory components)
    output_filename = os.path.basename(args.output)
    # Create the full path in the current working directory
    args.output = os.path.join(os.getcwd(), output_filename)
    
    print(f"World Bank Documents API Scraper")
    print(f"Fetching {args.count} documents...")
    if args.query:
        print(f"Query: {args.query}")
    if args.country:
        print(f"Country: {args.country}")
    if args.database:
        print(f"Database: {args.db_server}:{args.db_port}/{args.db_name}")
    else:
        print(f"Output file: {args.output}")
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
                    db_config = DatabaseConfig(
                        server=args.db_server,
                        port=args.db_port,
                        database=args.db_name
                    )
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
                print(f"Run this SQL file against your database to insert the data.")
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