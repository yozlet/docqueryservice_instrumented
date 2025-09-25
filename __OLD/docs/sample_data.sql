-- Sample Data for Document Query Service
-- Insert test data that matches World Bank API patterns

-- Insert sample countries
INSERT INTO countries (name, code, region) VALUES 
('Algeria', 'DZA', 'Middle East & North Africa'),
('Brazil', 'BRA', 'Latin America & Caribbean'),
('China', 'CHN', 'East Asia & Pacific'),
('Egypt', 'EGY', 'Middle East & North Africa'),
('India', 'IND', 'South Asia'),
('Kenya', 'KEN', 'Sub-Saharan Africa'),
('Mexico', 'MEX', 'Latin America & Caribbean'),
('Nigeria', 'NGA', 'Sub-Saharan Africa'),
('Thailand', 'THA', 'East Asia & Pacific'),
('Ukraine', 'UKR', 'Europe & Central Asia');

-- Insert sample languages
INSERT INTO languages (name, code) VALUES 
('English', 'en'),
('Spanish', 'es'),
('French', 'fr'),
('Portuguese', 'pt'),
('Arabic', 'ar'),
('Chinese', 'zh'),
('Russian', 'ru');

-- Insert sample document types
INSERT INTO document_types (type_name, major_type, description) VALUES 
('Project Appraisal Document', 'Project Document', 'Document appraising project feasibility'),
('Implementation Status Report', 'Project Document', 'Status update on project implementation'),
('Country Partnership Framework', 'Strategy Document', 'Strategic framework for country engagement'),
('Economic Sector Work', 'Analytical Work', 'Economic analysis of specific sectors'),
('Technical Assistance', 'Advisory Services', 'Technical advisory and capacity building'),
('Policy Research Working Paper', 'Research', 'Research papers on policy topics'),
('Country Economic Memorandum', 'Economic Analysis', 'Comprehensive country economic analysis'),
('Environmental Assessment', 'Safeguards', 'Environmental impact assessment'),
('Social Assessment', 'Safeguards', 'Social impact and stakeholder analysis'),
('Procurement Plan', 'Procurement', 'Detailed procurement planning document');

-- Insert sample document collections
INSERT INTO document_collections (name, description) VALUES 
('Renewable Energy Initiative', 'Documents related to renewable energy projects worldwide'),
('Climate Change Adaptation', 'Studies and projects focused on climate adaptation measures'),
('Digital Development', 'Digital transformation and technology adoption projects'),
('Health System Strengthening', 'Healthcare infrastructure and system improvement projects'),
('Urban Development', 'City planning and urban infrastructure development'),
('Agricultural Productivity', 'Projects and studies on improving agricultural yields'),
('Financial Inclusion', 'Initiatives to expand access to financial services'),
('Education for All', 'Educational system development and access improvement'),
('Water Resource Management', 'Sustainable water management and infrastructure projects'),
('Trade and Competitiveness', 'Studies on trade facilitation and economic competitiveness');

