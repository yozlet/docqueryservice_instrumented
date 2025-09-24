-- Document Query Service Database Schema - PostgreSQL Version
-- Based on World Bank Documents & Reports API specification
-- Optimized for PostgreSQL with full-text search capabilities

-- Create database (run this separately if needed)
-- CREATE DATABASE docqueryservice;
-- \c docqueryservice;

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
    
    -- Full-text search vector
    search_vector TSVECTOR
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
    description TEXT,
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
    description TEXT,
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
CREATE INDEX idx_documents_docdt ON documents(docdt);
CREATE INDEX idx_documents_lang ON documents(lang);
CREATE INDEX idx_documents_country ON documents(country);
CREATE INDEX idx_documents_docty ON documents(docty);
CREATE INDEX idx_documents_majdocty ON documents(majdocty);
CREATE INDEX idx_documents_created_at ON documents(created_at);
CREATE INDEX idx_documents_updated_at ON documents(updated_at);
CREATE INDEX idx_documents_document_status ON documents(document_status);

-- Full-text search indexes (PostgreSQL specific)
CREATE INDEX idx_documents_title_fts ON documents USING GIN(to_tsvector('english', title));
CREATE INDEX idx_documents_abstract_fts ON documents USING GIN(to_tsvector('english', COALESCE(abstract, '')));
CREATE INDEX idx_documents_content_fts ON documents USING GIN(to_tsvector('english', COALESCE(content_text, '')));
CREATE INDEX idx_documents_search_vector ON documents USING GIN(search_vector);

-- Search performance indexes
CREATE INDEX idx_search_queries_created_at ON search_queries(created_at);
CREATE INDEX idx_document_access_document_id ON document_access(document_id);
CREATE INDEX idx_document_access_created_at ON document_access(created_at);
CREATE INDEX idx_document_access_access_type ON document_access(access_type);

-- Composite indexes for common query patterns
CREATE INDEX idx_documents_lang_country ON documents(lang, country);
CREATE INDEX idx_documents_docdt_lang ON documents(docdt, lang);
CREATE INDEX idx_documents_majdocty_docdt ON documents(majdocty, docdt);
CREATE INDEX idx_documents_status_created ON documents(document_status, created_at);

-- Function to update search vector and timestamp
CREATE OR REPLACE FUNCTION update_document_search_and_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    -- Update the updated_at timestamp
    NEW.updated_at = CURRENT_TIMESTAMP;
    
    -- Update search vector
    NEW.search_vector := 
        setweight(to_tsvector('english', COALESCE(NEW.title, '')), 'A') ||
        setweight(to_tsvector('english', COALESCE(NEW.abstract, '')), 'B') ||
        setweight(to_tsvector('english', COALESCE(NEW.content_text, '')), 'C');
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger to automatically update search vector and timestamp
CREATE TRIGGER trig_update_document_search_and_timestamp
    BEFORE INSERT OR UPDATE ON documents
    FOR EACH ROW EXECUTE FUNCTION update_document_search_and_timestamp();

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

-- View for document facets (for search filtering)
CREATE VIEW v_document_facets AS
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
SELECT 'status' as facet_type, document_status as facet_value, COUNT(*) as count
FROM documents 
WHERE document_status IS NOT NULL
GROUP BY document_status;

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

-- PostgreSQL completion message
DO $$
BEGIN
    RAISE NOTICE 'PostgreSQL database schema created successfully!';
    RAISE NOTICE 'Next steps:';
    RAISE NOTICE '1. Run the scraper to populate with real data';
    RAISE NOTICE '2. Full-text search is automatically enabled with triggers';
    RAISE NOTICE '3. Monitor query performance and add indexes as needed';
    RAISE NOTICE '4. Consider partitioning large tables by date if needed';
END $$;