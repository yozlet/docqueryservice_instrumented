-- Document Query Service Database Schema
-- Based on World Bank Documents & Reports API specification
-- Supports both PostgreSQL and SQL Server with minor adjustments

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
    issn VARCHAR(50),
    
    -- Search optimization
    search_vector TSVECTOR -- PostgreSQL full-text search (remove for SQL Server)
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
    code VARCHAR(5) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Document types lookup table
CREATE TABLE document_types (
    id SERIAL PRIMARY KEY,
    type_name VARCHAR(100) UNIQUE NOT NULL,
    major_type VARCHAR(100),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Document-Country many-to-many relationship
CREATE TABLE document_countries (
    document_id VARCHAR(255) REFERENCES documents(id) ON DELETE CASCADE,
    country_id INTEGER REFERENCES countries(id) ON DELETE CASCADE,
    PRIMARY KEY (document_id, country_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Document tags/keywords for enhanced searching
CREATE TABLE document_tags (
    id SERIAL PRIMARY KEY,
    document_id VARCHAR(255) REFERENCES documents(id) ON DELETE CASCADE,
    tag VARCHAR(100) NOT NULL,
    tag_type VARCHAR(50), -- 'keyword', 'subject', 'theme', etc.
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Document collections/series
CREATE TABLE document_collections (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Document-Collection relationship
CREATE TABLE document_collection_memberships (
    document_id VARCHAR(255) REFERENCES documents(id) ON DELETE CASCADE,
    collection_id INTEGER REFERENCES document_collections(id) ON DELETE CASCADE,
    sequence_number INTEGER,
    PRIMARY KEY (document_id, collection_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for performance optimization

-- Primary search indexes
CREATE INDEX idx_documents_title ON documents USING GIN(to_tsvector('english', title));
CREATE INDEX idx_documents_content ON documents USING GIN(to_tsvector('english', content_text));
CREATE INDEX idx_documents_docdt ON documents(docdt);
CREATE INDEX idx_documents_lang ON documents(lang);
CREATE INDEX idx_documents_country ON documents(country);
CREATE INDEX idx_documents_docty ON documents(docty);
CREATE INDEX idx_documents_majdocty ON documents(majdocty);
CREATE INDEX idx_documents_document_status ON documents(document_status);

-- Composite indexes for common query patterns
CREATE INDEX idx_documents_country_date ON documents(country, docdt);
CREATE INDEX idx_documents_lang_date ON documents(lang, docdt);
CREATE INDEX idx_documents_type_date ON documents(docty, docdt);

-- Full-text search index (PostgreSQL specific)
CREATE INDEX idx_documents_search_vector ON documents USING GIN(search_vector);

-- Foreign key indexes
CREATE INDEX idx_document_countries_country ON document_countries(country_id);
CREATE INDEX idx_document_countries_document ON document_countries(document_id);
CREATE INDEX idx_document_tags_document ON document_tags(document_id);
CREATE INDEX idx_document_tags_tag ON document_tags(tag);

-- Function to update search vector (PostgreSQL specific)
CREATE OR REPLACE FUNCTION update_document_search_vector()
RETURNS TRIGGER AS $$
BEGIN
    NEW.search_vector := 
        setweight(to_tsvector('english', COALESCE(NEW.title, '')), 'A') ||
        setweight(to_tsvector('english', COALESCE(NEW.abstract, '')), 'B') ||
        setweight(to_tsvector('english', COALESCE(NEW.content_text, '')), 'C');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger to automatically update search vector
CREATE TRIGGER trig_update_document_search_vector
    BEFORE INSERT OR UPDATE ON documents
    FOR EACH ROW EXECUTE FUNCTION update_document_search_vector();

-- Views for common queries

-- Document search view with all related data
CREATE VIEW document_search_view AS
SELECT 
    d.id,
    d.title,
    d.docdt,
    d.abstract,
    d.docty,
    d.majdocty,
    d.volnb,
    d.totvolnb,
    d.url,
    d.document_location,
    d.document_status,
    d.lang,
    d.country,
    d.author,
    d.publisher,
    STRING_AGG(DISTINCT c.name, ', ') AS countries_list,
    STRING_AGG(DISTINCT dt.tag, ', ') AS tags_list
FROM documents d
LEFT JOIN document_countries dc ON d.id = dc.document_id
LEFT JOIN countries c ON dc.country_id = c.id
LEFT JOIN document_tags dt ON d.id = dt.document_id
GROUP BY d.id, d.title, d.docdt, d.abstract, d.docty, d.majdocty, 
         d.volnb, d.totvolnb, d.url, d.document_location, d.document_status, d.lang, d.country, d.author, d.publisher;

-- Facet counts view for API responses
CREATE VIEW document_facets AS
SELECT 'country' as facet_type, country as facet_value, COUNT(*) as count
FROM documents 
WHERE country IS NOT NULL
GROUP BY country
UNION ALL
SELECT 'language' as facet_type, lang as facet_value, COUNT(*) as count
FROM documents 
WHERE lang IS NOT NULL
GROUP BY lang
UNION ALL
SELECT 'document_type' as facet_type, docty as facet_value, COUNT(*) as count
FROM documents 
WHERE docty IS NOT NULL
GROUP BY docty
UNION ALL
SELECT 'major_document_type' as facet_type, majdocty as facet_value, COUNT(*) as count
FROM documents 
WHERE majdocty IS NOT NULL
GROUP BY majdocty
UNION ALL
SELECT 'document_status' as facet_type, document_status as facet_value, COUNT(*) as count
FROM documents 
WHERE document_status IS NOT NULL
GROUP BY document_status;

-- SQL Server compatibility notes:
-- 1. Replace SERIAL with IDENTITY(1,1)
-- 2. Replace TSVECTOR and GIN indexes with SQL Server Full-Text Search
-- 3. Replace STRING_AGG with FOR XML PATH or STRING_AGG (SQL Server 2017+)
-- 4. Remove PostgreSQL-specific functions and triggers
-- 5. Adjust date/time functions for SQL Server equivalents