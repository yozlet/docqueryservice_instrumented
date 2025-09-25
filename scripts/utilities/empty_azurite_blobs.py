#!/usr/bin/env python3
"""
Empty Azurite Blob Storage Script
Removes all blobs from specified containers in Azurite storage.
Useful for testing and cleanup purposes.
"""

import argparse
import sys
from azure.storage.blob import BlobServiceClient
from azure.core.exceptions import ResourceNotFoundError

def empty_container(connection_string: str, container_name: str, verbose: bool = True) -> bool:
    """Empty all blobs from a specific container."""
    try:
        # Initialize client
        blob_service_client = BlobServiceClient.from_connection_string(connection_string)
        container_client = blob_service_client.get_container_client(container_name)
        
        if verbose:
            print(f"🔵 Connecting to Azurite container: {container_name}")
            print(f"🔗 Endpoint: {connection_string.split('BlobEndpoint=')[1].split(';')[0] if 'BlobEndpoint=' in connection_string else 'default'}")
        
        # Check if container exists
        try:
            container_properties = container_client.get_container_properties()
            if verbose:
                print(f"✅ Container found: {container_name}")
        except ResourceNotFoundError:
            if verbose:
                print(f"⚠️  Container '{container_name}' does not exist")
            return True  # Nothing to delete
        
        # List all blobs
        if verbose:
            print(f"📋 Listing all blobs in container...")
        
        blobs = list(container_client.list_blobs())
        
        if not blobs:
            if verbose:
                print(f"✅ Container is already empty (0 blobs)")
            return True
        
        if verbose:
            print(f"📄 Found {len(blobs)} blobs to delete")
            
        # Calculate total size
        total_size = sum(blob.size for blob in blobs)
        total_size_mb = total_size / (1024 * 1024)
        
        if verbose:
            print(f"📊 Total size to delete: {total_size:,} bytes ({total_size_mb:.2f} MB)")
            print(f"🗑️  Starting deletion process...")
        
        # Delete all blobs
        deleted_count = 0
        failed_count = 0
        
        for i, blob in enumerate(blobs, 1):
            try:
                blob_client = container_client.get_blob_client(blob.name)
                blob_client.delete_blob()
                deleted_count += 1
                
                if verbose and (i % 10 == 0 or i == len(blobs)):
                    progress = (i / len(blobs)) * 100
                    print(f"   🗑️  Deleted {i}/{len(blobs)} blobs ({progress:.1f}%)")
                    
            except Exception as e:
                failed_count += 1
                if verbose:
                    print(f"   ❌ Failed to delete '{blob.name}': {e}")
        
        # Summary
        if verbose:
            print(f"")
            print(f"✅ Deletion complete!")
            print(f"   🗑️  Successfully deleted: {deleted_count} blobs")
            if failed_count > 0:
                print(f"   ❌ Failed to delete: {failed_count} blobs")
            print(f"   💾 Space freed: {total_size_mb:.2f} MB")
        
        return failed_count == 0
        
    except Exception as e:
        if verbose:
            print(f"❌ Error emptying container '{container_name}': {e}")
        return False

def empty_all_containers(connection_string: str, verbose: bool = True) -> bool:
    """Empty all containers in Azurite storage."""
    try:
        # Initialize client
        blob_service_client = BlobServiceClient.from_connection_string(connection_string)
        
        if verbose:
            print(f"🔵 Connecting to Azurite storage...")
            print(f"🔗 Endpoint: {connection_string.split('BlobEndpoint=')[1].split(';')[0] if 'BlobEndpoint=' in connection_string else 'default'}")
        
        # List all containers
        if verbose:
            print(f"📋 Listing all containers...")
        
        containers = list(blob_service_client.list_containers())
        
        if not containers:
            if verbose:
                print(f"✅ No containers found - Azurite is already empty")
            return True
        
        if verbose:
            print(f"📦 Found {len(containers)} containers:")
            for container in containers:
                print(f"   • {container.name}")
            print()
        
        # Empty each container
        all_success = True
        for i, container in enumerate(containers, 1):
            if verbose:
                print(f"🗑️  [{i}/{len(containers)}] Emptying container: {container.name}")
                print("-" * 60)
            
            success = empty_container(connection_string, container.name, verbose)
            if not success:
                all_success = False
            
            if verbose and i < len(containers):
                print()  # Separator between containers
        
        if verbose:
            print("=" * 60)
            if all_success:
                print(f"🎉 All containers emptied successfully!")
            else:
                print(f"⚠️  Some containers had errors during emptying")
        
        return all_success
        
    except Exception as e:
        if verbose:
            print(f"❌ Error listing containers: {e}")
            print("   Make sure Azurite is running and accessible")
        return False

