-- Migration script to add document_status and document_location fields to existing databases
-- Run this script on existing databases to add the new fields

-- PostgreSQL version
-- Uncomment the following lines if using PostgreSQL:

-- ALTER TABLE documents ADD COLUMN document_location VARCHAR(1024);
-- ALTER TABLE documents ADD COLUMN document_status VARCHAR(50) DEFAULT 'PENDING';
-- CREATE INDEX ix_documents_document_status ON documents(document_status);
-- CREATE INDEX ix_documents_status_created ON documents(document_status, created_at);

-- SQL Server version  
-- Uncomment the following lines if using SQL Server:

-- ALTER TABLE documents ADD document_location NVARCHAR(1024);
-- ALTER TABLE documents ADD document_status NVARCHAR(50) DEFAULT 'PENDING';
-- CREATE INDEX IX_documents_document_status ON documents(document_status);
-- CREATE INDEX IX_documents_status_created ON documents(document_status, created_at);

-- Update existing documents to have PENDING status if NULL
-- UPDATE documents SET document_status = 'PENDING' WHERE document_status IS NULL;

-- Optional: Update existing documents that have URLs but no status
-- UPDATE documents SET document_status = 'URL_ONLY' WHERE url IS NOT NULL AND document_status = 'PENDING';

PRINT 'Migration complete: Added document_status and document_location fields';
