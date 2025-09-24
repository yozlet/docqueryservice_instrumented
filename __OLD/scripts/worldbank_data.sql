-- World Bank Documents Data
-- Generated on 2025-09-22 15:39:09
-- Total documents: 5

-- Insert countries
INSERT INTO countries (name, code, region) VALUES
('Brazil', 'BRA', 'Unknown'),
('Poland', 'POL', 'Unknown'),
('World', 'WOR', 'Unknown')
ON CONFLICT (name) DO NOTHING;

-- Insert languages
INSERT INTO languages (name, code) VALUES
('English', 'en')
ON CONFLICT (name) DO NOTHING;

-- Insert document types
INSERT INTO document_types (type_name, major_type) VALUES
('Price Prospects for Major Primary Commodities', 'Unknown'),
('Pre-2003 Economic or Sector Report', 'Economic & Sector Work'),
('Publication', 'Publications; Publications & Research')
ON CONFLICT (type_name) DO NOTHING;

-- Insert documents
INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '12752468',
    'Price prospects for major primary commodities : 1984 (Vol. 5 of 5) : Energy',
    '1984-09-01',
    '',
    'Price Prospects for Major Primary Commodities',
    'Publications & Research',
    5,
    5,
    'http://documents.worldbank.org/curated/en/299201468915577406',
    'English',
    'World',
    '',
    '',
    'Price prospects for major primary commodities : 1984 (Vol. 5 of 5) : Energy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '1749621',
    'Brazil - Economic growth : problems and prospects (Vol. 4 of 6) : Energy',
    '1967-10-23',
    '',
    'Pre-2003 Economic or Sector Report',
    'Economic & Sector Work',
    4,
    6,
    'http://documents.worldbank.org/curated/en/954151467997857687/pdf/multi0page.pdf',
    'English',
    'Brazil',
    '',
    '',
    'Brazil - Economic growth : problems and prospects (Vol. 4 of 6) : Energy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '12753074',
    'Price prospects for major primary commodities - 1982 (Vol. 5 of 5) : Energy',
    '1982-07-01',
    '',
    'Price Prospects for Major Primary Commodities',
    '',
    5,
    5,
    'http://documents.worldbank.org/curated/en/791471468914729725',
    'English',
    'World',
    '',
    '',
    'Price prospects for major primary commodities - 1982 (Vol. 5 of 5) : Energy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '1556019',
    'Poland - Reform, adjustment and growth (Vol. 5 of 7) : Energy',
    '1987-11-30',
    '',
    'Publication',
    'Publications; Publications & Research',
    5,
    7,
    'http://documents.worldbank.org/curated/en/530151468780953068',
    'English',
    'Poland',
    '',
    '',
    'Poland - Reform, adjustment and growth (Vol. 5 of 7) : Energy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '8525921',
    'Price prospects for major primary commodities - 1986 (Vol. 5 of 5) : Energy',
    '1986-10-31',
    '',
    'Price Prospects for Major Primary Commodities',
    '',
    5,
    5,
    'http://documents.worldbank.org/curated/en/922981497543377364',
    'English',
    'World',
    '',
    '',
    'Price prospects for major primary commodities - 1986 (Vol. 5 of 5) : Energy'
) ON CONFLICT (id) DO NOTHING;

