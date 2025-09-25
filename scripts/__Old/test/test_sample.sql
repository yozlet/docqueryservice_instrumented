-- World Bank Documents Data
-- Generated on 2025-09-24 18:20:22
-- Total documents: 5

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
('Loan Agreement', 'Project Documents'),
('Disbursement Letter', 'Project Documents')
ON CONFLICT (type_name) DO NOTHING;

-- Insert documents
INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
) VALUES (
    '34442285',
    'Official Documents- Amendment No. 2 to the GPE Grant Agreement for Grant TF0B0846.pdf',
    '2026-12-31',
    '',
    'Agreement',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099010125191591417/pdf/P165557-f25f8ee3-ba39-43fe-a0eb-cd711d88eb49.pdf',
    NULL,
    'PENDING',
    'English',
    'Ghana',
    '',
    '',
    'Official Documents- Amendment No. 2 to the GPE Grant Agreement for Grant TF0B0846.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
) VALUES (
    '34442292',
    'Official Documents- Loan Agreement for Loan 9619-BR.pdf',
    '2026-12-31',
    '',
    'Loan Agreement',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099010125194536043/pdf/P179365-20b99485-9b6e-49ed-93ee-9976c1043be5.pdf',
    NULL,
    'PENDING',
    'English',
    'Brazil',
    '',
    '',
    'Official Documents- Loan Agreement for Loan 9619-BR.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
) VALUES (
    '34442277',
    'Official Documents- Amendment No. 1 to the GRPBA Grant Agreement for Grant TF0B3026.pdf',
    '2026-12-31',
    '',
    'Agreement',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099010125183538911/pdf/P165557-2c1083ca-3f3c-4534-ac20-d1dc178b09ab.pdf',
    NULL,
    'PENDING',
    'English',
    'Ghana',
    '',
    '',
    'Official Documents- Amendment No. 1 to the GRPBA Grant Agreement for Grant TF0B3026.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
) VALUES (
    '34442276',
    'Official Documents- Disbursement and Financial Information Letter for Additional Financing for TF0C6881 and TF0C6868.pdf',
    '2026-12-30',
    '',
    'Disbursement Letter',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099010125183017477/pdf/P165557-501197d3-f4a0-49af-aaeb-23f786589fb4.pdf',
    NULL,
    'PENDING',
    'English',
    'Ghana',
    '',
    '',
    'Official Documents- Disbursement and Financial Information Letter for Additional Financing for TF0C6881 and TF0C6868.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
) VALUES (
    '34442284',
    'Official Documents- Amendment No. 3 to the Financing Agreement for Credit 6482-GH.pdf',
    '2026-01-01',
    '',
    'Agreement',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099010125191532859/pdf/P165557-c57a4522-84fd-4b36-aaac-4051420ea046.pdf',
    NULL,
    'PENDING',
    'English',
    'Ghana',
    '',
    '',
    'Official Documents- Amendment No. 3 to the Financing Agreement for Credit 6482-GH.pdf'
) ON CONFLICT (id) DO NOTHING;