-- Insert sample documents
INSERT INTO documents (id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, url, lang, country, author, publisher) VALUES 
(
    'WB001234567890',
    'Renewable Energy Development in Algeria: Wind Power Assessment',
    '2023-03-15',
    'This document assesses the potential for wind energy development in Algeria, examining resource availability, economic feasibility, and policy framework requirements.',
    'Project Appraisal Document',
    'Project Document',
    1,
    1,
    'https://documents.worldbank.org/curated/en/algeria-wind-energy-2023',
    'English',
    'Algeria',
    'World Bank Energy Team',
    'World Bank'
),
(
    'WB001234567891',
    'Digital Infrastructure for Rural Brazil: Connectivity Solutions',
    '2023-02-28',
    'Analysis of digital infrastructure gaps in rural Brazil and proposed solutions for improving internet connectivity and digital services access.',
    'Economic Sector Work',
    'Analytical Work',
    1,
    2,
    'https://documents.worldbank.org/curated/en/brazil-digital-rural-2023',
    'English',
    'Brazil',
    'Digital Development Team',
    'World Bank'
),
(
    'WB001234567892',
    'Climate Resilience in Agricultural Systems: China Case Study',
    '2023-01-20',
    'Comprehensive study of climate adaptation strategies in Chinese agricultural systems, focusing on drought-resistant crops and water management.',
    'Policy Research Working Paper',
    'Research',
    1,
    1,
    'https://documents.worldbank.org/curated/en/china-climate-agriculture-2023',
    'English',
    'China',
    'Climate Change Team',
    'World Bank'
),
(
    'WB001234567893',
    'Urban Transport Modernization: Egypt Metro Expansion Project',
    '2023-04-10',
    'Project document for the expansion of Cairo metro system, including technical specifications, environmental assessment, and implementation timeline.',
    'Project Appraisal Document',
    'Project Document',
    1,
    3,
    'https://documents.worldbank.org/curated/en/egypt-metro-expansion-2023',
    'English',
    'Egypt',
    'Transport and ICT Team',
    'World Bank'
),
(
    'WB001234567894',
    'Healthcare System Strengthening in India: Digital Health Initiative',
    '2023-05-05',
    'Implementation strategy for digital health systems in India, covering telemedicine, electronic health records, and healthcare worker training.',
    'Technical Assistance',
    'Advisory Services',
    2,
    2,
    'https://documents.worldbank.org/curated/en/india-digital-health-2023',
    'English',
    'India',
    'Health, Nutrition and Population Team',
    'World Bank'
),
(
    'WB001234567895',
    'Water Resource Management in Kenya: Drought Mitigation Strategies',
    '2022-12-18',
    'Comprehensive analysis of drought mitigation strategies in Kenya, including water storage, irrigation efficiency, and community-based management.',
    'Country Economic Memorandum',
    'Economic Analysis',
    1,
    1,
    'https://documents.worldbank.org/curated/en/kenya-water-drought-2022',
    'English',
    'Kenya',
    'Water Team',
    'World Bank'
),
(
    'WB001234567896',
    'Financial Inclusion Through Mobile Banking: Mexico Experience',
    '2023-03-30',
    'Study of mobile banking adoption in Mexico and its impact on financial inclusion, particularly among rural and low-income populations.',
    'Implementation Status Report',
    'Project Document',
    3,
    3,
    'https://documents.worldbank.org/curated/en/mexico-mobile-banking-2023',
    'English',
    'Mexico',
    'Finance, Competitiveness and Innovation Team',
    'World Bank'
),
(
    'WB001234567897',
    'Education Technology Integration in Nigeria: Lessons Learned',
    '2023-04-22',
    'Assessment of education technology integration programs in Nigeria, analyzing effectiveness, challenges, and recommendations for scale-up.',
    'Social Assessment',
    'Safeguards',
    1,
    1,
    'https://documents.worldbank.org/curated/en/nigeria-edtech-assessment-2023',
    'English',
    'Nigeria',
    'Education Team',
    'World Bank'
),
(
    'WB001234567898',
    'Sustainable Tourism Development in Thailand: Post-Pandemic Recovery',
    '2023-06-12',
    'Strategy for sustainable tourism recovery in Thailand following the COVID-19 pandemic, focusing on environmental sustainability and community benefits.',
    'Country Partnership Framework',
    'Strategy Document',
    1,
    1,
    'https://documents.worldbank.org/curated/en/thailand-tourism-recovery-2023',
    'English',
    'Thailand',
    'Macroeconomics, Trade and Investment Team',
    'World Bank'
),
(
    'WB001234567899',
    'Agricultural Productivity Enhancement in Ukraine: Technology Adoption',
    '2022-11-15',
    'Analysis of agricultural technology adoption in Ukraine, focusing on precision farming, crop monitoring, and productivity improvements.',
    'Environmental Assessment',
    'Safeguards',
    2,
    2,
    'https://documents.worldbank.org/curated/en/ukraine-agriculture-tech-2022',
    'English',
    'Ukraine',
    'Agriculture and Food Team',
    'World Bank'
);

-- Insert document-country relationships (some documents may relate to multiple countries)
INSERT INTO document_countries (document_id, country_id) 
SELECT d.id, c.id 
FROM documents d, countries c 
WHERE d.country = c.name;

-- Insert additional country relationships for multi-country documents
INSERT INTO document_countries (document_id, country_id) VALUES 
('WB001234567892', (SELECT id FROM countries WHERE name = 'India')), -- China climate study also relevant to India
('WB001234567895', (SELECT id FROM countries WHERE name = 'Nigeria')), -- Kenya water management relevant to Nigeria
('WB001234567898', (SELECT id FROM countries WHERE name = 'Mexico')); -- Thailand tourism relevant to Mexico

