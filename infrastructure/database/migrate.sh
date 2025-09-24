#!/bin/bash

# Database migration script for Azure PostgreSQL

# Required environment variables:
# - DB_HOST: Database host
# - DB_PORT: Database port (default: 5432)
# - DB_NAME: Database name
# - DB_USER: Database user
# - DB_PASSWORD: Database password

# Exit on error
set -e

# Set default port if not provided
DB_PORT=${DB_PORT:-5432}

# Check required environment variables
if [ -z "$DB_HOST" ] || [ -z "$DB_NAME" ] || [ -z "$DB_USER" ] || [ -z "$DB_PASSWORD" ]; then
    echo "Error: Missing required environment variables"
    echo "Required: DB_HOST, DB_NAME, DB_USER, DB_PASSWORD"
    echo "Optional: DB_PORT (default: 5432)"
    exit 1
fi

# Function to run SQL file
run_sql_file() {
    local file=$1
    echo "Running migration: $file"
    PGPASSWORD=$DB_PASSWORD psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -f "$file"
}

# Create migrations table if it doesn't exist
echo "Creating migrations table if it doesn't exist..."
PGPASSWORD=$DB_PASSWORD psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME << EOF
CREATE TABLE IF NOT EXISTS schema_migrations (
    version VARCHAR(255) PRIMARY KEY,
    applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
EOF

# Get list of applied migrations
APPLIED_MIGRATIONS=$(PGPASSWORD=$DB_PASSWORD psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -t -c "SELECT version FROM schema_migrations ORDER BY version;")

# Run migrations
for file in migrations/V*__*.sql; do
    # Extract version number from filename (V1__, V2__, etc.)
    version=$(basename $file | grep -o '^V[0-9]\+')
    
    # Check if migration has been applied
    if echo "$APPLIED_MIGRATIONS" | grep -q "$version"; then
        echo "Migration $version already applied, skipping..."
        continue
    fi
    
    # Run migration
    run_sql_file $file
    
    # Record migration
    PGPASSWORD=$DB_PASSWORD psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -c "INSERT INTO schema_migrations (version) VALUES ('$version');"
    
    echo "Migration $version completed successfully"
done

echo "All migrations completed"

