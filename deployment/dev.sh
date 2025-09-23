#!/bin/bash

# Document Query Service - Local Development Manager
# Unified script for managing hybrid local development environment

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Script info
SCRIPT_NAME="$(basename "$0")"
VERSION="1.0.0"

# Functions
log() {
    echo -e "${GREEN}[$(date +'%H:%M:%S')] $1${NC}"
}

warn() {
    echo -e "${YELLOW}[$(date +'%H:%M:%S')] WARNING: $1${NC}"
}

error() {
    echo -e "${RED}[$(date +'%H:%M:%S')] ERROR: $1${NC}" >&2
}

info() {
    echo -e "${BLUE}[$(date +'%H:%M:%S')] $1${NC}"
}

success() {
    echo -e "${PURPLE}[$(date +'%H:%M:%S')] $1${NC}"
}

# Show help
show_help() {
    cat << EOF
${CYAN}Document Query Service - Local Development Manager${NC}

Usage: $SCRIPT_NAME <command> [options]

Commands:
  ${GREEN}start${NC}     Start the local development environment
  ${GREEN}stop${NC}      Stop the local development environment
  ${GREEN}status${NC}    Show status of all services
  ${GREEN}restart${NC}   Restart the entire environment
  ${GREEN}logs${NC}      Show logs from database container
  ${GREEN}help${NC}      Show this help message

Options:
  -a, --auto    Auto-start backend and frontend (for start command)
  -v, --verbose Show verbose output
  -q, --quiet   Suppress non-error output

Examples:
  $SCRIPT_NAME start           # Start database only, show commands
  $SCRIPT_NAME start --auto    # Start all services automatically
  $SCRIPT_NAME status          # Check service status
  $SCRIPT_NAME stop            # Stop all services
  $SCRIPT_NAME restart         # Stop and start all services

Services:
  ${BLUE}Database:${NC}  Azure SQL Edge in Docker (port 1433)
  ${BLUE}Backend:${NC}   .NET API in shell process (port 5001)
  ${BLUE}Frontend:${NC}  React + Vite in shell process (port 5173+)

Environment: Uses local-dev.env for configuration
EOF
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check if port is in use
port_in_use() {
    lsof -i :$1 >/dev/null 2>&1
}

# Function to get process using port
get_port_process() {
    lsof -ti :$1 2>/dev/null || echo ""
}

# Function to check service status
check_service_status() {
    local service=$1
    local port=$2
    local name=$3

    if port_in_use $port; then
        local pid=$(get_port_process $port)
        echo -e "  ${GREEN}✓${NC} $name: ${GREEN}Running${NC} (port $port, PID: $pid)"
        return 0
    else
        echo -e "  ${RED}✗${NC} $name: ${RED}Stopped${NC} (port $port)"
        return 1
    fi
}

# Function to check Docker container status
check_container_status() {
    local container=$1
    local name=$2

    if docker ps --format "table {{.Names}}" | grep -q "^$container$"; then
        local status=$(docker inspect --format='{{.State.Status}}' $container 2>/dev/null)
        local health=$(docker inspect --format='{{.State.Health.Status}}' $container 2>/dev/null || echo "none")

        if [ "$status" = "running" ]; then
            if [ "$health" = "healthy" ]; then
                echo -e "  ${GREEN}✓${NC} $name: ${GREEN}Running${NC} (healthy)"
            elif [ "$health" = "starting" ]; then
                echo -e "  ${YELLOW}⏳${NC} $name: ${YELLOW}Starting${NC}"
            elif [ "$health" = "unhealthy" ]; then
                echo -e "  ${RED}✗${NC} $name: ${RED}Unhealthy${NC}"
            else
                echo -e "  ${GREEN}✓${NC} $name: ${GREEN}Running${NC}"
            fi
            return 0
        else
            echo -e "  ${RED}✗${NC} $name: ${RED}$status${NC}"
            return 1
        fi
    else
        echo -e "  ${RED}✗${NC} $name: ${RED}Not running${NC}"
        return 1
    fi
}

# Load environment configuration
load_env() {
    if [ -f "local-dev.env" ]; then
        [ "$VERBOSE" = true ] && log "Loading local-dev.env"
        export $(grep -v '^#' local-dev.env | grep -v '^export' | xargs)
    else
        warn "local-dev.env not found, using defaults"
    fi
}

# Validate prerequisites
validate_prerequisites() {
    [ "$VERBOSE" = true ] && log "Validating prerequisites..."

    local missing=()

    if ! command_exists docker; then
        missing+=("docker")
    fi

    if ! command_exists mise; then
        missing+=("mise")
    fi

    if ! command_exists yarn; then
        missing+=("yarn")
    fi

    if ! command_exists nc; then
        missing+=("netcat (nc)")
    fi

    if [ ${#missing[@]} -ne 0 ]; then
        error "Missing required tools: ${missing[*]}"
        echo "Please install the missing tools and try again."
        exit 1
    fi

    [ "$VERBOSE" = true ] && log "Prerequisites validated ✓"
}

# Start database
start_database() {
    log "Starting database container..."

    if docker ps --format "table {{.Names}}" | grep -q "^docquery-database-dev$"; then
        warn "Database container already running"
        return 0
    fi

    docker-compose -f docker-compose.database-only.yml up -d

    # Wait for database to be ready
    log "Waiting for database to be ready..."
    local timeout=60
    local elapsed=0
    while ! nc -z localhost 1433 >/dev/null 2>&1; do
        if [ $elapsed -ge $timeout ]; then
            error "Database failed to start within $timeout seconds"
            return 1
        fi
        sleep 2
        elapsed=$((elapsed + 2))
        [ "$QUIET" != true ] && echo -n "."
    done
    [ "$QUIET" != true ] && echo

    # Additional wait for SQL Server to be fully ready for connections
    log "Waiting for SQL Server to accept connections..."
    elapsed=0
    while [ $elapsed -lt 30 ]; do
        # Use a simple connection test that doesn't require pymssql
        if timeout 3 bash -c "</dev/tcp/localhost/1433" >/dev/null 2>&1; then
            # Give SQL Server a bit more time to fully initialize after port is open
            sleep 5
            break
        fi
        sleep 2
        elapsed=$((elapsed + 2))
        [ "$QUIET" != true ] && echo -n "."
    done
    [ "$QUIET" != true ] && echo
    success "Database is ready ✓"

    # Initialize database schema and data
    init_database
    return 0
}

# Initialize database with schema and sample data
init_database() {
    log "Initializing database schema and data..."

    # Check if python3 is available
    if ! command -v python3 >/dev/null 2>&1; then
        warn "Python3 not found. Skipping database initialization."
        warn "You may need to manually run: cd scripts && python3 database.py"
        return 0
    fi

    # Check if pymssql is available
    if ! python3 -c "import pymssql" >/dev/null 2>&1; then
        warn "pymssql not installed. Installing database requirements..."
        if [ -f "../scripts/database_requirements.txt" ]; then
            pip3 install -r ../scripts/database_requirements.txt >/dev/null 2>&1 || {
                warn "Failed to install database requirements automatically."
                warn "You may need to run: pip3 install pymssql"
            }
        fi
    fi

    # Run database initialization
    local init_output
    if init_output=$(cd ../scripts && python3 -c "
import pymssql
import sys
try:
    conn = pymssql.connect('localhost:1433', 'sa', 'DevPassword123!', timeout=30)
    cursor = conn.cursor()

    # Check if DocQueryService database exists
    cursor.execute(\"SELECT COUNT(*) FROM sys.databases WHERE name = 'DocQueryService'\")
    if cursor.fetchone()[0] == 0:
        print('Creating DocQueryService database...')
        conn.autocommit(True)
        cursor.execute('CREATE DATABASE DocQueryService')
        conn.autocommit(False)

    # Switch to DocQueryService database
    conn.close()
    conn = pymssql.connect('localhost:1433', 'sa', 'DevPassword123!', 'DocQueryService', timeout=30)
    cursor = conn.cursor()

    # Check if documents table exists
    cursor.execute(\"SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'documents'\")
    if cursor.fetchone()[0] == 0:
        print('Creating documents table...')
        cursor.execute('''
            CREATE TABLE documents (
                id NVARCHAR(255) PRIMARY KEY,
                title NTEXT NOT NULL,
                docdt DATE,
                created_at DATETIME2 DEFAULT GETDATE(),
                updated_at DATETIME2 DEFAULT GETDATE(),
                abstract NTEXT,
                docty NVARCHAR(100),
                majdocty NVARCHAR(100),
                volnb INT,
                totvolnb INT,
                url NVARCHAR(2048),
                lang NVARCHAR(10),
                country NVARCHAR(100),
                author NVARCHAR(500),
                publisher NVARCHAR(500),
                content_text NTEXT
            )
        ''')
        conn.commit()

    # Check if we have documents
    cursor.execute('SELECT COUNT(*) FROM documents')
    count = cursor.fetchone()[0]

    if count == 0:
        print('No documents found. Loading sample data...')
        # Insert a few sample documents directly
        sample_docs = [
            ('34442285', 'Official Documents- Amendment No. 2 to the GPE Grant Agreement', '2026-12-31',
             'Agreement', 'Project Documents', 'https://documents.worldbank.org/example1.pdf',
             'English', 'Ghana', 'Official Documents- Amendment No. 2 to the GPE Grant Agreement'),
            ('34442292', 'Official Documents- Loan Agreement for Loan 9619-BR', '2026-12-31',
             'Loan Agreement', 'Project Documents', 'https://documents.worldbank.org/example2.pdf',
             'English', 'Brazil', 'Official Documents- Loan Agreement for Loan 9619-BR'),
            ('40045555', 'Costa Rica - Fiscal Management Improvement Project - Procurement Plan', '2025-09-22',
             'Procurement Plan', 'Project Documents', 'https://documents.worldbank.org/example3.pdf',
             'English', 'Costa Rica', 'Costa Rica - Fiscal Management Improvement Project - Procurement Plan')
        ]

        inserted = 0
        for doc in sample_docs:
            try:
                cursor.execute('''
                    INSERT INTO documents (id, title, docdt, docty, majdocty, url, lang, country, content_text)
                    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
                ''', doc)
                conn.commit()
                inserted += 1
            except Exception as e:
                print(f'Failed to insert document {doc[0]}: {e}')

        print(f'Loaded {inserted} sample documents')
    else:
        print(f'Database ready with {count} documents')

    conn.close()
    print('Database initialization completed successfully')

except ImportError:
    print('ERROR: pymssql not available. Install with: pip3 install pymssql')
    sys.exit(1)
except Exception as e:
    print(f'ERROR: Database initialization failed: {e}')
    sys.exit(1)
" 2>&1); then
        # Success case - show minimal output
        if echo "$init_output" | grep -q "ERROR:"; then
            warn "Database initialization had some issues:"
            echo "$init_output" | grep "ERROR:" || true
        else
            success "Database initialized ✓"
            [ "$VERBOSE" = true ] && echo "$init_output"
        fi
    else
        warn "Database initialization failed. Backend may return errors until database is set up."
        warn "To fix manually, run: cd scripts && python3 database.py && python3 worldbank_scraper.py --count 25 --database"
        [ "$VERBOSE" = true ] && echo "$init_output"
    fi
}

# Stop database
stop_database() {
    if docker ps --format "table {{.Names}}" | grep -q "^docquery-database-dev$"; then
        log "Stopping database container..."
        docker-compose -f docker-compose.database-only.yml down >/dev/null 2>&1
        success "Database stopped ✓"
    else
        [ "$VERBOSE" = true ] && warn "Database container not running"
    fi
}

# Stop backend processes
stop_backend() {
    local pids=$(pgrep -f "dotnet.*DocumentQueryService" 2>/dev/null || true)
    if [ -n "$pids" ]; then
        log "Stopping backend processes..."
        echo $pids | xargs kill 2>/dev/null || true
        sleep 2
        # Force kill if still running
        local remaining=$(pgrep -f "dotnet.*DocumentQueryService" 2>/dev/null || true)
        if [ -n "$remaining" ]; then
            echo $remaining | xargs kill -9 2>/dev/null || true
        fi
        success "Backend processes stopped ✓"
    else
        [ "$VERBOSE" = true ] && warn "No backend processes found"
    fi
}

# Stop frontend processes
stop_frontend() {
    local pids=$(pgrep -f "vite/bin/vite.js" 2>/dev/null || true)
    if [ -n "$pids" ]; then
        log "Stopping frontend processes..."
        echo $pids | xargs kill 2>/dev/null || true
        sleep 2
        # Force kill if still running
        local remaining=$(pgrep -f "vite/bin/vite.js" 2>/dev/null || true)
        if [ -n "$remaining" ]; then
            echo $remaining | xargs kill -9 2>/dev/null || true
        fi
        success "Frontend processes stopped ✓"
    else
        [ "$VERBOSE" = true ] && warn "No frontend processes found"
    fi
}

# Start services automatically
start_services_auto() {
    log "Starting backend and frontend automatically..."

    # Start backend in background
    cd ../backend-dotnet
    log "Starting backend on port 5001..."
    nohup mise exec -- dotnet run --no-launch-profile > ../deployment/.backend.log 2>&1 &
    local backend_pid=$!

    # Wait a moment for backend to start
    sleep 3

    # Verify backend started
    if ! kill -0 $backend_pid 2>/dev/null || ! port_in_use 5001; then
        error "Backend failed to start"
        return 1
    fi

    # Start frontend in background
    cd ../frontend-react
    log "Starting frontend (will auto-select port)..."
    nohup yarn dev > ../deployment/.frontend.log 2>&1 &
    local frontend_pid=$!

    # Wait for frontend to start
    sleep 5

    cd ../deployment

    # Show final status
    echo
    success "All services started!"
    show_service_urls
    echo
    echo -e "${YELLOW}Service logs:${NC}"
    echo "  Backend:  tail -f deployment/.backend.log"
    echo "  Frontend: tail -f deployment/.frontend.log"
    echo
    echo -e "${YELLOW}To stop all services:${NC} $SCRIPT_NAME stop"
}

# Show service URLs
show_service_urls() {
    echo -e "${CYAN}Service URLs:${NC}"

    if docker ps --format "table {{.Names}}" | grep -q "^docquery-database-dev$"; then
        echo -e "  ${GREEN}Database:${NC}  localhost:1433 (user: sa, password: DevPassword123!)"
    fi

    if port_in_use 5001; then
        echo -e "  ${GREEN}Backend:${NC}   http://localhost:5001 (API + Swagger UI)"
    fi

    # Find frontend port
    local frontend_port=""
    for port in 5173 5174 5175 5176 5177; do
        if port_in_use $port; then
            if pgrep -f "vite/bin/vite.js" >/dev/null 2>&1; then
                frontend_port=$port
                break
            fi
        fi
    done

    if [ -n "$frontend_port" ]; then
        echo -e "  ${GREEN}Frontend:${NC}  http://localhost:$frontend_port"
    fi
}

# Show manual start commands
show_manual_commands() {
    echo -e "${YELLOW}To start backend and frontend manually, run these commands in separate terminals:${NC}"
    echo
    echo -e "${BLUE}Terminal 1 - Backend:${NC}"
    echo "  cd backend-dotnet"
    echo "  source ../deployment/local-dev.env"
    echo "  mise exec -- dotnet run"
    echo
    echo -e "${BLUE}Terminal 2 - Frontend:${NC}"
    echo "  cd frontend-react"
    echo "  source ../deployment/local-dev.env"
    echo "  yarn dev"
}

# Command: start
cmd_start() {
    info "Starting Document Query Service local development environment..."

    load_env
    validate_prerequisites

    # Check for port conflicts (excluding database)
    if port_in_use 5001; then
        warn "Port 5001 is in use - backend may already be running"
    fi

    # Start database
    if ! start_database; then
        error "Failed to start database"
        exit 1
    fi

    # Show service information
    echo
    info "Database started successfully!"
    show_service_urls
    echo

    if [ "$AUTO_START" = true ]; then
        start_services_auto
    else
        show_manual_commands
        echo
        read -p "Would you like to start backend and frontend automatically? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            start_services_auto
        else
            echo
            info "Database is running. Use the commands above to start backend and frontend."
            echo -e "${YELLOW}Use '$SCRIPT_NAME status' to check service status${NC}"
            echo -e "${YELLOW}Use '$SCRIPT_NAME stop' to stop the database${NC}"
        fi
    fi
}

# Command: stop
cmd_stop() {
    info "Stopping Document Query Service local development environment..."

    stop_frontend
    stop_backend
    stop_database

    # Clean up log files
    rm -f .backend.log .frontend.log 2>/dev/null || true

    success "Local development environment stopped"
}

# Command: status
cmd_status() {
    load_env

    echo -e "${CYAN}Document Query Service - Development Status${NC}"
    echo -e "${CYAN}============================================${NC}"
    echo

    local all_running=true

    # Check database
    if ! check_container_status "docquery-database-dev" "Database (Azure SQL Edge)"; then
        all_running=false
    fi

    # Check backend
    if ! check_service_status "backend" 5001 "Backend (.NET API)"; then
        all_running=false
    fi

    # Check frontend (try common ports)
    local frontend_running=false
    for port in 5173 5174 5175 5176 5177; do
        if port_in_use $port && pgrep -f "vite/bin/vite.js" >/dev/null 2>&1; then
            check_service_status "frontend" $port "Frontend (React + Vite)"
            frontend_running=true
            break
        fi
    done

    if [ "$frontend_running" = false ]; then
        echo -e "  ${RED}✗${NC} Frontend (React + Vite): ${RED}Stopped${NC}"
        all_running=false
    fi

    echo

    if [ "$all_running" = true ]; then
        success "All services are running ✓"
        echo
        show_service_urls
    else
        info "Some services are not running"
        echo
        echo -e "${YELLOW}Commands:${NC}"
        echo "  Start: $SCRIPT_NAME start"
        echo "  Stop:  $SCRIPT_NAME stop"
    fi
}

# Command: restart
cmd_restart() {
    info "Restarting Document Query Service local development environment..."
    cmd_stop
    sleep 2
    AUTO_START=true cmd_start
}

# Command: logs
cmd_logs() {
    if docker ps --format "table {{.Names}}" | grep -q "^docquery-database-dev$"; then
        echo -e "${CYAN}Database Container Logs:${NC}"
        echo -e "${CYAN}=======================${NC}"
        docker logs --tail 50 -f docquery-database-dev
    else
        error "Database container is not running"
        echo "Use '$SCRIPT_NAME start' to start the database"
        exit 1
    fi
}

# Parse command line arguments
COMMAND=""
AUTO_START=false
VERBOSE=false
QUIET=false

while [[ $# -gt 0 ]]; do
    case $1 in
        start|stop|status|restart|logs|help)
            COMMAND="$1"
            shift
            ;;
        -a|--auto)
            AUTO_START=true
            shift
            ;;
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        -q|--quiet)
            QUIET=true
            shift
            ;;
        -h|--help)
            COMMAND="help"
            shift
            ;;
        *)
            error "Unknown argument: $1"
            echo "Use '$SCRIPT_NAME help' for usage information"
            exit 1
            ;;
    esac
done

# Show help if no command specified
if [ -z "$COMMAND" ]; then
    COMMAND="help"
fi

# Execute command
case $COMMAND in
    start)
        cmd_start
        ;;
    stop)
        cmd_stop
        ;;
    status)
        cmd_status
        ;;
    restart)
        cmd_restart
        ;;
    logs)
        cmd_logs
        ;;
    help)
        show_help
        ;;
    *)
        error "Unknown command: $COMMAND"
        echo "Use '$SCRIPT_NAME help' for usage information"
        exit 1
        ;;
esac