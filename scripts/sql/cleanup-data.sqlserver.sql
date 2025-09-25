-- SQL Server Database Cleanup Script
-- Deletes all data from tables while preserving table structure
-- Run this script to clear all data from the document query service database

-- Warning: This will delete ALL data from the database!
-- Make sure you have backups if needed.

BEGIN TRANSACTION;

-- Delete data from tables in dependency order (children first, parents last)
-- This prevents foreign key constraint violations
-- Using DELETE instead of TRUNCATE to handle foreign key relationships better

-- Relationship tables first (have foreign keys to other tables)
DELETE FROM document_authors;
DELETE FROM document_topics;
DELETE FROM document_access;

-- Main data tables
DELETE FROM search_queries;
DELETE FROM documents;

-- Lookup tables (referenced by foreign keys)
DELETE FROM authors;
DELETE FROM topics;
DELETE FROM document_types;
DELETE FROM languages;
DELETE FROM countries;

-- Reset identity columns to start from 1
DBCC CHECKIDENT ('countries', RESEED, 0);
DBCC CHECKIDENT ('languages', RESEED, 0);
DBCC CHECKIDENT ('document_types', RESEED, 0);
DBCC CHECKIDENT ('authors', RESEED, 0);
DBCC CHECKIDENT ('topics', RESEED, 0);
DBCC CHECKIDENT ('search_queries', RESEED, 0);
DBCC CHECKIDENT ('document_access', RESEED, 0);

-- Re-insert the basic lookup data that's needed for the application to function
-- (Same as in the original schema)

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

COMMIT TRANSACTION;

-- Show final table counts
SELECT 'countries' as table_name, COUNT(*) as row_count FROM countries
UNION ALL
SELECT 'languages', COUNT(*) FROM languages
UNION ALL
SELECT 'document_types', COUNT(*) FROM document_types
UNION ALL
SELECT 'topics', COUNT(*) FROM topics
UNION ALL
SELECT 'authors', COUNT(*) FROM authors
UNION ALL
SELECT 'documents', COUNT(*) FROM documents
UNION ALL
SELECT 'document_authors', COUNT(*) FROM document_authors
UNION ALL
SELECT 'document_topics', COUNT(*) FROM document_topics
UNION ALL
SELECT 'search_queries', COUNT(*) FROM search_queries
UNION ALL
SELECT 'document_access', COUNT(*) FROM document_access
ORDER BY table_name;

PRINT 'Database cleanup completed successfully!';
