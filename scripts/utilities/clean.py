#!/usr/bin/env python3
"""
Document Query Service - Complete Cleanup Script (Python)
Cleans database, removes generated files, and resets the environment
"""

import os
import sys
import shutil
import argparse
import subprocess
import logging
from pathlib import Path
from typing import List, Optional
import glob

# Try to import database drivers, handle missing dependencies gracefully
try:
    import psycopg2
    HAS_POSTGRESQL = True
except ImportError:
    HAS_POSTGRESQL = False
    psycopg2 = None

# Colors for terminal output
class Colors:
    RED = '\033[0;31m'
    GREEN = '\033[0;32m'
    YELLOW = '\033[1;33m'
    BLUE = '\033[0;34m'
    NC = '\033[0m'  # No Color
    BOLD = '\033[1m'

class CleanupManager:
    """Manages cleanup operations for the Document Query Service"""
    
    def __init__(self):
        self.script_dir = Path(__file__).parent.absolute()  # utilities directory
        self.scripts_dir = self.script_dir.parent  # scripts directory  
        self.project_root = self.scripts_dir.parent  # project root
        self.logger = self._setup_logging()
        
        # Database connection
        self.db_connection = None
        
        # Database tables in dependency order (children first, parents last)
        self.db_tables_in_order = [
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
        
    def _setup_logging(self) -> logging.Logger:
        """Setup colored logging"""
        logger = logging.getLogger(__name__)
        logger.setLevel(logging.INFO)
        
        # Remove existing handlers
        for handler in logger.handlers[:]:
            logger.removeHandler(handler)
        
        # Create console handler
        handler = logging.StreamHandler()
        handler.setLevel(logging.INFO)
        
        # Create formatter
        formatter = logging.Formatter('%(message)s')
        handler.setFormatter(formatter)
        logger.addHandler(handler)
        
        return logger
    
    def print_colored(self, message: str, color: str = Colors.NC):
        """Print colored message"""
        print(f"{color}{message}{Colors.NC}")
    
    def print_step(self, message: str):
        """Print step message"""
        self.print_colored(f"📋 {message}", Colors.BLUE)
    
    def print_success(self, message: str):
        """Print success message"""
        self.print_colored(f"✅ {message}", Colors.GREEN)
    
    def print_warning(self, message: str):
        """Print warning message"""
        self.print_colored(f"⚠️  {message}", Colors.YELLOW)
    
    def print_error(self, message: str):
        """Print error message"""
        self.print_colored(f"❌ {message}", Colors.RED)
    
    def check_docker_compose(self) -> bool:
        """Check if docker-compose is available"""
        try:
            # Try docker-compose first
            subprocess.run(['docker-compose', '--version'], 
                         capture_output=True, check=True)
            return True
        except (subprocess.CalledProcessError, FileNotFoundError):
            try:
                # Try docker compose (newer syntax)
                subprocess.run(['docker', 'compose', 'version'], 
                             capture_output=True, check=True)
                return True
            except (subprocess.CalledProcessError, FileNotFoundError):
                return False
    
    def run_docker_compose(self, args: List[str]) -> bool:
        """Run docker-compose command with proper syntax detection"""
        try:
            # Try docker-compose first
            try:
                result = subprocess.run(['docker-compose'] + args, 
                                      capture_output=True, check=True, 
                                      cwd=self.project_root)
                return True
            except (subprocess.CalledProcessError, FileNotFoundError):
                # Try docker compose (newer syntax)
                result = subprocess.run(['docker', 'compose'] + args, 
                                      capture_output=True, check=True, 
                                      cwd=self.project_root)
                return True
        except subprocess.CalledProcessError as e:
            self.print_error(f"Docker compose command failed: {e}")
            return False
        except FileNotFoundError:
            self.print_error("Docker compose not found")
            return False
    
    def clean_docker(self) -> bool:
        """Clean Docker containers and volumes"""
        self.print_step("Cleaning Docker containers and volumes...")
        
        if not self.check_docker_compose():
            self.print_warning("Docker Compose not available, skipping Docker cleanup")
            return False
        
        compose_file = self.project_root / "docker-compose.yml"
        if not compose_file.exists():
            self.print_warning("docker-compose.yml not found, skipping Docker cleanup")
            return False
        
        self.print_step("Stopping and removing Docker containers with volumes...")
        if self.run_docker_compose(['down', '-v', '--remove-orphans']):
            self.print_success("Docker cleanup completed")
            return True
        else:
            self.print_warning("Docker cleanup failed")
            return False
    
    def clean_files(self) -> bool:
        """Clean generated files"""
        self.print_step("Cleaning generated files...")
        
        success = True
        
        # Remove PDF directories
        pdf_dirs = ['pdfs', 'test_pdfs']
        for pdf_dir in pdf_dirs:
            pdf_path = self.scripts_dir / pdf_dir
            if pdf_path.exists():
                self.print_step(f"Removing {pdf_dir} directory...")
                try:
                    shutil.rmtree(pdf_path)
                    self.print_success(f"{pdf_dir} directory removed")
                except Exception as e:
                    self.print_error(f"Failed to remove {pdf_dir}: {e}")
                    success = False
        
        # Remove SQL data files
        self.print_step("Removing generated SQL files...")
        sql_patterns = [
            'sample_data.sql',
            'worldbank_data.sql', 
            '*_data.sql',
            'test_*.sql',
            'custom_*.sql'
        ]
        
        removed_files = 0
        for pattern in sql_patterns:
            for file_path in self.scripts_dir.glob(pattern):
                try:
                    file_path.unlink()
                    removed_files += 1
                except Exception as e:
                    self.print_error(f"Failed to remove {file_path}: {e}")
                    success = False
        
        if removed_files > 0:
            self.print_success(f"Removed {removed_files} SQL files")
        
        # Remove log directories
        log_dirs = ['logs', 'tmp', 'temp', '.tmp']
        for log_dir in log_dirs:
            log_path = self.scripts_dir / log_dir
            if log_path.exists():
                self.print_step(f"Removing {log_dir} directory...")
                try:
                    shutil.rmtree(log_path)
                    self.print_success(f"{log_dir} directory removed")
                except Exception as e:
                    self.print_error(f"Failed to remove {log_dir}: {e}")
                    success = False
        
        # Remove Python cache files
        self.print_step("Removing Python cache files...")
        cache_removed = 0
        
        # Remove __pycache__ directories
        for cache_dir in self.scripts_dir.rglob('__pycache__'):
            try:
                shutil.rmtree(cache_dir)
                cache_removed += 1
            except Exception as e:
                self.print_warning(f"Failed to remove cache dir {cache_dir}: {e}")
        
        # Remove .pyc and .pyo files
        for ext in ['*.pyc', '*.pyo']:
            for pyc_file in self.scripts_dir.rglob(ext):
                try:
                    pyc_file.unlink()
                    cache_removed += 1
                except Exception as e:
                    self.print_warning(f"Failed to remove {pyc_file}: {e}")
        
        if cache_removed > 0:
            self.print_success(f"Removed {cache_removed} cache files")
        
        if success:
            self.print_success("Generated files cleanup completed")
        
        return success
    
    def _connect_postgresql(self) -> bool:
        """Connect to PostgreSQL database using environment variables."""
        if not HAS_POSTGRESQL:
            self.print_warning("PostgreSQL support not available. Install with: pip install psycopg2-binary")
            return False
            
        try:
            # Try connection string first
            if os.getenv('DATABASE_URL'):
                self.db_connection = psycopg2.connect(os.getenv('DATABASE_URL'))
                self.print_step("Connected to PostgreSQL using DATABASE_URL")
                return True
            
            # Fall back to individual parameters
            self.db_connection = psycopg2.connect(
                host=os.getenv('DB_HOST', 'localhost'),
                port=os.getenv('DB_PORT', 5432),
                database=os.getenv('DB_DATABASE', 'docqueryservice'),
                user=os.getenv('DB_USERNAME', 'postgres'),
                password=os.getenv('DB_PASSWORD', 'DevPassword123!')
            )
            self.print_step("Connected to PostgreSQL")
            return True
            
        except Exception as e:
            self.print_warning(f"Failed to connect to PostgreSQL: {e}")
            return False
    
    def _get_table_row_count(self, table_name: str) -> int:
        """Get the current row count for a table."""
        try:
            cursor = self.db_connection.cursor()
            cursor.execute(f"SELECT COUNT(*) FROM {table_name}")
            count = cursor.fetchone()[0]
            cursor.close()
            return count
        except Exception as e:
            self.print_warning(f"Could not get row count for {table_name}: {e}")
            return 0
    
    def _delete_table_data(self, table_name: str) -> bool:
        """Delete all data from a specific table."""
        try:
            cursor = self.db_connection.cursor()
            
            # Get row count before deletion
            before_count = self._get_table_row_count(table_name)
            
            if before_count == 0:
                self.print_step(f"Table '{table_name}' is already empty")
                cursor.close()
                return True
            
            # Use TRUNCATE for better performance, but fall back to DELETE if it fails
            try:
                cursor.execute(f"TRUNCATE TABLE {table_name} RESTART IDENTITY CASCADE")
                self.print_step(f"Truncated table '{table_name}' ({before_count} rows)")
            except Exception:
                cursor.execute(f"DELETE FROM {table_name}")
                self.print_step(f"Deleted all rows from table '{table_name}' ({before_count} rows)")
            
            cursor.close()
            return True
            
        except Exception as e:
            self.print_error(f"Failed to delete data from table '{table_name}': {e}")
            return False
    
    def _reset_identity_sequences(self) -> bool:
        """Reset auto-increment sequences for tables that have them."""
        try:
            cursor = self.db_connection.cursor()
            
            # Tables with SERIAL columns that need sequence reset
            serial_tables = [
                'countries', 'languages', 'document_types', 'authors', 
                'topics', 'search_queries', 'document_access'
            ]
            
            for table in serial_tables:
                try:
                    cursor.execute(f"ALTER SEQUENCE {table}_id_seq RESTART WITH 1")
                    self.print_step(f"Reset sequence for table '{table}'")
                except Exception as e:
                    self.print_warning(f"Could not reset sequence for '{table}': {e}")
            
            cursor.close()
            return True
            
        except Exception as e:
            self.print_error(f"Failed to reset identity sequences: {e}")
            return False

    def clean_database(self) -> bool:
        """Clean database by deleting all data from all tables"""
        self.print_step("Cleaning database...")
        
        # Connect to database
        if not self._connect_postgresql():
            self.print_warning("Database cleanup failed - could not connect to database")
            self.print_warning("This is normal if the database container is not running")
            return False
        
        try:
            # Disable foreign key checks temporarily
            cursor = self.db_connection.cursor()
            cursor.execute("SET session_replication_role = replica")
            self.print_step("Disabled foreign key constraints")
            
            success_count = 0
            total_tables = len(self.db_tables_in_order)
            
            # Delete data from tables in dependency order
            for table_name in self.db_tables_in_order:
                if self._delete_table_data(table_name):
                    success_count += 1
                else:
                    self.print_warning(f"Failed to clean table: {table_name}")
            
            # Re-enable foreign key checks
            cursor.execute("SET session_replication_role = DEFAULT")
            self.print_step("Re-enabled foreign key constraints")
            cursor.close()
            
            # Reset identity sequences
            self._reset_identity_sequences()
            
            # Commit all changes
            self.db_connection.commit()
            
            self.print_success(f"Database cleanup completed: {success_count}/{total_tables} tables cleaned")
            
            return success_count == total_tables
            
        except Exception as e:
            self.print_error(f"Database cleanup failed: {e}")
            if self.db_connection:
                self.db_connection.rollback()
            return False
        
        finally:
            if self.db_connection:
                self.db_connection.close()
                self.print_step("Database connection closed")
    
    def run_cleanup(self, clean_database: bool, clean_files: bool, clean_docker: bool) -> bool:
        """Run the cleanup process"""
        self.print_colored("🧹 Document Query Service - Complete Cleanup", Colors.BLUE + Colors.BOLD)
        self.print_colored("=" * 45, Colors.BLUE)
        print()
        
        print("Starting cleanup process...")
        print()
        
        success = True
        
        # Clean Docker
        if clean_docker:
            if not self.clean_docker():
                success = False
            print()
        
        # Clean files
        if clean_files:
            if not self.clean_files():
                success = False
            print()
        
        # Clean database
        if clean_database:
            if not self.clean_database():
                success = False
            print()
        
        # Print summary
        self.print_colored("🎉 Cleanup Summary", Colors.GREEN + Colors.BOLD)
        self.print_colored("=" * 18, Colors.GREEN)
        print()
        
        if clean_docker:
            self.print_success("Docker: Containers and volumes cleanup attempted")
        
        if clean_files:
            self.print_success("Files: PDFs, SQL files, logs, and temporary files removed")
        
        if clean_database:
            self.print_success("Database: Cleanup attempted")
        
        print()
        self.print_colored("🚀 Environment cleanup completed!", Colors.BLUE + Colors.BOLD)
        print()
        self.print_colored("Next steps:", Colors.YELLOW + Colors.BOLD)
        print("  1. Run: docker-compose up -d                    # Start fresh database")
        print("  2. Run: python worldbank_scraper.py --count 100 # Generate sample data")
        print("  3. Run: python utilities/database.py           # Test database connection")
        print()
        
        return success

def main():
    """Main entry point"""
    parser = argparse.ArgumentParser(
        description="Document Query Service - Complete Cleanup Script",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  python clean.py --data --confirm               # Clean data only (database + files)
  python clean.py --database --confirm           # Clean database tables only
  python clean.py --files --confirm              # Clean generated files only
  python clean.py --all --confirm                # Clean everything (including Docker)
  python clean.py --docker --confirm             # Clean Docker containers only
        """
    )
    
    parser.add_argument('--database', '--db', action='store_true',
                       help='Clean database tables only (keeps containers running)')
    parser.add_argument('--files', action='store_true',
                       help='Clean generated files only (PDFs, SQL files, logs)')
    parser.add_argument('--docker', action='store_true',
                       help='Clean Docker containers and volumes only')
    parser.add_argument('--all', action='store_true',
                       help='Clean everything (database + files + docker)')
    parser.add_argument('--data', action='store_true',
                       help='Clean data only (database + files, but keep containers running)')
    parser.add_argument('--confirm', action='store_true',
                       help='Actually perform the cleanup (required)')
    
    args = parser.parse_args()
    
    # If --all is specified, enable all cleanup options
    if args.all:
        args.database = True
        args.files = True
        args.docker = True
    
    # If --data is specified, enable data cleanup options (but not Docker)
    if args.data:
        args.database = True
        args.files = True
    
    # If no specific options are given, show help
    if not (args.database or args.files or args.docker):
        print("⚠️  No cleanup options specified. Use --all to clean everything or --help for options.")
        return 1
    
    # Require confirmation
    if not args.confirm:
        print()
        print("⚠️  This script will permanently delete data. Use --confirm to proceed.")
        print()
        print("What will be cleaned:")
        if args.database:
            print("  🗄️  Database: All document data, search queries, access logs (containers stay running)")
        if args.files:
            print("  📁 Files: PDFs, SQL files, logs, generated content")
        if args.docker:
            print("  🐳 Docker: Containers, volumes, networks (infrastructure cleanup)")
        print()
        print("Re-run with --confirm to proceed.")
        return 0
    
    # Run cleanup
    manager = CleanupManager()
    success = manager.run_cleanup(args.database, args.files, args.docker)
    
    return 0 if success else 1

if __name__ == "__main__":
    sys.exit(main())
