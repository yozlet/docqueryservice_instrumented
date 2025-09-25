#!/usr/bin/env python3
"""
Demonstrate what document_location field looks like for Azurite vs filesystem storage
"""

def show_document_location_examples():
    print("📊 Document Location Field Examples")
    print("=" * 50)
    print()
    
    # Sample document data
    sample_doc = {
        'id': '34442292',
        'title': 'Official Documents- Loan Agreement for Loan 9619-BR.pdf',
        'country': 'Brazil',
        'major_doc_type': 'Project Documents',
        'date': '2026'
    }
    
    filename = "P179365-20b99485-9b6e-49ed-93ee-9976c1043be5.pdf"
    
    print("🔵 AZURITE BLOB STORAGE:")
    print("   Storage Type: Azure Blob Storage (Azurite)")
    print("   document_location format:")
    azurite_location = f"{sample_doc['country']}/{sample_doc['major_doc_type'].replace(' ', '_')}/{sample_doc['date']}/{filename}"
    print(f"   '{azurite_location}'")
    print()
    print("   ✅ Easy to identify as Azurite:")
    print("   • No file system path separators (no leading /)")
    print("   • Hierarchical blob path structure")
    print("   • Country/Type/Year/Filename format")
    print("   • No disk drive letters or absolute paths")
    print()
    
    print("💾 FILESYSTEM STORAGE:")
    print("   Storage Type: Local Filesystem")
    print("   document_location format:")
    filesystem_location = f"/path/to/pdfs/{sample_doc['country']}/{sample_doc['major_doc_type'].replace(' ', '_')}/{sample_doc['date']}/{filename}"
    print(f"   '{filesystem_location}'")
    print()
    print("   ✅ Easy to identify as filesystem:")
    print("   • Starts with absolute path (/)")
    print("   • Contains filesystem separators")
    print("   • Traditional file path structure")
    print()
    
    print("🔍 DETECTION LOGIC:")
    print("   You can easily distinguish between them:")
    print()
    print("   ```python")
    print("   def is_azurite_storage(document_location):")
    print("       if not document_location:")
    print("           return False")
    print("       # Azurite blob paths don't start with '/' or contain drive letters")
    print("       return not (document_location.startswith('/') or ")
    print("                  document_location.startswith('\\\\') or")
    print("                  (len(document_location) > 1 and document_location[1] == ':'))")
    print("   ```")
    print()
    
    print("📋 REAL EXAMPLES:")
    print()
    
    # Real examples from the output we saw
    real_examples = [
        "English/Project_Documents/2026/P165557-f25f8ee3-ba39-43fe-a0eb-cd711d88eb49.pdf",
        "English/Project_Documents/2026/P179365-20b99485-9b6e-49ed-93ee-9976c1043be5.pdf",
        "Spanish/Publications_Research/2024/P123456-abcd1234-5678-90ef-ghij-klmnopqrstuv.pdf",
        "French/Project_Documents/2025/P789012-wxyz5678-90ab-cdef-1234-567890abcdef.pdf"
    ]
    
    print("   🔵 Azurite blob paths:")
    for example in real_examples:
        print(f"   • {example}")
    print()
    
    filesystem_examples = [
        "/var/lib/docquery/pdfs/English/Project_Documents/2026/P165557-f25f8ee3-ba39-43fe-a0eb-cd711d88eb49.pdf",
        "/home/user/pdfs/Spanish/Publications_Research/2024/P123456-abcd1234-5678-90ef-ghij-klmnopqrstuv.pdf",
        "C:\\DocumentStorage\\French\\Project_Documents\\2025\\P789012-wxyz5678-90ab-cdef-1234-567890abcdef.pdf"
    ]
    
    print("   💾 Filesystem paths:")
    for example in filesystem_examples:
        print(f"   • {example}")
    print()
    
    print("🎯 SUMMARY:")
    print("   • Azurite: Relative blob paths (Country/Type/Year/File)")
    print("   • Filesystem: Absolute file paths (/path/to/file)")
    print("   • Very easy to distinguish programmatically")
    print("   • Both maintain organized hierarchical structure")

if __name__ == '__main__':
    show_document_location_examples()
