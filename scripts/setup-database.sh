#!/bin/bash
# Database Setup Script for Document Query Service
# Sets up PostgreSQL, initializes schema, and loads sample data

set -e

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Configuration
DB_NAME="docqueryservice"
SAMPLE_DOCS=500
VENV_DIR=".venv"
PYTHON_CMD="python3"

# Function to check if virtual environment exists
check_venv() {
    if [ -d "$VENV_DIR" ] && [ -f "$VENV_DIR/bin/python" ]; then
        return 0  # venv exists
    else
        return 1  # venv doesn't exist
    fi
}

# Function to create virtual environment
create_venv() {
    echo -e "${YELLOW}Creating Python virtual environment...${NC}"
    $PYTHON_CMD -m venv $VENV_DIR
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Virtual environment created${NC}"
        return 0
    else
        echo -e "${RED}❌ Failed to create virtual environment${NC}"
        return 1
    fi
}

# Function to activate virtual environment
activate_venv() {
    if ! check_venv; then
        create_venv || return 1
    fi
    source "$VENV_DIR/bin/activate"
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Virtual environment activated${NC}"
        # Upgrade pip to latest version
        pip install --upgrade pip > /dev/null 2>&1
        return 0
    else
        echo -e "${RED}❌ Failed to activate virtual environment${NC}"
        return 1
    fi
}

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE} Document Query Service Database Setup${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# Check if Docker is running
echo -e "${YELLOW}Checking Docker...${NC}"
if ! docker info > /dev/null 2>&1; then
    echo -e "${RED}❌ Docker is not running. Please start Docker first.${NC}"
    exit 1
fi
echo -e "${GREEN}✅ Docker is running${NC}"

# Check if PostgreSQL container is running
echo -e "${YELLOW}Checking PostgreSQL container...${NC}"
if ! docker ps | grep -q "docquery-postgres"; then
    echo -e "${YELLOW}Starting PostgreSQL container...${NC}"
    docker compose up -d postgres
    echo -e "${YELLOW}Waiting for PostgreSQL to be ready...${NC}"
    
    # Wait for PostgreSQL to be healthy
    for i in {1..30}; do
        if docker exec docquery-postgres pg_isready -U postgres > /dev/null 2>&1; then
            echo -e "${GREEN}✅ PostgreSQL is ready${NC}"
            break
        fi
        echo -n "."
        sleep 2
        if [ $i -eq 30 ]; then
            echo -e "${RED}❌ PostgreSQL failed to start${NC}"
            exit 1
        fi
    done
else
    echo -e "${GREEN}✅ PostgreSQL container is running${NC}"
fi

# Check Python and setup virtual environment
echo -e "${YELLOW}Checking Python installation...${NC}"
if ! command -v $PYTHON_CMD &> /dev/null; then
    echo -e "${RED}❌ Python3 not found. Please install Python 3.x${NC}"
    exit 1
fi
echo -e "${GREEN}✅ Python $($PYTHON_CMD --version) found${NC}"

# Setup and activate virtual environment
echo -e "${YELLOW}Setting up Python virtual environment...${NC}"
if ! activate_venv; then
    echo -e "${RED}❌ Failed to setup virtual environment${NC}"
    exit 1
fi

# Install Python dependencies
echo -e "${YELLOW}Installing Python dependencies...${NC}"

# Upgrade pip first
python -m pip install --upgrade pip

# Install wheel and setuptools first
echo -e "${YELLOW}Installing base packages...${NC}"
if ! python -m pip install --upgrade wheel setuptools; then
    echo -e "${RED}❌ Failed to install base packages${NC}"
    exit 1
fi

# Now install our requirements
echo -e "${YELLOW}Installing project dependencies (this may take a moment)...${NC}"
if ! python -m pip install -r requirements.txt 2>&1; then
    echo -e "${RED}❌ Failed to install dependencies${NC}"
    echo -e "${YELLOW}Trying alternative installation method...${NC}"
    
    # Try installing one by one to identify problematic package
    while IFS= read -r line || [[ -n "$line" ]]; do
        # Skip comments and empty lines
        [[ $line =~ ^#.*$ ]] && continue
        [[ -z "${line// }" ]] && continue
        
        echo -e "${YELLOW}Installing $line...${NC}"
        if ! python -m pip install "$line" 2>&1; then
            echo -e "${RED}❌ Failed to install $line${NC}"
            exit 1
        fi
    done < requirements.txt
fi
echo -e "${GREEN}✅ Python dependencies installed${NC}"

# Test database connection and setup
echo -e "${YELLOW}Setting up database schema...${NC}"
if python database.py > /dev/null 2>&1; then
    echo -e "${GREEN}✅ Database schema initialized${NC}"
else
    echo -e "${RED}❌ Database setup failed${NC}"
    echo -e "${YELLOW}Trying manual schema setup...${NC}"
    
    # Try to run schema script directly via Docker
    docker exec docquery-postgres psql -U postgres -c "
    SELECT 'CREATE DATABASE $DB_NAME' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = '$DB_NAME')
    "
    
    # Copy and run schema file
    docker cp sql/init-schema.postgresql.sql docquery-postgres:/tmp/init-schema.sql
    docker exec docquery-postgres psql -U postgres -d "$DB_NAME" -f /tmp/init-schema.sql
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Schema created via Docker${NC}"
    else
        echo -e "${RED}❌ Schema creation failed${NC}"
        exit 1
    fi
fi

# Load sample data
echo -e "${YELLOW}Loading sample data from World Bank API...${NC}"
echo -e "${YELLOW}Fetching $SAMPLE_DOCS documents (this may take a few minutes)...${NC}"

if python worldbank_scraper.py --count $SAMPLE_DOCS --database > /dev/null 2>&1; then
    echo -e "${GREEN}✅ Sample data loaded successfully${NC}"
else
    echo -e "${YELLOW}Direct database insertion failed, trying SQL file method...${NC}"
    
    # Generate SQL file and run it
    if python worldbank_scraper.py --count $SAMPLE_DOCS --output /sample_data.sql; then
        # Copy SQL file to container and run it
        docker cp /sample_data.sql docquery-postgres:/tmp/sample_data.sql
        docker exec docquery-postgres psql -U postgres -d "$DB_NAME" -f /tmp/sample_data.sql
        
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}✅ Sample data loaded via SQL file${NC}"
        else
            echo -e "${YELLOW}⚠️  Sample data loading failed, but database is ready${NC}"
        fi
    else
        echo -e "${YELLOW}⚠️  Could not fetch sample data, but database is ready${NC}"
    fi
fi

# Enable trigram extension if not already enabled
echo -e "${YELLOW}Ensuring trigram extension is enabled...${NC}"
docker exec docquery-postgres psql -U postgres -d "$DB_NAME" -c "CREATE EXTENSION IF NOT EXISTS pg_trgm;" > /dev/null 2>&1

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Trigram search extension enabled${NC}"
else
    echo -e "${YELLOW}⚠️  Trigram extension setup failed (non-critical)${NC}"
fi

# Test the setup
echo -e "${YELLOW}Testing database setup...${NC}"
if python -c "
from database import DatabaseManager
db = DatabaseManager()
if db.test_connection():
    count = db.get_document_count()
    print(f'Database connection successful: {count} documents')
    exit(0)
else:
    exit(1)
" 2>/dev/null; then
    echo -e "${GREEN}✅ Database test successful${NC}"
else
    echo -e "${YELLOW}⚠️  Database test failed, but container is running${NC}"
fi

# Summary
echo ""
echo -e "${GREEN}🎉 Database setup completed!${NC}"
echo ""
echo -e "${YELLOW}Connection Details:${NC}"
echo -e "  Host: ${GREEN}localhost${NC}"
echo -e "  Port: ${GREEN}5432${NC}"
echo -e "  Database: ${GREEN}$DB_NAME${NC}"
echo -e "  Username: ${GREEN}postgres${NC}"
echo -e "  Password: ${GREEN}DevPassword123!${NC}"
echo ""
echo -e "${YELLOW}Available Commands:${NC}"
echo -e "  # Connect with psql"
echo -e "  docker exec -it docquery-postgres psql -U postgres -d $DB_NAME"
echo ""
echo -e "  # Activate virtual environment"
echo -e "  source $VENV_DIR/bin/activate"
echo ""
echo -e "  # Add more documents"
echo -e "  python worldbank_scraper.py --count 1000 --database"
echo ""
echo -e "  # Test database operations"
echo -e "  python database.py"
echo ""
echo -e "  # Stop the database"
echo -e "  docker-compose down"
echo ""
echo -e "${GREEN}Ready to build your APIs! 🚀${NC}"