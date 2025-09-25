#!/usr/bin/env python3
"""
Database Cleanup Script
Deletes all data from database tables while preserving table structure.
Supports both PostgreSQL and SQL Server databases.
"""

import os
import sys
import argparse
from typing import Optional
import logging

# Try to import database drivers, handle missing dependencies gracefully
try:
    import psycopg2
    HAS_POSTGRESQL = True
except ImportError:
    HAS_POSTGRESQL = False
    psycopg2 = None

try:
    import pyodbc
    HAS_SQLSERVER = True
except ImportError:
    HAS_SQLSERVER = False
    pyodbc = None

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

class DatabaseCleaner:
    def __init__(self, db_type: str = "postgresql"):
        """Initialize database cleaner with specified database type."""
        self.db_type = db_type.lower()
        self.connection = None
        
        # Tables in dependency order (children first, parents last)
        # This ensures we don't hit foreign key constraints
        self.tables_in_order = [
            # Relationship tables first (have foreign keys)
            'document_authors',
            'document_topics', 
            'document_access',
            
            # Main data tables
            'search_queries',
            'documents',
            
            # Lookup tables (referenced by foreign keys)
            'authors',
            'topics',
            'document_types',
            'languages',
            'countries'
        ]
    
    def connect_postgresql(self) -> bool:
        """Connect to PostgreSQL database using environment variables."""
        if not HAS_POSTGRESQL:
            logger.error("PostgreSQL support not available. Install with: pip install psycopg2-binary")
            return False
            
        try:
            # Try connection string first
            if os.getenv('DATABASE_URL'):
                self.connection = psycopg2.connect(os.getenv('DATABASE_URL'))
                logger.info("Connected to PostgreSQL using DATABASE_URL")
                return True
            
            # Fall back to individual parameters
            self.connection = psycopg2.connect(
                host=os.getenv('DB_HOST', 'localhost'),
                port=os.getenv('DB_PORT', 5432),
                database=os.getenv('DB_DATABASE', 'docqueryservice'),
                user=os.getenv('DB_USERNAME', 'postgres'),
                password=os.getenv('DB_PASSWORD', 'DevPassword123!')
            )
            logger.info("Connected to PostgreSQL using individual parameters")
            return True
            
        except Exception as e:
            logger.error(f"Failed to connect to PostgreSQL: {e}")
            return False
    
    def connect_sqlserver(self) -> bool:
        """Connect to SQL Server database using environment variables."""
        if not HAS_SQLSERVER:
            logger.error("SQL Server support not available. Install with: pip install pyodbc")
            return False
            
        try:
            server = os.getenv('DB_SERVER', 'localhost')
            port = os.getenv('DB_PORT', '1433')
            database = os.getenv('DB_DATABASE', 'DocQueryService')
            username = os.getenv('DB_USERNAME', 'sa')
            password = os.getenv('DB_PASSWORD', 'DevPassword123!')
            
            connection_string = f'DRIVER={{ODBC Driver 17 for SQL Server}};SERVER={server},{port};DATABASE={database};UID={username};PWD={password}'
            self.connection = pyodbc.connect(connection_string)
            logger.info("Connected to SQL Server")
            return True
            
        except Exception as e:
            logger.error(f"Failed to connect to SQL Server: {e}")
            return False
    
    def connect(self) -> bool:
        """Connect to the appropriate database based on db_type."""
        if self.db_type == "postgresql":
            return self.connect_postgresql()
        elif self.db_type == "sqlserver":
            return self.connect_sqlserver()
        else:
            logger.error(f"Unsupported database type: {self.db_type}")
            return False
    
    def get_table_row_count(self, table_name: str) -> int:
        """Get the current row count for a table."""
        try:
            cursor = self.connection.cursor()
            cursor.execute(f"SELECT COUNT(*) FROM {table_name}")
            count = cursor.fetchone()[0]
            cursor.close()
            return count
        except Exception as e:
            logger.warning(f"Could not get row count for {table_name}: {e}")
            return 0
    
    def delete_table_data(self, table_name: str) -> bool:
        """Delete all data from a specific table."""
        try:
            cursor = self.connection.cursor()
            
            # Get row count before deletion
            before_count = self.get_table_row_count(table_name)
            
            if before_count == 0:
                logger.info(f"Table '{table_name}' is already empty")
                cursor.close()
                return True
            
            # Delete all rows
            if self.db_type == "postgresql":
                # Use TRUNCATE for better performance, but fall back to DELETE if it fails
                try:
                    cursor.execute(f"TRUNCATE TABLE {table_name} RESTART IDENTITY CASCADE")
                    logger.info(f"Truncated table '{table_name}' ({before_count} rows)")
                except Exception:
                    cursor.execute(f"DELETE FROM {table_name}")
                    logger.info(f"Deleted all rows from table '{table_name}' ({before_count} rows)")
            else:
                # SQL Server - use DELETE (TRUNCATE has more restrictions with foreign keys)
                cursor.execute(f"DELETE FROM {table_name}")
                logger.info(f"Deleted all rows from table '{table_name}' ({before_count} rows)")
            
            cursor.close()
            return True
            
        except Exception as e:
            logger.error(f"Failed to delete data from table '{table_name}': {e}")
            return False
    
    def reset_identity_sequences(self) -> bool:
        """Reset auto-increment sequences for tables that have them."""
        if self.db_type != "postgresql":
            logger.info("Identity sequence reset only supported for PostgreSQL")
            return True
            
        try:
            cursor = self.connection.cursor()
            
            # Tables with SERIAL columns that need sequence reset
            serial_tables = [
                'countries', 'languages', 'document_types', 'authors', 
                'topics', 'search_queries', 'document_access'
            ]
            
            for table in serial_tables:
                try:
                    cursor.execute(f"ALTER SEQUENCE {table}_id_seq RESTART WITH 1")
                    logger.info(f"Reset sequence for table '{table}'")
                except Exception as e:
                    logger.warning(f"Could not reset sequence for '{table}': {e}")
            
            cursor.close()
            return True
            
        except Exception as e:
            logger.error(f"Failed to reset identity sequences: {e}")
            return False
    
    def cleanup_database(self, confirm: bool = False) -> bool:
        """Delete all data from all tables in the correct order."""
        if not confirm:
            logger.error("Cleanup requires explicit confirmation. Use --confirm flag.")
            return False
        
        logger.info("Starting database cleanup...")
        
        # Connect to database
        if not self.connect():
            return False
        
        try:
            # Disable foreign key checks temporarily (if supported)
            cursor = self.connection.cursor()
            if self.db_type == "postgresql":
                cursor.execute("SET session_replication_role = replica")
                logger.info("Disabled foreign key constraints")
            
            success_count = 0
            total_tables = len(self.tables_in_order)
            
            # Delete data from tables in dependency order
            for table_name in self.tables_in_order:
                if self.delete_table_data(table_name):
                    success_count += 1
                else:
                    logger.warning(f"Failed to clean table: {table_name}")
            
            # Re-enable foreign key checks
            if self.db_type == "postgresql":
                cursor.execute("SET session_replication_role = DEFAULT")
                logger.info("Re-enabled foreign key constraints")
            
            cursor.close()
            
            # Reset identity sequences
            self.reset_identity_sequences()
            
            # Commit all changes
            self.connection.commit()
            
            logger.info(f"Database cleanup completed: {success_count}/{total_tables} tables cleaned")
            
            return success_count == total_tables
            
        except Exception as e:
            logger.error(f"Database cleanup failed: {e}")
            if self.connection:
                self.connection.rollback()
            return False
        
        finally:
            if self.connection:
                self.connection.close()
                logger.info("Database connection closed")
    
    def show_table_counts(self) -> bool:
        """Show current row counts for all tables."""
        logger.info("Checking current table row counts...")
        
        if not self.connect():
            return False
        
        try:
            total_rows = 0
            print("\n" + "="*50)
            print("Current Database Table Counts")
            print("="*50)
            
            for table_name in reversed(self.tables_in_order):  # Show in logical order
                count = self.get_table_row_count(table_name)
                print(f"{table_name:<20}: {count:>8,} rows")
                total_rows += count
            
            print("-"*50)
            print(f"{'Total':<20}: {total_rows:>8,} rows")
            print("="*50)
            
            return True
            
        except Exception as e:
            logger.error(f"Failed to get table counts: {e}")
            return False
        
        finally:
            if self.connection:
                self.connection.close()


