-- World Bank Documents Data
-- Generated on 2025-09-22 13:07:15
-- Total documents: 2

-- Insert countries
INSERT INTO countries (name, code, region) VALUES
('Brazil', 'BRA', 'Unknown'),
('Ghana', 'GHA', 'Unknown')
ON CONFLICT (name) DO NOTHING;

-- Insert languages
INSERT INTO languages (name, code) VALUES
('English', 'en')
ON CONFLICT (name) DO NOTHING;

-- Insert document types
INSERT INTO document_types (type_name, major_type) VALUES
('Agreement', 'Project Documents'),
('Loan Agreement', 'Project Documents')
ON CONFLICT (type_name) DO NOTHING;

-- Insert documents
INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '34442285',
    '',
    '2026-12-31',
    '',
    'Agreement',
    'Project Documents',
    NULL,
    NULL,
    'http://documents.worldbank.org/curated/en/099010125191591417',
    'English',
    'Ghana',
    '',
    '',
    ''
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '34442292',
    '',
    '2026-12-31',
    '',
    'Loan Agreement',
    'Project Documents',
    NULL,
    NULL,
    'http://documents.worldbank.org/curated/en/099010125194536043',
    'English',
    'Brazil',
    '',
    '',
    ''
) ON CONFLICT (id) DO NOTHING;

