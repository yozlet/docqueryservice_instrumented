-- Document Query Service Database Schema - SQL Server Version
-- Based on World Bank Documents & Reports API specification
-- Optimized for SQL Server with full-text search capabilities

-- Create database (run this separately if needed)
-- CREATE DATABASE DocQueryService;
-- USE DocQueryService;

-- Main documents table
CREATE TABLE documents (
    id NVARCHAR(255) PRIMARY KEY,
    title NTEXT NOT NULL,
    docdt DATE,
    created_at DATETIME2 DEFAULT GETDATE(),
    updated_at DATETIME2 DEFAULT GETDATE(),
    
    -- Content and classification
    abstract NTEXT,
    content_text NTEXT, -- For full-text search
    
    -- Document type information
    docty NVARCHAR(100),
    majdocty NVARCHAR(100),
    
    -- Publishing information
    volnb INT,
    totvolnb INT,
    url NVARCHAR(2048),
    document_location NVARCHAR(1024), -- Path to downloaded PDF file on disk
    document_status NVARCHAR(50) DEFAULT 'PENDING', -- Document download status: PENDING, DOWNLOADED, NOT_FOUND, FAILED, URL_ONLY
    
    -- Language and country
    lang NVARCHAR(50),
    country NVARCHAR(100),
    
    -- Additional metadata
    author NVARCHAR(500),
    publisher NVARCHAR(500),
    isbn NVARCHAR(50),
    issn NVARCHAR(50)
);

-- Countries lookup table for normalization
CREATE TABLE countries (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) UNIQUE NOT NULL,
    code NVARCHAR(3) UNIQUE,
    region NVARCHAR(100),
    created_at DATETIME2 DEFAULT GETDATE()
);

-- Languages lookup table
CREATE TABLE languages (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(50) UNIQUE NOT NULL,
    iso_code NVARCHAR(3),
    created_at DATETIME2 DEFAULT GETDATE()
);

-- Document types lookup table
CREATE TABLE document_types (
    id INT IDENTITY(1,1) PRIMARY KEY,
    type_name NVARCHAR(100) UNIQUE NOT NULL,
    major_type NVARCHAR(100),
    description NVARCHAR(500),
    created_at DATETIME2 DEFAULT GETDATE()
);

-- Authors table (many-to-many with documents)
CREATE TABLE authors (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(500) NOT NULL,
    email NVARCHAR(255),
    organization NVARCHAR(500),
    created_at DATETIME2 DEFAULT GETDATE(),
    
    UNIQUE(name, organization)
);

-- Document-Author relationship table
CREATE TABLE document_authors (
    document_id NVARCHAR(255),
    author_id INT,
    author_order INT DEFAULT 1,
    PRIMARY KEY (document_id, author_id),
    FOREIGN KEY (document_id) REFERENCES documents(id) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES authors(id) ON DELETE CASCADE
);

-- Topics/Tags for categorization
CREATE TABLE topics (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) UNIQUE NOT NULL,
    description NVARCHAR(500),
    parent_id INT,
    created_at DATETIME2 DEFAULT GETDATE(),
    FOREIGN KEY (parent_id) REFERENCES topics(id)
);

-- Document-Topic relationship table
CREATE TABLE document_topics (
    document_id NVARCHAR(255),
    topic_id INT,
    relevance_score DECIMAL(3,2) DEFAULT 1.0,
    PRIMARY KEY (document_id, topic_id),
    FOREIGN KEY (document_id) REFERENCES documents(id) ON DELETE CASCADE,
    FOREIGN KEY (topic_id) REFERENCES topics(id) ON DELETE CASCADE
);

-- Search and analytics tables
CREATE TABLE search_queries (
    id INT IDENTITY(1,1) PRIMARY KEY,
    query_text NVARCHAR(1000) NOT NULL,
    result_count INT DEFAULT 0,
    execution_time_ms INT,
    user_id NVARCHAR(255),
    session_id NVARCHAR(255),
    created_at DATETIME2 DEFAULT GETDATE()
);

-- Document view/download tracking
CREATE TABLE document_access (
    id INT IDENTITY(1,1) PRIMARY KEY,
    document_id NVARCHAR(255) NOT NULL,
    access_type NVARCHAR(20) CHECK (access_type IN ('view', 'download', 'search_result')),
    user_id NVARCHAR(255),
    session_id NVARCHAR(255),
    ip_address NVARCHAR(45),
    user_agent NVARCHAR(1000),
    created_at DATETIME2 DEFAULT GETDATE(),
    FOREIGN KEY (document_id) REFERENCES documents(id)
);