-- Insert sample tags
INSERT INTO document_tags (document_id, tag, tag_type) VALUES 
('WB001234567890', 'renewable energy', 'keyword'),
('WB001234567890', 'wind power', 'keyword'),
('WB001234567890', 'energy policy', 'subject'),
('WB001234567891', 'digital divide', 'keyword'),
('WB001234567891', 'rural development', 'subject'),
('WB001234567891', 'telecommunications', 'sector'),
('WB001234567892', 'climate change', 'theme'),
('WB001234567892', 'agriculture', 'sector'),
('WB001234567892', 'adaptation', 'keyword'),
('WB001234567893', 'urban transport', 'sector'),
('WB001234567893', 'public transport', 'keyword'),
('WB001234567893', 'infrastructure', 'theme'),
('WB001234567894', 'digital health', 'keyword'),
('WB001234567894', 'healthcare', 'sector'),
('WB001234567894', 'telemedicine', 'keyword'),
('WB001234567895', 'water management', 'sector'),
('WB001234567895', 'drought', 'keyword'),
('WB001234567895', 'resilience', 'theme'),
('WB001234567896', 'financial inclusion', 'theme'),
('WB001234567896', 'mobile banking', 'keyword'),
('WB001234567896', 'fintech', 'keyword'),
('WB001234567897', 'education technology', 'keyword'),
('WB001234567897', 'digital learning', 'keyword'),
('WB001234567897', 'education', 'sector'),
('WB001234567898', 'sustainable tourism', 'keyword'),
('WB001234567898', 'covid-19', 'keyword'),
('WB001234567898', 'recovery', 'theme'),
('WB001234567899', 'precision farming', 'keyword'),
('WB001234567899', 'agricultural technology', 'keyword'),
('WB001234567899', 'productivity', 'theme');

-- Insert document collection memberships
INSERT INTO document_collection_memberships (document_id, collection_id, sequence_number) VALUES 
('WB001234567890', (SELECT id FROM document_collections WHERE name = 'Renewable Energy Initiative'), 1),
('WB001234567891', (SELECT id FROM document_collections WHERE name = 'Digital Development'), 1),
('WB001234567892', (SELECT id FROM document_collections WHERE name = 'Climate Change Adaptation'), 1),
('WB001234567892', (SELECT id FROM document_collections WHERE name = 'Agricultural Productivity'), 1),
('WB001234567893', (SELECT id FROM document_collections WHERE name = 'Urban Development'), 1),
('WB001234567894', (SELECT id FROM document_collections WHERE name = 'Digital Development'), 2),
('WB001234567894', (SELECT id FROM document_collections WHERE name = 'Health System Strengthening'), 1),
('WB001234567895', (SELECT id FROM document_collections WHERE name = 'Water Resource Management'), 1),
('WB001234567896', (SELECT id FROM document_collections WHERE name = 'Financial Inclusion'), 1),
('WB001234567897', (SELECT id FROM document_collections WHERE name = 'Education for All'), 1),
('WB001234567897', (SELECT id FROM document_collections WHERE name = 'Digital Development'), 3),
('WB001234567898', (SELECT id FROM document_collections WHERE name = 'Trade and Competitiveness'), 1),
('WB001234567899', (SELECT id FROM document_collections WHERE name = 'Agricultural Productivity'), 2);

-- Add some content text for full-text search testing
UPDATE documents SET content_text = abstract || ' ' || title || ' Additional searchable content about ' || 
    CASE 
        WHEN id = 'WB001234567890' THEN 'wind turbines, renewable energy infrastructure, power generation, sustainability, clean energy transition'
        WHEN id = 'WB001234567891' THEN 'broadband access, fiber optic networks, digital literacy, internet connectivity, rural telecommunications'
        WHEN id = 'WB001234567892' THEN 'climate resilience, crop adaptation, water scarcity, agricultural innovation, food security'
        WHEN id = 'WB001234567893' THEN 'metro system, urban mobility, public transportation, traffic congestion, sustainable cities'
        WHEN id = 'WB001234567894' THEN 'electronic health records, remote healthcare, medical technology, healthcare digitization'
        WHEN id = 'WB001234567895' THEN 'water conservation, irrigation systems, drought preparedness, water security, hydrology'
        WHEN id = 'WB001234567896' THEN 'digital payments, banking technology, financial services, economic inclusion, microfinance'
        WHEN id = 'WB001234567897' THEN 'online learning, educational innovation, digital classrooms, student engagement, teacher training'
        WHEN id = 'WB001234567898' THEN 'eco-tourism, hospitality industry, tourism recovery, sustainable development, cultural heritage'
        WHEN id = 'WB001234567899' THEN 'smart farming, crop monitoring, agricultural efficiency, farm technology, yield optimization'
        ELSE 'general development topics'
    END;