def main():
    parser = argparse.ArgumentParser(
        description='Empty Azurite blob storage containers',
        epilog="""
Examples:
  # Empty specific container
  python3 empty_azurite_blobs.py --container pdfs
  
  # Empty all containers
  python3 empty_azurite_blobs.py --all
  
  # Empty with custom connection string
  python3 empty_azurite_blobs.py --container pdfs --connection "DefaultEndpointsProtocol=http;..."
  
  # Quiet mode (minimal output)
  python3 empty_azurite_blobs.py --all --quiet
        """,
        formatter_class=argparse.RawDescriptionHelpFormatter
    )
    
    parser.add_argument('--container', type=str,
                       help='Specific container name to empty')
    parser.add_argument('--all', action='store_true',
                       help='Empty all containers in Azurite storage')
    parser.add_argument('--connection', type=str,
                       help='Custom Azurite connection string')
    parser.add_argument('--quiet', action='store_true',
                       help='Minimal output (only errors and final result)')
    parser.add_argument('--confirm', action='store_true',
                       help='Skip confirmation prompt (for automation)')
    
    args = parser.parse_args()
    
    # Validate arguments
    if not args.container and not args.all:
        print("❌ Error: Must specify either --container <name> or --all")
        print("Use --help for usage information")
        sys.exit(1)
    
    if args.container and args.all:
        print("❌ Error: Cannot use both --container and --all options")
        sys.exit(1)
    
    # Set verbosity
    verbose = not args.quiet
    
    # Default Azurite connection string
    connection_string = args.connection or 'DefaultEndpointsProtocol=http;AccountName=devstoreaccount1;AccountKey=Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==;BlobEndpoint=http://127.0.0.1:10000/devstoreaccount1;'
    
    # Show banner
    if verbose:
        print("🗑️  " + "=" * 60 + " 🗑️")
        print("           Azurite Blob Storage Cleanup Tool")
        print("=" * 64)
        print()
    
    # Confirmation prompt (unless --confirm is used)
    if not args.confirm:
        if args.all:
            action_desc = "empty ALL containers in Azurite storage"
        else:
            action_desc = f"empty container '{args.container}'"
        
        if verbose:
            print(f"⚠️  WARNING: This will {action_desc}")
            print(f"🗑️  All blobs will be permanently deleted!")
            print()
        
        try:
            response = input("Are you sure you want to continue? (yes/no): ").lower().strip()
            if response not in ['yes', 'y']:
                print("❌ Operation cancelled by user")
                sys.exit(0)
            print()
        except KeyboardInterrupt:
            print("\n❌ Operation cancelled by user (Ctrl+C)")
            sys.exit(0)
    
    # Perform the operation
    try:
        if args.all:
            success = empty_all_containers(connection_string, verbose)
        else:
            success = empty_container(connection_string, args.container, verbose)
        
        # Exit with appropriate code
        if success:
            if verbose:
                print()
                print("🎉 Operation completed successfully!")
            sys.exit(0)
        else:
            if verbose:
                print()
                print("❌ Operation completed with errors")
            sys.exit(1)
            
    except KeyboardInterrupt:
        print("\n⚠️  Operation interrupted by user (Ctrl+C)")
        sys.exit(130)
    except Exception as e:
        print(f"💥 Unexpected error: {e}")
        sys.exit(1)

if __name__ == '__main__':
    main()
