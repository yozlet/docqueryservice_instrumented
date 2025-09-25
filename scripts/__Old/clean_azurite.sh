#!/bin/bash
# Simple wrapper script to clean Azurite blob storage

echo "🗑️  Azurite Blob Storage Cleanup"
echo "================================"

# Check if Azurite cleanup script exists
if [ ! -f "$(dirname "$0")/empty_azurite_blobs.py" ]; then
    echo "❌ Error: empty_azurite_blobs.py not found in utilities directory"
    exit 1
fi

# Parse arguments
CONTAINER=""
ALL_CONTAINERS=false
QUIET=false
CONFIRM=false

for arg in "$@"; do
    case $arg in
        --container=*)
            CONTAINER="${arg#*=}"
            shift
            ;;
        --all)
            ALL_CONTAINERS=true
            shift
            ;;
        --quiet)
            QUIET=true
            shift
            ;;
        --confirm)
            CONFIRM=true
            shift
            ;;
        --help|-h)
            echo "Usage: $0 [options]"
            echo ""
            echo "Options:"
            echo "  --container=NAME    Empty specific container"
            echo "  --all              Empty all containers"
            echo "  --quiet            Minimal output"
            echo "  --confirm          Skip confirmation prompt"
            echo "  --help             Show this help"
            echo ""
            echo "Examples:"
            echo "  $0 --container=pdfs"
            echo "  $0 --all --confirm"
            echo "  $0 --container=pdfs --quiet"
            exit 0
            ;;
        *)
            echo "❌ Unknown option: $arg"
            echo "Use --help for usage information"
            exit 1
            ;;
    esac
done

# Build Python command
SCRIPT_DIR="$(dirname "$0")"
CMD="python3 $SCRIPT_DIR/empty_azurite_blobs.py"

if [ "$ALL_CONTAINERS" = true ]; then
    CMD="$CMD --all"
elif [ -n "$CONTAINER" ]; then
    CMD="$CMD --container $CONTAINER"
else
    # Default to pdfs container
    echo "ℹ️  No container specified, defaulting to 'pdfs'"
    CMD="$CMD --container pdfs"
fi

if [ "$QUIET" = true ]; then
    CMD="$CMD --quiet"
fi

if [ "$CONFIRM" = true ]; then
    CMD="$CMD --confirm"
fi

# Execute the command
echo "🚀 Executing: $CMD"
echo ""
exec $CMD