-- Indexes for performance
CREATE INDEX IX_documents_docdt ON documents(docdt);
CREATE INDEX IX_documents_lang ON documents(lang);
CREATE INDEX IX_documents_country ON documents(country);
CREATE INDEX IX_documents_docty ON documents(docty);
CREATE INDEX IX_documents_majdocty ON documents(majdocty);
CREATE INDEX IX_documents_created_at ON documents(created_at);
CREATE INDEX IX_documents_updated_at ON documents(updated_at);
CREATE INDEX IX_documents_document_status ON documents(document_status);

-- Search performance indexes
CREATE INDEX IX_search_queries_created_at ON search_queries(created_at);
CREATE INDEX IX_document_access_document_id ON document_access(document_id);
CREATE INDEX IX_document_access_created_at ON document_access(created_at);
CREATE INDEX IX_document_access_access_type ON document_access(access_type);

-- Composite indexes for common query patterns
CREATE INDEX IX_documents_lang_country ON documents(lang, country);
CREATE INDEX IX_documents_docdt_lang ON documents(docdt, lang);
CREATE INDEX IX_documents_majdocty_docdt ON documents(majdocty, docdt);
CREATE INDEX IX_documents_status_created ON documents(document_status, created_at);

-- Full-text search setup (enable after data is loaded)
-- Full-text catalog and index will be created separately
-- as they require the database to have data first

-- Trigger to update updated_at timestamp
CREATE TRIGGER TR_documents_update_timestamp
ON documents
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE documents 
    SET updated_at = GETDATE()
    FROM documents d
    INNER JOIN inserted i ON d.id = i.id;
END;

-- Views for common queries
CREATE VIEW v_documents_summary AS
SELECT 
    d.id,
    d.title,
    d.docdt,
    d.lang,
    d.country,
    d.docty,
    d.majdocty,
    d.url,
    d.document_status,
    d.created_at,
    COUNT(da.id) as access_count
FROM documents d
LEFT JOIN document_access da ON d.id = da.document_id
GROUP BY d.id, d.title, d.docdt, d.lang, d.country, d.docty, d.majdocty, d.url, d.document_status, d.created_at;

-- View for recent documents
CREATE VIEW v_recent_documents AS
SELECT TOP 100
    id,
    title,
    docdt,
    lang,
    country,
    majdocty,
    document_status,
    created_at
FROM documents
ORDER BY created_at DESC;

-- View for popular documents (by access count)
CREATE VIEW v_popular_documents AS
SELECT TOP 100
    d.id,
    d.title,
    d.docdt,
    d.lang,
    d.country,
    d.document_status,
    COUNT(da.id) as access_count
FROM documents d
INNER JOIN document_access da ON d.id = da.document_id
GROUP BY d.id, d.title, d.docdt, d.lang, d.country, d.document_status
ORDER BY COUNT(da.id) DESC;

-- Sample data for testing (World Bank regions and languages)
INSERT INTO countries (name, code, region) VALUES
('Afghanistan', 'AFG', 'South Asia'),
('Brazil', 'BRA', 'Latin America & Caribbean'),
('China', 'CHN', 'East Asia & Pacific'),
('Germany', 'DEU', 'Europe & Central Asia'),
('India', 'IND', 'South Asia'),
('Kenya', 'KEN', 'Sub-Saharan Africa'),
('Mexico', 'MEX', 'Latin America & Caribbean'),
('Nigeria', 'NGA', 'Sub-Saharan Africa'),
('United States', 'USA', 'North America'),
('Global', 'GLB', 'Global');

INSERT INTO languages (name, iso_code) VALUES
('English', 'en'),
('Spanish', 'es'),
('French', 'fr'),
('Portuguese', 'pt'),
('Chinese', 'zh'),
('Arabic', 'ar'),
('Russian', 'ru');

INSERT INTO document_types (type_name, major_type, description) VALUES
('Project Document', 'Project Documents', 'Documents related to World Bank projects'),
('Country Study', 'Economic & Sector Work', 'Country-specific economic analysis'),
('Policy Research Report', 'Policy Research', 'Research on development policy'),
('Working Paper', 'Policy Research', 'Working papers and research notes'),
('Annual Report', 'Corporate Publications', 'Annual institutional reports'),
('Strategy Document', 'Strategy & Policy', 'Institutional strategy documents');

INSERT INTO topics (name, description) VALUES
('Energy', 'Energy sector development and policy'),
('Education', 'Education systems and human capital'),
('Health', 'Health systems and public health'),
('Infrastructure', 'Physical infrastructure development'),
('Environment', 'Environmental sustainability and climate'),
('Governance', 'Public sector governance and institutions'),
('Private Sector', 'Private sector development'),
('Social Protection', 'Social safety nets and protection systems');

PRINT 'Database schema created successfully!';
PRINT 'Next steps:';
PRINT '1. Run the scraper to populate with real data';
PRINT '2. Enable full-text search after data is loaded';
PRINT '3. Create additional indexes based on query patterns';