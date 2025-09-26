-- World Bank Documents Data
-- Generated on 2025-09-25 05:15:48
-- Total documents: 100

-- Insert countries
INSERT INTO countries (name, code, region) VALUES
('Angola', 'ANG', 'Unknown'),
('Bangladesh', 'BAN', 'Unknown'),
('Bhutan', 'BHU', 'Unknown'),
('Bolivia,Brazil,Ecuador,Colombia,Guyana,Suriname,Peru', 'BOL', 'Unknown'),
('Brazil', 'BRA', 'Unknown'),
('Burkina Faso', 'BUR', 'Unknown'),
('Cabo Verde', 'CAB', 'Unknown'),
('Cambodia', 'CAM', 'Unknown'),
('Chad', 'CHA', 'Unknown'),
('Eastern and Southern Africa', 'EAS', 'Unknown'),
('Ecuador', 'ECU', 'Unknown'),
('Eswatini', 'ESW', 'Unknown'),
('Ethiopia', 'ETH', 'Unknown'),
('Gambia, The', 'GAM', 'Unknown'),
('Georgia', 'GEO', 'Unknown'),
('Ghana', 'GHA', 'Unknown'),
('Guatemala', 'GUA', 'Unknown'),
('Haiti', 'HAI', 'Unknown'),
('Honduras', 'HON', 'Unknown'),
('India', 'IND', 'Unknown'),
('Indonesia', 'IND', 'Unknown'),
('Jamaica', 'JAM', 'Unknown'),
('Japan', 'JAP', 'Unknown'),
('Kosovo', 'KOS', 'Unknown'),
('Lao People''s Democratic Republic', 'LAO', 'Unknown'),
('Lebanon', 'LEB', 'Unknown'),
('Lesotho', 'LES', 'Unknown'),
('Liberia', 'LIB', 'Unknown'),
('Maldives', 'MAL', 'Unknown'),
('Mali', 'MAL', 'Unknown'),
('Mauritania', 'MAU', 'Unknown'),
('Micronesia, Federated States of', 'MIC', 'Unknown'),
('Moldova', 'MOL', 'Unknown'),
('Mozambique', 'MOZ', 'Unknown'),
('Nepal', 'NEP', 'Unknown'),
('Niger', 'NIG', 'Unknown'),
('Nigeria', 'NIG', 'Unknown'),
('OECS Countries', 'OEC', 'Unknown'),
('Pakistan', 'PAK', 'Unknown'),
('Papua New Guinea', 'PAP', 'Unknown'),
('Peru', 'PER', 'Unknown'),
('Philippines', 'PHI', 'Unknown'),
('Rwanda', 'RWA', 'Unknown'),
('Senegal', 'SEN', 'Unknown'),
('Serbia', 'SER', 'Unknown'),
('Solomon Islands', 'SOL', 'Unknown'),
('Sri Lanka', 'SRI', 'Unknown'),
('Sudan', 'SUD', 'Unknown'),
('Tajikistan', 'TAJ', 'Unknown'),
('Tanzania', 'TAN', 'Unknown'),
('Turkiye', 'TUR', 'Unknown'),
('Tuvalu', 'TUV', 'Unknown'),
('Uganda', 'UGA', 'Unknown'),
('Ukraine', 'UKR', 'Unknown'),
('Uzbekistan', 'UZB', 'Unknown'),
('Vanuatu', 'VAN', 'Unknown'),
('West Bank and Gaza', 'WES', 'Unknown'),
('Western and Central Africa', 'WES', 'Unknown'),
('World', 'WOR', 'Unknown')
ON CONFLICT (name) DO NOTHING;

-- Insert languages
INSERT INTO languages (name, code) VALUES
('Arabic', 'ar'),
('Dutch', 'du'),
('English', 'en'),
('French', 'fr'),
('Portuguese', 'po'),
('Spanish', 'sp')
ON CONFLICT (name) DO NOTHING;

-- Insert document types
INSERT INTO document_types (type_name, major_type) VALUES
('Agreement', 'Project Documents'),
('Loan Agreement', 'Project Documents'),
('Disbursement Letter', 'Project Documents'),
('Board Report', 'Board Documents'),
('Standard Procurement Document', 'Project Documents'),
('Procurement Plan', 'Project Documents'),
('Implementation Status and Results Report', 'Project Documents'),
('Project Paper', 'Project Documents'),
('Brief', 'Publications & Research'),
('Environmental and Social Commitment Plan', 'Project Documents'),
('Publication', 'Publications & Research'),
('Environmental and Social Assessment; Social Assessment', 'Project Documents'),
('Report', 'Publications & Research'),
('Auditing Document', 'Project Documents'),
('Project Information Document', 'Project Documents'),
('Working Paper', 'Publications & Research'),
('Program-for-Results Environmental and Social Systems Assessment', 'Project Documents'),
('Environmental and Social Review Summary', 'Project Documents')
ON CONFLICT (type_name) DO NOTHING;

