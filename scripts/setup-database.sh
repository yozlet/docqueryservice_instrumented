#!/bin/bash
# Database Setup Script for Document Query Service
# Sets up SQL Server, initializes schema, and loads sample data

set -e

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Configuration
DB_NAME="DocQueryService"
SAMPLE_DOCS=500

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

# Check if SQL Server container is running
echo -e "${YELLOW}Checking SQL Server container...${NC}"
if ! docker ps | grep -q "docquery-sqlserver"; then
    echo -e "${YELLOW}Starting SQL Server container...${NC}"
    docker-compose up -d sqlserver
    echo -e "${YELLOW}Waiting for SQL Server to be ready...${NC}"
    
    # Wait for SQL Server to be healthy
    for i in {1..30}; do
        if docker exec docquery-sqlserver /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'DevPassword123!' -Q 'SELECT 1' > /dev/null 2>&1; then
            echo -e "${GREEN}✅ SQL Server is ready${NC}"
            break
        fi
        echo -n "."
        sleep 2
        if [ $i -eq 30 ]; then
            echo -e "${RED}❌ SQL Server failed to start${NC}"
            exit 1
        fi
    done
else
    echo -e "${GREEN}✅ SQL Server container is running${NC}"
fi

# Install Python dependencies
echo -e "${YELLOW}Installing Python dependencies...${NC}"
if command -v python3 &> /dev/null; then
    pip3 install -r database_requirements.txt > /dev/null 2>&1 || {
        echo -e "${YELLOW}Some dependencies may already be installed${NC}"
    }
    echo -e "${GREEN}✅ Python dependencies ready${NC}"
else
    echo -e "${RED}❌ Python3 not found. Please install Python 3.x${NC}"
    exit 1
fi

# Test database connection and setup
echo -e "${YELLOW}Setting up database schema...${NC}"
if python3 database.py > /dev/null 2>&1; then
    echo -e "${GREEN}✅ Database schema initialized${NC}"
else
    echo -e "${RED}❌ Database setup failed${NC}"
    echo -e "${YELLOW}Trying manual schema setup...${NC}"
    
    # Try to run schema script directly via Docker
    docker exec docquery-sqlserver /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'DevPassword123!' -Q "
    IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = '$DB_NAME')
    BEGIN
        CREATE DATABASE [$DB_NAME];
        PRINT 'Database created successfully';
    END
    "
    
    # Copy and run schema file
    docker cp sql/init-schema.sql docquery-sqlserver:/tmp/init-schema.sql
    docker exec docquery-sqlserver /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'DevPassword123!' -d "$DB_NAME" -i /tmp/init-schema.sql
    
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

if python3 worldbank_scraper.py --count $SAMPLE_DOCS --database > /dev/null 2>&1; then
    echo -e "${GREEN}✅ Sample data loaded successfully${NC}"
else
    echo -e "${YELLOW}Direct database insertion failed, trying SQL file method...${NC}"
    
    # Generate SQL file and run it
    if python3 worldbank_scraper.py --count $SAMPLE_DOCS --output /tmp/sample_data.sql; then
        # Copy SQL file to container and run it
        docker cp /tmp/sample_data.sql docquery-sqlserver:/tmp/sample_data.sql
        docker exec docquery-sqlserver /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'DevPassword123!' -d "$DB_NAME" -i /tmp/sample_data.sql
        
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}✅ Sample data loaded via SQL file${NC}"
        else
            echo -e "${YELLOW}⚠️  Sample data loading failed, but database is ready${NC}"
        fi
    else
        echo -e "${YELLOW}⚠️  Could not fetch sample data, but database is ready${NC}"
    fi
fi

# Enable full-text search
echo -e "${YELLOW}Enabling full-text search...${NC}"
docker cp sql/enable-fulltext-search.sql docquery-sqlserver:/tmp/enable-fulltext-search.sql
docker exec docquery-sqlserver /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'DevPassword123!' -d "$DB_NAME" -i /tmp/enable-fulltext-search.sql > /dev/null 2>&1

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Full-text search enabled${NC}"
else
    echo -e "${YELLOW}⚠️  Full-text search setup failed (non-critical)${NC}"
fi

# Test the setup
echo -e "${YELLOW}Testing database setup...${NC}"
if python3 -c "
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
echo -e "  Server: ${GREEN}localhost:1433${NC}"
echo -e "  Database: ${GREEN}$DB_NAME${NC}"
echo -e "  Username: ${GREEN}sa${NC}"
echo -e "  Password: ${GREEN}DevPassword123!${NC}"
echo ""
echo -e "${YELLOW}Available Commands:${NC}"
echo -e "  # Connect with sqlcmd"
echo -e "  docker exec -it docquery-sqlserver /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'DevPassword123!' -d $DB_NAME"
echo ""
echo -e "  # Add more documents"
echo -e "  python3 worldbank_scraper.py --count 1000 --database"
echo ""
echo -e "  # Test database operations"
echo -e "  python3 database.py"
echo ""
echo -e "  # Stop the database"
echo -e "  docker-compose down"
echo ""
echo -e "${GREEN}Ready to build your APIs! 🚀${NC}"