#!/bin/bash
# Database Setup Script - Azurite Integration
# Sets up PostgreSQL database and Azurite blob storage for development

set -e  # Exit on any error

# Configuration
DB_NAME="docqueryservice"
SAMPLE_DOCS=500
VENV_DIR=".venv"
PYTHON_CMD="python3"
CLEAN_FOR_TESTING=false
AZURITE_PORT=10000
AZURITE_DATA_DIR="./azurite_data"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Print banner
print_banner() {
    echo -e "${CYAN}"
    echo "╔══════════════════════════════════════════════════════════════════════════════╗"
    echo "║                    🔵 Database Setup - Azurite Integration 🔵                 ║"
    echo "║                                                                              ║"
    echo "║  📊 Sets up PostgreSQL database for document management                      ║"
    echo "║  🔵 Configures Azurite blob storage for PDF files                          ║"
    echo "║  📄 Downloads sample documents to Azurite storage                           ║"
    echo "║  🔄 Provides integrated development environment                              ║"
    echo "║                                                                              ║"
    echo "║  🚀 Ready for cloud-native document processing development                   ║"
    echo "╚══════════════════════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# Cleanup function for testing
cleanup_for_testing() {
    echo -e "${YELLOW}🧹 Cleaning up for fresh start...${NC}"
    
    echo -e "${YELLOW}Cleaning database...${NC}"
    if "$SCRIPT_DIR/utilities/cleanup-database.sh" --confirm --yes; then
        echo -e "${GREEN}✅ Database cleaned${NC}"
    else
        echo -e "${YELLOW}⚠️  Database cleanup skipped or failed (non-critical for setup)${NC}"
    fi

    echo -e "${YELLOW}Cleaning Azurite blob storage...${NC}"
    if [ -f "$SCRIPT_DIR/utilities/empty_azurite_blobs.py" ]; then
        if python3 "$SCRIPT_DIR/utilities/empty_azurite_blobs.py" --all --confirm --quiet; then
            echo -e "${GREEN}✅ Azurite storage cleaned${NC}"
        else
            echo -e "${YELLOW}⚠️  Azurite cleanup skipped or failed (non-critical)${NC}"
        fi
    else
        echo -e "${YELLOW}⚠️  Azurite cleanup script not found (non-critical)${NC}"
    fi

    echo -e "${YELLOW}Removing old sample data file...${NC}"
    if rm -f "$SCRIPT_DIR/tmp/sample_data.sql"; then
        echo -e "${GREEN}✅ Sample data file cleaned${NC}"
    else
        echo -e "${YELLOW}⚠️  Sample data file cleanup skipped or failed (non-critical)${NC}"
    fi
}

# Check if Azurite is running
check_azurite() {
    echo -e "${BLUE}🔵 Checking Azurite blob storage...${NC}"
    
    if curl -s "http://127.0.0.1:${AZURITE_PORT}/devstoreaccount1" > /dev/null 2>&1; then
        echo -e "${GREEN}✅ Azurite is running on port ${AZURITE_PORT}${NC}"
        return 0
    else
        echo -e "${YELLOW}⚠️  Azurite not detected on port ${AZURITE_PORT}${NC}"
        return 1
    fi
}

# Start Azurite if not running
start_azurite() {
    echo -e "${BLUE}🚀 Starting Azurite blob storage...${NC}"
    
    # Check if azurite command exists
    if ! command -v azurite &> /dev/null; then
        echo -e "${YELLOW}📦 Installing Azurite...${NC}"
        if command -v npm &> /dev/null; then
            npm install -g azurite
            echo -e "${GREEN}✅ Azurite installed${NC}"
        else
            echo -e "${RED}❌ npm not found. Please install Node.js and npm first${NC}"
            echo -e "${YELLOW}   Visit: https://nodejs.org/${NC}"
            exit 1
        fi
    fi
    
    # Create data directory
    mkdir -p "$AZURITE_DATA_DIR"
    
    # Start Azurite in background
    echo -e "${BLUE}🔵 Starting Azurite services...${NC}"
    azurite --silent --location "$AZURITE_DATA_DIR" --debug "$AZURITE_DATA_DIR/debug.log" &
    AZURITE_PID=$!
    
    # Wait for Azurite to start
    echo -e "${BLUE}⏳ Waiting for Azurite to initialize...${NC}"
    for i in {1..30}; do
        if check_azurite; then
            echo -e "${GREEN}✅ Azurite started successfully (PID: $AZURITE_PID)${NC}"
            echo -e "${CYAN}   📦 Blob service: http://127.0.0.1:10000${NC}"
            echo -e "${CYAN}   📋 Queue service: http://127.0.0.1:10001${NC}"
            echo -e "${CYAN}   📊 Table service: http://127.0.0.1:10002${NC}"
            echo -e "${CYAN}   📁 Data directory: $AZURITE_DATA_DIR${NC}"
            return 0
        fi
        sleep 1
    done
    
    echo -e "${RED}❌ Azurite failed to start within 30 seconds${NC}"
    return 1
}

# Setup Python virtual environment
setup_python_env() {
    echo -e "${BLUE}🐍 Setting up Python environment...${NC}"
    
    if [ ! -d "$VENV_DIR" ]; then
        echo -e "${YELLOW}📦 Creating virtual environment...${NC}"
        $PYTHON_CMD -m venv "$VENV_DIR"
        echo -e "${GREEN}✅ Virtual environment created${NC}"
    else
        echo -e "${GREEN}✅ Virtual environment already exists${NC}"
    fi
    
    # Activate virtual environment
    source "$VENV_DIR/bin/activate"
    echo -e "${GREEN}✅ Virtual environment activated${NC}"
    
    # Install dependencies
    echo -e "${YELLOW}📦 Installing Python dependencies...${NC}"
    
    # Install base requirements
    if [ -f "requirements.txt" ]; then
        pip install -r requirements.txt
        echo -e "${GREEN}✅ Base requirements installed${NC}"
    fi
    
    # Install Azurite-specific requirements
    if [ -f "requirements_azurite.txt" ]; then
        pip install -r requirements_azurite.txt
        echo -e "${GREEN}✅ Azurite requirements installed${NC}"
    else
        echo -e "${YELLOW}⚠️  Azurite requirements file not found, installing manually...${NC}"
        pip install azure-storage-blob azure-core
        echo -e "${GREEN}✅ Azure dependencies installed${NC}"
    fi
}

# Check database connection
check_database() {
    echo -e "${BLUE}🗄️  Checking database connection...${NC}"
    
    if docker exec docquery-postgres pg_isready -U postgres > /dev/null 2>&1; then
        echo -e "${GREEN}✅ Database is running${NC}"
        return 0
    else
        echo -e "${YELLOW}⚠️  Database not accessible${NC}"
        return 1
    fi
}

# Setup database
setup_database() {
    echo -e "${BLUE}🗄️  Setting up PostgreSQL database...${NC}"
    
    # Start database if not running
    if ! check_database; then
        echo -e "${YELLOW}🚀 Starting database services...${NC}"
        cd "$SCRIPT_DIR/.."
        docker compose up -d postgres
        cd "$SCRIPT_DIR"
        
        # Wait for database to be ready
        echo -e "${BLUE}⏳ Waiting for database to initialize...${NC}"
        for i in {1..60}; do
            if check_database; then
                echo -e "${GREEN}✅ Database is ready${NC}"
                break
            fi
            sleep 1
        done
        
        if ! check_database; then
            echo -e "${RED}❌ Database failed to start${NC}"
            exit 1
        fi
    fi
    
    # Create database and schema
    echo -e "${YELLOW}📊 Setting up database schema...${NC}"
    
    # Create database if it doesn't exist
    docker exec docquery-postgres psql -U postgres -c "CREATE DATABASE $DB_NAME;" 2>/dev/null || true
    
    # Apply schema
    if [ -f "../docs/schema.sql" ]; then
        docker exec -i docquery-postgres psql -U postgres -d "$DB_NAME" < "../docs/schema.sql"
        echo -e "${GREEN}✅ Database schema applied${NC}"
    else
        echo -e "${YELLOW}⚠️  Schema file not found, skipping schema setup${NC}"
    fi
}

# Generate sample data file only (without loading to database)
generate_sample_data_file_only() {
    echo -e "${BLUE}📄 Generating sample document data...${NC}"
    
    if [ ! -f "tmp/sample_data.sql" ]; then
        echo -e "${YELLOW}🌐 Fetching sample documents from World Bank API...${NC}"
        $PYTHON_CMD worldbank_scraper.py --count $SAMPLE_DOCS --output tmp/sample_data.sql
        
        if [ -f "tmp/sample_data.sql" ]; then
            echo -e "${GREEN}✅ Sample data generated (${SAMPLE_DOCS} documents)${NC}"
        else
            echo -e "${RED}❌ Failed to generate sample data${NC}"
            exit 1
        fi
    else
        echo -e "${GREEN}✅ Sample data file already exists${NC}"
    fi
}

# Load sample data to database (after PDFs are downloaded and SQL file is updated)
load_sample_data_to_database() {
    echo -e "${YELLOW}📊 Loading sample data into database...${NC}"
    docker exec -i docquery-postgres psql -U postgres -d "$DB_NAME" < "tmp/sample_data.sql"
    echo -e "${GREEN}✅ Sample data loaded into database${NC}"
}

# Download PDFs to Azurite
download_pdfs_to_azurite() {
    echo -e "${BLUE}🔵 Downloading PDFs to Azurite blob storage...${NC}"
    
    if [ ! -f "pdf_downloader_azurite.py" ]; then
        echo -e "${RED}❌ Azurite PDF downloader not found${NC}"
        echo -e "${YELLOW}   Expected: pdf_downloader_azurite.py${NC}"
        exit 1
    fi
    
    # Download all available PDFs to Azurite (same as regular setup)
    echo -e "${YELLOW}📥 Downloading all available PDFs to Azurite...${NC}"
    
    # Activate virtual environment and run PDF downloader with SQL file updates
    source "$VENV_DIR/bin/activate"
    $PYTHON_CMD pdf_downloader_azurite.py tmp/sample_data.sql \
        --container pdfs \
        --update-sql-file \
        --quiet
    
    echo -e "${GREEN}✅ PDFs downloaded to Azurite blob storage${NC}"
    
    # Show summary
    if [ -f "utilities/list_azurite_blobs.py" ]; then
        echo -e "${CYAN}📊 Azurite storage summary:${NC}"
        $PYTHON_CMD utilities/list_azurite_blobs.py | grep -E "(Found|Total:|📦|🔗)" || true
    fi
}

# Verify setup
verify_setup() {
    echo -e "${BLUE}🔍 Verifying setup...${NC}"
    
    # Check database
    DOC_COUNT=$(docker exec docquery-postgres psql -U postgres -d "$DB_NAME" -t -c "SELECT COUNT(*) FROM documents;" 2>/dev/null | tr -d ' ' || echo "0")
    if [ "$DOC_COUNT" -gt 0 ]; then
        echo -e "${GREEN}✅ Database: ${DOC_COUNT} documents loaded${NC}"
    else
        echo -e "${YELLOW}⚠️  Database: No documents found${NC}"
    fi
    
    # Check Azurite
    if check_azurite; then
        echo -e "${GREEN}✅ Azurite: Blob storage accessible${NC}"
        
        # Count blobs if possible
        if [ -f "utilities/list_azurite_blobs.py" ]; then
            BLOB_COUNT=$($PYTHON_CMD utilities/list_azurite_blobs.py 2>/dev/null | grep "Found" | grep -o '[0-9]\+' | head -1 || echo "0")
            if [ "$BLOB_COUNT" -gt 0 ]; then
                echo -e "${GREEN}✅ Azurite: ${BLOB_COUNT} PDFs stored${NC}"
            else
                echo -e "${YELLOW}⚠️  Azurite: No PDFs found${NC}"
            fi
        fi
    else
        echo -e "${YELLOW}⚠️  Azurite: Not accessible${NC}"
    fi
    
    # Check Python environment
    if [ -d "$VENV_DIR" ] && [ -f "$VENV_DIR/bin/activate" ]; then
        echo -e "${GREEN}✅ Python: Virtual environment ready${NC}"
    else
        echo -e "${YELLOW}⚠️  Python: Virtual environment not found${NC}"
    fi
}

# Show usage information
show_usage() {
    echo -e "${CYAN}📋 Development Environment Ready!${NC}"
    echo ""
    echo -e "${YELLOW}🔵 Azurite Blob Storage:${NC}"
    echo -e "  # Blob endpoint"
    echo -e "  http://127.0.0.1:10000/devstoreaccount1"
    echo ""
    echo -e "  # List blobs"
    echo -e "  python3 utilities/list_azurite_blobs.py"
    echo ""
    echo -e "  # Download more PDFs"
    echo -e "  python3 pdf_downloader_azurite.py tmp/sample_data.sql --max-downloads 50"
    echo ""
    echo -e "  # Clean Azurite storage"
    echo -e "  utilities/clean_azurite.sh --confirm"
    echo ""
    echo -e "${YELLOW}🗄️  Database Operations:${NC}"
    echo -e "  # Connect with psql"
    echo -e "  docker exec -it docquery-postgres psql -U postgres -d $DB_NAME"
    echo ""
    echo -e "  # Test database operations"
    echo -e "  python3 utilities/database.py"
    echo ""
    echo -e "${YELLOW}🐍 Python Environment:${NC}"
    echo -e "  # Activate virtual environment"
    echo -e "  source $VENV_DIR/bin/activate"
    echo ""
    echo -e "  # Add more documents"
    echo -e "  python3 worldbank_scraper.py --count 1000 --database"
    echo ""
    echo -e "${YELLOW}🧹 Cleanup Commands:${NC}"
    echo -e "  # Clean everything for fresh start"
    echo -e "  ./setup-database-azurite.sh --clean"
    echo ""
    echo -e "  # Stop services"
    echo -e "  docker compose down  # (run from project root)"
    echo -e "  pkill -f azurite"
    echo ""
    echo -e "${YELLOW}🔧 Troubleshooting:${NC}"
    echo -e "  # Check Azurite logs"
    echo -e "  tail -f $AZURITE_DATA_DIR/debug.log"
    echo ""
    echo -e "  # Restart Azurite"
    echo -e "  pkill -f azurite && utilities/start_azurite.sh"
    echo ""
}

# Main execution
main() {
    print_banner
    
    # Parse arguments
    for arg in "$@"; do
        case $arg in
            --clean)
                CLEAN_FOR_TESTING=true
                shift
                ;;
            --sample-docs=*)
                SAMPLE_DOCS="${arg#*=}"
                shift
                ;;
            --help|-h)
                echo "Usage: $0 [options]"
                echo ""
                echo "Options:"
                echo "  --clean              Clean database and Azurite storage before setup"
                echo "  --sample-docs=N      Number of sample documents to generate (default: $SAMPLE_DOCS)"
                echo "  --help               Show this help message"
                echo ""
                echo "This script sets up a complete development environment with:"
                echo "  • PostgreSQL database with sample data"
                echo "  • Azurite blob storage emulator"
                echo "  • Python virtual environment with dependencies"
                echo "  • Sample PDF documents in Azurite storage"
                exit 0
                ;;
            *)
                echo -e "${RED}❌ Unknown option: $arg${NC}"
                echo "Use --help for usage information"
                exit 1
                ;;
        esac
    done
    
    echo -e "${CYAN}🚀 Starting Azurite-integrated database setup...${NC}"
    echo -e "${CYAN}📊 Sample documents: $SAMPLE_DOCS${NC}"
    echo -e "${CYAN}🔵 Azurite data directory: $AZURITE_DATA_DIR${NC}"
    echo ""
    
    # Perform cleanup if requested
    if [ "$CLEAN_FOR_TESTING" = true ]; then
        cleanup_for_testing
        echo ""
    fi
    
    # Setup steps
    echo -e "${PURPLE}Step 1: Python Environment${NC}"
    setup_python_env
    echo ""
    
    echo -e "${PURPLE}Step 2: Azurite Blob Storage${NC}"
    if ! check_azurite; then
        start_azurite
    fi
    echo ""
    
    echo -e "${PURPLE}Step 3: Database Setup${NC}"
    setup_database
    echo ""
    
    echo -e "${PURPLE}Step 4: Sample Data Generation${NC}"
    generate_sample_data_file_only
    echo ""
    
    echo -e "${PURPLE}Step 5: PDF Download to Azurite${NC}"
    download_pdfs_to_azurite
    echo ""
    
    echo -e "${PURPLE}Step 6: Load Updated Sample Data${NC}"
    load_sample_data_to_database
    echo ""
    
    echo -e "${PURPLE}Step 7: Verification${NC}"
    verify_setup
    echo ""
    
    # Success message
    echo -e "${GREEN}🎉 Setup completed successfully!${NC}"
    echo ""
    
    show_usage
}

# Run main function
main "$@"