-- Insert documents
INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
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
    'English',
    'Ghana',
    '',
    '',
    'Official Documents- Amendment No. 2 to the GPE Grant Agreement for Grant TF0B0846.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
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
    'English',
    'Brazil',
    '',
    '',
    'Official Documents- Loan Agreement for Loan 9619-BR.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
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
    'English',
    'Ghana',
    '',
    '',
    'Official Documents- Amendment No. 1 to the GRPBA Grant Agreement for Grant TF0B3026.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
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
    'English',
    'Ghana',
    '',
    '',
    'Official Documents- Disbursement and Financial Information Letter for Additional Financing for TF0C6881 and TF0C6868.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
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
    'English',
    'Ghana',
    '',
    '',
    'Official Documents- Amendment No. 3 to the Financing Agreement for Credit 6482-GH.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '34442293',
    'Official Documents- Second Amendment to the Loan Agreement for Loan 8955-GE.pdf',
    '2026-01-01',
    '',
    'Agreement',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099010125194057342/pdf/P168481-34503cea-b0e6-432a-ba9e-98dd51ef9f88.pdf',
    'English',
    'Georgia',
    '',
    '',
    'Official Documents- Second Amendment to the Loan Agreement for Loan 8955-GE.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '34442296',
    'Official Documents- Second Amendment to the Loan Agreement for Loan 9580-TR.pdf',
    '2026-01-01',
    '',
    'Agreement',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099010125195520971/pdf/P180849-8d22f7cf-6d7c-4b68-aa48-b3a6e065b60b.pdf',
    'English',
    'Turkiye',
    '',
    '',
    'Official Documents- Second Amendment to the Loan Agreement for Loan 9580-TR.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '34442495',
    'Official Documents- Loan Agreement for Loan 9718-AO.pdf',
    '2025-12-31',
    '',
    'Loan Agreement',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099010225122016167/pdf/P181495-588c8f8d-f594-4727-99a6-dbffa3628018.pdf',
    'English',
    'Angola',
    '',
    '',
    'Official Documents- Loan Agreement for Loan 9718-AO.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '34442754',
    'Official Documents- Disbursement and Financial Information Letter for V5320-ML.pdf',
    '2025-12-31',
    '',
    'Disbursement Letter',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099010325112523643/pdf/P507921-07da4923-b94e-4de1-944b-2f4d7666ebb0.pdf',
    'English',
    'Mali',
    '',
    '',
    'Official Documents- Disbursement and Financial Information Letter for V5320-ML.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '34442755',
    'Official Documents- Agreement for Advance No. V5320-ML.pdf',
    '2025-12-31',
    '',
    'Agreement',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099010325112536348/pdf/P507921-e305b9a6-56cc-4e86-8024-34bbbb65d211.pdf',
    'English',
    'Mali',
    '',
    '',
    'Official Documents- Agreement for Advance No. V5320-ML.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40043805',
    'Ethiopia - Joint World Bank-IMF Debt Sustainability Analysis',
    '2025-09-30',
    '',
    'Board Report',
    'Board Documents',
    1,
    NULL,
    'https://documents.worldbank.org/curated/en/099091725182560879/pdf/BOSIB-9b099c36-ec91-4c49-a173-24653c9e3697.pdf',
    'English',
    'Ethiopia',
    '',
    '',
    'Ethiopia - Joint World Bank-IMF Debt Sustainability Analysis'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044006',
    'Tajikistan - Joint World Bank-IMF Debt Sustainability Analysis',
    '2025-09-30',
    '',
    'Board Report',
    'Board Documents',
    1,
    NULL,
    'https://documents.worldbank.org/curated/en/099091825170016730/pdf/BOSIB-f3c4c161-7123-4c2d-a412-7d3be29fa34a.pdf',
    'English',
    'Tajikistan',
    '',
    '',
    'Tajikistan - Joint World Bank-IMF Debt Sustainability Analysis'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40040166',
    '',
    '2025-09-30',
    '',
    'Standard Procurement Document',
    'Project Documents',
    1,
    NULL,
    'https://documents.worldbank.org/curated/en/099238108282538095/pdf/IDU-7acd5b7f-043a-4f3c-a963-fa12b7096a84.pdf',
    'English',
    'World',
    '',
    '',
    ''
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40041009',
    'Official Documents- Disbursement and Financial Information Letter for Grant E572-LK.pdf',
    '2025-09-28',
    '',
    'Disbursement Letter',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099090225134530649/pdf/P511828-705be4ac-50c6-4243-a6cd-73d947cfcf55.pdf',
    'English',
    'Sri Lanka',
    '',
    '',
    'Official Documents- Disbursement and Financial Information Letter for Grant E572-LK.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40047179',
    'Vanuatu - EAST ASIA AND PACIFIC- P173278- Vanuatu Affordable and Resilient Settlements Project - Procurement Plan',
    '2025-09-25',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425203538000/pdf/P173278-828949b0-a2dd-402e-9154-7a489a448c29.pdf',
    'English',
    'Vanuatu',
    '',
    '',
    'Vanuatu - EAST ASIA AND PACIFIC- P173278- Vanuatu Affordable and Resilient Settlements Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40047207',
    'Disclosable Version of the ISR - Uganda Learning Acceleration Program (ULEARN) - P179397 - Sequence No : 1',
    '2025-09-25',
    '',
    'Implementation Status and Results Report',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425234558800/pdf/P179397-bf8040da-da3f-407c-b6ef-d14fc326871f.pdf',
    'English',
    'Uganda',
    '',
    '',
    'Disclosable Version of the ISR - Uganda Learning Acceleration Program (ULEARN) - P179397 - Sequence No : 1'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40047181',
    'Niger - WESTERN AND CENTRAL AFRICA- P171793- ENHANCING NIGER NORTHEASTERN CONNECTIVITY - Procurement Plan',
    '2025-09-25',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425205512293/pdf/P171793-b6bf0b49-44a8-4834-99da-b8337b4ae0cc.pdf',
    'English',
    'Niger',
    '',
    '',
    'Niger - WESTERN AND CENTRAL AFRICA- P171793- ENHANCING NIGER NORTHEASTERN CONNECTIVITY - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40047201',
    'Philippines - EAST ASIA AND PACIFIC- P171419- Philippines Seismic Risk Reduction and Resilience Project - Procurement Plan',
    '2025-09-25',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425230547023/pdf/P171419-54582b60-f83e-4078-86e5-d4c82ae92cd9.pdf',
    'English',
    'Philippines',
    '',
    '',
    'Philippines - EAST ASIA AND PACIFIC- P171419- Philippines Seismic Risk Reduction and Resilience Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40047203',
    'Disclosable Version of the ISR - Lesotho Education Improvement Project - P500587 - Sequence No : 3',
    '2025-09-25',
    '',
    'Implementation Status and Results Report',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425234031448/pdf/P500587-a9c9d717-72ab-43fc-9017-6d483414d77f.pdf',
    'English',
    'Lesotho',
    '',
    '',
    'Disclosable Version of the ISR - Lesotho Education Improvement Project - P500587 - Sequence No : 3'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40047202',
    'Cambodia - EAST ASIA AND PACIFIC- P178417- Water Supply and Sanitation Acceleration Project - Procurement Plan',
    '2025-09-25',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425232510165/pdf/P178417-97096fab-8ef2-4d97-a033-d72fadb3a9fc.pdf',
    'English',
    'Cambodia',
    '',
    '',
    'Cambodia - EAST ASIA AND PACIFIC- P178417- Water Supply and Sanitation Acceleration Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40047180',
    'Papua New Guinea - EAST ASIA AND PACIFIC- P166420- Urban Youth Employment Project II - Procurement Plan',
    '2025-09-25',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425204021254/pdf/P166420-678fe0c6-2875-442e-8f0f-bf8a5082c3aa.pdf',
    'English',
    'Papua New Guinea',
    '',
    '',
    'Papua New Guinea - EAST ASIA AND PACIFIC- P166420- Urban Youth Employment Project II - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40047178',
    'Disclosable Restructuring Paper - SUSTAINABLE ENERGY DEVELOPMENT AND ACCESS PROJECT - P165183',
    '2025-09-25',
    '',
    'Project Paper',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425203086075/pdf/P165183-ff822d44-c414-4d10-8f57-ed2167852e30.pdf',
    'English',
    'Micronesia, Federated States of',
    '',
    '',
    'Disclosable Restructuring Paper - SUSTAINABLE ENERGY DEVELOPMENT AND ACCESS PROJECT - P165183'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046534',
    'Disclosable Version of the ISR - Burkina Faso Livestock Resilience and Competitiveness Project - P178598 - Sequence No : 5',
    '2025-09-24',
    '',
    'Implementation Status and Results Report',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325215522496/pdf/P178598-eca71dfc-0099-4397-b3ed-5e73f2b1edbb.pdf',
    'English',
    'Burkina Faso',
    '',
    '',
    'Disclosable Version of the ISR - Burkina Faso Livestock Resilience and Competitiveness Project - P178598 - Sequence No : 5'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046723',
    'Rethinking Resilience : Challenges for Developing Countries in the Face of Climate Change and Disaster Risks',
    '2025-09-24',
    '',
    'Brief',
    'Publications & Research',
    1,
    NULL,
    'https://documents.worldbank.org/curated/en/099833109242568395/pdf/IDU-4dbeb6f9-cd9c-45e8-9557-35fba01b0036.pdf',
    'English',
    'World',
    '',
    '',
    'Rethinking Resilience : Challenges for Developing Countries in the Face of Climate Change and Disaster Risks'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046854',
    'Ukraine - EUROPE AND CENTRAL ASIA- P506083- Transforming Healthcare through Reform and Investments in Efficiency - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425073082022/pdf/P506083-0b9341e6-aefc-4c82-b1c1-263b0dcd7b9a.pdf',
    'English',
    'Ukraine',
    '',
    '',
    'Ukraine - EUROPE AND CENTRAL ASIA- P506083- Transforming Healthcare through Reform and Investments in Efficiency - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046893',
    'Ethiopia - EASTERN AND SOUTHERN AFRICA- P171627- Financial Sector Strengthening Project (FSSP) - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425085041038/pdf/P171627-f0bb1665-5cf0-46ab-9d39-7bb2a7488419.pdf',
    'English',
    'Ethiopia',
    '',
    '',
    'Ethiopia - EASTERN AND SOUTHERN AFRICA- P171627- Financial Sector Strengthening Project (FSSP) - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046917',
    'Revised Environmental and Social Commitment Plan (ESCP) Human Capital Protection Project (P506528)',
    '2025-09-24',
    '',
    'Environmental and Social Commitment Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425091530816/pdf/P506528-7b62f98c-1528-48d8-bcaf-d32e9eaed7e9.pdf',
    'English',
    'Burkina Faso',
    '',
    '',
    'Revised Environmental and Social Commitment Plan (ESCP) Human Capital Protection Project (P506528)'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046964',
    'Mauritania - WESTERN AND CENTRAL AFRICA- P179558- Mauritania Health System Support Project - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425112018875/pdf/P179558-625f8913-26fa-4d67-8619-43b6752549af.pdf',
    'English',
    'Mauritania',
    '',
    '',
    'Mauritania - WESTERN AND CENTRAL AFRICA- P179558- Mauritania Health System Support Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40047038',
    'West Bank and Gaza - MID EAST,NORTH AFRICA,AFG,PAK- P181354- Innovative Private Sector Development II - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425145525546/pdf/P181354-99857001-1e99-48d0-affb-ce5112e6531f.pdf',
    'English',
    'West Bank and Gaza',
    '',
    '',
    'West Bank and Gaza - MID EAST,NORTH AFRICA,AFG,PAK- P181354- Innovative Private Sector Development II - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40047112',
    'Disclosable Version of the ISR - Lebanon Emergency Assistance Project - P509428 - Sequence No : 1',
    '2025-09-24',
    '',
    'Implementation Status and Results Report',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425163037244/pdf/P509428-8183afa5-2d83-4fd5-9788-2230e5216342.pdf',
    'English',
    'Lebanon',
    '',
    '',
    'Disclosable Version of the ISR - Lebanon Emergency Assistance Project - P509428 - Sequence No : 1'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40047136',
    'Jamaica - LATIN AMERICA AND CARIBBEAN- P166279- Second Rural Economic Development Initiative (REDI II) Project - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425171522186/pdf/P166279-4080417f-0793-415a-9ecc-3d2f212f9d70.pdf',
    'English',
    'Jamaica',
    '',
    '',
    'Jamaica - LATIN AMERICA AND CARIBBEAN- P166279- Second Rural Economic Development Initiative (REDI II) Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40047182',
    'Revised Environmental and Social Commitment Plan (ESCP) Strengthening Lebanon’s Covid-19 Response (P178587)',
    '2025-09-24',
    '',
    'Environmental and Social Commitment Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425212048443/pdf/P178587-de2d2f5f-9025-466d-af8c-4b1528eee025.pdf',
    'English',
    'Lebanon',
    '',
    '',
    'Revised Environmental and Social Commitment Plan (ESCP) Strengthening Lebanon’s Covid-19 Response (P178587)'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046574',
    'Nepal - SOUTH ASIA- P501985- Electricity Supply Reliability Improvement Project - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425003529424/pdf/P501985-90b75bed-aa38-46bc-9dfe-431134be79fa.pdf',
    'English',
    'Nepal',
    '',
    '',
    'Nepal - SOUTH ASIA- P501985- Electricity Supply Reliability Improvement Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046645',
    'Pakistan - MID EAST,NORTH AFRICA,AFG,PAK- P172834- Sindh Early Learning Enhancement through Classroom Transformation - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425023520990/pdf/P172834-a90b0a4e-c6c9-484c-b7bf-8c13011ca3b6.pdf',
    'English',
    'Pakistan',
    '',
    '',
    'Pakistan - MID EAST,NORTH AFRICA,AFG,PAK- P172834- Sindh Early Learning Enhancement through Classroom Transformation - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046740',
    'Disclosable Version of the ISR - Sudan Health Assistance and Response to Emergencies - P504629 - Sequence No : 2',
    '2025-09-24',
    '',
    'Implementation Status and Results Report',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425052538895/pdf/P504629-f8992420-6b24-4296-bf70-918431a5811f.pdf',
    'English',
    'Sudan',
    '',
    '',
    'Disclosable Version of the ISR - Sudan Health Assistance and Response to Emergencies - P504629 - Sequence No : 2'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046765',
    'Western and Central Africa - WESTERN AND CENTRAL AFRICA- P173830- Community-Based Recovery and Stabilization Project for the Sahel - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425055034458/pdf/P173830-4f3f1f2d-6594-465f-8b03-da42f7299505.pdf',
    'English',
    'Western and Central Africa',
    '',
    '',
    'Western and Central Africa - WESTERN AND CENTRAL AFRICA- P173830- Community-Based Recovery and Stabilization Project for the Sahel - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046831',
    'Moldova - EUROPE AND CENTRAL ASIA- P179363- Education Quality Improvement Project - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425070526987/pdf/P179363-5cff9b86-e90b-4cb5-a39e-e2b9ec196d20.pdf',
    'English',
    'Moldova',
    '',
    '',
    'Moldova - EUROPE AND CENTRAL ASIA- P179363- Education Quality Improvement Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046980',
    'الهجرة : إمكانات أفريقيا غير المستغلة',
    '2025-09-24',
    '',
    'Publication',
    'Publications & Research',
    1,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425115559598/pdf/P502008-b822b07a-6edc-4186-9742-3dedbf84b77f.pdf',
    'Arabic',
    'World',
    '',
    '',
    'الهجرة : إمكانات أفريقيا غير المستغلة'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40047070',
    'Gender-Based Violence (GBV) Assessment Sudan - Enhancing Community Resilience Project (P181490)',
    '2025-09-24',
    '',
    'Environmental and Social Assessment; Social Assessment',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425152542511/pdf/P181490-dbc2a425-f8cb-4224-9c66-060c9df91598.pdf',
    'English',
    'Sudan',
    '',
    '',
    'Gender-Based Violence (GBV) Assessment Sudan - Enhancing Community Resilience Project (P181490)'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40047148',
    'Ecuador - LATIN AMERICA AND CARIBBEAN- P180688- Strengthening the Resilience of Ecuadorian Schools Project - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425175035325/pdf/P180688-c0260530-8b9d-4aab-be28-809e4f30f19f.pdf',
    'English',
    'Ecuador',
    '',
    '',
    'Ecuador - LATIN AMERICA AND CARIBBEAN- P180688- Strengthening the Resilience of Ecuadorian Schools Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046611',
    'Transparence Radicale de la dette',
    '2025-09-24',
    '',
    'Report',
    'Publications & Research',
    1,
    NULL,
    'https://documents.worldbank.org/curated/en/099503009242537134/pdf/IDU-b811c80c-834e-4e93-9b99-1214ee5b1884.pdf',
    'French',
    'World',
    '',
    '',
    'Transparence Radicale de la dette'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046714',
    'Repensando a Resiliência : Desafios para Países em Desenvolvimento Diante das Mudanças Climáticas e Riscos para Desastres',
    '2025-09-24',
    '',
    'Brief',
    'Publications & Research',
    1,
    NULL,
    'https://documents.worldbank.org/curated/en/099811209242522644/pdf/IDU-97c071f0-a309-4213-9ca4-96ddea75bf3f.pdf',
    'Portuguese',
    'World',
    '',
    '',
    'Repensando a Resiliência : Desafios para Países em Desenvolvimento Diante das Mudanças Climáticas e Riscos para Desastres'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046734',
    'Nigeria - WESTERN AND CENTRAL AFRICA - P170734 - Nigeria Sustainable Urban and Rural Water Supply, Sanitation and Hygiene Program-for-Results - Audited Financial Statement',
    '2025-09-24',
    '',
    'Auditing Document',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425050034660/pdf/P170734-6628aa03-b7dd-434c-a938-aae425668f40.pdf',
    'English',
    'Nigeria',
    '',
    '',
    'Nigeria - WESTERN AND CENTRAL AFRICA - P170734 - Nigeria Sustainable Urban and Rural Water Supply, Sanitation and Hygiene Program-for-Results - Audited Financial Statement'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046749',
    'Peru - LATIN AMERICA AND CARIBBEAN- P157043- Modernization of Water Supply and Sanitation Services - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425053533337/pdf/P157043-9a5d852e-cc3d-4fbc-a471-2b1e7f8d0fa8.pdf',
    'English',
    'Peru',
    '',
    '',
    'Peru - LATIN AMERICA AND CARIBBEAN- P157043- Modernization of Water Supply and Sanitation Services - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046781',
    'Disclosable Version of the ISR - Accelerating the Market Transition for Distributed Energy Program as part of ECARES MPA - P176375 - Sequence No : 4',
    '2025-09-24',
    '',
    'Implementation Status and Results Report',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425061513555/pdf/P176375-88084d73-84bf-426a-8163-72fd293050cd.pdf',
    'English',
    'Turkiye',
    '',
    '',
    'Disclosable Version of the ISR - Accelerating the Market Transition for Distributed Energy Program as part of ECARES MPA - P176375 - Sequence No : 4'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046783',
    'Eastern and Southern Africa - EASTERN AND SOUTHERN AFRICA- P175731- SADC Regional Statistics Project - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425061583945/pdf/P175731-3cb5b7cd-6964-4123-9a05-8c4aaedcf728.pdf',
    'English',
    'Eastern and Southern Africa',
    '',
    '',
    'Eastern and Southern Africa - EASTERN AND SOUTHERN AFRICA- P175731- SADC Regional Statistics Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046858',
    'Liberia - WESTERN AND CENTRAL AFRICA- P172012- Liberia Sustainable Management of Fisheries Project - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425075090941/pdf/P172012-e3fc5206-76a2-422f-b4ee-da3e501abd6a.pdf',
    'English',
    'Liberia',
    '',
    '',
    'Liberia - WESTERN AND CENTRAL AFRICA- P172012- Liberia Sustainable Management of Fisheries Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046923',
    'Concept Project Information Document (PID)',
    '2025-09-24',
    '',
    'Project Information Document',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425094535234/pdf/P510691-fbd97f10-0e5e-4b72-a2c1-cf38d5ee1356.pdf',
    'English',
    'Brazil',
    '',
    '',
    'Concept Project Information Document (PID)'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046928',
    'Haiti - LATIN AMERICA AND CARIBBEAN- P173743- Private Sector Jobs and Economic Transformation (PSJET) - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425100019905/pdf/P173743-a4c560a8-8a41-4584-a3b4-3ac8529b7661.pdf',
    'English',
    'Haiti',
    '',
    '',
    'Haiti - LATIN AMERICA AND CARIBBEAN- P173743- Private Sector Jobs and Economic Transformation (PSJET) - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40047114',
    'Kosovo - EUROPE AND CENTRAL ASIA- P178162- Strengthening Digital Governance for Service Delivery - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425163518151/pdf/P178162-ddee12a2-43fc-4780-87ce-68f950d40be4.pdf',
    'English',
    'Kosovo',
    '',
    '',
    'Kosovo - EUROPE AND CENTRAL ASIA- P178162- Strengthening Digital Governance for Service Delivery - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046859',
    'Gambia, The - WESTERN AND CENTRAL AFRICA- P504762- The Gambia Infrastructure Project - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425075524343/pdf/P504762-58c8e924-7071-4434-9855-506e5497a046.pdf',
    'English',
    'Gambia, The',
    '',
    '',
    'Gambia, The - WESTERN AND CENTRAL AFRICA- P504762- The Gambia Infrastructure Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046909',
    'Official Documents- First Restatement of the Disbursement and Financial Information Letter for Grant E275-TV.pdf',
    '2025-09-24',
    '',
    'Disbursement Letter',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425091017857/pdf/P179599-3bbea9d4-397d-465b-b112-2e0e1050b2f9.pdf',
    'English',
    'Tuvalu',
    '',
    '',
    'Official Documents- First Restatement of the Disbursement and Financial Information Letter for Grant E275-TV.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046913',
    'Official Documents- Administration Agreement with the Government of Flanders, acting through the Flemish Department of Foreign Affairs, for TF074190.pdf',
    '2025-09-24',
    '',
    'Agreement',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425091523841/pdf/TF074190-b4b6c4fe-7282-4a8b-ab79-b5815b347eb4.pdf',
    'English',
    '',
    '',
    '',
    'Official Documents- Administration Agreement with the Government of Flanders, acting through the Flemish Department of Foreign Affairs, for TF074190.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046966',
    'Maldives - SOUTH ASIA- P177768- Maldives Atoll Education Development Project - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425112514363/pdf/P177768-502d7582-334f-4bd5-9859-73c4414957c0.pdf',
    'English',
    'Maldives',
    '',
    '',
    'Maldives - SOUTH ASIA- P177768- Maldives Atoll Education Development Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046969',
    'Chad - WESTERN AND CENTRAL AFRICA- P174495- Chad Energy Access Scale Up Project - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425113511852/pdf/P174495-423356b7-4229-456b-a9c8-289154fa0df7.pdf',
    'English',
    'Chad',
    '',
    '',
    'Chad - WESTERN AND CENTRAL AFRICA- P174495- Chad Energy Access Scale Up Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40047018',
    'Guatemala - LATIN AMERICA AND CARIBBEAN- P159213- Crecer Sano: Guatemala Nutrition and Health Project - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425142030256/pdf/P159213-c55cd564-7c2e-4be0-b594-900dc9170dc1.pdf',
    'English',
    'Guatemala',
    '',
    '',
    'Guatemala - LATIN AMERICA AND CARIBBEAN- P159213- Crecer Sano: Guatemala Nutrition and Health Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40047118',
    'Amazonia Viva GCF Program : Environmental and Social Sustainability Framework',
    '2025-09-24',
    '',
    'Report',
    'Publications & Research',
    1,
    NULL,
    'https://documents.worldbank.org/curated/en/099037209242521603/pdf/IDU-bedb75da-f03b-4364-852c-685bbabd6f23.pdf',
    'English',
    'Bolivia,Brazil,Ecuador,Colombia,Guyana,Suriname,Peru',
    '',
    '',
    'Amazonia Viva GCF Program : Environmental and Social Sustainability Framework'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046722',
    'Repensando la Resiliencia : Desafíos para Países en Desarrollo Ante El Cambio Climático y Los Riesgos de Desastres',
    '2025-09-24',
    '',
    'Brief',
    'Publications & Research',
    1,
    NULL,
    'https://documents.worldbank.org/curated/en/099826509242541774/pdf/IDU-ea11837f-1b0f-46b5-bc1a-cbdc0e0f7997.pdf',
    'Spanish',
    'World',
    '',
    '',
    'Repensando la Resiliencia : Desafíos para Países en Desarrollo Ante El Cambio Climático y Los Riesgos de Desastres'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046834',
    'India - SOUTH ASIA- P179749- Uttarakhand Disaster Preparedness and Resilience Project - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425071015394/pdf/P179749-5b81308e-fe7c-4505-b7b9-a8795b85791e.pdf',
    'English',
    'India',
    '',
    '',
    'India - SOUTH ASIA- P179749- Uttarakhand Disaster Preparedness and Resilience Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046887',
    'Cabo Verde - WESTERN AND CENTRAL AFRICA- P176981- Resilient Tourism and Blue Economy Development in Cabo Verde Project - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425083513741/pdf/P176981-5dbe927e-ca70-4f78-9bb3-3aa35f53fe8d.pdf',
    'English',
    'Cabo Verde',
    '',
    '',
    'Cabo Verde - WESTERN AND CENTRAL AFRICA- P176981- Resilient Tourism and Blue Economy Development in Cabo Verde Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046924',
    'Ethiopia - EASTERN AND SOUTHERN AFRICA- P504281- Innovative Systems to Promote Integrated, Resilient and Enhanced Responses to Women and Girls? Health - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425095023351/pdf/P504281-73b8c18f-e22f-40a0-90d3-ffa05203d542.pdf',
    'English',
    'Ethiopia',
    '',
    '',
    'Ethiopia - EASTERN AND SOUTHERN AFRICA- P504281- Innovative Systems to Promote Integrated, Resilient and Enhanced Responses to Women and Girls? Health - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046926',
    'Serbia - EUROPE AND CENTRAL ASIA- P164824- Enabling Digital Governance Project - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425100019692/pdf/P164824-c75e1e62-c2d5-464f-bedf-60853a0f2021.pdf',
    'English',
    'Serbia',
    '',
    '',
    'Serbia - EUROPE AND CENTRAL ASIA- P164824- Enabling Digital Governance Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40047014',
    'Disclosable Version of the ISR - Sustainable Transition through Energy Efficiency in Moldova Project (STEEM) - P500560 - Sequence No : 3',
    '2025-09-24',
    '',
    'Implementation Status and Results Report',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425131016134/pdf/P500560-6547e72a-80fa-4cf7-ba5e-594aa57d01f5.pdf',
    'English',
    'Moldova',
    '',
    '',
    'Disclosable Version of the ISR - Sustainable Transition through Energy Efficiency in Moldova Project (STEEM) - P500560 - Sequence No : 3'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40047017',
    'Western and Central Africa - WESTERN AND CENTRAL AFRICA- P162337- West Africa Coastal Areas Resilience Investment Project - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425140021580/pdf/P162337-29011027-13da-46d7-b406-298f12bb13f3.pdf',
    'English',
    'Western and Central Africa',
    '',
    '',
    'Western and Central Africa - WESTERN AND CENTRAL AFRICA- P162337- West Africa Coastal Areas Resilience Investment Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40047126',
    'Amazonia Viva GCF-programma : Kader voor ecologische en sociale duurzaamheid',
    '2025-09-24',
    '',
    'Report',
    'Publications & Research',
    1,
    NULL,
    'https://documents.worldbank.org/curated/en/099049309242540580/pdf/IDU-5810d08e-7f2e-438b-81ff-2c93d662670e.pdf',
    'Dutch',
    'Bolivia,Brazil,Ecuador,Colombia,Guyana,Suriname,Peru',
    '',
    '',
    'Amazonia Viva GCF-programma : Kader voor ecologische en sociale duurzaamheid'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046576',
    'Tornando as Escolas Resilientes no Japao : Foco em Medidas de Combate a Enchentes',
    '2025-09-24',
    '',
    'Working Paper',
    'Publications & Research',
    1,
    NULL,
    'http://documents.worldbank.org/curated/en/099439509242519239',
    'Portuguese',
    'Japan',
    '',
    '',
    'Tornando as Escolas Resilientes no Japao : Foco em Medidas de Combate a Enchentes'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046688',
    'Uzbekistan - EUROPE AND CENTRAL ASIA- P181922- Uzbekistan - National Energy-Efficient Heating and Cooling Program - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425034535599/pdf/P181922-480fa2df-daa0-4761-b70c-a126bd6fea4d.pdf',
    'English',
    'Uzbekistan',
    '',
    '',
    'Uzbekistan - EUROPE AND CENTRAL ASIA- P181922- Uzbekistan - National Energy-Efficient Heating and Cooling Program - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046538',
    'Disclosable Version of the ISR - Burkina Faso Livestock Resilience and Competitiveness Project - P178598 - Sequence No : 5',
    '2025-09-24',
    '',
    'Implementation Status and Results Report',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325215529327/pdf/P178598-7cbe80aa-9e22-4c31-aaeb-f5acc2058abc.pdf',
    'English',
    'Burkina Faso',
    '',
    '',
    'Disclosable Version of the ISR - Burkina Faso Livestock Resilience and Competitiveness Project - P178598 - Sequence No : 5'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046654',
    'Rwanda - EASTERN AND SOUTHERN AFRICA- P178161- Volcanoes Community Resilience Project - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425024511484/pdf/P178161-d2bcfd05-644a-43c0-a799-4a1618e113fc.pdf',
    'English',
    'Rwanda',
    '',
    '',
    'Rwanda - EASTERN AND SOUTHERN AFRICA- P178161- Volcanoes Community Resilience Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046720',
    'Disclosable Version of the ISR - Zanzibar Judicial Modernization Project (Zi-JUMP) - P500588 - Sequence No : 3',
    '2025-09-24',
    '',
    'Implementation Status and Results Report',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425042513199/pdf/P500588-e4e6fa06-3553-4e91-ba32-392978839b70.pdf',
    'English',
    'Tanzania',
    '',
    '',
    'Disclosable Version of the ISR - Zanzibar Judicial Modernization Project (Zi-JUMP) - P500588 - Sequence No : 3'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046788',
    'Eastern and Southern Africa - EASTERN AND SOUTHERN AFRICA- P175731- SADC Regional Statistics Project - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425062015639/pdf/P175731-4e2a76ab-c9ea-4577-97a5-84a3425ba66d.pdf',
    'English',
    'Eastern and Southern Africa',
    '',
    '',
    'Eastern and Southern Africa - EASTERN AND SOUTHERN AFRICA- P175731- SADC Regional Statistics Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046826',
    'Lebanon - MID EAST,NORTH AFRICA,AFG,PAK- P163476- Lebanon Health Resilience Project - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425070542751/pdf/P163476-ecff6831-6825-4b3b-9ff3-0a0f3145a964.pdf',
    'English',
    'Lebanon',
    '',
    '',
    'Lebanon - MID EAST,NORTH AFRICA,AFG,PAK- P163476- Lebanon Health Resilience Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40047019',
    'Measuring Welfare When It Matters Most : Learning from Country Applications',
    '2025-09-24',
    '',
    'Report',
    'Publications & Research',
    1,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425142040194/pdf/P500442-cc03ca00-69d1-4ee9-b1b1-cd2b9b288fd8.pdf',
    'English',
    'World',
    '',
    '',
    'Measuring Welfare When It Matters Most : Learning from Country Applications'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40047119',
    'Western and Central Africa - WESTERN AND CENTRAL AFRICA- P508837- Health Security Program in Western and Central Africa - Phase III - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425164018430/pdf/P508837-f5d99a4a-fde8-4f9d-b5bf-97514525b9d5.pdf',
    'English',
    'Western and Central Africa',
    '',
    '',
    'Western and Central Africa - WESTERN AND CENTRAL AFRICA- P508837- Health Security Program in Western and Central Africa - Phase III - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046877',
    'Nepal - SOUTH ASIA- P181087- Food And Nutrition Security Enhancement Project II - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425082521117/pdf/P181087-e445b986-5fc7-4721-9b55-03a483fdc6b9.pdf',
    'English',
    'Nepal',
    '',
    '',
    'Nepal - SOUTH ASIA- P181087- Food And Nutrition Security Enhancement Project II - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046981',
    'Migration : Le Potentiel Inexploité de l’Afrique',
    '2025-09-24',
    '',
    'Report',
    'Publications & Research',
    1,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425115520409/pdf/P502008-23cc9915-9f3f-4705-ba77-e0529440b3e0.pdf',
    'French',
    'World',
    '',
    '',
    'Migration : Le Potentiel Inexploité de l’Afrique'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046982',
    'Migration : Africa’s Untapped Potential',
    '2025-09-24',
    '',
    'Publication',
    'Publications & Research',
    1,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425115527214/pdf/P502008-5506f083-90e1-4e33-8709-3ebdd59888b7.pdf',
    'English',
    'World',
    '',
    '',
    'Migration : Africa’s Untapped Potential'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40047010',
    'OECS Countries - LATIN AMERICA AND CARIBBEAN- P168539- OECS Regional Health Project - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425125542003/pdf/P168539-981251c4-9450-4353-9b4e-ba9b74baf28a.pdf',
    'English',
    'OECS Countries',
    '',
    '',
    'OECS Countries - LATIN AMERICA AND CARIBBEAN- P168539- OECS Regional Health Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046665',
    'Solomon Islands - EAST ASIA AND PACIFIC- P181295- Community Access and Urban Services Enhancement Project II - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425031026172/pdf/P181295-6edae685-4d8d-47aa-9243-8eb5bba5069a.pdf',
    'English',
    'Solomon Islands',
    '',
    '',
    'Solomon Islands - EAST ASIA AND PACIFIC- P181295- Community Access and Urban Services Enhancement Project II - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046568',
    'Honduras - LATIN AMERICA AND CARIBBEAN- P174328- Innovation for Rural Competitiveness Project - COMRURAL III - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425001570173/pdf/P174328-293fb75b-9a98-42c1-a9f7-697558f958aa.pdf',
    'English',
    'Honduras',
    '',
    '',
    'Honduras - LATIN AMERICA AND CARIBBEAN- P174328- Innovation for Rural Competitiveness Project - COMRURAL III - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046795',
    'Micronesia, Federated States of - EAST ASIA AND PACIFIC- P181237- Strengthening Public Financial Management II Project - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425062523711/pdf/P181237-ba71c044-9585-4802-990e-cce88f3e6a47.pdf',
    'English',
    'Micronesia, Federated States of',
    '',
    '',
    'Micronesia, Federated States of - EAST ASIA AND PACIFIC- P181237- Strengthening Public Financial Management II Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046802',
    'Concept Program Information Document (PID)',
    '2025-09-24',
    '',
    'Project Information Document',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425063023895/pdf/P509816-b207dcc3-00d8-4ae1-a1cb-f3e1e94d0ca1.pdf',
    'English',
    'Bhutan',
    '',
    '',
    'Concept Program Information Document (PID)'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046808',
    'India - SOUTH ASIA- P180932- Strengthening Coastal Resilience and the Economy Project - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425064031214/pdf/P180932-3327a3a6-b5f6-4ce6-844f-076624992066.pdf',
    'English',
    'India',
    '',
    '',
    'India - SOUTH ASIA- P180932- Strengthening Coastal Resilience and the Economy Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046925',
    'Brazil - LATIN AMERICA AND CARIBBEAN- P178567- Piau? Health and Social Protection Development Project - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425100040708/pdf/P178567-f244f24b-16b6-4284-93d8-32d308c6932e.pdf',
    'English',
    'Brazil',
    '',
    '',
    'Brazil - LATIN AMERICA AND CARIBBEAN- P178567- Piau? Health and Social Protection Development Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046977',
    'Final Environmental and Social Systems Assessment (ESSA) - Indonesia - Electricity Network Transformation (I-ENET) Program - P180992',
    '2025-09-24',
    '',
    'Program-for-Results Environmental and Social Systems Assessment',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425114539112/pdf/P180992-65fcd64e-2344-4d94-ac6a-e6ed771282cb.pdf',
    'English',
    'Indonesia',
    '',
    '',
    'Final Environmental and Social Systems Assessment (ESSA) - Indonesia - Electricity Network Transformation (I-ENET) Program - P180992'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046986',
    'Burkina Faso - WESTERN AND CENTRAL AFRICA- P178598- Burkina Faso Livestock Resilience and Competitiveness Project - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425120510501/pdf/P178598-8941fde9-40b9-49ba-be56-89e200855efe.pdf',
    'English',
    'Burkina Faso',
    '',
    '',
    'Burkina Faso - WESTERN AND CENTRAL AFRICA- P178598- Burkina Faso Livestock Resilience and Competitiveness Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40047046',
    'Senegal - WESTERN AND CENTRAL AFRICA- P156186- Dakar Bus Rapid Transit Pilot Project - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425151031707/pdf/P156186-f4530fda-2bd9-4a08-b2e4-e806cde6e123.pdf',
    'English',
    'Senegal',
    '',
    '',
    'Senegal - WESTERN AND CENTRAL AFRICA- P156186- Dakar Bus Rapid Transit Pilot Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40047125',
    'Liberia - WESTERN AND CENTRAL AFRICA- P177478- Governance Reform and Accountability Transformation (GREAT) Project - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425164519206/pdf/P177478-a5bbc42c-d918-40c1-a175-2c53a802799d.pdf',
    'English',
    'Liberia',
    '',
    '',
    'Liberia - WESTERN AND CENTRAL AFRICA- P177478- Governance Reform and Accountability Transformation (GREAT) Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40047147',
    'Environmental and Social Commitment Plan (ESCP) Optimization of Public Finance Management in Honduras (P511035)',
    '2025-09-24',
    '',
    'Environmental and Social Commitment Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425174010254/pdf/P511035-fa63bf82-b846-4086-af83-c0ae7996a209.pdf',
    'English',
    'Honduras',
    '',
    '',
    'Environmental and Social Commitment Plan (ESCP) Optimization of Public Finance Management in Honduras (P511035)'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046572',
    'Making Schools Resilient in Japan : Focusing on Flood Countermeasures',
    '2025-09-24',
    '',
    'Working Paper',
    'Publications & Research',
    1,
    NULL,
    'https://documents.worldbank.org/curated/en/099428309242516243/pdf/IDU-e90e8d80-af94-4d90-bdfc-fc9993b7c3c7.pdf',
    'English',
    'Japan',
    '',
    '',
    'Making Schools Resilient in Japan : Focusing on Flood Countermeasures'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046575',
    'Desarrollando escuelas Resilientes en Japón : Enfoque en las Medidas Contra Inundaciones',
    '2025-09-24',
    '',
    'Working Paper',
    'Publications & Research',
    1,
    NULL,
    'https://documents.worldbank.org/curated/en/099435509242529769/pdf/IDU-69cad72a-82da-4557-a436-0c082302d5b0.pdf',
    'Spanish',
    'Japan',
    '',
    '',
    'Desarrollando escuelas Resilientes en Japón : Enfoque en las Medidas Contra Inundaciones'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046755',
    'Bangladesh - SOUTH ASIA- P508058- Bangladesh Sustainable Recovery, Emergency Preparedness and Response Project - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425054029930/pdf/P508058-6e8916be-1494-4f69-9333-8a3a1b101d45.pdf',
    'English',
    'Bangladesh',
    '',
    '',
    'Bangladesh - SOUTH ASIA- P508058- Bangladesh Sustainable Recovery, Emergency Preparedness and Response Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046789',
    'Disclosable Version of the ISR - Accelerating the Market Transition for Distributed Energy Program as part of ECARES MPA - P176375 - Sequence No : 4',
    '2025-09-24',
    '',
    'Implementation Status and Results Report',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425062034838/pdf/P176375-cf3817f8-c846-435e-ba68-94d4ab55d3d6.pdf',
    'English',
    'Turkiye',
    '',
    '',
    'Disclosable Version of the ISR - Accelerating the Market Transition for Distributed Energy Program as part of ECARES MPA - P176375 - Sequence No : 4'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046836',
    'Eswatini - EASTERN AND SOUTHERN AFRICA- P508948- Digital Eswatini - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425071068407/pdf/P508948-7a790184-74d5-4d1f-8cff-10000c796fb2.pdf',
    'English',
    'Eswatini',
    '',
    '',
    'Eswatini - EASTERN AND SOUTHERN AFRICA- P508948- Digital Eswatini - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046882',
    'Western and Central Africa - WESTERN AND CENTRAL AFRICA- P172769- West Africa Food System Resilience Program (FSRP) - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425083024412/pdf/P172769-b9cd353a-d1ab-4c72-8743-7049b95514fc.pdf',
    'English',
    'Western and Central Africa',
    '',
    '',
    'Western and Central Africa - WESTERN AND CENTRAL AFRICA- P172769- West Africa Food System Resilience Program (FSRP) - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046897',
    'Official Documents- Amendment to the Co-Financing Grant Agreement for Grant No. TF0B6525.pdf',
    '2025-09-24',
    '',
    'Agreement',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425090041904/pdf/P169669-bb2f0312-151b-4658-927d-cc0e832135f4.pdf',
    'English',
    'Lao People''s Democratic Republic',
    '',
    '',
    'Official Documents- Amendment to the Co-Financing Grant Agreement for Grant No. TF0B6525.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046914',
    'Disclosable Version of the ISR - Real Estate Registration Project - P168576 - Sequence No : 13',
    '2025-09-24',
    '',
    'Implementation Status and Results Report',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425091519244/pdf/P168576-4c1caccb-e4aa-446d-b6fe-58360687110e.pdf',
    'English',
    'West Bank and Gaza',
    '',
    '',
    'Disclosable Version of the ISR - Real Estate Registration Project - P168576 - Sequence No : 13'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046920',
    'Mozambique - EASTERN AND SOUTHERN AFRICA- P174002- Sustainable Rural Economy Program - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425093540608/pdf/P174002-f8f07051-b0fd-4602-af21-68ce2e6970d1.pdf',
    'English',
    'Mozambique',
    '',
    '',
    'Mozambique - EASTERN AND SOUTHERN AFRICA- P174002- Sustainable Rural Economy Program - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046984',
    'Concept Environmental and Social Review Summary (ESRS) - Parana Water Security Project - P510227',
    '2025-09-24',
    '',
    'Environmental and Social Review Summary',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425120024377/pdf/P510227-c5f0205f-5ee5-43c9-9757-cca8bfb6fa51.pdf',
    'English',
    'Brazil',
    '',
    '',
    'Concept Environmental and Social Review Summary (ESRS) - Parana Water Security Project - P510227'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb,
    url, lang, country, author, publisher, content_text
) VALUES (
    '40047015',
    'Tanzania - EASTERN AND SOUTHERN AFRICA- P164920- Tanzania Roads to Inclusion and Socioeconomic Opportunities (RISE) Project - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425131051948/pdf/P164920-a60fcda3-ba07-43c6-8532-5db252c1dc9a.pdf',
    'English',
    'Tanzania',
    '',
    '',
    'Tanzania - EASTERN AND SOUTHERN AFRICA- P164920- Tanzania Roads to Inclusion and Socioeconomic Opportunities (RISE) Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;