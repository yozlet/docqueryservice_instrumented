#!/usr/bin/env python3
"""
Simple script to list blobs in Azurite storage
"""

from azure.storage.blob import BlobServiceClient

def list_blobs():
    # Default Azurite connection string
    connection_string = 'DefaultEndpointsProtocol=http;AccountName=devstoreaccount1;AccountKey=Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==;BlobEndpoint=http://127.0.0.1:10000/devstoreaccount1;'
    container_name = 'pdfs'
    
    try:
        # Initialize client
        blob_service_client = BlobServiceClient.from_connection_string(connection_string)
        container_client = blob_service_client.get_container_client(container_name)
        
        print(f"🔵 Listing blobs in Azurite container: {container_name}")
        print(f"🔗 Endpoint: http://127.0.0.1:10000/devstoreaccount1")
        print("=" * 60)
        
        # List all blobs
        blobs = list(container_client.list_blobs())
        
        if not blobs:
            print("📄 No blobs found in container")
            return
        
        print(f"📄 Found {len(blobs)} blobs:")
        print()
        
        total_size = 0
        for i, blob in enumerate(blobs, 1):
            size_mb = blob.size / (1024 * 1024)
            total_size += blob.size
            
            print(f"{i:2d}. {blob.name}")
            print(f"    📊 Size: {blob.size:,} bytes ({size_mb:.2f} MB)")
            print(f"    📅 Modified: {blob.last_modified}")
            print(f"    📋 Content Type: {blob.content_settings.content_type if blob.content_settings else 'Unknown'}")
            
            # Show metadata if available
            if hasattr(blob, 'metadata') and blob.metadata:
                print(f"    🏷️  Metadata:")
                for key, value in blob.metadata.items():
                    print(f"       {key}: {value}")
            print()
        
        total_size_mb = total_size / (1024 * 1024)
        print("=" * 60)
        print(f"📊 Total: {len(blobs)} blobs, {total_size:,} bytes ({total_size_mb:.2f} MB)")
        
    except Exception as e:
        print(f"❌ Error listing blobs: {e}")
        print("   Make sure Azurite is running: azurite --silent --location ./azurite_data")

if __name__ == '__main__':
    list_blobs()