def main():
    """Main function to handle command line arguments and execute cleanup."""
    parser = argparse.ArgumentParser(
        description="Delete all data from database tables while preserving structure",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  # Show current table counts
  python cleanup-database.py --show-counts
  
  # Clean PostgreSQL database (requires confirmation)
  python cleanup-database.py --db-type postgresql --confirm
  
  # Clean SQL Server database  
  python cleanup-database.py --db-type sqlserver --confirm

Environment Variables:
  PostgreSQL:
    DATABASE_URL=postgresql://user:pass@host:port/dbname
    OR
    DB_HOST, DB_PORT, DB_DATABASE, DB_USERNAME, DB_PASSWORD
  
  SQL Server:
    DB_SERVER, DB_PORT, DB_DATABASE, DB_USERNAME, DB_PASSWORD
        """
    )
    
    parser.add_argument(
        '--db-type', 
        choices=['postgresql', 'sqlserver'], 
        default='postgresql',
        help='Database type (default: postgresql)'
    )
    
    parser.add_argument(
        '--confirm', 
        action='store_true',
        help='Confirm that you want to delete ALL data (required for cleanup)'
    )
    
    parser.add_argument(
        '--show-counts', 
        action='store_true',
        help='Show current row counts for all tables'
    )
    
    parser.add_argument(
        '--verbose', '-v',
        action='store_true',
        help='Enable verbose logging'
    )
    
    args = parser.parse_args()
    
    if args.verbose:
        logging.getLogger().setLevel(logging.DEBUG)
    
    # Create cleaner instance
    cleaner = DatabaseCleaner(args.db_type)
    
    # Show table counts if requested
    if args.show_counts:
        if not cleaner.show_table_counts():
            sys.exit(1)
        return
    
    # Perform cleanup
    if args.confirm:
        print("\n⚠️  WARNING: This will DELETE ALL DATA from the database!")
        print("Tables that will be cleaned:")
        for table in reversed(cleaner.tables_in_order):
            print(f"  - {table}")
        
        response = input("\nAre you absolutely sure? Type 'YES' to continue: ")
        if response != 'YES':
            print("Cleanup cancelled.")
            sys.exit(0)
    
    success = cleaner.cleanup_database(args.confirm)
    
    if success:
        print("\n✅ Database cleanup completed successfully!")
        # Show final counts
        cleaner.show_table_counts()
    else:
        print("\n❌ Database cleanup failed!")
        sys.exit(1)


if __name__ == "__main__":
    main()
