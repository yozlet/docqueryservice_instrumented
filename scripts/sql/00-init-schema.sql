-- Document Query Service Database Schema - PostgreSQL Version
-- Based on World Bank Documents & Reports API specification

-- Enable required extensions
CREATE EXTENSION IF NOT EXISTS pg_trgm;

-- Main documents table
CREATE TABLE documents (
    id VARCHAR(255) PRIMARY KEY,
    title TEXT NOT NULL,
    docdt DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Content and classification
    abstract TEXT,
    content_text TEXT, -- For full-text search
    
    -- Document type information
    docty VARCHAR(100),
    majdocty VARCHAR(100),
    
    -- Publishing information
    volnb INTEGER,
    totvolnb INTEGER,
    url VARCHAR(2048),
    document_location VARCHAR(1024), -- Path to downloaded PDF file on disk
    document_status VARCHAR(50) DEFAULT 'PENDING', -- Document download status: PENDING, DOWNLOADED, NOT_FOUND, FAILED, URL_ONLY
    
    -- Language and country
    lang VARCHAR(50),
    country VARCHAR(100),
    
    -- Additional metadata
    author VARCHAR(500),
    publisher VARCHAR(500),
    isbn VARCHAR(50),
    issn VARCHAR(50)
);

-- Countries lookup table for normalization
CREATE TABLE countries (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    code VARCHAR(3) UNIQUE,
    region VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Languages lookup table
CREATE TABLE languages (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    iso_code VARCHAR(3),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Document types lookup table
CREATE TABLE document_types (
    id SERIAL PRIMARY KEY,
    type_name VARCHAR(100) UNIQUE NOT NULL,
    major_type VARCHAR(100),
    description VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Authors table (many-to-many with documents)
CREATE TABLE authors (
    id SERIAL PRIMARY KEY,
    name VARCHAR(500) NOT NULL,
    email VARCHAR(255),
    organization VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(name, organization)
);

-- Document-Author relationship table
CREATE TABLE document_authors (
    document_id VARCHAR(255),
    author_id INTEGER,
    author_order INTEGER DEFAULT 1,
    PRIMARY KEY (document_id, author_id),
    FOREIGN KEY (document_id) REFERENCES documents(id) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES authors(id) ON DELETE CASCADE
);

-- Topics/Tags for categorization
CREATE TABLE topics (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    description VARCHAR(500),
    parent_id INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (parent_id) REFERENCES topics(id)
);

-- Document-Topic relationship table
CREATE TABLE document_topics (
    document_id VARCHAR(255),
    topic_id INTEGER,
    relevance_score DECIMAL(3,2) DEFAULT 1.0,
    PRIMARY KEY (document_id, topic_id),
    FOREIGN KEY (document_id) REFERENCES documents(id) ON DELETE CASCADE,
    FOREIGN KEY (topic_id) REFERENCES topics(id) ON DELETE CASCADE
);

-- Search and analytics tables
CREATE TABLE search_queries (
    id SERIAL PRIMARY KEY,
    query_text VARCHAR(1000) NOT NULL,
    result_count INTEGER DEFAULT 0,
    execution_time_ms INTEGER,
    user_id VARCHAR(255),
    session_id VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Document view/download tracking
CREATE TABLE document_access (
    id SERIAL PRIMARY KEY,
    document_id VARCHAR(255) NOT NULL,
    access_type VARCHAR(20) CHECK (access_type IN ('view', 'download', 'search_result')),
    user_id VARCHAR(255),
    session_id VARCHAR(255),
    ip_address VARCHAR(45),
    user_agent VARCHAR(1000),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (document_id) REFERENCES documents(id)
);

-- Indexes for performance
CREATE INDEX ix_documents_docdt ON documents(docdt);
CREATE INDEX ix_documents_lang ON documents(lang);
CREATE INDEX ix_documents_country ON documents(country);
CREATE INDEX ix_documents_docty ON documents(docty);
CREATE INDEX ix_documents_majdocty ON documents(majdocty);
CREATE INDEX ix_documents_created_at ON documents(created_at);
CREATE INDEX ix_documents_updated_at ON documents(updated_at);
CREATE INDEX ix_documents_document_status ON documents(document_status);

-- Search performance indexes
CREATE INDEX ix_search_queries_created_at ON search_queries(created_at);
CREATE INDEX ix_document_access_document_id ON document_access(document_id);
CREATE INDEX ix_document_access_created_at ON document_access(created_at);
CREATE INDEX ix_document_access_access_type ON document_access(access_type);

-- Composite indexes for common query patterns
CREATE INDEX ix_documents_lang_country ON documents(lang, country);
CREATE INDEX ix_documents_docdt_lang ON documents(docdt, lang);
CREATE INDEX ix_documents_majdocty_docdt ON documents(majdocty, docdt);
CREATE INDEX ix_documents_status_created ON documents(document_status, created_at);

-- Full-text search indexes using trigram similarity
CREATE INDEX ix_documents_title_trgm ON documents USING gin(title gin_trgm_ops);
CREATE INDEX ix_documents_abstract_trgm ON documents USING gin(abstract gin_trgm_ops);
CREATE INDEX ix_documents_content_trgm ON documents USING gin(content_text gin_trgm_ops);

-- Trigger to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_documents_updated_at
    BEFORE UPDATE ON documents
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

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
SELECT
    id,
    title,
    docdt,
    lang,
    country,
    majdocty,
    document_status,
    created_at
FROM documents
ORDER BY created_at DESC
LIMIT 100;

-- View for popular documents (by access count)
CREATE VIEW v_popular_documents AS
SELECT
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
ORDER BY COUNT(da.id) DESC
LIMIT 100;
