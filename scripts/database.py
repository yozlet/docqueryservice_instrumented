#!/usr/bin/env python3
"""
Database utilities for Document Query Service
Handles connections and operations for PostgreSQL database
"""

import os
import pg8000
import logging
from typing import Dict, List, Optional, Any, Tuple
from dataclasses import dataclass
from contextlib import contextmanager
import json
from datetime import datetime, date

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

@dataclass
class DatabaseConfig:
    """Database configuration settings"""
    host: str = "localhost"
    port: int = 5432
    database: str = "docqueryservice"
    username: str = "postgres"
    password: str = "DevPassword123!"
    timeout: int = 30
    
    @classmethod
    def from_env(cls) -> "DatabaseConfig":
        """Create config from environment variables"""
        return cls(
            host=os.getenv("DB_HOST", "localhost"),
            port=int(os.getenv("DB_PORT", "5432")),
            database=os.getenv("DB_DATABASE", "docqueryservice"),
            username=os.getenv("DB_USERNAME", "postgres"),
            password=os.getenv("DB_PASSWORD", "DevPassword123!"),
            timeout=int(os.getenv("DB_TIMEOUT", "30"))
        )

class DatabaseManager:
    """Manages database connections and operations"""
    
    def __init__(self, config: Optional[DatabaseConfig] = None):
        self.config = config or DatabaseConfig.from_env()
    
    @contextmanager
    def get_connection(self):
        """Get a database connection with automatic cleanup"""
        connection = None
        try:
            connection = pg8000.Connection(
                host=self.config.host,
                port=self.config.port,
                user=self.config.username,
                password=self.config.password,
                database=self.config.database,
                timeout=self.config.timeout
            )
            yield connection
        except Exception as e:
            if connection:
                connection.rollback()
            logger.error(f"Database connection error: {e}")
            raise
        finally:
            if connection:
                connection.close()
    
    def test_connection(self) -> bool:
        """Test database connectivity"""
        try:
            with self.get_connection() as conn:
                cursor = conn.cursor()
                cursor.execute("SELECT 1 as test")
                result = cursor.fetchone()
                logger.info("Database connection successful")
                return result[0] == 1
        except Exception as e:
            logger.error(f"Database connection failed: {e}")
            return False
    
    def create_database_if_not_exists(self) -> bool:
        """Create database if it doesn't exist"""
        try:
            # Connect to postgres database first
            master_config = DatabaseConfig(
                host=self.config.host,
                port=self.config.port,
                database="postgres",
                username=self.config.username,
                password=self.config.password,
                timeout=self.config.timeout
            )
            
            # Use autocommit for DDL operations
            connection = None
            try:
                connection = pg8000.Connection(
                    host=master_config.host,
                    port=master_config.port,
                    user=master_config.username,
                    password=master_config.password,
                    database=master_config.database,
                    timeout=master_config.timeout
                )
                connection.autocommit = True
                cursor = connection.cursor()
                
                # Check if database exists
                cursor.execute(
                    "SELECT COUNT(*) FROM pg_database WHERE datname = %s",
                    (self.config.database,)
                )
                exists = cursor.fetchone()[0] > 0
                
                if not exists:
                    logger.info(f"Creating database: {self.config.database}")
                    cursor.execute(f'CREATE DATABASE "{self.config.database}"')
                    logger.info("Database created successfully")
                else:
                    logger.info("Database already exists")
                
                return True
                
            finally:
                if connection:
                    connection.close()
                
        except Exception as e:
            logger.error(f"Failed to create database: {e}")
            return False
    
    def execute_script(self, script_path: str) -> bool:
        """Execute SQL script file"""
        try:
            with open(script_path, 'r', encoding='utf-8') as f:
                script = f.read()
            
            with self.get_connection() as conn:
                cursor = conn.cursor()
                
                # Split script by semicolons and execute separately
                statements = [stmt.strip() for stmt in script.split(';') if stmt.strip()]
                
                for statement in statements:
                    if statement:
                        try:
                            cursor.execute(statement)
                            conn.commit()
                        except Exception as e:
                            # Log warning but continue with other statements
                            logger.warning(f"Statement failed (continuing): {e}")
                            conn.rollback()
                            
                logger.info(f"Script executed successfully: {script_path}")
                return True
                
        except Exception as e:
            logger.error(f"Failed to execute script {script_path}: {e}")
            return False
    
    def insert_document(self, doc_data: Dict[str, Any]) -> bool:
        """Insert a single document into the database"""
        try:
            with self.get_connection() as conn:
                cursor = conn.cursor()
                
                # Prepare the insert statement
                sql = """
                INSERT INTO documents (
                    id, title, docdt, abstract, docty, majdocty, 
                    volnb, totvolnb, url, document_location, document_status, lang, country, author, publisher
                ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                """
                
                # Convert date string to date object if needed
                docdt = None
                if doc_data.get('docdt'):
                    try:
                        if isinstance(doc_data['docdt'], str):
                            docdt = datetime.strptime(doc_data['docdt'], '%Y-%m-%d').date()
                        elif isinstance(doc_data['docdt'], (datetime, date)):
                            docdt = doc_data['docdt']
                    except ValueError:
                        logger.warning(f"Invalid date format for document {doc_data.get('id')}: {doc_data.get('docdt')}")
                
                values = (
                    doc_data.get('id'),
                    doc_data.get('title', '')[:4000],  # Truncate if too long
                    docdt,
                    doc_data.get('abstract', '')[:4000] if doc_data.get('abstract') else None,
                    doc_data.get('docty', '')[:100] if doc_data.get('docty') else None,
                    doc_data.get('majdocty', '')[:100] if doc_data.get('majdocty') else None,
                    doc_data.get('volnb'),
                    doc_data.get('totvolnb'), 
                    doc_data.get('url', '')[:2048] if doc_data.get('url') else None,
                    doc_data.get('document_location', '')[:1024] if doc_data.get('document_location') else None,
                    doc_data.get('document_status', 'PENDING')[:50],
                    doc_data.get('lang', '')[:50] if doc_data.get('lang') else None,
                    doc_data.get('count', '')[:100] if doc_data.get('count') else None,  # count -> country
                    doc_data.get('author', '')[:500] if doc_data.get('author') else None,
                    doc_data.get('publisher', '')[:500] if doc_data.get('publisher') else None
                )
                
                cursor.execute(sql, values)
                conn.commit()
                return True
                
        except Exception as e:
            logger.error(f"Failed to insert document {doc_data.get('id')}: {e}")
            return False
    
    def bulk_insert_documents(self, documents: List[Dict[str, Any]], batch_size: int = 100) -> Tuple[int, int]:
        """Insert multiple documents in batches"""
        total_docs = len(documents)
        inserted_count = 0
        failed_count = 0
        
        logger.info(f"Starting bulk insert of {total_docs} documents")
        
        for i in range(0, total_docs, batch_size):
            batch = documents[i:i + batch_size]
            batch_inserted = 0
            
            try:
                with self.get_connection() as conn:
                    cursor = conn.cursor()
                    
                    for doc_data in batch:
                        try:
                            # Prepare insert statement 
                            sql = """
<<<<<<< HEAD
                            MERGE documents AS target
                            USING (VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)) AS source 
                            (id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, url, document_location, document_status, lang, country, author, publisher)
                            ON target.id = source.id
                            WHEN MATCHED THEN
                                UPDATE SET 
                                    title = source.title,
                                    docdt = source.docdt,
                                    abstract = source.abstract,
                                    docty = source.docty,
                                    majdocty = source.majdocty,
                                    volnb = source.volnb,
                                    totvolnb = source.totvolnb,
                                    url = source.url,
                                    document_location = source.document_location,
                                    document_status = source.document_status,
                                    lang = source.lang,
                                    country = source.country,
                                    author = source.author,
                                    publisher = source.publisher,
                                    updated_at = GETDATE()
                            WHEN NOT MATCHED THEN
                                INSERT (id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, url, document_location, document_status, lang, country, author, publisher)
                                VALUES (source.id, source.title, source.docdt, source.abstract, source.docty, source.majdocty, 
                                       source.volnb, source.totvolnb, source.url, source.document_location, source.document_status, source.lang, source.country, source.author, source.publisher);
=======
                            INSERT INTO documents (
                                id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
                                url, lang, country, author, publisher
                            ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                            ON CONFLICT (id) DO UPDATE SET
                                title = EXCLUDED.title,
                                docdt = EXCLUDED.docdt,
                                abstract = EXCLUDED.abstract,
                                docty = EXCLUDED.docty,
                                majdocty = EXCLUDED.majdocty,
                                volnb = EXCLUDED.volnb,
                                totvolnb = EXCLUDED.totvolnb,
                                url = EXCLUDED.url,
                                lang = EXCLUDED.lang,
                                country = EXCLUDED.country,
                                author = EXCLUDED.author,
                                publisher = EXCLUDED.publisher,
                                updated_at = CURRENT_TIMESTAMP
>>>>>>> origin/howardyoo
                            """
                            
                            # Convert date
                            docdt = None
                            if doc_data.get('docdt'):
                                try:
                                    if isinstance(doc_data['docdt'], str):
                                        docdt = datetime.strptime(doc_data['docdt'], '%Y-%m-%d').date()
                                    elif isinstance(doc_data['docdt'], (datetime, date)):
                                        docdt = doc_data['docdt']
                                except ValueError:
                                    pass
                            
                            values = (
                                doc_data.get('id'),
                                doc_data.get('title', '')[:4000] if doc_data.get('title') else '',
                                docdt,
                                doc_data.get('abstract', '')[:4000] if doc_data.get('abstract') else None,
                                doc_data.get('docty', '')[:100] if doc_data.get('docty') else None,
                                doc_data.get('majdocty', '')[:100] if doc_data.get('majdocty') else None,
                                doc_data.get('volnb'),
                                doc_data.get('totvolnb'), 
                                doc_data.get('url', '')[:2048] if doc_data.get('url') else None,
                                doc_data.get('document_location', '')[:1024] if doc_data.get('document_location') else None,
                                doc_data.get('document_status', 'PENDING')[:50],
                                doc_data.get('lang', '')[:50] if doc_data.get('lang') else None,
                                doc_data.get('count', '')[:100] if doc_data.get('count') else None,
                                doc_data.get('author', '')[:500] if doc_data.get('author') else None,
                                doc_data.get('publisher', '')[:500] if doc_data.get('publisher') else None
                            )
                            
                            cursor.execute(sql, values)
                            batch_inserted += 1
                            
                        except Exception as e:
                            logger.warning(f"Failed to insert document {doc_data.get('id')}: {e}")
                            failed_count += 1
                    
                    conn.commit()
                    inserted_count += batch_inserted
                    logger.info(f"Batch {i//batch_size + 1}: Inserted {batch_inserted}/{len(batch)} documents")
                    
            except Exception as e:
                logger.error(f"Batch {i//batch_size + 1} failed: {e}")
                failed_count += len(batch)
        
        logger.info(f"Bulk insert completed: {inserted_count} inserted, {failed_count} failed")
        return inserted_count, failed_count
    
    def get_document_count(self) -> int:
        """Get total number of documents in database"""
        try:
            with self.get_connection() as conn:
                cursor = conn.cursor()
                cursor.execute("SELECT COUNT(*) FROM documents")
                return cursor.fetchone()[0]
        except Exception as e:
            logger.error(f"Failed to get document count: {e}")
            return 0
    
    def search_documents(self, search_term: str = None, limit: int = 10) -> List[Dict[str, Any]]:
        """Search documents using PostgreSQL full-text search with trigram similarity"""
        try:
            with self.get_connection() as conn:
                cursor = conn.cursor()
                
                if search_term:
                    # Use trigram similarity for search
                    sql = """
                    SELECT id, title, abstract, docdt, lang, country, majdocty, url
                    FROM documents
                    WHERE title %% %s OR abstract %% %s
                    ORDER BY 
                        GREATEST(
                            SIMILARITY(title, %s),
                            SIMILARITY(abstract, %s)
                        ) DESC
                    LIMIT %s
                    """
                    cursor.execute(sql, (search_term, search_term, search_term, search_term, limit))
                else:
                    sql = """
                    SELECT id, title, abstract, docdt, lang, country, majdocty, url
                    FROM documents
                    ORDER BY created_at DESC
                    LIMIT %s
                    """
                    cursor.execute(sql, (limit,))
                
                results = []
                for row in cursor:
                    doc = dict(zip([col[0] for col in cursor.description], row))
                    # Convert date to string if present
                    if doc.get('docdt'):
                        doc['docdt'] = doc['docdt'].strftime('%Y-%m-%d')
                    results.append(doc)
                
                return results
                
        except Exception as e:
            logger.error(f"Search failed: {e}")
            return []

def main():
    """Test database functionality"""
    logger.info("Testing database connection and setup...")
    
    # Initialize database manager
    db = DatabaseManager()
    
    # Test connection to master
    logger.info("Testing initial connection...")
    if not db.test_connection():
        logger.info("Database doesn't exist, attempting to create...")
        if not db.create_database_if_not_exists():
            logger.error("Failed to create database")
            return False
    
    # Test connection to our database
    if not db.test_connection():
        logger.error("Failed to connect to database")
        return False
    
    # Initialize schema
    schema_path = os.path.join(os.path.dirname(__file__), 'sql', 'init-schema.sql')
    if os.path.exists(schema_path):
        logger.info("Initializing database schema...")
        if not db.execute_script(schema_path):
            logger.error("Failed to initialize schema")
            return False
    else:
        logger.warning(f"Schema file not found: {schema_path}")
    
    # Test basic operations
    doc_count = db.get_document_count()
    logger.info(f"Current document count: {doc_count}")
    
    # Test search (will be empty initially)
    results = db.search_documents(limit=5)
    logger.info(f"Sample documents: {len(results)} found")
    
    logger.info("Database setup completed successfully!")
    return True

if __name__ == "__main__":
    main()