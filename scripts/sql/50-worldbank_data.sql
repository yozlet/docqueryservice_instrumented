-- World Bank Documents Data
-- Generated on 2025-09-24 21:45:42
-- Total documents: 500

-- Insert countries
INSERT INTO countries (name, code, region) VALUES
('Albania', 'ALB', 'Unknown'),
('Angola', 'AGO', 'Unknown'),
('Argentina', 'ARG', 'Unknown'),
('Armenia', 'ARM', 'Unknown'),
('Bangladesh', 'BGD', 'Unknown'),
('Benin', 'BEN', 'Unknown'),
('Bhutan', 'BTN', 'Unknown'),
('Bosnia and Herzegovina', 'BIH', 'Unknown'),
('Brazil', 'BRA', 'Unknown'),
('Burkina Faso', 'BFA', 'Unknown'),
('Cabo Verde', 'CPV', 'Unknown'),
('Cambodia', 'KHM', 'Unknown'),
('Central African Republic', 'CAF', 'Unknown'),
('Chad', 'CHA', 'Unknown'),
('China', 'CHN', 'Unknown'),
('Colombia', 'COL', 'Unknown'),
('Comoros', 'COM', 'Unknown'),
('Congo, Democratic Republic of', 'CON', 'Unknown'),
('Costa Rica', 'COS', 'Unknown'),
('Cote d''Ivoire', 'COT', 'Unknown'),
('Croatia', 'CRO', 'Unknown'),
('Djibouti', 'DJI', 'Unknown'),
('Dominican Republic', 'DOM', 'Unknown'),
('Ecuador', 'ECU', 'Unknown'),
('El Salvador', 'EL', 'Unknown'),
('Eswatini', 'ESW', 'Unknown'),
('Ethiopia', 'ETH', 'Unknown'),
('Gabon', 'GAB', 'Unknown'),
('Gambia, The', 'GAM', 'Unknown'),
('Georgia', 'GEO', 'Unknown'),
('Ghana', 'GHA', 'Unknown'),
('Guatemala', 'GUA', 'Unknown'),
('Guinea-Bissau', 'GUI', 'Unknown'),
('Haiti', 'HAI', 'Unknown'),
('Honduras', 'HON', 'Unknown'),
('Indonesia', 'IDN', 'Unknown'),
('India', 'IND', 'Unknown'),
('Jamaica', 'JAM', 'Unknown'),
('Japan', 'JPN', 'Unknown'),
('Kazakhstan', 'KAZ', 'Unknown'),
('Kenya', 'KEN', 'Unknown'),
('Kiribati', 'KIR', 'Unknown'),
('Kosovo', 'KOS', 'Unknown'),
('Kyrgyz Republic', 'KYR', 'Unknown'),
('Lao People''s Democratic Republic', 'LAO', 'Unknown'),
('Lebanon', 'LEB', 'Unknown'),
('Liberia', 'LIB', 'Unknown'),
('Madagascar', 'MAD', 'Unknown'),
('Malawi', 'MWI', 'Unknown'),
('Malaysia', 'MYS', 'Unknown'),
('Maldives', 'MDV', 'Unknown'),
('Mali', 'MLI', 'Unknown'),
('Mauritania', 'MAU', 'Unknown'),
('Micronesia, Federated States of', 'MIC', 'Unknown'),
('Moldova', 'MOL', 'Unknown'),
('Mongolia', 'MON', 'Unknown'),
('Morocco', 'MOR', 'Unknown'),
('Mozambique', 'MOZ', 'Unknown'),
('Namibia', 'NAM', 'Unknown'),
('Nepal', 'NEP', 'Unknown'),
('Niger', 'NER', 'Unknown'),
('Nigeria', 'NGA', 'Unknown'),
('Pakistan', 'PAK', 'Unknown'),
('Panama', 'PAN', 'Unknown'),
('Papua New Guinea', 'PNG', 'Unknown'),
('Paraguay', 'PAR', 'Unknown'),
('Peru', 'PER', 'Unknown'),
('Philippines', 'PHL', 'Unknown'),
('Romania', 'ROU', 'Unknown'),
('Rwanda', 'RWA', 'Unknown'),
('Samoa', 'SAM', 'Unknown'),
('Sao Tome and Principe', 'SAO', 'Unknown'),
('Senegal', 'SEN', 'Unknown'),
('Serbia', 'SER', 'Unknown'),
('Sierra Leone', 'SLE', 'Unknown'),
('Solomon Islands', 'SLB', 'Unknown'),
('Somalia, Federal Republic of', 'SOM', 'Unknown'),
('South Africa', 'ZAF', 'Unknown'),
('South Sudan', 'SSD', 'Unknown'),
('Sri Lanka', 'SRI', 'Unknown'),
('St Maarten', 'ST', 'Unknown'),
('Sudan', 'SUD', 'Unknown'),
('Suriname', 'SUR', 'Unknown'),
('Tajikistan', 'TAJ', 'Unknown'),
('Tanzania', 'TZA', 'Unknown'),
('Tonga', 'TON', 'Unknown'),
('Tunisia', 'TUN', 'Unknown'),
('Turkiye', 'TUR', 'Unknown'),
('Tuvalu', 'TUV', 'Unknown'),
('Ukraine', 'UKR', 'Unknown'),
('United States', 'UNI', 'Unknown'),
('Uruguay', 'URU', 'Unknown'),
('Uzbekistan', 'UZB', 'Unknown'),
('Vanuatu', 'VAN', 'Unknown'),
('Viet Nam', 'VIE', 'Unknown'),
('Western and Central Africa', 'WES', 'Unknown'),
('World', 'WOR', 'Unknown'),
('Yemen, Republic of', 'YEM', 'Unknown')
ON CONFLICT (name) DO NOTHING;

-- Insert languages
INSERT INTO languages (name, iso_code) VALUES
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
('Implementation Status and Results Report', 'Project Documents'),
('Brief', 'Publications & Research'),
('Procurement Plan', 'Project Documents'),
('Environmental and Social Commitment Plan', 'Project Documents'),
('Publication', 'Publications & Research'),
('Environmental and Social Assessment; Social Assessment', 'Project Documents'),
('Report', 'Publications & Research'),
('Auditing Document', 'Project Documents'),
('Project Information Document', 'Project Documents'),
('Working Paper', 'Publications & Research'),
('Program-for-Results Environmental and Social Systems Assessment', 'Project Documents'),
('Environmental and Social Review Summary', 'Project Documents'),
('Letter', 'Unknown'),
('Policy Research Working Paper', 'Publications & Research'),
('Environmental and Social Management Plan', 'Project Documents'),
('Project Paper', 'Project Documents'),
('Stakeholder Engagement Plan', 'Project Documents'),
('Program Information Document', 'Project Documents'),
('Environmental and Social Management Plan; Indigenous Peoples Plan', 'Project Documents'),
('ESMAP Paper', 'Publications & Research'),
('Procedure and Checklist', 'Publications & Research'),
('Environmental Assessment; Environmental and Social Assessment; Social Assessment', 'Project Documents'),
('Policy Note', 'Economic & Sector Work'),
('Guarantee Agreement', 'Project Documents'),
('Environmental and Social Management Plan; Resettlement Plan', 'Project Documents'),
('Social Assessment; Environmental and Social Assessment; Environmental Assessment', 'Project Documents'),
('Grant or Trust Fund Agreement', 'Project Documents'),
('Environmental and Social Management Framework', 'Project Documents'),
('Social Assessment; Environmental Assessment; Environmental and Social Assessment', 'Project Documents'),
('Project Agreement', 'Project Documents'),
('Poverty Assessment', 'Economic & Sector Work'),
('Resettlement Plan', 'Project Documents'),
('Resettlement Plan; Environmental and Social Management Plan', 'Project Documents')
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

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '34452596',
    'Migration : Leveraging Human Capital in the East Asia and Pacific Region - A Companion Piece to the World Development Report 2023 : Migrants, Refugees, and Society',
    '2025-09-24',
    '',
    'Report',
    'Publications & Research',
    1,
    NULL,
    'https://documents.worldbank.org/curated/en/099020325194013546/pdf/P180848-980daabd-c4df-4314-a796-5df3bf5c97c5.pdf',
    'English',
    'East Asia and Pacific',
    '',
    '',
    'Migration : Leveraging Human Capital in the East Asia and Pacific Region - A Companion Piece to the World Development Report 2023 : Migrants, Refugees, and Society'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046677',
    'Sudan - EASTERN AND SOUTHERN AFRICA- P181490- Sudan - Enhancing Community Resilience Project - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425033514113/pdf/P181490-f0cbc82e-7284-4b6c-a843-c628bcef6cdf.pdf',
    'English',
    'Sudan',
    '',
    '',
    'Sudan - EASTERN AND SOUTHERN AFRICA- P181490- Sudan - Enhancing Community Resilience Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046775',
    'Tajikistan - EUROPE AND CENTRAL ASIA- P168052- Tajikistan Socio-Economic Resilience Strengthening Project - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425061018513/pdf/P168052-e1edfd38-7cc2-4d48-8235-661eee71a7c9.pdf',
    'English',
    'Tajikistan',
    '',
    '',
    'Tajikistan - EUROPE AND CENTRAL ASIA- P168052- Tajikistan Socio-Economic Resilience Strengthening Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046975',
    'Honduras - LATIN AMERICA AND CARIBBEAN- P507958- Honduras Resilient Management for La Ceiba - Puerto Castilla Road Corridor Project - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425114511974/pdf/P507958-5efb5f3a-f5e5-4474-b19d-f90a881bf06c.pdf',
    'English',
    'Honduras',
    '',
    '',
    'Honduras - LATIN AMERICA AND CARIBBEAN- P507958- Honduras Resilient Management for La Ceiba - Puerto Castilla Road Corridor Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046991',
    'Official Documents- Corrigendum to correct amounts in the Withdrawal Table for 6776-RW and Grant D721-RW.pdf',
    '2025-09-24',
    '',
    'Letter',
    '',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425122038843/pdf/P172594-5c721c80-9457-430d-90a4-b20307969ecc.pdf',
    'English',
    'Rwanda',
    '',
    '',
    'Official Documents- Corrigendum to correct amounts in the Withdrawal Table for 6776-RW and Grant D721-RW.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40047008',
    'Concept Project Information Document (PID)',
    '2025-09-24',
    '',
    'Project Information Document',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425124518724/pdf/P510227-8f500c44-ff16-4e56-97ad-aeba485b8a24.pdf',
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
    '40047124',
    'Programa GCF Amazônia Viva : Estrutura de Sustentabilidade Ambiental e Social',
    '2025-09-24',
    '',
    'Report',
    'Publications & Research',
    1,
    NULL,
    'https://documents.worldbank.org/curated/en/099044009242538248/pdf/IDU-4d7a3055-368b-4742-b3ce-692f1569820e.pdf',
    'Portuguese',
    'Bolivia,Brazil,Ecuador,Colombia,Guyana,Suriname,Peru',
    '',
    '',
    'Programa GCF Amazônia Viva : Estrutura de Sustentabilidade Ambiental e Social'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40047145',
    'Disclosable Version of the ISR - Eastern Africa Regional Digital Integration Project - P176181 - Sequence No : 5',
    '2025-09-24',
    '',
    'Implementation Status and Results Report',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425174091515/pdf/P176181-8b0d8c1a-a2fa-475e-b485-bc31013b0651.pdf',
    'English',
    'Eastern and Southern Africa',
    '',
    '',
    'Disclosable Version of the ISR - Eastern Africa Regional Digital Integration Project - P176181 - Sequence No : 5'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046543',
    'Philippines - EAST ASIA AND PACIFIC- P174137- Philippine Fisheries and Coastal Resiliency Project - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325222526104/pdf/P174137-d17d6171-1cae-4468-8d91-f8349409dd0f.pdf',
    'English',
    'Philippines',
    '',
    '',
    'Philippines - EAST ASIA AND PACIFIC- P174137- Philippine Fisheries and Coastal Resiliency Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '',
    '',
    NULL,
    '',
    '',
    '',
    NULL,
    NULL,
    '',
    '',
    '',
    '',
    '',
    ''
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046837',
    'Disclosable Version of the ISR - Climate Resilient Roads for the North Project - P500488 - Sequence No : 3',
    '2025-09-24',
    '',
    'Implementation Status and Results Report',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425071510228/pdf/P500488-413350e8-ed20-4cca-8981-7a1003beeb7b.pdf',
    'English',
    'Mozambique',
    '',
    '',
    'Disclosable Version of the ISR - Climate Resilient Roads for the North Project - P500488 - Sequence No : 3'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046857',
    'Nepal - SOUTH ASIA- P505226- Public Financial Management for Development Effectiveness Project - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425074030466/pdf/P505226-d2844a3a-4bdf-4c0d-a41c-a7254b056c79.pdf',
    'English',
    'Nepal',
    '',
    '',
    'Nepal - SOUTH ASIA- P505226- Public Financial Management for Development Effectiveness Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046879',
    'Mongolia - EAST ASIA AND PACIFIC- P170676- Ulaanbaatar Heating Sector Improvement Project - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425082515770/pdf/P170676-4ee311c9-035c-44df-af59-5dc85380a4ad.pdf',
    'English',
    'Mongolia',
    '',
    '',
    'Mongolia - EAST ASIA AND PACIFIC- P170676- Ulaanbaatar Heating Sector Improvement Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046885',
    'Natural Disasters and Perceived Returns to Education',
    '2025-09-24',
    '',
    'Policy Research Working Paper',
    'Publications & Research',
    1,
    NULL,
    'https://documents.worldbank.org/curated/en/099230309242516909/pdf/IDU-9e8cbb8a-d7d7-4de0-88c4-d823dfc37c03.pdf',
    'English',
    'Mozambique',
    '',
    '',
    'Natural Disasters and Perceived Returns to Education'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046938',
    'Turkiye - EUROPE AND CENTRAL ASIA- P172562- Turkey Resilient Landscape Integration Project (TULIP) - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425103537317/pdf/P172562-c2915c80-8493-47a8-8494-10a8a95f0180.pdf',
    'English',
    'Turkiye',
    '',
    '',
    'Turkiye - EUROPE AND CENTRAL ASIA- P172562- Turkey Resilient Landscape Integration Project (TULIP) - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046985',
    'Western and Central Africa - WESTERN AND CENTRAL AFRICA- P180085- Harmonizing and Improving Statistics in West and Central Africa - Series of Projects Two (HISWACA - SOP 2) - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425120522906/pdf/P180085-383626a8-4b17-4d91-aeb7-cafb78308daf.pdf',
    'English',
    'Western and Central Africa',
    '',
    '',
    'Western and Central Africa - WESTERN AND CENTRAL AFRICA- P180085- Harmonizing and Improving Statistics in West and Central Africa - Series of Projects Two (HISWACA - SOP 2) - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40047073',
    'Environmental and Social Management Framework (ESMF) Sudan - Enhancing Community Resilience Project (P181490)',
    '2025-09-24',
    '',
    'Environmental and Social Management Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425153032330/pdf/P181490-568b97e1-58ef-4a24-9935-2084f4f10bb5.pdf',
    'English',
    'Sudan',
    '',
    '',
    'Environmental and Social Management Framework (ESMF) Sudan - Enhancing Community Resilience Project (P181490)'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40047127',
    'Programa Amazonia Viva GCF : Marco de sostenibilidad ambiental y social',
    '2025-09-24',
    '',
    'Report',
    'Publications & Research',
    1,
    NULL,
    'https://documents.worldbank.org/curated/en/099054509242517990/pdf/IDU-02aabdec-e855-4560-8a28-0edcca2bea43.pdf',
    'Spanish',
    'Bolivia,Brazil,Ecuador,Colombia,Guyana,Suriname,Peru',
    '',
    '',
    'Programa Amazonia Viva GCF : Marco de sostenibilidad ambiental y social'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046632',
    'Lao People''s Democratic Republic - EAST ASIA AND PACIFIC- P179284- Lao PDR Climate Resilient Road Connectivity Improvement Project - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425015514950/pdf/P179284-45763602-e47f-407a-86b3-5bb9279ff65e.pdf',
    'English',
    'Lao People''s Democratic Republic',
    '',
    '',
    'Lao People''s Democratic Republic - EAST ASIA AND PACIFIC- P179284- Lao PDR Climate Resilient Road Connectivity Improvement Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046635',
    'Western and Central Africa - WESTERN AND CENTRAL AFRICA- P176932- Digital Transformation for Africa Western Africa Regional Digital Integration Program SOP1 - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425022519887/pdf/P176932-e28b6375-10ae-485c-aabd-b5a76db3b387.pdf',
    'English',
    'Western and Central Africa',
    '',
    '',
    'Western and Central Africa - WESTERN AND CENTRAL AFRICA- P176932- Digital Transformation for Africa Western Africa Regional Digital Integration Program SOP1 - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046659',
    'Indonesia - EAST ASIA AND PACIFIC- P500764- Indonesia Supporting Health Transformation Project (I-SeHat) - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425025026568/pdf/P500764-53df32be-ca46-471b-ad47-af737e5f0a5d.pdf',
    'English',
    'Indonesia',
    '',
    '',
    'Indonesia - EAST ASIA AND PACIFIC- P500764- Indonesia Supporting Health Transformation Project (I-SeHat) - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046697',
    'Disclosable Restructuring Paper - Agriculture Modernization Project - P158372',
    '2025-09-24',
    '',
    'Project Paper',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425035532879/pdf/P158372-fcd78130-7889-483f-90cc-5416d8679f44.pdf',
    'English',
    'Uzbekistan',
    '',
    '',
    'Disclosable Restructuring Paper - Agriculture Modernization Project - P158372'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046738',
    'Burkina Faso - WESTERN AND CENTRAL AFRICA- P178598- Burkina Faso Livestock Resilience and Competitiveness Project - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425052536886/pdf/P178598-0a15582b-8c57-400f-ad06-5cf95248fcb5.pdf',
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
    '40046927',
    'Rwanda - EASTERN AND SOUTHERN AFRICA- P507271- Ecosystem-Based Restoration Approach for Nyungwe-Ruhango Corridor Project - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425100033568/pdf/P507271-b0e6adf0-3a64-4c57-9331-9eb0adc407a4.pdf',
    'English',
    'Rwanda',
    '',
    '',
    'Rwanda - EASTERN AND SOUTHERN AFRICA- P507271- Ecosystem-Based Restoration Approach for Nyungwe-Ruhango Corridor Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046965',
    'Guinea-Bissau - WESTERN AND CENTRAL AFRICA- P176383- Guinea-Bissau Public Sector Strengthening Project II - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425112011123/pdf/P176383-ed44fd45-0c13-4870-9bc8-60cb6327cdba.pdf',
    'English',
    'Guinea-Bissau',
    '',
    '',
    'Guinea-Bissau - WESTERN AND CENTRAL AFRICA- P176383- Guinea-Bissau Public Sector Strengthening Project II - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046983',
    'Revised Hazardous/non-Hazardous Waste Management Plan Human Capital Protection Project (P506528)',
    '2025-09-24',
    '',
    'Environmental and Social Management Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425120066032/pdf/P506528-c7c091d9-cf56-42df-b57d-f4f54bd95fa8.pdf',
    'French',
    'Burkina Faso',
    '',
    '',
    'Revised Hazardous/non-Hazardous Waste Management Plan Human Capital Protection Project (P506528)'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40047009',
    'OECS Countries - LATIN AMERICA AND CARIBBEAN- P168539- OECS Regional Health Project - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425125579887/pdf/P168539-c35bf5cb-1fc9-46b4-be04-eb1c41d71759.pdf',
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
    '40047090',
    'Argentina - LATIN AMERICA AND CARIBBEAN- P179534- Strengthening the Digital Health Agenda in the Province of Buenos Aires - Procurement Plan',
    '2025-09-24',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425155015588/pdf/P179534-229e363a-971b-4f2f-be77-f73598e96100.pdf',
    'English',
    'Argentina',
    '',
    '',
    'Argentina - LATIN AMERICA AND CARIBBEAN- P179534- Strengthening the Digital Health Agenda in the Province of Buenos Aires - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046142',
    'Sri Lanka - SOUTH ASIA- P160005- Climate Resilience Multi-Phase Programmatic Approach - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225221526413/pdf/P160005-ce111366-d999-483c-8dd5-044657806df3.pdf',
    'English',
    'Sri Lanka',
    '',
    '',
    'Sri Lanka - SOUTH ASIA- P160005- Climate Resilience Multi-Phase Programmatic Approach - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046160',
    'Novel AI Technologies and the Future of Work in Malaysia',
    '2025-09-23',
    '',
    'Report',
    'Publications & Research',
    1,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325013010451/pdf/P181093-2e5b89c5-f3be-43b3-868c-8890b74bef21.pdf',
    'English',
    'Malaysia',
    '',
    '',
    'Novel AI Technologies and the Future of Work in Malaysia'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046208',
    'Serbia - EUROPE AND CENTRAL ASIA- P163673- Tax Administration Modernization Project - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325034015613/pdf/P163673-c0ae668b-2bcc-47d1-83d4-da46fa1b4f77.pdf',
    'English',
    'Serbia',
    '',
    '',
    'Serbia - EUROPE AND CENTRAL ASIA- P163673- Tax Administration Modernization Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046265',
    'Djibouti - MID EAST,NORTH AFRICA,AFG,PAK- P175483- Djibouti Skills Development for Employment Project - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325065013951/pdf/P175483-aaa49e3e-3890-4d14-8fe2-5c37055ed195.pdf',
    'English',
    'Djibouti',
    '',
    '',
    'Djibouti - MID EAST,NORTH AFRICA,AFG,PAK- P175483- Djibouti Skills Development for Employment Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046315',
    'Madagascar - EASTERN AND SOUTHERN AFRICA- P159756- Integrated Urban Development and Resilience Project for Greater Antananarivo - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325091535218/pdf/P159756-b010ca65-d987-4869-8e6a-687caefcdae2.pdf',
    'English',
    'Madagascar',
    '',
    '',
    'Madagascar - EASTERN AND SOUTHERN AFRICA- P159756- Integrated Urban Development and Resilience Project for Greater Antananarivo - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046332',
    'Disclosable Version of the ISR - Building Resilient Bridges - P174595 - Sequence No : 5',
    '2025-09-23',
    '',
    'Implementation Status and Results Report',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325095527566/pdf/P174595-6e1037a7-7c92-42dd-aa9d-e60091e94d14.pdf',
    'English',
    'Albania',
    '',
    '',
    'Disclosable Version of the ISR - Building Resilient Bridges - P174595 - Sequence No : 5'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046371',
    'Peru - LATIN AMERICA AND CARIBBEAN- P163023- Integrated Forest Landscape Management Project in Atalaya, Ucayali - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325113022671/pdf/P163023-c5b20f86-0d99-44ed-81ff-9876e6b68240.pdf',
    'English',
    'Peru',
    '',
    '',
    'Peru - LATIN AMERICA AND CARIBBEAN- P163023- Integrated Forest Landscape Management Project in Atalaya, Ucayali - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046397',
    'Western and Central Africa - WESTERN AND CENTRAL AFRICA- P162337- West Africa Coastal Areas Resilience Investment Project - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325120019780/pdf/P162337-26db7b03-172c-43c4-a918-78a0ed3d152b.pdf',
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
    '40046452',
    'Central African Republic - WESTERN AND CENTRAL AFRICA- P178699- Local Governance and Community Resilience Project - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325133017644/pdf/P178699-188a99b7-0e53-4858-b326-fc6210a71093.pdf',
    'English',
    'Central African Republic',
    '',
    '',
    'Central African Republic - WESTERN AND CENTRAL AFRICA- P178699- Local Governance and Community Resilience Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046463',
    'Appraisal Project Information Document (PID)',
    '2025-09-23',
    '',
    'Project Information Document',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325134517893/pdf/P511645-06e90cd6-e597-40fb-9e9b-38330cee8951.pdf',
    'English',
    'Brazil',
    '',
    '',
    'Appraisal Project Information Document (PID)'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046512',
    'Appraisal Environmental and Social Review Summary (ESRS) - Resilient Infrastructure for Regional Economic Development and Job Creation Phase 1 - Province of Neuquén - P508558',
    '2025-09-23',
    '',
    'Environmental and Social Review Summary',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325153010487/pdf/P508558-5460d58a-f3d9-4559-bb38-0068380939c0.pdf',
    'English',
    'Argentina',
    '',
    '',
    'Appraisal Environmental and Social Review Summary (ESRS) - Resilient Infrastructure for Regional Economic Development and Job Creation Phase 1 - Province of Neuquén - P508558'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046515',
    'Sudan - EASTERN AND SOUTHERN AFRICA- P181490- Sudan - Enhancing Community Resilience Project - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325160039417/pdf/P181490-f4a0dce0-c87c-427b-9fab-1a2e7578548c.pdf',
    'English',
    'Sudan',
    '',
    '',
    'Sudan - EASTERN AND SOUTHERN AFRICA- P181490- Sudan - Enhancing Community Resilience Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046942',
    'Official Documents- Amendment No. 222 to the Contribution Agreement with the Gates Foundation for TF069033.pdf',
    '2025-09-23',
    '',
    'Agreement',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425104030157/pdf/TF069033-c76dbacc-1c6c-4cf6-b67f-4838695f334e.pdf',
    'English',
    '',
    '',
    '',
    'Official Documents- Amendment No. 222 to the Contribution Agreement with the Gates Foundation for TF069033.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046212',
    'Disclosable Version of the ISR - Strengthening Senegal’s Fiscal Sustainability Program - P510613 - Sequence No : 1',
    '2025-09-23',
    '',
    'Implementation Status and Results Report',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325041028906/pdf/P510613-d02b7e68-f2fa-4696-9170-ffdfc7528c28.pdf',
    'English',
    'Senegal',
    '',
    '',
    'Disclosable Version of the ISR - Strengthening Senegal’s Fiscal Sustainability Program - P510613 - Sequence No : 1'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046224',
    'Madagascar - EASTERN AND SOUTHERN AFRICA- P174684- Economic Transformation for Inclusive Growth Project - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325051524289/pdf/P174684-988355e3-fbb0-48ac-8a5a-4bf065b9ad79.pdf',
    'English',
    'Madagascar',
    '',
    '',
    'Madagascar - EASTERN AND SOUTHERN AFRICA- P174684- Economic Transformation for Inclusive Growth Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046258',
    'Disclosable Version of the ISR - Benin Economic Governance for Service Delivery Program for Results - P176763 - Sequence No : 4',
    '2025-09-23',
    '',
    'Implementation Status and Results Report',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325063510323/pdf/P176763-2035557c-fe0f-4162-a072-04b417dfb137.pdf',
    'English',
    'Benin',
    '',
    '',
    'Disclosable Version of the ISR - Benin Economic Governance for Service Delivery Program for Results - P176763 - Sequence No : 4'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046263',
    'Concept Project Information Document (PID)',
    '2025-09-23',
    '',
    'Project Information Document',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325064520621/pdf/P512377-0bab5e83-e792-4fc2-b9d3-7354117cf82e.pdf',
    'English',
    'Nepal',
    '',
    '',
    'Concept Project Information Document (PID)'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046272',
    'Bosnia and Herzegovina - EUROPE AND CENTRAL ASIA- P180409- Geospatial Infrastructure and Valuation Enhancement Project (GIVE) - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325065534627/pdf/P180409-d40d48e4-1d95-4b48-8c84-9b4355ff6471.pdf',
    'English',
    'Bosnia and Herzegovina',
    '',
    '',
    'Bosnia and Herzegovina - EUROPE AND CENTRAL ASIA- P180409- Geospatial Infrastructure and Valuation Enhancement Project (GIVE) - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046327',
    'Ethiopia - EASTERN AND SOUTHERN AFRICA- P167794- One WASH?Consolidated Water Supply, Sanitation, and Hygiene Account Project (One WASH?CWA) - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325093531508/pdf/P167794-93e4487c-e6b5-4cad-9703-26a6b7a9a42c.pdf',
    'English',
    'Ethiopia',
    '',
    '',
    'Ethiopia - EASTERN AND SOUTHERN AFRICA- P167794- One WASH?Consolidated Water Supply, Sanitation, and Hygiene Account Project (One WASH?CWA) - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046336',
    'Western and Central Africa - WESTERN AND CENTRAL AFRICA- P172769- West Africa Food System Resilience Program (FSRP) - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325100514922/pdf/P172769-a5009d9f-bec9-43a6-9cac-f1139e2100b8.pdf',
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
    '40046395',
    'Maldives - SOUTH ASIA- P177240- Sustainable and Integrated Labor Services (SAILS) - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325115510836/pdf/P177240-7ff76189-3f24-497e-87b2-58f977db881b.pdf',
    'English',
    'Maldives',
    '',
    '',
    'Maldives - SOUTH ASIA- P177240- Sustainable and Integrated Labor Services (SAILS) - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046426',
    'Western and Central Africa - WESTERN AND CENTRAL AFRICA- P180085- Harmonizing and Improving Statistics in West and Central Africa - Series of Projects Two (HISWACA - SOP 2) - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325125097981/pdf/P180085-12a681e9-2d71-4d92-917c-237366bac55d.pdf',
    'English',
    'Western and Central Africa',
    '',
    '',
    'Western and Central Africa - WESTERN AND CENTRAL AFRICA- P180085- Harmonizing and Improving Statistics in West and Central Africa - Series of Projects Two (HISWACA - SOP 2) - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046511',
    'Stakeholder Engagement Plan (SEP) - Resilient Infrastructure for Regional Economic Development and Job Creation Phase 1 - Province of Neuquén - P508558',
    '2025-09-23',
    '',
    'Stakeholder Engagement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325153054239/pdf/P508558-1edc8e30-9116-4a65-974d-9086304ea90a.pdf',
    'English',
    'Argentina',
    '',
    '',
    'Stakeholder Engagement Plan (SEP) - Resilient Infrastructure for Regional Economic Development and Job Creation Phase 1 - Province of Neuquén - P508558'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046518',
    'P500561 - Draft Environmental and Social Systems Assessment (ESSA) - Women entrepreneurship development and access to finance',
    '2025-09-23',
    '',
    'Program-for-Results Environmental and Social Systems Assessment',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325161018923/pdf/P500561-ef690863-4138-44b6-86bd-835f7d8ca0fc.pdf',
    'English',
    'Benin',
    '',
    '',
    'P500561 - Draft Environmental and Social Systems Assessment (ESSA) - Women entrepreneurship development and access to finance'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046520',
    'Sao Tome and Principe - EASTERN AND SOUTHERN AFRICA- P180982- Coastal Resilience and Sustainable Tourism Project - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325164514435/pdf/P180982-055602d9-bbec-482e-9220-b96668a9ded4.pdf',
    'English',
    'Sao Tome and Principe',
    '',
    '',
    'Sao Tome and Principe - EASTERN AND SOUTHERN AFRICA- P180982- Coastal Resilience and Sustainable Tourism Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046138',
    'Disclosable Restructuring Paper - Benin - Stormwater Management and Urban Resilience Project - P167359',
    '2025-09-23',
    '',
    'Project Paper',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225203017338/pdf/P167359-2a030c59-f625-4810-9d5d-6ce04ba5129d.pdf',
    'English',
    'Benin',
    '',
    '',
    'Disclosable Restructuring Paper - Benin - Stormwater Management and Urban Resilience Project - P167359'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046140',
    'Disclosable Version of the ISR - Excellence in Learning in Liberia - P510448 - Sequence No : 1',
    '2025-09-23',
    '',
    'Implementation Status and Results Report',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225213048532/pdf/P510448-649ed815-0d77-4b0e-a592-2d1316af245d.pdf',
    'English',
    'Liberia',
    '',
    '',
    'Disclosable Version of the ISR - Excellence in Learning in Liberia - P510448 - Sequence No : 1'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046172',
    'Disclosable Restructuring Paper - MG ethanol clean cooking climate finance program - P154440',
    '2025-09-23',
    '',
    'Project Paper',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325021029858/pdf/P154440-a06a0096-532d-4884-98ed-5d83c76c33a6.pdf',
    'English',
    'Madagascar',
    '',
    '',
    'Disclosable Restructuring Paper - MG ethanol clean cooking climate finance program - P154440'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046202',
    'Disclosable Version of the ISR - Pacific Healthy Islands Transformation Project - P508550 - Sequence No : 1',
    '2025-09-23',
    '',
    'Implementation Status and Results Report',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325030514590/pdf/P508550-92065c8a-e60c-49e2-b175-f15381836c87.pdf',
    'English',
    'Pacific 1',
    '',
    '',
    'Disclosable Version of the ISR - Pacific Healthy Islands Transformation Project - P508550 - Sequence No : 1'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046231',
    'Gambia, The - WESTERN AND CENTRAL AFRICA- P179233- The Gambia Resilience, Inclusion, Skills, and Equity Project - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325054530475/pdf/P179233-56949bcd-8156-464f-8bac-79edeeb963ae.pdf',
    'English',
    'Gambia, The',
    '',
    '',
    'Gambia, The - WESTERN AND CENTRAL AFRICA- P179233- The Gambia Resilience, Inclusion, Skills, and Equity Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046240',
    'Central African Republic - WESTERN AND CENTRAL AFRICA- P176450- CAR - Emergency Infrastructure and Connectivity Recovery Project - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325060030525/pdf/P176450-abbd1855-2edd-4791-84e0-b7e57498680a.pdf',
    'English',
    'Central African Republic',
    '',
    '',
    'Central African Republic - WESTERN AND CENTRAL AFRICA- P176450- CAR - Emergency Infrastructure and Connectivity Recovery Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046295',
    'Appraisal Program Information Document (PID)',
    '2025-09-23',
    '',
    'Program Information Document',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325081518739/pdf/P510184-21f297f2-b043-4224-8fd3-4b4f80d05bb1.pdf',
    'English',
    'Philippines',
    '',
    '',
    'Appraisal Program Information Document (PID)'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046405',
    'Uruguay - LATIN AMERICA AND CARIBBEAN- P180638- Institutional Strengthening for Greater Competitiveness in Uruguay - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325121032242/pdf/P180638-66812344-8464-4f85-b0ab-a4a17ea230f7.pdf',
    'English',
    'Uruguay',
    '',
    '',
    'Uruguay - LATIN AMERICA AND CARIBBEAN- P180638- Institutional Strengthening for Greater Competitiveness in Uruguay - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046970',
    'Official Documents- Amendment No. 7 to the Administration Arrangement with Ireland, acting through its Department of Foreign Affairs and Trade, for TF073570.pdf',
    '2025-09-23',
    '',
    'Agreement',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425114044493/pdf/TF073570-74890be0-d225-42bd-9cbb-d00ae0160517.pdf',
    'English',
    '',
    '',
    '',
    'Official Documents- Amendment No. 7 to the Administration Arrangement with Ireland, acting through its Department of Foreign Affairs and Trade, for TF073570.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046147',
    'Ethiopia - EASTERN AND SOUTHERN AFRICA - P000755 - ET ROAD SEC. DEV. PROG - Audited Financial Statement',
    '2025-09-23',
    '',
    'Auditing Document',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225235533475/pdf/P000755-60835a9d-e52b-4769-9c24-39a682c944cb.pdf',
    'English',
    '',
    '',
    '',
    'Ethiopia - EASTERN AND SOUTHERN AFRICA - P000755 - ET ROAD SEC. DEV. PROG - Audited Financial Statement'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046169',
    'Tajikistan - EUROPE AND CENTRAL ASIA- P163734- Dushanbe Water Supply and Wastewater Project - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325015538695/pdf/P163734-931b0b39-25a9-4bfc-87c4-83524396a1b7.pdf',
    'English',
    'Tajikistan',
    '',
    '',
    'Tajikistan - EUROPE AND CENTRAL ASIA- P163734- Dushanbe Water Supply and Wastewater Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046206',
    'Tunisia - MID EAST,NORTH AFRICA,AFG,PAK- P179010- Tunisia Emergency Food Security Response Project - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325033026998/pdf/P179010-86f058f2-5622-4c50-885b-a9cc12d234bc.pdf',
    'English',
    'Tunisia',
    '',
    '',
    'Tunisia - MID EAST,NORTH AFRICA,AFG,PAK- P179010- Tunisia Emergency Food Security Response Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046278',
    'Colombia - LATIN AMERICA AND CARIBBEAN- P144271- Forest Conservation and Sustainability in the Heart of the Colombian Amazon - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325070538812/pdf/P144271-c1839584-0c28-4c95-a6d3-7b6718127cb0.pdf',
    'English',
    'Colombia',
    '',
    '',
    'Colombia - LATIN AMERICA AND CARIBBEAN- P144271- Forest Conservation and Sustainability in the Heart of the Colombian Amazon - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046291',
    'Congo, Democratic Republic of - EASTERN AND SOUTHERN AFRICA- P172341- DR Congo Emergency Equity and System Strengthening in Education - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325080020707/pdf/P172341-de87e197-f786-48c2-a836-0885457fcd78.pdf',
    'English',
    'Congo, Democratic Republic of',
    '',
    '',
    'Congo, Democratic Republic of - EASTERN AND SOUTHERN AFRICA- P172341- DR Congo Emergency Equity and System Strengthening in Education - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046302',
    'Malawi - EASTERN AND SOUTHERN AFRICA- P502464- Accelerating Sustainable and Clean Energy Access Transformation in Malawi - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325090021699/pdf/P502464-ed8c67cb-7429-49ff-9ff9-cddc92bde8df.pdf',
    'English',
    'Malawi',
    '',
    '',
    'Malawi - EASTERN AND SOUTHERN AFRICA- P502464- Accelerating Sustainable and Clean Energy Access Transformation in Malawi - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046382',
    'Nigeria - WESTERN AND CENTRAL AFRICA- P167156- Nigeria: Improved Child Survival Program for Human Capital?MPA - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325114515625/pdf/P167156-26f0a114-95ac-477e-afa2-87c1349f4c42.pdf',
    'English',
    'Nigeria',
    '',
    '',
    'Nigeria - WESTERN AND CENTRAL AFRICA- P167156- Nigeria: Improved Child Survival Program for Human Capital?MPA - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046407',
    'Nigeria - WESTERN AND CENTRAL AFRICA- P167156- Nigeria: Improved Child Survival Program for Human Capital?MPA - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325121013170/pdf/P167156-83af1f81-2ade-4e00-b095-33bcedacf658.pdf',
    'English',
    'Nigeria',
    '',
    '',
    'Nigeria - WESTERN AND CENTRAL AFRICA- P167156- Nigeria: Improved Child Survival Program for Human Capital?MPA - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046497',
    'Disclosable Version of the ISR - Angola Strengthening Governance for Enhanced Service Delivery Project - P178040 - Sequence No : 5',
    '2025-09-23',
    '',
    'Implementation Status and Results Report',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325144029266/pdf/P178040-5dc3e82e-e887-43ce-85f5-d6708379c1c2.pdf',
    'English',
    'Angola',
    '',
    '',
    'Disclosable Version of the ISR - Angola Strengthening Governance for Enhanced Service Delivery Project - P178040 - Sequence No : 5'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046507',
    'Ukraine - EUROPE AND CENTRAL ASIA- P180245- Health Enhancement And Lifesaving (HEAL) Ukraine Project - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325150546458/pdf/P180245-8b39ea29-9345-42d8-b4de-f7496e3bc93b.pdf',
    'English',
    'Ukraine',
    '',
    '',
    'Ukraine - EUROPE AND CENTRAL ASIA- P180245- Health Enhancement And Lifesaving (HEAL) Ukraine Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046522',
    'Caribbean - LATIN AMERICA AND CARIBBEAN- P171833- Unleashing the Blue Economy of the Caribbean (UBEC) - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325171533128/pdf/P171833-dda714c4-95f1-408d-ba2e-21c2041bd148.pdf',
    'English',
    'Caribbean',
    '',
    '',
    'Caribbean - LATIN AMERICA AND CARIBBEAN- P171833- Unleashing the Blue Economy of the Caribbean (UBEC) - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046148',
    'India - SOUTH ASIA- P180634- Sikkim: Integrated Service Provision and Innovation for Reviving Economies Operation - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325004015552/pdf/P180634-028ff612-7ba4-4057-958d-b9dcb695d25a.pdf',
    'English',
    'India',
    '',
    '',
    'India - SOUTH ASIA- P180634- Sikkim: Integrated Service Provision and Innovation for Reviving Economies Operation - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046229',
    '- - P162263- - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325053012291/pdf/P162263-accf6856-9b0e-4951-8443-3b72103a2564.pdf',
    'English',
    'Uzbekistan',
    '',
    '',
    '- - P162263- - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046262',
    'Nepal - SOUTH ASIA- P180665- Institutionalizing GBV Response in Nepal - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325064097717/pdf/P180665-8b91f9b0-5cf2-461c-8e07-8ae37514a05e.pdf',
    'English',
    'Nepal',
    '',
    '',
    'Nepal - SOUTH ASIA- P180665- Institutionalizing GBV Response in Nepal - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046288',
    'India - SOUTH ASIA- P174593- Assam Integrated River Basin Management Program - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325074032364/pdf/P174593-087e9b8b-ef0b-45d4-8ee9-0c05c1e4767f.pdf',
    'English',
    'India',
    '',
    '',
    'India - SOUTH ASIA- P174593- Assam Integrated River Basin Management Program - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046333',
    'Official Documents- Amendment No. 13 to the Administration Arrangement with the United Kingdom of Great Britain and Northern Ireland, acting through the Foreign, Commonwealth and Development Office (FCDO), for TF072858.pdf',
    '2025-09-23',
    '',
    'Agreement',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325095539509/pdf/TF072858-da9becad-ba4b-41cd-a5a4-fcf247e2cfbd.pdf',
    'English',
    '',
    '',
    '',
    'Official Documents- Amendment No. 13 to the Administration Arrangement with the United Kingdom of Great Britain and Northern Ireland, acting through the Foreign, Commonwealth and Development Office (FCDO), for TF072858.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046462',
    'World - OTHER- P170861- Phase 2 for DGM Program and Global Learning and Knowledge Exchange Project - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325134020511/pdf/P170861-bd272fbd-b11f-4f14-b131-18efc2fba633.pdf',
    'English',
    'World',
    '',
    '',
    'World - OTHER- P170861- Phase 2 for DGM Program and Global Learning and Knowledge Exchange Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046465',
    'El Salvador - LATIN AMERICA AND CARIBBEAN- P169677- Growing up Healthy Together: Comprehensive Early Childhood Development in El Salvador - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325140032115/pdf/P169677-dc6c3c40-cb5e-4319-96d8-d79e053aacc1.pdf',
    'English',
    'El Salvador',
    '',
    '',
    'El Salvador - LATIN AMERICA AND CARIBBEAN- P169677- Growing up Healthy Together: Comprehensive Early Childhood Development in El Salvador - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046530',
    'IP/SSAHUTLC Plan Climate-Resilient and Inclusive Livelihoods Project (ProClimat Congo) (P177786)',
    '2025-09-23',
    '',
    'Environmental and Social Management Plan; Indigenous Peoples Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325185525522/pdf/P177786-dd0f6593-3ae0-41ae-94b8-fa77dad31048.pdf',
    'French',
    'Congo, Republic of',
    '',
    '',
    'IP/SSAHUTLC Plan Climate-Resilient and Inclusive Livelihoods Project (ProClimat Congo) (P177786)'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046930',
    'Lao People s Democratic Republic - EAST ASIA AND PACIFIC - P170640 - Public Information and Awareness Services for Vulnerable Communities in Lao PDR - Audited Financial Statement',
    '2025-09-23',
    '',
    'Auditing Document',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425101056548/pdf/P170640-cb0338ce-d409-4286-8034-2cce7d673f63.pdf',
    'English',
    'Lao People''s Democratic Republic',
    '',
    '',
    'Lao People s Democratic Republic - EAST ASIA AND PACIFIC - P170640 - Public Information and Awareness Services for Vulnerable Communities in Lao PDR - Audited Financial Statement'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046136',
    'Disclosable Version of the ISR - Health Enhancement and Resiliency in Tonga Project - P180965 - Sequence No : 2',
    '2025-09-23',
    '',
    'Implementation Status and Results Report',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225202034884/pdf/P180965-e957ff99-8de1-4562-b0ff-20d505ffa42d.pdf',
    'English',
    'Tonga',
    '',
    '',
    'Disclosable Version of the ISR - Health Enhancement and Resiliency in Tonga Project - P180965 - Sequence No : 2'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046237',
    'Rwanda - EASTERN AND SOUTHERN AFRICA- P180575- Rwanda - Accelerating Sustainable and Clean Energy Access Transformation in AFE MPA (ASCENT - Rwanda)) - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325060027340/pdf/P180575-7acdb01b-6d0c-44f6-b987-e866a3e3a384.pdf',
    'English',
    'Rwanda',
    '',
    '',
    'Rwanda - EASTERN AND SOUTHERN AFRICA- P180575- Rwanda - Accelerating Sustainable and Clean Energy Access Transformation in AFE MPA (ASCENT - Rwanda)) - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046267',
    'Ethiopia - EASTERN AND SOUTHERN AFRICA- P167794- One WASH?Consolidated Water Supply, Sanitation, and Hygiene Account Project (One WASH?CWA) - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325065024865/pdf/P167794-77283df2-b8d7-4756-bddb-c91171dd8c38.pdf',
    'English',
    'Ethiopia',
    '',
    '',
    'Ethiopia - EASTERN AND SOUTHERN AFRICA- P167794- One WASH?Consolidated Water Supply, Sanitation, and Hygiene Account Project (One WASH?CWA) - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046293',
    'Gender Gaps in the Performance of Small Firms : Evidence from Urban Peru',
    '2025-09-23',
    '',
    'Policy Research Working Paper',
    'Publications & Research',
    1,
    NULL,
    'https://documents.worldbank.org/curated/en/099210109232549830/pdf/IDU-b41fb633-a2a1-42ec-bc7e-d7555bb359f2.pdf',
    'English',
    'Peru',
    '',
    '',
    'Gender Gaps in the Performance of Small Firms : Evidence from Urban Peru'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046309',
    'Nigeria - WESTERN AND CENTRAL AFRICA- P179447- Nigeria for Women Program Scale Up Project - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325091117009/pdf/P179447-4dbf8c5c-84e6-43c8-8858-46191cf59e53.pdf',
    'English',
    'Nigeria',
    '',
    '',
    'Nigeria - WESTERN AND CENTRAL AFRICA- P179447- Nigeria for Women Program Scale Up Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046369',
    'Mozambique - EASTERN AND SOUTHERN AFRICA- P174002- Sustainable Rural Economy Program - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325112039789/pdf/P174002-ddff2652-0f9d-4b7f-a68d-f5fd7efb20cb.pdf',
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
    '40046372',
    'Lebanon - MID EAST,NORTH AFRICA,AFG,PAK- P509428- Lebanon Emergency Assistance Project - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325113021010/pdf/P509428-0fd29ca4-40c0-4950-83a7-5d5a4a805e23.pdf',
    'English',
    'Lebanon',
    '',
    '',
    'Lebanon - MID EAST,NORTH AFRICA,AFG,PAK- P509428- Lebanon Emergency Assistance Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046424',
    'Namibia - EASTERN AND SOUTHERN AFRICA- P177328- Transmission Expansion and Energy Storage Project - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325123031979/pdf/P177328-973bad0d-0ae4-4492-9ef8-a8fc307d14f6.pdf',
    'English',
    'Namibia',
    '',
    '',
    'Namibia - EASTERN AND SOUTHERN AFRICA- P177328- Transmission Expansion and Energy Storage Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046455',
    'Honduras - LATIN AMERICA AND CARIBBEAN- P181166- Honduras Sustainable Connectivity Project - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325133022850/pdf/P181166-c8ea693e-7d79-48a9-a80d-0542e6e4e850.pdf',
    'English',
    'Honduras',
    '',
    '',
    'Honduras - LATIN AMERICA AND CARIBBEAN- P181166- Honduras Sustainable Connectivity Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046464',
    'Haiti - LATIN AMERICA AND CARIBBEAN- P504222- Resilient Productive Landscapes II - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325135011879/pdf/P504222-712cb867-257b-4c7f-9bfb-063b2c9f9799.pdf',
    'English',
    'Haiti',
    '',
    '',
    'Haiti - LATIN AMERICA AND CARIBBEAN- P504222- Resilient Productive Landscapes II - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046493',
    'Suriname - LATIN AMERICA AND CARIBBEAN - P165973 - Saramacca Canal System Rehabilitation Project - Audited Financial Statement',
    '2025-09-23',
    '',
    'Auditing Document',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325143519171/pdf/P165973-4199900d-91e7-451a-8a5e-fd0b083faf36.pdf',
    'English',
    'Suriname',
    '',
    '',
    'Suriname - LATIN AMERICA AND CARIBBEAN - P165973 - Saramacca Canal System Rehabilitation Project - Audited Financial Statement'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046146',
    'China - EAST ASIA AND PACIFIC- P168061- HUBEI SMART AND SUSTAINABLE AGRICULTURE PROJECT - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225235016999/pdf/P168061-58eb73c0-e778-4edc-9024-fada25ae3737.pdf',
    'English',
    'China',
    '',
    '',
    'China - EAST ASIA AND PACIFIC- P168061- HUBEI SMART AND SUSTAINABLE AGRICULTURE PROJECT - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046214',
    'Pakistan - MID EAST,NORTH AFRICA,AFG,PAK- P180707- Khyber Pakhtunkhwa Citizen-Centered Service Delivery Project - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325041518591/pdf/P180707-2b8a76ab-6457-4709-bdc3-a4813db78384.pdf',
    'English',
    'Pakistan',
    '',
    '',
    'Pakistan - MID EAST,NORTH AFRICA,AFG,PAK- P180707- Khyber Pakhtunkhwa Citizen-Centered Service Delivery Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046230',
    'Ethiopia - EASTERN AND SOUTHERN AFRICA- P178808- Governance Modernization to Enable Efficient Service Delivery Project - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325054063185/pdf/P178808-510159af-3833-4cef-ac1c-60ea96723e80.pdf',
    'English',
    'Ethiopia',
    '',
    '',
    'Ethiopia - EASTERN AND SOUTHERN AFRICA- P178808- Governance Modernization to Enable Efficient Service Delivery Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046243',
    'Nigeria - WESTERN AND CENTRAL AFRICA- P176935- National Social Safety Net Program-Scale Up - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325060519374/pdf/P176935-73af7a0c-5f2c-4345-ab77-7fd5cb8e1954.pdf',
    'English',
    'Nigeria',
    '',
    '',
    'Nigeria - WESTERN AND CENTRAL AFRICA- P176935- National Social Safety Net Program-Scale Up - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046303',
    'Albania - EUROPE AND CENTRAL ASIA- P177845- Improving Equitable Access To High Standard Public Services Through Govtech - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325090531376/pdf/P177845-efc8d221-ae6b-4b6c-b400-269d0a17f64c.pdf',
    'English',
    'Albania',
    '',
    '',
    'Albania - EUROPE AND CENTRAL ASIA- P177845- Improving Equitable Access To High Standard Public Services Through Govtech - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046328',
    'Armenia - EUROPE AND CENTRAL ASIA- P179988- RESILAND: Armenia Resilient Landscapes Project - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325094056851/pdf/P179988-122e918a-88d3-4e00-b124-579fdeabc054.pdf',
    'English',
    'Armenia',
    '',
    '',
    'Armenia - EUROPE AND CENTRAL ASIA- P179988- RESILAND: Armenia Resilient Landscapes Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046346',
    'Mauritania - WESTERN AND CENTRAL AFRICA- P179383- Development of Energy Resources and Mining Sector Support Phase 1 Project - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325104032249/pdf/P179383-3812144d-64c6-4596-b6fb-93038f0aac92.pdf',
    'English',
    'Mauritania',
    '',
    '',
    'Mauritania - WESTERN AND CENTRAL AFRICA- P179383- Development of Energy Resources and Mining Sector Support Phase 1 Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046361',
    'South Sudan - EASTERN AND SOUTHERN AFRICA- P176761- Public Financial Management and Institutional Strengthening Project - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325110515757/pdf/P176761-9f169378-13f2-438f-a95f-ac7b3197fcd1.pdf',
    'English',
    'South Sudan',
    '',
    '',
    'South Sudan - EASTERN AND SOUTHERN AFRICA- P176761- Public Financial Management and Institutional Strengthening Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046388',
    'Violence Against Women and Girls Resource Guide : Energy Guide',
    '2025-09-23',
    '',
    'ESMAP Paper',
    'Publications & Research',
    1,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325115041707/pdf/P506599-764a5758-c15e-4828-b613-8f1875054cfb.pdf',
    'English',
    'World',
    '',
    '',
    'Violence Against Women and Girls Resource Guide : Energy Guide'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046429',
    'Haiti - LATIN AMERICA AND CARIBBEAN- P180384- Haiti Strengthening Public Financial Management Project - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325130098907/pdf/P180384-8329a1f8-9fa0-4482-96de-662c681b1342.pdf',
    'English',
    'Haiti',
    '',
    '',
    'Haiti - LATIN AMERICA AND CARIBBEAN- P180384- Haiti Strengthening Public Financial Management Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046139',
    'China - EAST ASIA AND PACIFIC- P158622- Hezhou Urban Water Infrastructure and Environment Improvement Project - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225211577191/pdf/P158622-e33ab111-ad58-4e5a-b44c-2df641723a67.pdf',
    'English',
    'China',
    '',
    '',
    'China - EAST ASIA AND PACIFIC- P158622- Hezhou Urban Water Infrastructure and Environment Improvement Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046144',
    'Viet Nam - EAST ASIA AND PACIFIC- P166656- Vietnam University Development of VNU-Hanoi, VNU-HCM, and UD - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225231540069/pdf/P166656-70b63fe9-8f29-461b-b318-f255fdcbe564.pdf',
    'English',
    'Viet Nam',
    '',
    '',
    'Viet Nam - EAST ASIA AND PACIFIC- P166656- Vietnam University Development of VNU-Hanoi, VNU-HCM, and UD - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046271',
    'Mozambique - EASTERN AND SOUTHERN AFRICA- P175266- Mozambique Northern Urban Development Project - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325065522434/pdf/P175266-5252be38-33fe-4575-b7ce-1355a4c8fdc8.pdf',
    'English',
    'Mozambique',
    '',
    '',
    'Mozambique - EASTERN AND SOUTHERN AFRICA- P175266- Mozambique Northern Urban Development Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046285',
    'Western and Central Africa - WESTERN AND CENTRAL AFRICA- P167798- Cameroon-Chad Transport Corridor - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325072013385/pdf/P167798-436e24f1-69b6-42fb-8d6a-18132e144c94.pdf',
    'English',
    'Western and Central Africa',
    '',
    '',
    'Western and Central Africa - WESTERN AND CENTRAL AFRICA- P167798- Cameroon-Chad Transport Corridor - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046299',
    'Dominican Republic - LATIN AMERICA AND CARIBBEAN- P180349- Program to Support the Strengthening of the National Health System - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325085582524/pdf/P180349-c53326eb-a48b-456e-8c90-ecc589b4d3f4.pdf',
    'English',
    'Dominican Republic',
    '',
    '',
    'Dominican Republic - LATIN AMERICA AND CARIBBEAN- P180349- Program to Support the Strengthening of the National Health System - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046370',
    'Bangladesh - SOUTH ASIA- P171144- Urban Health, Nutrition and Population Project - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325112528632/pdf/P171144-b315f818-59fa-49f2-8c26-4b467b4b7bd9.pdf',
    'English',
    'Bangladesh',
    '',
    '',
    'Bangladesh - SOUTH ASIA- P171144- Urban Health, Nutrition and Population Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046387',
    'Disclosable Version of the ISR - Green National Highways Corridor Project - P167350 - Sequence No : 13',
    '2025-09-23',
    '',
    'Implementation Status and Results Report',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325115010598/pdf/P167350-8b59a6ac-acee-49c3-8b05-2e0ef5e43b0c.pdf',
    'English',
    'India',
    '',
    '',
    'Disclosable Version of the ISR - Green National Highways Corridor Project - P167350 - Sequence No : 13'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '',
    '',
    NULL,
    '',
    '',
    '',
    NULL,
    NULL,
    '',
    '',
    '',
    '',
    '',
    ''
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046404',
    'Colombia - LATIN AMERICA AND CARIBBEAN- P162594- Multipurpose Cadaster Project - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325120541548/pdf/P162594-3a95b0eb-dd31-41dc-88d2-e431b6e49052.pdf',
    'English',
    'Colombia',
    '',
    '',
    'Colombia - LATIN AMERICA AND CARIBBEAN- P162594- Multipurpose Cadaster Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046425',
    'Caribbean - LATIN AMERICA AND CARIBBEAN- P171528- Caribbean Digital Transformation Project - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325124538679/pdf/P171528-5338b92c-61fa-4864-b1ee-0b4a7dbdf8e5.pdf',
    'English',
    'Caribbean',
    '',
    '',
    'Caribbean - LATIN AMERICA AND CARIBBEAN- P171528- Caribbean Digital Transformation Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046438',
    'Honduras - LATIN AMERICA AND CARIBBEAN- P152057- Social Protection Integration Project - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325131085109/pdf/P152057-801f4bb0-ad7e-4d11-a58d-33e9726b950a.pdf',
    'English',
    'Honduras',
    '',
    '',
    'Honduras - LATIN AMERICA AND CARIBBEAN- P152057- Social Protection Integration Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046159',
    'Madagascar - EASTERN AND SOUTHERN AFRICA- P175269- Rural Livelihoods Productivity and Resilience Project - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325011028382/pdf/P175269-8c8e704c-e06d-45f5-9e8d-294d2b4b7ef4.pdf',
    'English',
    'Madagascar',
    '',
    '',
    'Madagascar - EASTERN AND SOUTHERN AFRICA- P175269- Rural Livelihoods Productivity and Resilience Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046166',
    'Disclosable Version of the ISR - Second Kenya Urban Support Program - P177048 - Sequence No : 6',
    '2025-09-23',
    '',
    'Implementation Status and Results Report',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325015020156/pdf/P177048-1f873883-a664-4816-8750-9c3f129cf716.pdf',
    'English',
    'Kenya',
    '',
    '',
    'Disclosable Version of the ISR - Second Kenya Urban Support Program - P177048 - Sequence No : 6'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046253',
    'Nigeria - WESTERN AND CENTRAL AFRICA- P179447- Nigeria for Women Program Scale Up Project - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325061510945/pdf/P179447-974803cc-9ed7-4477-ab55-a49eb7c75f22.pdf',
    'English',
    'Nigeria',
    '',
    '',
    'Nigeria - WESTERN AND CENTRAL AFRICA- P179447- Nigeria for Women Program Scale Up Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046399',
    'Gabon - WESTERN AND CENTRAL AFRICA- P132824- eGabon - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325120541607/pdf/P132824-0843bd3b-f668-416d-9cb9-ff8b4bcf04ce.pdf',
    'English',
    'Gabon',
    '',
    '',
    'Gabon - WESTERN AND CENTRAL AFRICA- P132824- eGabon - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046401',
    'Revised Environmental and Social Commitment Plan (ESCP) Productive Social Safety Net III Project (P508191)',
    '2025-09-23',
    '',
    'Environmental and Social Commitment Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325120589707/pdf/P508191-b724d48d-5d5a-401e-a2b4-e20323a041c0.pdf',
    'English',
    'Tanzania',
    '',
    '',
    'Revised Environmental and Social Commitment Plan (ESCP) Productive Social Safety Net III Project (P508191)'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046500',
    'Official Documents- Amendment No. 2 to the Administration Agreement with the Shell International Exploration and Production, B.V. for TF074035.pdf',
    '2025-09-23',
    '',
    'Agreement',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325144024613/pdf/TF074035-8f073e8c-f06e-4dc7-966c-68ffca97747e.pdf',
    'English',
    '',
    '',
    '',
    'Official Documents- Amendment No. 2 to the Administration Agreement with the Shell International Exploration and Production, B.V. for TF074035.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046510',
    'Environmental and Social Commitment Plan (ESCP) - Resilient Infrastructure for Regional Economic Development and Job Creation Phase 1 - Province of Neuquén - P508558',
    '2025-09-23',
    '',
    'Environmental and Social Commitment Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325153022546/pdf/P508558-7762b7e4-f1b3-43b5-a3b8-a200b1d0dac5.pdf',
    'English',
    'Argentina',
    '',
    '',
    'Environmental and Social Commitment Plan (ESCP) - Resilient Infrastructure for Regional Economic Development and Job Creation Phase 1 - Province of Neuquén - P508558'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046519',
    'St Maarten - LATIN AMERICA AND CARIBBEAN- P179067- SINT MAARTEN: WASTEWATER MANAGEMENT PROJECT - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325161034258/pdf/P179067-ae05de86-7ad0-4f32-9c77-60fe1768577a.pdf',
    'English',
    'St Maarten',
    '',
    '',
    'St Maarten - LATIN AMERICA AND CARIBBEAN- P179067- SINT MAARTEN: WASTEWATER MANAGEMENT PROJECT - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046521',
    'Eastern and Southern Africa - EASTERN AND SOUTHERN AFRICA- P177816- Food Systems Resilience Program for Eastern and Southern Africa (Phase 3) FSRP - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325170015155/pdf/P177816-8aab9c50-7263-4994-baed-e5dbbaed6b64.pdf',
    'English',
    'Eastern and Southern Africa',
    '',
    '',
    'Eastern and Southern Africa - EASTERN AND SOUTHERN AFRICA- P177816- Food Systems Resilience Program for Eastern and Southern Africa (Phase 3) FSRP - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046143',
    'Indonesia - EAST ASIA AND PACIFIC- P173671- Indonesia: National Urban Flood Resilience Project (NUFReP) - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225230022107/pdf/P173671-fce8f677-0640-425b-9aad-f4dbd3440992.pdf',
    'English',
    'Indonesia',
    '',
    '',
    'Indonesia - EAST ASIA AND PACIFIC- P173671- Indonesia: National Urban Flood Resilience Project (NUFReP) - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046163',
    'Disclosable Version of the ISR - Madagascar Road Sector Sustainability Project - P176811 - Sequence No : 9',
    '2025-09-23',
    '',
    'Implementation Status and Results Report',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325014521149/pdf/P176811-f4cbe003-d27c-4739-aded-32cb3470581d.pdf',
    'English',
    'Madagascar',
    '',
    '',
    'Disclosable Version of the ISR - Madagascar Road Sector Sustainability Project - P176811 - Sequence No : 9'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046193',
    'Revised Labor Management Procedures Sustainable Fisheries Development Project (P512407)',
    '2025-09-23',
    '',
    'Procedure and Checklist',
    'Publications & Research',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325025535123/pdf/P512407-6ea1b756-cfbc-467d-9522-49be1f144ed3.pdf',
    'English',
    'Viet Nam',
    '',
    '',
    'Revised Labor Management Procedures Sustainable Fisheries Development Project (P512407)'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046196',
    'Revised Labor Management Procedures Sustainable Fisheries Development Project (P512407)',
    '2025-09-23',
    '',
    'Procedure and Checklist',
    'Publications & Research',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325030018252/pdf/P512407-3089b6b6-1182-49f4-9528-ab29a7c17195.pdf',
    'English',
    'Viet Nam',
    '',
    '',
    'Revised Labor Management Procedures Sustainable Fisheries Development Project (P512407)'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046292',
    'Papua New Guinea - EAST ASIA AND PACIFIC- P166222- PNG Agriculture Commercialization and Diversification Project - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325081032845/pdf/P166222-2408735c-84b9-4a3f-ac8d-21972c8121e7.pdf',
    'English',
    'Papua New Guinea',
    '',
    '',
    'Papua New Guinea - EAST ASIA AND PACIFIC- P166222- PNG Agriculture Commercialization and Diversification Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046365',
    'South Sudan - EASTERN AND SOUTHERN AFRICA- P177663- South Sudan Productive Safety Net for Socioeconomic Opportunities Project - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325111021801/pdf/P177663-f060c364-9296-4708-a6c0-192b3d33b0ef.pdf',
    'English',
    'South Sudan',
    '',
    '',
    'South Sudan - EASTERN AND SOUTHERN AFRICA- P177663- South Sudan Productive Safety Net for Socioeconomic Opportunities Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046528',
    'Peru - LATIN AMERICA AND CARIBBEAN- P162278- National Urban Cadaster and Municipal Support Project - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325182024063/pdf/P162278-c630f8bc-b6ea-406e-918e-15d9e703e99a.pdf',
    'English',
    'Peru',
    '',
    '',
    'Peru - LATIN AMERICA AND CARIBBEAN- P162278- National Urban Cadaster and Municipal Support Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046235',
    'Environmental and Social Management Plan (ESMP) Kyrgyz Republic Contingent Emergency Response Project (P509818)',
    '2025-09-23',
    '',
    'Environmental and Social Management Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325055532391/pdf/P509818-6d8e8fbd-0b07-4fa9-bad0-8ad18471d944.pdf',
    'English',
    'Kyrgyz Republic',
    '',
    '',
    'Environmental and Social Management Plan (ESMP) Kyrgyz Republic Contingent Emergency Response Project (P509818)'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046264',
    'Turkiye - EUROPE AND CENTRAL ASIA- P171645- Turkey Organized Industrial Zones Project - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325064541298/pdf/P171645-f83236db-83b1-425a-916e-5a021e170a1e.pdf',
    'English',
    'Turkiye',
    '',
    '',
    'Turkiye - EUROPE AND CENTRAL ASIA- P171645- Turkey Organized Industrial Zones Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046286',
    'Tajikistan - EUROPE AND CENTRAL ASIA- P175952- Strengthening Resilience of the Agriculture Sector Project - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325073034599/pdf/P175952-2cda49cd-b4fb-40b6-a5e5-cea5544a08a1.pdf',
    'English',
    'Tajikistan',
    '',
    '',
    'Tajikistan - EUROPE AND CENTRAL ASIA- P175952- Strengthening Resilience of the Agriculture Sector Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046290',
    'Angola - EASTERN AND SOUTHERN AFRICA- P178040- Angola Strengthening Governance for Enhanced Service Delivery Project - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325075031520/pdf/P178040-603ae5cf-347b-4da7-be9e-34a6a84af44d.pdf',
    'English',
    'Angola',
    '',
    '',
    'Angola - EASTERN AND SOUTHERN AFRICA- P178040- Angola Strengthening Governance for Enhanced Service Delivery Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046300',
    'Geopolitical Risks and Trade',
    '2025-09-23',
    '',
    'Policy Research Working Paper',
    'Publications & Research',
    1,
    NULL,
    'https://documents.worldbank.org/curated/en/099257009232525631/pdf/IDU-6a52e81b-22d9-4e0c-b520-931c26858b54.pdf',
    'English',
    'World',
    '',
    '',
    'Geopolitical Risks and Trade'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046314',
    'Burundi - EASTERN AND SOUTHERN AFRICA- P181494- Accelerating Sustainable and Clean Energy Access Transformation in Burundi (ASCENT Burundi) - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325091525719/pdf/P181494-c2f7b09a-346f-497f-889e-d6e20de1337e.pdf',
    'English',
    'Burundi',
    '',
    '',
    'Burundi - EASTERN AND SOUTHERN AFRICA- P181494- Accelerating Sustainable and Clean Energy Access Transformation in Burundi (ASCENT Burundi) - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046326',
    'Ethiopia - EASTERN AND SOUTHERN AFRICA- P167794- One WASH?Consolidated Water Supply, Sanitation, and Hygiene Account Project (One WASH?CWA) - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325093518240/pdf/P167794-684d269b-1aab-4961-b69c-56e8902cee29.pdf',
    'English',
    'Ethiopia',
    '',
    '',
    'Ethiopia - EASTERN AND SOUTHERN AFRICA- P167794- One WASH?Consolidated Water Supply, Sanitation, and Hygiene Account Project (One WASH?CWA) - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046329',
    'Panama - LATIN AMERICA AND CARIBBEAN- P157575- Support for the National Indigenous Peoples Development Plan - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325095049267/pdf/P157575-8e50e685-c16d-46de-9800-490e3fbbba3e.pdf',
    'English',
    'Panama',
    '',
    '',
    'Panama - LATIN AMERICA AND CARIBBEAN- P157575- Support for the National Indigenous Peoples Development Plan - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046506',
    'Disclosable Version of the ISR - JAMAICA: SOCIAL PROTECTION FOR INCREASED RESILIENCE AND OPPORTUNITY (SPIRO) - P178582 - Sequence No : 3',
    '2025-09-23',
    '',
    'Implementation Status and Results Report',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325145525948/pdf/P178582-a2c1b917-8448-4a7a-8aa1-ef4206d6dea6.pdf',
    'English',
    'Jamaica',
    '',
    '',
    'Disclosable Version of the ISR - JAMAICA: SOCIAL PROTECTION FOR INCREASED RESILIENCE AND OPPORTUNITY (SPIRO) - P178582 - Sequence No : 3'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046513',
    'Gabon - WESTERN AND CENTRAL AFRICA- P175987- Digital Gabon Project - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325155015981/pdf/P175987-b0482b53-0e17-4096-971a-548402bda131.pdf',
    'English',
    'Gabon',
    '',
    '',
    'Gabon - WESTERN AND CENTRAL AFRICA- P175987- Digital Gabon Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046529',
    'Senegal - WESTERN AND CENTRAL AFRICA- P161477- Senegal Municipal Solid Waste Management Project - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325185565335/pdf/P161477-edcdb35b-9dd1-40b6-8ac8-28c16f714908.pdf',
    'English',
    'Senegal',
    '',
    '',
    'Senegal - WESTERN AND CENTRAL AFRICA- P161477- Senegal Municipal Solid Waste Management Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046531',
    'Papua New Guinea - EAST ASIA AND PACIFIC- P174637- Child Nutrition and Social Protection Project - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325193022816/pdf/P174637-a82da8e4-89b8-4bd3-8fc4-b8e059ed6b24.pdf',
    'English',
    'Papua New Guinea',
    '',
    '',
    'Papua New Guinea - EAST ASIA AND PACIFIC- P174637- Child Nutrition and Social Protection Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046225',
    'Western and Central Africa - WESTERN AND CENTRAL AFRICA- P173830- Community-Based Recovery and Stabilization Project for the Sahel - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325052014995/pdf/P173830-3bbbc1e0-94d4-44e3-b43d-e120cc88f60b.pdf',
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
    '40046294',
    'Central African Republic - WESTERN AND CENTRAL AFRICA- P178699- Local Governance and Community Resilience Project - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325081542463/pdf/P178699-21688849-d0b3-421a-8b64-aaaa26cce349.pdf',
    'English',
    'Central African Republic',
    '',
    '',
    'Central African Republic - WESTERN AND CENTRAL AFRICA- P178699- Local Governance and Community Resilience Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046364',
    'Tajikistan - EUROPE AND CENTRAL ASIA- P178819- Technical Assistance for Financing Framework for Rogun Hydropower Project - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325111031322/pdf/P178819-9c67ef71-dd02-4153-805f-69c6d0a4e193.pdf',
    'English',
    'Tajikistan',
    '',
    '',
    'Tajikistan - EUROPE AND CENTRAL ASIA- P178819- Technical Assistance for Financing Framework for Rogun Hydropower Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046412',
    'Peru - LATIN AMERICA AND CARIBBEAN- P179037- Irrigation for Climate Resilient Agriculture - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325121529561/pdf/P179037-033da2bc-d8bb-4522-9dfa-4df7ff3a0f7c.pdf',
    'English',
    'Peru',
    '',
    '',
    'Peru - LATIN AMERICA AND CARIBBEAN- P179037- Irrigation for Climate Resilient Agriculture - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046517',
    'Nigeria - WESTERN AND CENTRAL AFRICA- P157891- Multi-Sectoral Crisis Recovery Project for North Eastern Nigeria - Procurement Plan',
    '2025-09-23',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325161016106/pdf/P157891-f9ee0956-7840-4249-bece-a91e2f7b2942.pdf',
    'English',
    'Nigeria',
    '',
    '',
    'Nigeria - WESTERN AND CENTRAL AFRICA- P157891- Multi-Sectoral Crisis Recovery Project for North Eastern Nigeria - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045555',
    'Costa Rica - LATIN AMERICA AND CARIBBEAN- P172352- Costa Rica Fiscal Management Improvement Project - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092125230516651/pdf/P172352-7d3bf633-f387-4f03-a7f3-0e54635f8d9d.pdf',
    'English',
    'Costa Rica',
    '',
    '',
    'Costa Rica - LATIN AMERICA AND CARIBBEAN- P172352- Costa Rica Fiscal Management Improvement Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045562',
    'Maldives - SOUTH ASIA- P163957- Maldives Urban Development and Resilience Project - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225003039657/pdf/P163957-a9cde11c-7ee9-4887-93bf-72b665b68cfc.pdf',
    'English',
    'Maldives',
    '',
    '',
    'Maldives - SOUTH ASIA- P163957- Maldives Urban Development and Resilience Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045595',
    'Uzbekistan - EUROPE AND CENTRAL ASIA- P504420- INnovative SOcial Protection System for inclusiON of Vulnerable People Project - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225015515163/pdf/P504420-91e87e71-e848-4b1b-8bba-b4abbb89b933.pdf',
    'English',
    'Uzbekistan',
    '',
    '',
    'Uzbekistan - EUROPE AND CENTRAL ASIA- P504420- INnovative SOcial Protection System for inclusiON of Vulnerable People Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045841',
    'Disclosable Version of the ISR - Lake Chad Region Recovery and Development Project - P161706 - Sequence No : 9',
    '2025-09-22',
    '',
    'Implementation Status and Results Report',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225101511857/pdf/P161706-460330fd-71fd-421a-9b83-d8dc8fbfa392.pdf',
    'English',
    'Western and Central Africa',
    '',
    '',
    'Disclosable Version of the ISR - Lake Chad Region Recovery and Development Project - P161706 - Sequence No : 9'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045915',
    'Official Documents- Advance Agreement for V552-BJ.pdf',
    '2025-09-22',
    '',
    'Agreement',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225114089667/pdf/P509153-a0e47b66-ed10-49ff-9a58-881f6160b39e.pdf',
    'English',
    'Western and Central Africa',
    '',
    '',
    'Official Documents- Advance Agreement for V552-BJ.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045950',
    'Transformational Learning : Most Recent Use This - Delve Exchange Artisanal and Small-scale Miners (ASM) Academy : Module 1 - Your Context and Opportunities',
    '2025-09-22',
    '',
    'Report',
    'Publications & Research',
    1,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225122524378/pdf/P177009-d499e7eb-b8b2-4d4c-86e9-ae75e9878ab1.pdf',
    'English',
    'World',
    '',
    '',
    'Transformational Learning : Most Recent Use This - Delve Exchange Artisanal and Small-scale Miners (ASM) Academy : Module 1 - Your Context and Opportunities'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045966',
    'Disclosable Version of the ISR - Governance Modernization to Enable Efficient Service Delivery Project - P178808 - Sequence No : 2',
    '2025-09-22',
    '',
    'Implementation Status and Results Report',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225124037657/pdf/P178808-c0ef12f7-de57-43ba-a444-16b332874b36.pdf',
    'English',
    'Ethiopia',
    '',
    '',
    'Disclosable Version of the ISR - Governance Modernization to Enable Efficient Service Delivery Project - P178808 - Sequence No : 2'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046049',
    'Ukraine - EUROPE AND CENTRAL ASIA- P181604- Center for Advancement in Restoration and Modernization Capacity - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225144029364/pdf/P181604-1a448955-d365-4abc-ac6d-bed54bfb519c.pdf',
    'English',
    'Ukraine',
    '',
    '',
    'Ukraine - EUROPE AND CENTRAL ASIA- P181604- Center for Advancement in Restoration and Modernization Capacity - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046057',
    'Environmental and Social Commitment Plan (ESCP) Housing response and Mortgage market Enhancement Project (P508310)',
    '2025-09-22',
    '',
    'Environmental and Social Commitment Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225150017261/pdf/P508310-cd650c30-81f5-4163-9314-7fbe984927de.pdf',
    'English',
    'Armenia',
    '',
    '',
    'Environmental and Social Commitment Plan (ESCP) Housing response and Mortgage market Enhancement Project (P508310)'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046130',
    'Environmental and Social Commitment Plan (ESCP) Ghana Landscape Restoration and Small-Scale Mining Project (P171933)',
    '2025-09-22',
    '',
    'Environmental and Social Commitment Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225181536526/pdf/P171933-7d65f8fe-2fca-45c3-b975-bed20899505a.pdf',
    'English',
    'Ghana',
    '',
    '',
    'Environmental and Social Commitment Plan (ESCP) Ghana Landscape Restoration and Small-Scale Mining Project (P171933)'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046145',
    'Revised Environmental and Social Impact Assessment Bihar Water Security and Irrigation Modernization Project (P505190)',
    '2025-09-22',
    '',
    'Environmental Assessment; Environmental and Social Assessment; Social Assessment',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225234534521/pdf/P505190-5fe4626f-abec-4259-99b1-10c89298debe.pdf',
    'English',
    'India',
    '',
    '',
    'Revised Environmental and Social Impact Assessment Bihar Water Security and Irrigation Modernization Project (P505190)'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046470',
    'East Asia and Pacific - Third Phase of Public Expenditure Management Network in Asia Project',
    '2025-09-22',
    '',
    'Project Paper',
    'Project Documents',
    1,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325141024289/pdf/P510072-3f171f5e-04f5-4d2e-ad45-517b8ff9564b.pdf',
    'English',
    'East Asia and Pacific',
    '',
    '',
    'East Asia and Pacific - Third Phase of Public Expenditure Management Network in Asia Project'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046848',
    'Nigeria - WESTERN AND CENTRAL AFRICA - P162009 - States Fiscal Transparency, Accountability and Sustainability PforR - Audited Financial Statement',
    '2025-09-22',
    '',
    'Auditing Document',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425072539070/pdf/P162009-90b7bbbd-2d0f-43f3-8ad4-40105f2b7b87.pdf',
    'English',
    'Nigeria',
    '',
    '',
    'Nigeria - WESTERN AND CENTRAL AFRICA - P162009 - States Fiscal Transparency, Accountability and Sustainability PforR - Audited Financial Statement'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045550',
    'Disclosable Version of the ISR - Tuvalu Second Climate and Disaster Resilience Development Policy Financing - P506356 - Sequence No : 1',
    '2025-09-22',
    '',
    'Implementation Status and Results Report',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092125203014664/pdf/P506356-f6b70651-8203-4ddd-8c97-1e942a2ea119.pdf',
    'English',
    'Tuvalu',
    '',
    '',
    'Disclosable Version of the ISR - Tuvalu Second Climate and Disaster Resilience Development Policy Financing - P506356 - Sequence No : 1'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045719',
    'Western and Central Africa - WESTERN AND CENTRAL AFRICA- P180244- WEST AFRICA FOOD SYSTEM RESILIENCE PROGRAM (FSRP) PHASE 3 - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225060014997/pdf/P180244-45fa7706-b777-420f-9ff2-921e143cf89e.pdf',
    'English',
    'Western and Central Africa',
    '',
    '',
    'Western and Central Africa - WESTERN AND CENTRAL AFRICA- P180244- WEST AFRICA FOOD SYSTEM RESILIENCE PROGRAM (FSRP) PHASE 3 - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045725',
    'Lebanon - MID EAST,NORTH AFRICA,AFG,PAK- P173367- LEBANON EMERGENCY CRISIS AND COVID-19 RESPONSE SOCIAL SAFETY NET PROJECT - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225063531770/pdf/P173367-9eea5958-8fe3-4244-b023-4b071201ba57.pdf',
    'English',
    'Lebanon',
    '',
    '',
    'Lebanon - MID EAST,NORTH AFRICA,AFG,PAK- P173367- LEBANON EMERGENCY CRISIS AND COVID-19 RESPONSE SOCIAL SAFETY NET PROJECT - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045819',
    'Peru - LATIN AMERICA AND CARIBBEAN- P157043- Modernization of Water Supply and Sanitation Services - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225093081344/pdf/P157043-d3972536-8acb-4222-9953-190ae3bcf02d.pdf',
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
    '40045936',
    'Transformational Learning : Delve Exchange ASM Academy Module 3 - Safety and Health for Your Site, Your Workers and Your Community',
    '2025-09-22',
    '',
    'Report',
    'Publications & Research',
    1,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225121540204/pdf/P177009-25e779d1-f9b1-47e1-bedc-691ccc829861.pdf',
    'English',
    'World',
    '',
    '',
    'Transformational Learning : Delve Exchange ASM Academy Module 3 - Safety and Health for Your Site, Your Workers and Your Community'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045973',
    'Lebanon - MID EAST,NORTH AFRICA,AFG,PAK- P180334- Lebanon: Green Agri-food transformation for economic recovery (GATE) - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225125574241/pdf/P180334-58f44291-9113-4d4a-b4c5-af48009a1760.pdf',
    'English',
    'Lebanon',
    '',
    '',
    'Lebanon - MID EAST,NORTH AFRICA,AFG,PAK- P180334- Lebanon: Green Agri-food transformation for economic recovery (GATE) - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045991',
    'Disclosable Version of the ISR - Scaling-up Locally Led Climate Action Program - P180742 - Sequence No : 1',
    '2025-09-22',
    '',
    'Implementation Status and Results Report',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225131542219/pdf/P180742-b59ee6ed-25e7-48a3-88e1-fcd81bfb7a41.pdf',
    'English',
    'Tanzania',
    '',
    '',
    'Disclosable Version of the ISR - Scaling-up Locally Led Climate Action Program - P180742 - Sequence No : 1'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046033',
    'Nigeria - WESTERN AND CENTRAL AFRICA- P160865- Livestock Productivity and Resilience Support Project - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225142039180/pdf/P160865-4e395eb5-4d70-4458-bf14-0cfb0d22d2fc.pdf',
    'English',
    'Nigeria',
    '',
    '',
    'Nigeria - WESTERN AND CENTRAL AFRICA- P160865- Livestock Productivity and Resilience Support Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046050',
    'Environmental and Social Commitment Plan (ESCP) Housing response and Mortgage market Enhancement Project (P508310)',
    '2025-09-22',
    '',
    'Environmental and Social Commitment Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225145031787/pdf/P508310-1aa65835-110c-4897-9cab-b66147dd3f37.pdf',
    'English',
    'Armenia',
    '',
    '',
    'Environmental and Social Commitment Plan (ESCP) Housing response and Mortgage market Enhancement Project (P508310)'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046073',
    'Disclosable Version of the ISR - DR Resilient Agriculture and Integrated Water Resources Management - P163260 - Sequence No : 13',
    '2025-09-22',
    '',
    'Implementation Status and Results Report',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225153051561/pdf/P163260-79d8dfcf-090b-4a96-bea3-87bbd6759583.pdf',
    'English',
    'Dominican Republic',
    '',
    '',
    'Disclosable Version of the ISR - DR Resilient Agriculture and Integrated Water Resources Management - P163260 - Sequence No : 13'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045591',
    'Pakistan - MID EAST,NORTH AFRICA,AFG,PAK- P131324- PK-Sindh Barrages Improvement Project - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225013021783/pdf/P131324-81625dda-e3af-4e1a-b2f8-a664ce23cf86.pdf',
    'English',
    'Pakistan',
    '',
    '',
    'Pakistan - MID EAST,NORTH AFRICA,AFG,PAK- P131324- PK-Sindh Barrages Improvement Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045645',
    'Somalia, Federal Republic of - EASTERN AND SOUTHERN AFRICA- P177627- Barwaaqo - Somalia Water for Rural Resilience Project - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225031042690/pdf/P177627-952e6a32-cc42-4511-a760-8352dabd9b1a.pdf',
    'English',
    'Somalia, Federal Republic of',
    '',
    '',
    'Somalia, Federal Republic of - EASTERN AND SOUTHERN AFRICA- P177627- Barwaaqo - Somalia Water for Rural Resilience Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045809',
    'Brazil - LATIN AMERICA AND CARIBBEAN- P158000- Amazon Sustainable Landscapes Project - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225091510042/pdf/P158000-931e4123-3be3-45f2-a091-4bfc43045f0f.pdf',
    'English',
    'Brazil',
    '',
    '',
    'Brazil - LATIN AMERICA AND CARIBBEAN- P158000- Amazon Sustainable Landscapes Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045898',
    'Official Documents- Amendment No. 36 to the Letter Agreement with the Kingdom of Denmark, represented by the Ministry of Foreign Affairs, for TF050576.pdf',
    '2025-09-22',
    '',
    'Agreement',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225112539900/pdf/TF050576-0343455d-86ad-4528-a2d7-f5bb54df97d5.pdf',
    'English',
    '',
    '',
    '',
    'Official Documents- Amendment No. 36 to the Letter Agreement with the Kingdom of Denmark, represented by the Ministry of Foreign Affairs, for TF050576.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045900',
    'Disclosable Version of the ISR - Eastern Türkiye Middle Corridor Railway Development Project - P179128 - Sequence No : 2',
    '2025-09-22',
    '',
    'Implementation Status and Results Report',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225112539558/pdf/P179128-d635001f-374a-4ba0-b11f-0f1c1f6929d7.pdf',
    'English',
    'Turkiye',
    '',
    '',
    'Disclosable Version of the ISR - Eastern Türkiye Middle Corridor Railway Development Project - P179128 - Sequence No : 2'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045953',
    'Honduras - LATIN AMERICA AND CARIBBEAN- P152057- Social Protection Integration - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225123041984/pdf/P152057-9878a7cd-bf80-48c2-8092-36133d4be1d9.pdf',
    'English',
    'Honduras',
    '',
    '',
    'Honduras - LATIN AMERICA AND CARIBBEAN- P152057- Social Protection Integration - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046129',
    'East Asia and Pacific Economic Update : Services Unbound Data Figures',
    '2025-09-22',
    '',
    'Report',
    'Publications & Research',
    1,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225180042834/pdf/P507415-6bcc62ec-e237-4628-89a2-5779f3531851.pdf',
    'English',
    'East Asia and Pacific',
    '',
    '',
    'East Asia and Pacific Economic Update : Services Unbound Data Figures'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046669',
    'Nigeria - WESTERN AND CENTRAL AFRICA - P162009 - States Fiscal Transparency, Accountability and Sustainability PforR - Audited Financial Statement',
    '2025-09-22',
    '',
    'Auditing Document',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425032542837/pdf/P162009-3105ad80-b010-44b6-b27d-b2643b71f127.pdf',
    'English',
    'Nigeria',
    '',
    '',
    'Nigeria - WESTERN AND CENTRAL AFRICA - P162009 - States Fiscal Transparency, Accountability and Sustainability PforR - Audited Financial Statement'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045744',
    'Morocco - MID EAST,NORTH AFRICA,AFG,PAK- P167894- MA North-East Economic Development Project - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225070515639/pdf/P167894-252eae47-9135-4869-9603-1c6902dc009c.pdf',
    'English',
    'Morocco',
    '',
    '',
    'Morocco - MID EAST,NORTH AFRICA,AFG,PAK- P167894- MA North-East Economic Development Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045810',
    'Brazil - LATIN AMERICA AND CARIBBEAN- P506142- Santa Catarina Rural Development Project for Sustainability and Innovation - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225091536412/pdf/P506142-98533d9c-76bc-40a0-a343-b889f0298cf7.pdf',
    'English',
    'Brazil',
    '',
    '',
    'Brazil - LATIN AMERICA AND CARIBBEAN- P506142- Santa Catarina Rural Development Project for Sustainability and Innovation - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045912',
    'Eastern and Southern Africa - EASTERN AND SOUTHERN AFRICA- P175731- SADC Regional Statistics Project - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225114033511/pdf/P175731-9cafb939-bebf-416d-afd3-2a3a2b8f24ff.pdf',
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
    '40046066',
    'Stakeholder Engagement Plan (SEP) Housing response and Mortgage market Enhancement Project (P508310)',
    '2025-09-22',
    '',
    'Stakeholder Engagement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225151599540/pdf/P508310-c47cafcd-713a-4bbc-8103-9ad4fe990d5e.pdf',
    'English',
    'Armenia',
    '',
    '',
    'Stakeholder Engagement Plan (SEP) Housing response and Mortgage market Enhancement Project (P508310)'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046086',
    'Eastern and Southern Africa - EASTERN AND SOUTHERN AFRICA- P177816- Food Systems Resilience Program for Eastern and Southern Africa (Phase 3) FSRP - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225154541442/pdf/P177816-4d328967-a6f8-4cef-a627-af301d465d2e.pdf',
    'English',
    'Eastern and Southern Africa',
    '',
    '',
    'Eastern and Southern Africa - EASTERN AND SOUTHERN AFRICA- P177816- Food Systems Resilience Program for Eastern and Southern Africa (Phase 3) FSRP - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046100',
    'Colombia - LATIN AMERICA AND CARIBBEAN- P144271- Forest Conservation and Sustainability in the Heart of the Colombian Amazon - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225162012157/pdf/P144271-f621b447-7bf5-4189-b41a-6098ec7f301f.pdf',
    'English',
    'Colombia',
    '',
    '',
    'Colombia - LATIN AMERICA AND CARIBBEAN- P144271- Forest Conservation and Sustainability in the Heart of the Colombian Amazon - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045640',
    'West Bank and Gaza - MID EAST,NORTH AFRICA,AFG,PAK- P178723- West Bank and Gaza Resilient Municipal Services Project - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225025031303/pdf/P178723-40f0c683-7bf0-46d6-a69e-fec37d40a667.pdf',
    'English',
    'West Bank and Gaza',
    '',
    '',
    'West Bank and Gaza - MID EAST,NORTH AFRICA,AFG,PAK- P178723- West Bank and Gaza Resilient Municipal Services Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045745',
    'Sri Lanka - SOUTH ASIA- P163742- Climate Smart Irrigated Agriculture Project - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225070515544/pdf/P163742-71d8b53d-914f-4b6c-bbfe-f7fbe88729d1.pdf',
    'English',
    'Sri Lanka',
    '',
    '',
    'Sri Lanka - SOUTH ASIA- P163742- Climate Smart Irrigated Agriculture Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045751',
    'Maldives - SOUTH ASIA- P179242- Transforming Fisheries Sector Management in South-West Indian Ocean Region and Maldives Project (TransFORM, SWIOFish5) - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225071515793/pdf/P179242-8ba4ce3f-7aa3-4d46-8c54-d3941d2e51e2.pdf',
    'English',
    'Maldives',
    '',
    '',
    'Maldives - SOUTH ASIA- P179242- Transforming Fisheries Sector Management in South-West Indian Ocean Region and Maldives Project (TransFORM, SWIOFish5) - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045769',
    'Cote d''Ivoire - WESTERN AND CENTRAL AFRICA- P177118- Cote d''Ivoire Water Security and Sanitation Support Program - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225075042340/pdf/P177118-7500ffc6-955f-441e-9c41-548df7054818.pdf',
    'English',
    'Cote d''Ivoire',
    '',
    '',
    'Cote d''Ivoire - WESTERN AND CENTRAL AFRICA- P177118- Cote d''Ivoire Water Security and Sanitation Support Program - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045814',
    'The Impact of Atlantic Hurricanes on Business Activity',
    '2025-09-22',
    '',
    'Policy Research Working Paper',
    'Publications & Research',
    1,
    NULL,
    'https://documents.worldbank.org/curated/en/099316009222536192/pdf/IDU-2baaa97f-4072-4de3-862a-d6eb87845cda.pdf',
    'English',
    'United States',
    '',
    '',
    'The Impact of Atlantic Hurricanes on Business Activity'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045889',
    'A Gender Lens on Adaptive Social Protection to Maximize Impact for Women and Girls in the Sahel: Guidance for the Sahel Adaptive Social Protection Program',
    '2025-09-22',
    '',
    'Working Paper',
    'Publications & Research',
    1,
    NULL,
    'https://documents.worldbank.org/curated/en/099515309222536568/pdf/IDU-e843a133-e922-4be0-b186-0b9df853143a.pdf',
    'English',
    'Senegal,Chad,Burkina Faso,Mauritania,Mali,Niger',
    '',
    '',
    'A Gender Lens on Adaptive Social Protection to Maximize Impact for Women and Girls in the Sahel: Guidance for the Sahel Adaptive Social Protection Program'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045905',
    'Disclosable Restructuring Paper - Comprehensive Approach to Health System Strengthening - P166013',
    '2025-09-22',
    '',
    'Project Paper',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225113016320/pdf/P166013-ff2fbd2a-4427-4c8c-8c68-991cb9005fda.pdf',
    'English',
    'Comoros',
    '',
    '',
    'Disclosable Restructuring Paper - Comprehensive Approach to Health System Strengthening - P166013'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046028',
    'Burkina Faso - WESTERN AND CENTRAL AFRICA- P178598- Burkina Faso Livestock Resilience and Competitiveness Project - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225140535061/pdf/P178598-25057a08-8322-45d7-9a57-788d84e596fa.pdf',
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
    '40046029',
    'Nigeria - WESTERN AND CENTRAL AFRICA- P160865- Livestock Productivity and Resilience Support Project - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225141033028/pdf/P160865-58d48197-aca7-4bec-91dd-6350c07ebb75.pdf',
    'English',
    'Nigeria',
    '',
    '',
    'Nigeria - WESTERN AND CENTRAL AFRICA- P160865- Livestock Productivity and Resilience Support Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045612',
    'Disclosable Version of the ISR - Transport Resilience and Connectivity Enhancement Project (Jezkazgan-Karagandy Section of TCITR (Middle Corridor)) - P500565 - Sequence No : 2',
    '2025-09-22',
    '',
    'Implementation Status and Results Report',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225021535702/pdf/P500565-8f7f5633-4515-43be-adfd-588e4d1d1c33.pdf',
    'English',
    'Kazakhstan',
    '',
    '',
    'Disclosable Version of the ISR - Transport Resilience and Connectivity Enhancement Project (Jezkazgan-Karagandy Section of TCITR (Middle Corridor)) - P500565 - Sequence No : 2'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045659',
    'Mozambique - EASTERN AND SOUTHERN AFRICA- P174639- Mozambique Safer Roads for Socio-Economic Integration Program - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225033025490/pdf/P174639-85ad120a-1a51-49f0-8f85-d40557dad499.pdf',
    'English',
    'Mozambique',
    '',
    '',
    'Mozambique - EASTERN AND SOUTHERN AFRICA- P174639- Mozambique Safer Roads for Socio-Economic Integration Program - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045693',
    'Lao People''s Democratic Republic - EAST ASIA AND PACIFIC- P178545- Community Livelihood Enhancement And Resilience - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225045513816/pdf/P178545-11b641c6-5dc2-4462-92b8-b33badb3cf2d.pdf',
    'English',
    'Lao People''s Democratic Republic',
    '',
    '',
    'Lao People''s Democratic Republic - EAST ASIA AND PACIFIC- P178545- Community Livelihood Enhancement And Resilience - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045707',
    'China - EAST ASIA AND PACIFIC- P173316- GEF7: Green and Carbon Neutral Cities - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225054510104/pdf/P173316-b676c7a4-1920-4be9-8a93-fa4ad42f1edc.pdf',
    'English',
    'China',
    '',
    '',
    'China - EAST ASIA AND PACIFIC- P173316- GEF7: Green and Carbon Neutral Cities - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045752',
    'Georgia - EUROPE AND CENTRAL ASIA- P173782- Kakheti Connectivity Improvement Project - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225073033897/pdf/P173782-695dcc79-f2b9-4d67-aa94-83b233cf5598.pdf',
    'English',
    'Georgia',
    '',
    '',
    'Georgia - EUROPE AND CENTRAL ASIA- P173782- Kakheti Connectivity Improvement Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045815',
    'Eastern and Southern Africa - EASTERN AND SOUTHERN AFRICA- P175731- SADC Regional Statistics Project - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225092015911/pdf/P175731-1e8ed848-ae8e-49b6-aeef-55f4b16f6f66.pdf',
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
    '40045862',
    'Official Documents- Amendment No. 8 to Contribution Agreement with Republic of Korea through its Rural Development Administration for TF069033.pdf',
    '2025-09-22',
    '',
    'Agreement',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225103515314/pdf/TF069033-017c847d-99a4-4f66-bdec-1c7b4ab9756d.pdf',
    'English',
    '',
    '',
    '',
    'Official Documents- Amendment No. 8 to Contribution Agreement with Republic of Korea through its Rural Development Administration for TF069033.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046006',
    'Brazil - LATIN AMERICA AND CARIBBEAN- P180462- Esp?rito Santo Digital Acceleration Project - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225133525619/pdf/P180462-1bed6818-67c9-4e41-8542-683453aca314.pdf',
    'English',
    'Brazil',
    '',
    '',
    'Brazil - LATIN AMERICA AND CARIBBEAN- P180462- Esp?rito Santo Digital Acceleration Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046038',
    'Colombia - LATIN AMERICA AND CARIBBEAN- P156239- CO Plan PAZcifico:Water Supply and Basic Sanitation Infrastructure and Service Delivery Project - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225142519110/pdf/P156239-78c6cd6a-4a76-4eee-b5c2-f34eed057806.pdf',
    'English',
    'Colombia',
    '',
    '',
    'Colombia - LATIN AMERICA AND CARIBBEAN- P156239- CO Plan PAZcifico:Water Supply and Basic Sanitation Infrastructure and Service Delivery Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046067',
    'The Global Sanitation Crisis : Pathways to Urgent Action Background Paper - A Systems Approach to Resilient Citywide Inclusive Sanitation',
    '2025-09-22',
    '',
    'Report',
    'Publications & Research',
    1,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225151516392/pdf/P179061-2e3ca577-cf20-4728-91d7-a105f0cadeb1.pdf',
    'English',
    'World',
    '',
    '',
    'The Global Sanitation Crisis : Pathways to Urgent Action Background Paper - A Systems Approach to Resilient Citywide Inclusive Sanitation'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046312',
    'Official Documents- Disbursement and Financial Information Letter for Loan 9724-BR.pdf',
    '2025-09-22',
    '',
    'Disbursement Letter',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325091132963/pdf/P180555-f53a1c6d-c899-4c80-a622-e480ce001cad.pdf',
    'English',
    'Brazil',
    '',
    '',
    'Official Documents- Disbursement and Financial Information Letter for Loan 9724-BR.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046726',
    'Nigeria - WESTERN AND CENTRAL AFRICA - P162009 - States Fiscal Transparency, Accountability and Sustainability PforR - Audited Financial Statement',
    '2025-09-22',
    '',
    'Auditing Document',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425044025287/pdf/P162009-02ceddb8-1aa0-42d0-89b4-6db36f68bb37.pdf',
    'English',
    'Nigeria',
    '',
    '',
    'Nigeria - WESTERN AND CENTRAL AFRICA - P162009 - States Fiscal Transparency, Accountability and Sustainability PforR - Audited Financial Statement'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045559',
    'Disclosable Version of the ISR - Tuvalu Safe and Resilient Aviation Project - P180674 - Sequence No : 6',
    '2025-09-22',
    '',
    'Implementation Status and Results Report',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092125235541266/pdf/P180674-5a55dda8-8e7f-4ad1-8e1f-20448cc64332.pdf',
    'English',
    'Tuvalu',
    '',
    '',
    'Disclosable Version of the ISR - Tuvalu Safe and Resilient Aviation Project - P180674 - Sequence No : 6'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045694',
    'Eastern and Southern Africa - EASTERN AND SOUTHERN AFRICA- P167916- Africa CDC Regional Investment Financing Project - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225045540989/pdf/P167916-f7f87d72-760c-4742-8c9a-6e68f5de2443.pdf',
    'English',
    'Eastern and Southern Africa',
    '',
    '',
    'Eastern and Southern Africa - EASTERN AND SOUTHERN AFRICA- P167916- Africa CDC Regional Investment Financing Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045787',
    'India - SOUTH ASIA- P179337- Assam State Secondary Healthcare Initiative for Service Delivery Transformation (ASSIST) Project - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225084523966/pdf/P179337-9d0c9b0a-59da-4ff4-96a0-08b3d46ad4d4.pdf',
    'English',
    'India',
    '',
    '',
    'India - SOUTH ASIA- P179337- Assam State Secondary Healthcare Initiative for Service Delivery Transformation (ASSIST) Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045881',
    'Disclosable Version of the ISR - Philippines Digital Infrastructure Project - P176317 - Sequence No : 2',
    '2025-09-22',
    '',
    'Implementation Status and Results Report',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225110032999/pdf/P176317-98c71c79-cfa5-4065-9f55-c50c2d63f67a.pdf',
    'English',
    'Philippines',
    '',
    '',
    'Disclosable Version of the ISR - Philippines Digital Infrastructure Project - P176317 - Sequence No : 2'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045928',
    'Cabo Verde - WESTERN AND CENTRAL AFRICA- P178644- Improving Connectivity and Urban Infrastructure in Cabo Verde - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225121042487/pdf/P178644-23fe1d7c-33ff-446f-aad2-a9faa50834ea.pdf',
    'English',
    'Cabo Verde',
    '',
    '',
    'Cabo Verde - WESTERN AND CENTRAL AFRICA- P178644- Improving Connectivity and Urban Infrastructure in Cabo Verde - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045935',
    '2023 State of the Artisanal and Small-Scale Mining Sector',
    '2025-09-22',
    '',
    'Report',
    'Publications & Research',
    1,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225121558277/pdf/P177009-9e10446f-c635-4d6b-8f6a-ca41b2e7fb7c.pdf',
    'English',
    'World',
    '',
    '',
    '2023 State of the Artisanal and Small-Scale Mining Sector'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '',
    '',
    NULL,
    '',
    '',
    '',
    NULL,
    NULL,
    '',
    '',
    '',
    '',
    '',
    ''
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046308',
    'Official Documents- Loan Agreement for Loan 9724-BR.pdf',
    '2025-09-22',
    '',
    'Loan Agreement',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325091021188/pdf/P180555-726c87aa-f5ed-4056-a94d-4a0741d40651.pdf',
    'English',
    'Brazil',
    '',
    '',
    'Official Documents- Loan Agreement for Loan 9724-BR.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045553',
    'Indonesia - EAST ASIA AND PACIFIC- P180860- Integrated Land Administration and Spatial Planning Project - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092125213512706/pdf/P180860-fef70106-9e3f-4e59-a3a6-49b9ba456b9c.pdf',
    'English',
    'Indonesia',
    '',
    '',
    'Indonesia - EAST ASIA AND PACIFIC- P180860- Integrated Land Administration and Spatial Planning Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045556',
    'China - EAST ASIA AND PACIFIC- P173746- China Emerging Infectious Diseases Prevention, Preparedness and Response Project - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092125233519320/pdf/P173746-e44ddab9-339f-469b-a671-f09e8bb57a0a.pdf',
    'English',
    'China',
    '',
    '',
    'China - EAST ASIA AND PACIFIC- P173746- China Emerging Infectious Diseases Prevention, Preparedness and Response Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045587',
    'Transforming Ghana in a Generation : 2025 Policy Notes - Overview',
    '2025-09-22',
    '',
    'Policy Note',
    'Economic & Sector Work',
    1,
    NULL,
    'https://documents.worldbank.org/curated/en/099514209222540141/pdf/IDU-8a84aae6-2bb7-4b31-b365-37ab4921f3f0.pdf',
    'English',
    'Ghana',
    '',
    '',
    'Transforming Ghana in a Generation : 2025 Policy Notes - Overview'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045677',
    'Eastern and Southern Africa - EASTERN AND SOUTHERN AFRICA- P180171- Regional Climate Resilience Program for Eastern and Southern Africa 1 Project (RCRP1) - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225042510686/pdf/P180171-0564b0be-f615-4381-a6a8-8b7463ff8375.pdf',
    'English',
    'Eastern and Southern Africa',
    '',
    '',
    'Eastern and Southern Africa - EASTERN AND SOUTHERN AFRICA- P180171- Regional Climate Resilience Program for Eastern and Southern Africa 1 Project (RCRP1) - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045726',
    'Environmental and Social Management Plan (ESMP) Integrated Urban Services Emergency Project II (P175791)',
    '2025-09-22',
    '',
    'Environmental and Social Management Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225064098353/pdf/P175791-f01e8c3e-6641-46a3-b104-94256e4729df.pdf',
    'English',
    'Yemen, Republic of',
    '',
    '',
    'Environmental and Social Management Plan (ESMP) Integrated Urban Services Emergency Project II (P175791)'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045788',
    'Djibouti - MID EAST,NORTH AFRICA,AFG,PAK- P175483- Djibouti Skills Development for Employment Project - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225084519921/pdf/P175483-30971c43-41d3-42de-88e3-19b5124c1ead.pdf',
    'English',
    'Djibouti',
    '',
    '',
    'Djibouti - MID EAST,NORTH AFRICA,AFG,PAK- P175483- Djibouti Skills Development for Employment Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045858',
    'Turkiye - EUROPE AND CENTRAL ASIA- P172562- Turkey Resilient Landscape Integration Project (TULIP) - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225103528466/pdf/P172562-322dda9d-d0f0-460b-8355-6a28d0c89462.pdf',
    'English',
    'Turkiye',
    '',
    '',
    'Turkiye - EUROPE AND CENTRAL ASIA- P172562- Turkey Resilient Landscape Integration Project (TULIP) - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045931',
    'Transformational Learning : Delve Exchange ASM Academy Module 5 - Managing and Caring for Your Environment : Steps to Climate Smart Mining',
    '2025-09-22',
    '',
    'Report',
    'Publications & Research',
    1,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225121541251/pdf/P177009-120ea6cd-569e-4343-8b0b-fe59f5dbb626.pdf',
    'English',
    'World',
    '',
    '',
    'Transformational Learning : Delve Exchange ASM Academy Module 5 - Managing and Caring for Your Environment : Steps to Climate Smart Mining'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045983',
    'India - SOUTH ASIA- P179749- Uttarakhand Disaster Preparedness and Resilience Project - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225130516989/pdf/P179749-2dc88e94-41de-4dd1-ae99-22ebe95876bd.pdf',
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
    '40045988',
    'Southwest Indian Ocean - EASTERN AND SOUTHERN AFRICA- P181014- Regional Emergency Preparedness and Access to Inclusive Recovery Project - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225130628604/pdf/P181014-d368dfc2-7950-48f1-9e7d-40ac1bf73899.pdf',
    'English',
    'Southwest Indian Ocean',
    '',
    '',
    'Southwest Indian Ocean - EASTERN AND SOUTHERN AFRICA- P181014- Regional Emergency Preparedness and Access to Inclusive Recovery Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046032',
    'Brazil - LATIN AMERICA AND CARIBBEAN- P506142- Santa Catarina Rural Development Project for Sustainability and Innovation - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225142041317/pdf/P506142-09141b0e-d975-4f6f-a4d7-fa34ecbcfa77.pdf',
    'English',
    'Brazil',
    '',
    '',
    'Brazil - LATIN AMERICA AND CARIBBEAN- P506142- Santa Catarina Rural Development Project for Sustainability and Innovation - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046727',
    'Nigeria - WESTERN AND CENTRAL AFRICA - P162009 - States Fiscal Transparency, Accountability and Sustainability PforR - Audited Financial Statement',
    '2025-09-22',
    '',
    'Auditing Document',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425044035204/pdf/P162009-703736c8-02a7-48d8-ab5d-fcea4c3d9c81.pdf',
    'English',
    'Nigeria',
    '',
    '',
    'Nigeria - WESTERN AND CENTRAL AFRICA - P162009 - States Fiscal Transparency, Accountability and Sustainability PforR - Audited Financial Statement'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045564',
    'Tajikistan - EUROPE AND CENTRAL ASIA- P175952- Strengthening Resilience of the Agriculture Sector Project - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225005030452/pdf/P175952-f5fde4ee-f4e1-465e-90ad-25b9233e112a.pdf',
    'English',
    'Tajikistan',
    '',
    '',
    'Tajikistan - EUROPE AND CENTRAL ASIA- P175952- Strengthening Resilience of the Agriculture Sector Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045697',
    'Concept Program Information Document (PID)',
    '2025-09-22',
    '',
    'Program Information Document',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225051011161/pdf/P512663-280fd1de-7765-49b9-95f2-a759157d475e.pdf',
    'English',
    'China',
    '',
    '',
    'Concept Program Information Document (PID)'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045708',
    'Concept Project Information Document (PID)',
    '2025-09-22',
    '',
    'Project Information Document',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225055050691/pdf/P512160-18a2b6fb-db59-4f84-ac4d-3701967e3fdb.pdf',
    'English',
    'Sao Tome and Principe',
    '',
    '',
    'Concept Project Information Document (PID)'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045793',
    'Niger - WESTERN AND CENTRAL AFRICA- P174822- Niger Public Sector Management for Resilience and Service Delivery Program - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225090015332/pdf/P174822-98c194c8-0e34-4e38-8ba4-d4cb646bfef4.pdf',
    'English',
    'Niger',
    '',
    '',
    'Niger - WESTERN AND CENTRAL AFRICA- P174822- Niger Public Sector Management for Resilience and Service Delivery Program - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045820',
    'Concept Environmental and Social Review Summary (ESRS) - Paraiba Sustainable Rural Development Phase II - P511645',
    '2025-09-22',
    '',
    'Environmental and Social Review Summary',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225094032130/pdf/P511645-5b35b88a-6edf-49ae-84bc-082e898a6194.pdf',
    'English',
    'Brazil',
    '',
    '',
    'Concept Environmental and Social Review Summary (ESRS) - Paraiba Sustainable Rural Development Phase II - P511645'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045885',
    'Honduras - LATIN AMERICA AND CARIBBEAN- P176724- Youth Employability and Climate Resilience Project - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225110516620/pdf/P176724-f19dde01-3fa8-4848-8dc5-b6bf1ff23467.pdf',
    'English',
    'Honduras',
    '',
    '',
    'Honduras - LATIN AMERICA AND CARIBBEAN- P176724- Youth Employability and Climate Resilience Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045934',
    'Transformational Learning : ASM Academy Module 6 - Opportunities and Challenges for Women in ASM',
    '2025-09-22',
    '',
    'Report',
    'Publications & Research',
    1,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225121519351/pdf/P177009-d69f88dc-5167-4dda-aed5-e1d91eb2e9f0.pdf',
    'English',
    'World',
    '',
    '',
    'Transformational Learning : ASM Academy Module 6 - Opportunities and Challenges for Women in ASM'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045947',
    'Transformational Learning : Module 4 - ASM Technology : Technology and Your Site',
    '2025-09-22',
    '',
    'Report',
    'Publications & Research',
    1,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225122526027/pdf/P177009-e80a9af9-4fed-4086-aa84-d8cdd6e5c9c3.pdf',
    'English',
    'World',
    '',
    '',
    'Transformational Learning : Module 4 - ASM Technology : Technology and Your Site'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046103',
    'Disclosable Restructuring Paper - Resilient Tourism and Blue Economy Development in Cabo Verde Project - P176981',
    '2025-09-22',
    '',
    'Project Paper',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225162518586/pdf/P176981-0e37ce1a-7759-4933-a378-22b4e8972ef9.pdf',
    'English',
    'Cabo Verde',
    '',
    '',
    'Disclosable Restructuring Paper - Resilient Tourism and Blue Economy Development in Cabo Verde Project - P176981'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046319',
    'Official Documents- Guarantee Agreement for Loan 9724-BR.pdf',
    '2025-09-22',
    '',
    'Guarantee Agreement',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325091555786/pdf/P180555-db1d6796-a1ef-4dbb-8b58-535c2e8f71db.pdf',
    'English',
    'Brazil',
    '',
    '',
    'Official Documents- Guarantee Agreement for Loan 9724-BR.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045561',
    'Pakistan - MID EAST,NORTH AFRICA,AFG,PAK- P162302- Khyber Pakhtunkhwa Revenue Mobilization and Public Resource Management - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225000530170/pdf/P162302-1ab40139-1cd9-4b61-8365-e8dcfa01078d.pdf',
    'English',
    'Pakistan',
    '',
    '',
    'Pakistan - MID EAST,NORTH AFRICA,AFG,PAK- P162302- Khyber Pakhtunkhwa Revenue Mobilization and Public Resource Management - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045563',
    'Environmental and Social Management Framework (ESMF) Solomon Islands Engaging Communities to Improve Health Outcomes (P510479)',
    '2025-09-22',
    '',
    'Environmental and Social Management Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225004521439/pdf/P510479-f98a21ef-3142-4897-9035-d9c1eca79bba.pdf',
    'English',
    'Solomon Islands',
    '',
    '',
    'Environmental and Social Management Framework (ESMF) Solomon Islands Engaging Communities to Improve Health Outcomes (P510479)'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045660',
    'Moldova - EUROPE AND CENTRAL ASIA- P177895- MSME Competitiveness Project - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225033538156/pdf/P177895-b5fbbdaf-f71b-4c3b-beb7-cf8fe7a66be1.pdf',
    'English',
    'Moldova',
    '',
    '',
    'Moldova - EUROPE AND CENTRAL ASIA- P177895- MSME Competitiveness Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045686',
    'Bhutan - SOUTH ASIA- P181278- Accelerating Transport and Trade Connectivity in Eastern South Asia Phase 2 - Bhutan Project - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225043578906/pdf/P181278-b58354e1-fa20-4f33-9535-53cd4b16eb6a.pdf',
    'English',
    'Bhutan',
    '',
    '',
    'Bhutan - SOUTH ASIA- P181278- Accelerating Transport and Trade Connectivity in Eastern South Asia Phase 2 - Bhutan Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045692',
    'Maldives - SOUTH ASIA- P177240- Sustainable and Integrated Labor Services (SAILS) - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225045032570/pdf/P177240-148ee29c-972e-4574-bbfc-2f062e154ca0.pdf',
    'English',
    'Maldives',
    '',
    '',
    'Maldives - SOUTH ASIA- P177240- Sustainable and Integrated Labor Services (SAILS) - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045698',
    'Disclosable Version of the ISR - Kiribati Kiritimati Infrastructure Project - P506425 - Sequence No : 2',
    '2025-09-22',
    '',
    'Implementation Status and Results Report',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225051081164/pdf/P506425-4d2822d2-1687-4580-98a1-a561200ef511.pdf',
    'English',
    'Kiribati',
    '',
    '',
    'Disclosable Version of the ISR - Kiribati Kiritimati Infrastructure Project - P506425 - Sequence No : 2'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045989',
    'Ukraine - EUROPE AND CENTRAL ASIA- P171050- Ukraine Improving Higher Education for Results Project - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225131018835/pdf/P171050-60ae49f1-2daf-4e5f-8fd2-40afa3555b97.pdf',
    'English',
    'Ukraine',
    '',
    '',
    'Ukraine - EUROPE AND CENTRAL ASIA- P171050- Ukraine Improving Higher Education for Results Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045999',
    'Cote d''Ivoire - WESTERN AND CENTRAL AFRICA- P171613- Cote d''Ivoire Agri-Food Sector Development Project - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225132512300/pdf/P171613-93de895f-55be-423b-9a14-2e521d7c9561.pdf',
    'English',
    'Cote d''Ivoire',
    '',
    '',
    'Cote d''Ivoire - WESTERN AND CENTRAL AFRICA- P171613- Cote d''Ivoire Agri-Food Sector Development Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046089',
    'Blueing the Black Sea : Reducing Marine Plastics Pollution in Georgia',
    '2025-09-22',
    '',
    'Report',
    'Publications & Research',
    1,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225155531952/pdf/P173334-99d39e63-8066-4193-bff6-675c8d3adb3e.pdf',
    'English',
    'Europe and Central Asia',
    '',
    '',
    'Blueing the Black Sea : Reducing Marine Plastics Pollution in Georgia'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046368',
    'Official Documents- First Restatement of Disbursement and Financial Information Letter for Grant E1280-BI and Additional Financing Grant E5070-BI.pdf',
    '2025-09-22',
    '',
    'Disbursement Letter',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325111518782/pdf/P172988-cd2cdce0-f328-407f-97a0-b403306f7c9c.pdf',
    'English',
    'Burundi',
    '',
    '',
    'Official Documents- First Restatement of Disbursement and Financial Information Letter for Grant E1280-BI and Additional Financing Grant E5070-BI.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045552',
    'Samoa - EAST ASIA AND PACIFIC- P176272- Samoa Aviation and Roads Investment Project - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092125211011446/pdf/P176272-a53f2084-1fed-4d50-b9cc-f4d35726c98f.pdf',
    'English',
    'Samoa',
    '',
    '',
    'Samoa - EAST ASIA AND PACIFIC- P176272- Samoa Aviation and Roads Investment Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045578',
    'Disclosable Version of the ISR - Secure Affordable and Sustainable Energy for Sri Lanka - P505052 - Sequence No : 1',
    '2025-09-22',
    '',
    'Implementation Status and Results Report',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225010522851/pdf/P505052-7d8a7c9c-a55e-456e-9f69-ddbd6c49f0b6.pdf',
    'English',
    'Sri Lanka',
    '',
    '',
    'Disclosable Version of the ISR - Secure Affordable and Sustainable Energy for Sri Lanka - P505052 - Sequence No : 1'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045581',
    'Transforming Ghana in a Generation : 2025 Policy Notes',
    '2025-09-22',
    '',
    'Policy Note',
    'Economic & Sector Work',
    1,
    NULL,
    'https://documents.worldbank.org/curated/en/099506109222528534/pdf/IDU-a33bc71b-5b6d-4fdb-aded-9fda6978153c.pdf',
    'English',
    'Ghana',
    '',
    '',
    'Transforming Ghana in a Generation : 2025 Policy Notes'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045608',
    'India - SOUTH ASIA- P179749- Uttarakhand Disaster Preparedness and Resilience Project - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225021017966/pdf/P179749-85f8ae97-1b61-4264-b0cc-97d911d3b258.pdf',
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
    '40045620',
    'Kazakhstan - EUROPE AND CENTRAL ASIA- P171577- Kazakhstan Resilient Landscapes Restoration Project - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225022568427/pdf/P171577-8c183fe9-55ad-4109-921a-d4b96f086167.pdf',
    'English',
    'Kazakhstan',
    '',
    '',
    'Kazakhstan - EUROPE AND CENTRAL ASIA- P171577- Kazakhstan Resilient Landscapes Restoration Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045723',
    'Maldives - SOUTH ASIA- P179242- Transforming Fisheries Sector Management in South-West Indian Ocean Region and Maldives Project (TransFORM, SWIOFish5) - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225060517481/pdf/P179242-bc8976f6-49dc-4352-896f-996e02d9b588.pdf',
    'English',
    'Maldives',
    '',
    '',
    'Maldives - SOUTH ASIA- P179242- Transforming Fisheries Sector Management in South-West Indian Ocean Region and Maldives Project (TransFORM, SWIOFish5) - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045792',
    'South Africa - EASTERN AND SOUTHERN AFRICA- P177398- Eskom Just Energy Transition Project - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225090020992/pdf/P177398-ca4fe106-3ec1-42b5-be41-ff90d32b148b.pdf',
    'English',
    'South Africa',
    '',
    '',
    'South Africa - EASTERN AND SOUTHERN AFRICA- P177398- Eskom Just Energy Transition Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045818',
    'Sierra Leone - WESTERN AND CENTRAL AFRICA- P171059- Enhancing Sierra Leone Energy Access - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225092511147/pdf/P171059-90ae9bad-7f52-49be-9ed0-468340c98a01.pdf',
    'English',
    'Sierra Leone',
    '',
    '',
    'Sierra Leone - WESTERN AND CENTRAL AFRICA- P171059- Enhancing Sierra Leone Energy Access - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045823',
    'Concept Project Information Document (PID)',
    '2025-09-22',
    '',
    'Project Information Document',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225094582198/pdf/P512688-a46d05f6-fe3a-4523-99fd-7c6f560fae4a.pdf',
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
    '40045824',
    'Pakistan - MID EAST,NORTH AFRICA,AFG,PAK- P179003- Sindh Livestock and Aquaculture Sectors Transformation Project - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225094521285/pdf/P179003-c683d0f5-dc8d-4142-b2bd-e70a68418a8c.pdf',
    'English',
    'Pakistan',
    '',
    '',
    'Pakistan - MID EAST,NORTH AFRICA,AFG,PAK- P179003- Sindh Livestock and Aquaculture Sectors Transformation Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045828',
    'Paraguay - LATIN AMERICA AND CARIBBEAN- P167996- Paraguay Public Health Sector Strengthening - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225101031407/pdf/P167996-cc12a86a-304f-4295-9119-06ae905044d4.pdf',
    'English',
    'Paraguay',
    '',
    '',
    'Paraguay - LATIN AMERICA AND CARIBBEAN- P167996- Paraguay Public Health Sector Strengthening - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045929',
    'Jamaica - LATIN AMERICA AND CARIBBEAN- P178595- Jamaica Education Project - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225121036521/pdf/P178595-d1fcf162-3ed6-420a-87f1-34cdb8df7e5a.pdf',
    'English',
    'Jamaica',
    '',
    '',
    'Jamaica - LATIN AMERICA AND CARIBBEAN- P178595- Jamaica Education Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045958',
    'Dominican Republic - LATIN AMERICA AND CARIBBEAN- P179440- Integrated Social Protection Inclusion and Resilience Project (INSPIRE) - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225123533148/pdf/P179440-9e9cc632-d19d-4621-83bb-f9708e632653.pdf',
    'English',
    'Dominican Republic',
    '',
    '',
    'Dominican Republic - LATIN AMERICA AND CARIBBEAN- P179440- Integrated Social Protection Inclusion and Resilience Project (INSPIRE) - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045962',
    'Disclosable Version of the ISR - Yemen Financial Market Infrastructure and Inclusion Project - P180708 - Sequence No : 1',
    '2025-09-22',
    '',
    'Implementation Status and Results Report',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225124020645/pdf/P180708-5de900d7-912a-4077-a4f4-f1664228ab67.pdf',
    'English',
    'Yemen, Republic of',
    '',
    '',
    'Disclosable Version of the ISR - Yemen Financial Market Infrastructure and Inclusion Project - P180708 - Sequence No : 1'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046126',
    'Cote d''Ivoire - WESTERN AND CENTRAL AFRICA- P164302- Enhancing Government Effectiveness for Improved Public Services - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225175514356/pdf/P164302-458684c3-93a8-45b8-9b1c-e02813d9cf48.pdf',
    'English',
    'Cote d''Ivoire',
    '',
    '',
    'Cote d''Ivoire - WESTERN AND CENTRAL AFRICA- P164302- Enhancing Government Effectiveness for Improved Public Services - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046128',
    'East Asia and Pacific Economic Update : Charts - Future Jobs',
    '2025-09-22',
    '',
    'Report',
    'Publications & Research',
    1,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225180033940/pdf/P507415-7f4d6853-aa46-46de-ac26-f36f1681d1a9.pdf',
    'English',
    'East Asia and Pacific',
    '',
    '',
    'East Asia and Pacific Economic Update : Charts - Future Jobs'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046724',
    'Nigeria - WESTERN AND CENTRAL AFRICA - P162009 - States Fiscal Transparency, Accountability and Sustainability PforR - Audited Financial Statement',
    '2025-09-22',
    '',
    'Auditing Document',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425043519410/pdf/P162009-f264875f-d730-4e64-a149-2bebbf3bd923.pdf',
    'English',
    'Nigeria',
    '',
    '',
    'Nigeria - WESTERN AND CENTRAL AFRICA - P162009 - States Fiscal Transparency, Accountability and Sustainability PforR - Audited Financial Statement'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045724',
    'Comoros - EASTERN AND SOUTHERN AFRICA- P179291- Shock Responsive and Resilient Social Safety Net Project - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225061035633/pdf/P179291-1dd0bd7d-0874-4f43-aabd-38fb8726999e.pdf',
    'English',
    'Comoros',
    '',
    '',
    'Comoros - EASTERN AND SOUTHERN AFRICA- P179291- Shock Responsive and Resilient Social Safety Net Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045933',
    'Transformational Learning : Module 2.1 - Your Vision for Mining Business',
    '2025-09-22',
    '',
    'Report',
    'Publications & Research',
    1,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225121510111/pdf/P177009-5e94440f-eb11-4203-951c-405b25393043.pdf',
    'English',
    'World',
    '',
    '',
    'Transformational Learning : Module 2.1 - Your Vision for Mining Business'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045946',
    'Serbia - EUROPE AND CENTRAL ASIA- P174251- Serbia Local Infrastructure and Institutional Development Project - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225122532660/pdf/P174251-8f468483-4e55-4bfe-a1f8-bb2245307ca4.pdf',
    'English',
    'Serbia',
    '',
    '',
    'Serbia - EUROPE AND CENTRAL ASIA- P174251- Serbia Local Infrastructure and Institutional Development Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045992',
    'Concept Program Information Document (PID)',
    '2025-09-22',
    '',
    'Project Information Document',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225132031679/pdf/P512660-b04c2bcb-44be-4fd1-b7de-315f10087d9b.pdf',
    'English',
    'Croatia',
    '',
    '',
    'Concept Program Information Document (PID)'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046035',
    'Vanuatu - EAST ASIA AND PACIFIC- P173278- Vanuatu Affordable and Resilient Settlements Project - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225142534700/pdf/P173278-c31e6f3a-aa50-4096-9f26-5723080fd009.pdf',
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
    '40046047',
    'Armenia - EUROPE AND CENTRAL ASIA- P179988- RESILAND: Armenia Resilient Landscapes Project - Procurement Plan',
    '2025-09-22',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225143538272/pdf/P179988-a9b304aa-be5f-4a16-87fa-af84c0bd8ff5.pdf',
    'English',
    'Armenia',
    '',
    '',
    'Armenia - EUROPE AND CENTRAL ASIA- P179988- RESILAND: Armenia Resilient Landscapes Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046131',
    'Nigeria - WESTERN AND CENTRAL AFRICA - P174114 - NIGERIA: Community Action (for) Resilience and Economic Stimulus Program - Audited Financial Statement',
    '2025-09-22',
    '',
    'Auditing Document',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225193522972/pdf/P174114-ca63bf90-983e-483e-a417-54bf265a02e6.pdf',
    'English',
    'Nigeria',
    '',
    '',
    'Nigeria - WESTERN AND CENTRAL AFRICA - P174114 - NIGERIA: Community Action (for) Resilience and Economic Stimulus Program - Audited Financial Statement'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045503',
    'Environmental and Social Management Plan (ESMP) Integrated Urban Services Emergency Project II (P175791)',
    '2025-09-21',
    '',
    'Environmental and Social Management Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092125133014174/pdf/P175791-93fe7ef6-83d4-4a56-bcc2-663b68d927bd.pdf',
    'English',
    'Yemen, Republic of',
    '',
    '',
    'Environmental and Social Management Plan (ESMP) Integrated Urban Services Emergency Project II (P175791)'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045548',
    'Kiribati - EAST ASIA AND PACIFIC- P165821- Kiribati: Pacific Islands Regional Oceanscape Program - Procurement Plan',
    '2025-09-21',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092125194033773/pdf/P165821-40ff0ead-fadf-45ff-a1b0-e767b678ec0a.pdf',
    'English',
    'Kiribati',
    '',
    '',
    'Kiribati - EAST ASIA AND PACIFIC- P165821- Kiribati: Pacific Islands Regional Oceanscape Program - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045868',
    'Official Documents- Amendment No. 6 to Administration Arrangement with the United Kingdom of Great Britain and Northern Ireland through the Department for Energy Security and Net Zero for TF073553.pdf',
    '2025-09-21',
    '',
    'Agreement',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225105029825/pdf/TF073553-4f5cc854-cc04-4f74-bea0-180e7dbf4490.pdf',
    'English',
    '',
    '',
    '',
    'Official Documents- Amendment No. 6 to Administration Arrangement with the United Kingdom of Great Britain and Northern Ireland through the Department for Energy Security and Net Zero for TF073553.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045432',
    'Resettlement Plan Resilient Urban Sierra Leone Project (P168608)',
    '2025-09-21',
    '',
    'Environmental and Social Management Plan; Resettlement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092125085530432/pdf/P168608-e8939d7d-0749-4232-96fb-8d8d653cd7fa.pdf',
    'English',
    'Sierra Leone',
    '',
    '',
    'Resettlement Plan Resilient Urban Sierra Leone Project (P168608)'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045360',
    'Appraisal Program Information Document (PID)',
    '2025-09-21',
    '',
    'Program Information Document',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092125055035541/pdf/P508569-d297086a-6766-4a2e-96b9-382bfb508d04.pdf',
    'English',
    'Armenia',
    '',
    '',
    'Appraisal Program Information Document (PID)'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045501',
    'Cambodia - EAST ASIA AND PACIFIC- P170976- Cambodia: Solid Waste and Plastic Management Improvement Project - Procurement Plan',
    '2025-09-21',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092125133039378/pdf/P170976-4de44c8e-deeb-4a67-b417-d2aea8af5bb3.pdf',
    'English',
    'Cambodia',
    '',
    '',
    'Cambodia - EAST ASIA AND PACIFIC- P170976- Cambodia: Solid Waste and Plastic Management Improvement Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045433',
    'Environmental and Social Impact Assessment Resilient Urban Sierra Leone Project (P168608)',
    '2025-09-21',
    '',
    'Social Assessment; Environmental and Social Assessment; Environmental Assessment',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092125090545651/pdf/P168608-226345e3-4620-4d6e-b9bd-652b4246b1db.pdf',
    'English',
    'Sierra Leone',
    '',
    '',
    'Environmental and Social Impact Assessment Resilient Urban Sierra Leone Project (P168608)'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045253',
    'Pakistan - MID EAST,NORTH AFRICA,AFG,PAK- P170230- Electricity Distribution Efficiency Improvement Project - Procurement Plan',
    '2025-09-21',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092125013029575/pdf/P170230-7af8bb56-f214-4424-b3a8-e1f0b233ac2a.pdf',
    'English',
    'Pakistan',
    '',
    '',
    'Pakistan - MID EAST,NORTH AFRICA,AFG,PAK- P170230- Electricity Distribution Efficiency Improvement Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045434',
    'Eastern and Southern Africa - EASTERN AND SOUTHERN AFRICA- P176371- Eastern Africa Regional Statistics Program-for-Results - Procurement Plan',
    '2025-09-21',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092125092517007/pdf/P176371-eb05bc28-cf40-4f4c-b898-2f210758b258.pdf',
    'English',
    'Eastern and Southern Africa',
    '',
    '',
    'Eastern and Southern Africa - EASTERN AND SOUTHERN AFRICA- P176371- Eastern Africa Regional Statistics Program-for-Results - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045910',
    'Official Documents- Grant Agreement for Grant TF0C8969.pdf',
    '2025-09-21',
    '',
    'Grant or Trust Fund Agreement',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225113519307/pdf/P504267-e53d48fa-27e2-4d8c-9974-104583342c0b.pdf',
    'English',
    'China',
    '',
    '',
    'Official Documents- Grant Agreement for Grant TF0C8969.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045345',
    'Senegal - WESTERN AND CENTRAL AFRICA- P172524- Senegal Digital Economy Acceleration Project - Procurement Plan',
    '2025-09-21',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092125051016991/pdf/P172524-8a50864b-90e6-42d7-833d-163d8db18ca4.pdf',
    'English',
    'Senegal',
    '',
    '',
    'Senegal - WESTERN AND CENTRAL AFRICA- P172524- Senegal Digital Economy Acceleration Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045505',
    'Pakistan - MID EAST,NORTH AFRICA,AFG,PAK- P174402- Islamic Republic of Pakistan: Digital Economy Enhancement Project - Procurement Plan',
    '2025-09-21',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092125135079271/pdf/P174402-68c9c0a4-8237-4a94-969d-b74a6bfcd55a.pdf',
    'English',
    'Pakistan',
    '',
    '',
    'Pakistan - MID EAST,NORTH AFRICA,AFG,PAK- P174402- Islamic Republic of Pakistan: Digital Economy Enhancement Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045547',
    'Sri Lanka - SOUTH ASIA- P505241- Integrated Rurban Development and Climate Resilience Project - Procurement Plan',
    '2025-09-21',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092125193026094/pdf/P505241-8faae77f-18de-43cf-b1e3-6694605632c7.pdf',
    'English',
    'Sri Lanka',
    '',
    '',
    'Sri Lanka - SOUTH ASIA- P505241- Integrated Rurban Development and Climate Resilience Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045544',
    'Brazil - LATIN AMERICA AND CARIBBEAN- P179046- Progest?o Acre: Public Sector Management Efficiency - Procurement Plan',
    '2025-09-21',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092125171036335/pdf/P179046-6b1729b5-adb9-44dc-93e0-f9e7e9793fce.pdf',
    'English',
    'Brazil',
    '',
    '',
    'Brazil - LATIN AMERICA AND CARIBBEAN- P179046- Progest?o Acre: Public Sector Management Efficiency - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045344',
    'Senegal - WESTERN AND CENTRAL AFRICA- P172524- Senegal Digital Economy Acceleration Project - Procurement Plan',
    '2025-09-21',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092125050531354/pdf/P172524-c42ec5f3-0267-4afa-8a24-f9db7aa94900.pdf',
    'English',
    'Senegal',
    '',
    '',
    'Senegal - WESTERN AND CENTRAL AFRICA- P172524- Senegal Digital Economy Acceleration Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045504',
    'Environmental and Social Management Plan (ESMP) Integrated Urban Services Emergency Project II (P175791)',
    '2025-09-21',
    '',
    'Environmental and Social Management Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092125133514512/pdf/P175791-85240196-e00b-4815-b055-a736a7c33530.pdf',
    'English',
    'Yemen, Republic of',
    '',
    '',
    'Environmental and Social Management Plan (ESMP) Integrated Urban Services Emergency Project II (P175791)'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045825',
    'Official Documents- Letter Agreement for Grant E5490-KM.pdf',
    '2025-09-21',
    '',
    'Agreement',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225095011902/pdf/P182113-9632047d-e3c4-40ed-afc9-131375bd99ba.pdf',
    'English',
    'Somalia, Federal Republic of',
    '',
    '',
    'Official Documents- Letter Agreement for Grant E5490-KM.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045502',
    'Environmental and Social Management Plan (ESMP) Integrated Urban Services Emergency Project II (P175791)',
    '2025-09-21',
    '',
    'Environmental and Social Management Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092125133021960/pdf/P175791-ecc227be-ed7f-49c8-aa18-0633205a281c.pdf',
    'English',
    'Yemen, Republic of',
    '',
    '',
    'Environmental and Social Management Plan (ESMP) Integrated Urban Services Emergency Project II (P175791)'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044614',
    'Disclosable Version of the ISR - West Bengal Building State Capability for Inclusive Social Protection Operation - P174564 - Sequence No : 8',
    '2025-09-20',
    '',
    'Implementation Status and Results Report',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925214510641/pdf/P174564-aae3f77b-5661-4635-b476-a0c89ac824c3.pdf',
    'English',
    'India',
    '',
    '',
    'Disclosable Version of the ISR - West Bengal Building State Capability for Inclusive Social Protection Operation - P174564 - Sequence No : 8'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045817',
    'Official Documents- Corrigendum to the Disbursement Table included in the Cancellation Letter as Amendment to the Financing Agreement for Credit 6864-ET.pdf',
    '2025-09-20',
    '',
    'Agreement',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225092019962/pdf/P148447-61dd6f5d-cdf7-46c0-adcc-362cd132eb3a.pdf',
    'English',
    'Ethiopia',
    '',
    '',
    'Official Documents- Corrigendum to the Disbursement Table included in the Cancellation Letter as Amendment to the Financing Agreement for Credit 6864-ET.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044926',
    'Ethiopia - EASTERN AND SOUTHERN AFRICA- P177881- Ethiopia Education and Skills for Employability Project - Procurement Plan',
    '2025-09-20',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092025121521909/pdf/P177881-c91f25b0-ef56-4fc8-9bf2-e997af150295.pdf',
    'English',
    'Ethiopia',
    '',
    '',
    'Ethiopia - EASTERN AND SOUTHERN AFRICA- P177881- Ethiopia Education and Skills for Employability Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044801',
    'Revised Resettlement Process Framework Huila-Cunene Interconnection Project (P512716)',
    '2025-09-20',
    '',
    'Environmental and Social Management Framework',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092025075594132/pdf/P512716-2c25b289-de5b-43bd-bb88-d151ae1be630.pdf',
    'English',
    'Angola',
    '',
    '',
    'Revised Resettlement Process Framework Huila-Cunene Interconnection Project (P512716)'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045046',
    'Disclosable Version of the ISR - Health Enhancement And Lifesaving (HEAL) Ukraine Project - P180245 - Sequence No : 6',
    '2025-09-20',
    '',
    'Implementation Status and Results Report',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092025154039038/pdf/P180245-d6cc3af1-00f6-4e09-a145-7eb191499fcb.pdf',
    'English',
    'Ukraine',
    '',
    '',
    'Disclosable Version of the ISR - Health Enhancement And Lifesaving (HEAL) Ukraine Project - P180245 - Sequence No : 6'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045891',
    'Official Documents- Corrigendum to correct the Grant Number of the Letter Agreement and the Disbursement and Financial Information Letter from Grant E526-DJ to the correct Grant E562-DJ.pdf',
    '2025-09-20',
    '',
    'Letter',
    '',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225112022330/pdf/P511492-9ee0d48a-9215-418e-99d9-e1c0e32cc0b2.pdf',
    'English',
    'Djibouti',
    '',
    '',
    'Official Documents- Corrigendum to correct the Grant Number of the Letter Agreement and the Disbursement and Financial Information Letter from Grant E526-DJ to the correct Grant E562-DJ.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044932',
    'Revised Stakeholder Engagement Plan (SEP) Huila-Cunene Interconnection Project (P512716)',
    '2025-09-20',
    '',
    'Stakeholder Engagement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092025122025749/pdf/P512716-116928da-c6ce-4e51-b701-559a5ce6767e.pdf',
    'English',
    'Angola',
    '',
    '',
    'Revised Stakeholder Engagement Plan (SEP) Huila-Cunene Interconnection Project (P512716)'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044937',
    'Central African Republic - WESTERN AND CENTRAL AFRICA- P176274- CAR Investment and Business Competitiveness for Employment - Procurement Plan',
    '2025-09-20',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092025124028676/pdf/P176274-426cf918-247f-418a-be21-ce54a4c94cbd.pdf',
    'English',
    'Central African Republic',
    '',
    '',
    'Central African Republic - WESTERN AND CENTRAL AFRICA- P176274- CAR Investment and Business Competitiveness for Employment - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044714',
    'Eastern and Southern Africa - EASTERN AND SOUTHERN AFRICA- P180171- Regional Climate Resilience Program for Eastern and Southern Africa 1 Project (RCRP1) - Procurement Plan',
    '2025-09-20',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092025042522816/pdf/P180171-46c8ed0a-f677-4925-a0b4-94a6886b8a6f.pdf',
    'English',
    'Eastern and Southern Africa',
    '',
    '',
    'Eastern and Southern Africa - EASTERN AND SOUTHERN AFRICA- P180171- Regional Climate Resilience Program for Eastern and Southern Africa 1 Project (RCRP1) - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044617',
    'Bangladesh - SOUTH ASIA- P501274- Host and Rohingya Enhancement of Lives Project - Procurement Plan',
    '2025-09-20',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925225526179/pdf/P501274-62daff60-ddf5-47df-b3ed-db2ee0aaed92.pdf',
    'English',
    'Bangladesh',
    '',
    '',
    'Bangladesh - SOUTH ASIA- P501274- Host and Rohingya Enhancement of Lives Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045639',
    'Nigeria - WESTERN AND CENTRAL AFRICA - P174114 - NIGERIA: Community Action (for) Resilience and Economic Stimulus Program - Audited Financial Statement',
    '2025-09-20',
    '',
    'Auditing Document',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225025019323/pdf/P174114-bdb4026e-f5ff-4d90-b8a8-b5898895f01c.pdf',
    'English',
    'Nigeria',
    '',
    '',
    'Nigeria - WESTERN AND CENTRAL AFRICA - P174114 - NIGERIA: Community Action (for) Resilience and Economic Stimulus Program - Audited Financial Statement'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044933',
    'Somalia, Federal Republic of - EASTERN AND SOUTHERN AFRICA- P172434- Somalia Education for Human Capital Development Project - Procurement Plan',
    '2025-09-20',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092025122024420/pdf/P172434-4d99bb4f-a410-4653-bb71-60a8f6dc168d.pdf',
    'English',
    'Somalia, Federal Republic of',
    '',
    '',
    'Somalia, Federal Republic of - EASTERN AND SOUTHERN AFRICA- P172434- Somalia Education for Human Capital Development Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044685',
    'Appraisal Project Information Document (PID)',
    '2025-09-20',
    '',
    'Project Information Document',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092025024022286/pdf/P512154-ca08f190-6858-4bf3-a551-e71e20ca9292.pdf',
    'English',
    'Bangladesh',
    '',
    '',
    'Appraisal Project Information Document (PID)'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044619',
    'Bangladesh - SOUTH ASIA- P508058- Bangladesh Sustainable Recovery, Emergency Preparedness and Response Project - Procurement Plan',
    '2025-09-20',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925230530118/pdf/P508058-fa614cbb-f077-42b7-a814-77354b8b6bf6.pdf',
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
    '40044620',
    'Bangladesh - SOUTH ASIA- P501274- Host and Rohingya Enhancement of Lives Project - Procurement Plan',
    '2025-09-20',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925230511201/pdf/P501274-b18d56eb-80fe-42fd-ab9e-d8d5e720362c.pdf',
    'English',
    'Bangladesh',
    '',
    '',
    'Bangladesh - SOUTH ASIA- P501274- Host and Rohingya Enhancement of Lives Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044697',
    'Concept Project Information Document (PID)',
    '2025-09-20',
    '',
    'Project Information Document',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092025033540316/pdf/P509079-e8b0bbf8-90c1-400c-bf40-dd88ad262535.pdf',
    'English',
    'Philippines',
    '',
    '',
    'Concept Project Information Document (PID)'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044713',
    'Sri Lanka - SOUTH ASIA- P166865- Sri Lanka Integrated Watershed and Water Resources Management Project - Procurement Plan',
    '2025-09-20',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092025042057395/pdf/P166865-d69ec2a9-bc4d-46b3-bf43-776df33fd037.pdf',
    'English',
    'Sri Lanka',
    '',
    '',
    'Sri Lanka - SOUTH ASIA- P166865- Sri Lanka Integrated Watershed and Water Resources Management Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044615',
    'Disclosable Version of the ISR - PHSPP: Transforming India’s Public Health Systems for Pandemic Preparedness Program - P175676 - Sequence No : 8',
    '2025-09-20',
    '',
    'Implementation Status and Results Report',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925220537108/pdf/P175676-707a8f87-0af6-41c6-ab85-10d8c10bcbec.pdf',
    'English',
    'India',
    '',
    '',
    'Disclosable Version of the ISR - PHSPP: Transforming India’s Public Health Systems for Pandemic Preparedness Program - P175676 - Sequence No : 8'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044618',
    'Bangladesh - SOUTH ASIA- P501274- Host and Rohingya Enhancement of Lives Project - Procurement Plan',
    '2025-09-20',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925230039155/pdf/P501274-0a300518-f9f9-420c-8daa-19217ddc8617.pdf',
    'English',
    'Bangladesh',
    '',
    '',
    'Bangladesh - SOUTH ASIA- P501274- Host and Rohingya Enhancement of Lives Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044621',
    'Bangladesh - SOUTH ASIA- P501274- Host and Rohingya Enhancement of Lives Project - Procurement Plan',
    '2025-09-20',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925230553103/pdf/P501274-8a6d8f3e-7b71-425e-9762-41f146dc598a.pdf',
    'English',
    'Bangladesh',
    '',
    '',
    'Bangladesh - SOUTH ASIA- P501274- Host and Rohingya Enhancement of Lives Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044418',
    'Official Documents- Letter Agreement for Grant E5850-MG.pdf',
    '2025-09-19',
    '',
    'Agreement',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925100019012/pdf/P182053-d6a5a89f-9b69-4483-8332-bd2082046842.pdf',
    'English',
    'Madagascar',
    '',
    '',
    'Official Documents- Letter Agreement for Grant E5850-MG.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044442',
    'Disclosable Restructuring Paper - El Salvador Local Economic Resilience Project - P169125',
    '2025-09-19',
    '',
    'Project Paper',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925103041473/pdf/P169125-250047d3-1063-45ba-9cce-90675258a3cd.pdf',
    'English',
    'El Salvador',
    '',
    '',
    'Disclosable Restructuring Paper - El Salvador Local Economic Resilience Project - P169125'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044379',
    'Cambodia - EAST ASIA AND PACIFIC- P171331- Land Allocation for Social and Economic Development Project III - Procurement Plan',
    '2025-09-19',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925084013241/pdf/P171331-f6447c86-ea2f-442c-b460-c3310bf3f98a.pdf',
    'English',
    'Cambodia',
    '',
    '',
    'Cambodia - EAST ASIA AND PACIFIC- P171331- Land Allocation for Social and Economic Development Project III - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044119',
    'Appraisal Environmental and Social Review Summary (ESRS) - Assam: School Education and Adolescent Wellbeing Project (ASAP) - P507865',
    '2025-09-19',
    '',
    'Environmental and Social Review Summary',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925020042090/pdf/P507865-d3a472de-3a6a-4928-aae1-cd82b0d6af29.pdf',
    'English',
    'India',
    '',
    '',
    'Appraisal Environmental and Social Review Summary (ESRS) - Assam: School Education and Adolescent Wellbeing Project (ASAP) - P507865'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044307',
    'Environmental and Social Impact Assessment Huila-Cunene Interconnection Project (P512716)',
    '2025-09-19',
    '',
    'Social Assessment; Environmental Assessment; Environmental and Social Assessment',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925061064343/pdf/P512716-f0c792ac-5de6-450d-b581-977b76ffa55b.pdf',
    'Portuguese',
    'Angola',
    '',
    '',
    'Environmental and Social Impact Assessment Huila-Cunene Interconnection Project (P512716)'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '',
    '',
    NULL,
    '',
    '',
    '',
    NULL,
    NULL,
    '',
    '',
    '',
    '',
    '',
    ''
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046832',
    'Nigeria - WESTERN AND CENTRAL AFRICA - P174114 - NIGERIA: Community Action (for) Resilience and Economic Stimulus Program - Audited Financial Statement',
    '2025-09-19',
    '',
    'Auditing Document',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425070533826/pdf/P174114-20730391-6a7f-4204-b526-f463afb3bd39.pdf',
    'English',
    'Nigeria',
    '',
    '',
    'Nigeria - WESTERN AND CENTRAL AFRICA - P174114 - NIGERIA: Community Action (for) Resilience and Economic Stimulus Program - Audited Financial Statement'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044372',
    'Chad - WESTERN AND CENTRAL AFRICA- P175803- CHAD Improving Learning Outcomes Project - Procurement Plan',
    '2025-09-19',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925080530337/pdf/P175803-03af056c-c848-4eb5-a296-8b8875017786.pdf',
    'English',
    'Chad',
    '',
    '',
    'Chad - WESTERN AND CENTRAL AFRICA- P175803- CHAD Improving Learning Outcomes Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044274',
    'Pakistan - MID EAST,NORTH AFRICA,AFG,PAK- P172615- National Health Support Program - Procurement Plan',
    '2025-09-19',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925054038853/pdf/P172615-64815e98-d409-4238-add0-a10c1a753c9f.pdf',
    'English',
    'Pakistan',
    '',
    '',
    'Pakistan - MID EAST,NORTH AFRICA,AFG,PAK- P172615- National Health Support Program - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044435',
    'Rwanda - EASTERN AND SOUTHERN AFRICA- P171462- Commercialization and De-Risking for Agricultural Transformation Project - Procurement Plan',
    '2025-09-19',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925102010010/pdf/P171462-671a36ff-11d9-49ff-887a-6b77c05059fa.pdf',
    'English',
    'Rwanda',
    '',
    '',
    'Rwanda - EASTERN AND SOUTHERN AFRICA- P171462- Commercialization and De-Risking for Agricultural Transformation Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044384',
    'Cote d''Ivoire - WESTERN AND CENTRAL AFRICA- P172425- Competitive Value Chains for Jobs and Economic Transformation Project - Procurement Plan',
    '2025-09-19',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925084527223/pdf/P172425-7d24ba8c-3874-403b-86bd-21a7553b204a.pdf',
    'English',
    'Cote d''Ivoire',
    '',
    '',
    'Cote d''Ivoire - WESTERN AND CENTRAL AFRICA- P172425- Competitive Value Chains for Jobs and Economic Transformation Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044536',
    'Nigeria - WESTERN AND CENTRAL AFRICA- P160865- Livestock Productivity and Resilience Support Project - Procurement Plan',
    '2025-09-19',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925130515404/pdf/P160865-757310a1-dc2b-44d1-8cfe-70e64342a64a.pdf',
    'English',
    'Nigeria',
    '',
    '',
    'Nigeria - WESTERN AND CENTRAL AFRICA- P160865- Livestock Productivity and Resilience Support Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044551',
    'Madagascar - EASTERN AND SOUTHERN AFRICA- P173711- Connecting Madagascar for Inclusive Growth - Procurement Plan',
    '2025-09-19',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925132518783/pdf/P173711-2bf2db90-26b9-4266-bab0-a2239df8490d.pdf',
    'English',
    'Madagascar',
    '',
    '',
    'Madagascar - EASTERN AND SOUTHERN AFRICA- P173711- Connecting Madagascar for Inclusive Growth - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044611',
    'Honduras - LATIN AMERICA AND CARIBBEAN- P175977- Honduras Tropical Cyclones Eta and Iota Emergency Recovery Project - Procurement Plan',
    '2025-09-19',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925191532414/pdf/P175977-ad34b9a1-7d93-4b02-b433-d1c87a6e5580.pdf',
    'English',
    'Honduras',
    '',
    '',
    'Honduras - LATIN AMERICA AND CARIBBEAN- P175977- Honduras Tropical Cyclones Eta and Iota Emergency Recovery Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044508',
    'Niger - WESTERN AND CENTRAL AFRICA- P167543- Niger: Smart Villages for rural growth and digital inclusion - Procurement Plan',
    '2025-09-19',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925121534733/pdf/P167543-1e710840-54d5-4373-bb4a-f47698bf41c2.pdf',
    'English',
    'Niger',
    '',
    '',
    'Niger - WESTERN AND CENTRAL AFRICA- P167543- Niger: Smart Villages for rural growth and digital inclusion - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044518',
    'Disclosable Restructuring Paper - Temane Regional Electricity Project - P160427',
    '2025-09-19',
    '',
    'Project Paper',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925122528635/pdf/P160427-e500cdcb-79c2-4ea8-8335-73e3725eb112.pdf',
    'English',
    'Eastern and Southern Africa',
    '',
    '',
    'Disclosable Restructuring Paper - Temane Regional Electricity Project - P160427'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044519',
    'Disclosable Restructuring Paper - Cameroon - Chad Power Interconnection Project - P168185',
    '2025-09-19',
    '',
    'Project Paper',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925122516410/pdf/P168185-50bb51f9-f9f9-41db-bf8f-aeda923f8216.pdf',
    'English',
    'Western and Central Africa',
    '',
    '',
    'Disclosable Restructuring Paper - Cameroon - Chad Power Interconnection Project - P168185'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044383',
    'Disclosable Version of the ISR - Albania National Water Supply and Sanitation Sector Modernization Program - P170891 - Sequence No : 6',
    '2025-09-19',
    '',
    'Implementation Status and Results Report',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925084564162/pdf/P170891-fa3723fb-3f72-4fcc-b33b-b528b0f4e361.pdf',
    'English',
    'Albania',
    '',
    '',
    'Disclosable Version of the ISR - Albania National Water Supply and Sanitation Sector Modernization Program - P170891 - Sequence No : 6'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044609',
    'Concept Program Information Document (PID)',
    '2025-09-19',
    '',
    'Program Information Document',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925185536048/pdf/P508171-1c9145ed-faeb-43c0-8e08-b08a2bd17b8e.pdf',
    'English',
    'Senegal',
    '',
    '',
    'Concept Program Information Document (PID)'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044602',
    'Nigeria - WESTERN AND CENTRAL AFRICA - P174114 - NIGERIA: Community Action (for) Resilience and Economic Stimulus Program - Audited Financial Statement',
    '2025-09-19',
    '',
    'Auditing Document',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925170021846/pdf/P174114-75bb12fc-c927-41e9-b209-fbe1825c8c29.pdf',
    'English',
    'Nigeria',
    '',
    '',
    'Nigeria - WESTERN AND CENTRAL AFRICA - P174114 - NIGERIA: Community Action (for) Resilience and Economic Stimulus Program - Audited Financial Statement'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044584',
    'Resettlement Plan Liberia: Rural Economic Transformation Project (P175263)',
    '2025-09-19',
    '',
    'Environmental and Social Management Plan; Resettlement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925140533706/pdf/P175263-c3662024-83ad-4f36-8653-0341e64310db.pdf',
    'English',
    'Liberia',
    '',
    '',
    'Resettlement Plan Liberia: Rural Economic Transformation Project (P175263)'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045977',
    'Official Documents- Second Restatement of the Revised Disbursement and Financial Information Letter for Credit 6527-NG and COFN C202-NG.pdf',
    '2025-09-19',
    '',
    'Disbursement Letter',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225125512405/pdf/P167183-16a688af-4973-49b5-b00a-1407a032d150.pdf',
    'English',
    'Nigeria',
    '',
    '',
    'Official Documents- Second Restatement of the Revised Disbursement and Financial Information Letter for Credit 6527-NG and COFN C202-NG.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044455',
    'Official Documents- Program Agreement for Loan 9828-CN.pdf',
    '2025-09-19',
    '',
    'Project Agreement',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925105514613/pdf/P506602-0fe0528b-84f8-47ab-9d2a-33f400948917.pdf',
    'English',
    'China',
    '',
    '',
    'Official Documents- Program Agreement for Loan 9828-CN.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044582',
    'Revised Resettlement Process Framework Sierra Leone Water Security and WASH Access Improvement Project (P507588)',
    '2025-09-19',
    '',
    'Environmental and Social Management Framework',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925140537354/pdf/P507588-da1b54c0-2b56-4637-8e36-e843c7202594.pdf',
    'English',
    'Sierra Leone',
    '',
    '',
    'Revised Resettlement Process Framework Sierra Leone Water Security and WASH Access Improvement Project (P507588)'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044587',
    'Stakeholder Engagement Plan (SEP) Resilient Infrastructure for Regional Economic Development and Job Creation Phase 1 - Province of Neuquén (P508558)',
    '2025-09-19',
    '',
    'Stakeholder Engagement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925141021929/pdf/P508558-54acaeb2-e554-4f48-832c-50613fafd8af.pdf',
    'Spanish',
    'Argentina',
    '',
    '',
    'Stakeholder Engagement Plan (SEP) Resilient Infrastructure for Regional Economic Development and Job Creation Phase 1 - Province of Neuquén (P508558)'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044588',
    'Burundi - EASTERN AND SOUTHERN AFRICA- P177146- Urban Resilience Emergency Project - Procurement Plan',
    '2025-09-19',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925141017869/pdf/P177146-8b8a9606-8634-4108-b703-9df005369760.pdf',
    'English',
    'Burundi',
    '',
    '',
    'Burundi - EASTERN AND SOUTHERN AFRICA- P177146- Urban Resilience Emergency Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044330',
    'Albania - EUROPE AND CENTRAL ASIA- P177845- Improving Equitable Access To High Standard Public Services Through Govtech - Procurement Plan',
    '2025-09-19',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925065516798/pdf/P177845-a5c2da72-58fa-467a-a19d-59276719bec6.pdf',
    'English',
    'Albania',
    '',
    '',
    'Albania - EUROPE AND CENTRAL ASIA- P177845- Improving Equitable Access To High Standard Public Services Through Govtech - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044349',
    'Tajikistan - EUROPE AND CENTRAL ASIA- P177779- Tajikistan Preparedness and Resilience to Disasters Project - Procurement Plan',
    '2025-09-19',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925072034334/pdf/P177779-c3656a3f-12a6-4206-8150-f6769f63253c.pdf',
    'English',
    'Tajikistan',
    '',
    '',
    'Tajikistan - EUROPE AND CENTRAL ASIA- P177779- Tajikistan Preparedness and Resilience to Disasters Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40029641',
    'Forging Viet Nam’s Semiconductor Future : A Tech Talent and Innovation Flywheel',
    '2025-09-19',
    '',
    'Report',
    'Publications & Research',
    1,
    NULL,
    'https://documents.worldbank.org/curated/en/099071425042512029/pdf/P507482-a2f47330-b662-475d-908f-41fc3a027a04.pdf',
    'English',
    'Viet Nam',
    '',
    '',
    'Forging Viet Nam’s Semiconductor Future : A Tech Talent and Innovation Flywheel'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40045866',
    'Official Documents- Amendment No. 2 to the Administration Arrangement with the United Kingdom of Great Britain and Northern Ireland, acting through the Foreign, Commonwealth and Development Office (FCDO), for TF073388.pdf',
    '2025-09-19',
    '',
    'Agreement',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092225104522966/pdf/TF073388-3ffc79ff-8535-4e1a-9e45-31308da4ef57.pdf',
    'English',
    '',
    '',
    '',
    'Official Documents- Amendment No. 2 to the Administration Arrangement with the United Kingdom of Great Britain and Northern Ireland, acting through the Foreign, Commonwealth and Development Office (FCDO), for TF073388.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044117',
    'Environmental and Social Commitment Plan (ESCP) - Assam: School Education and Adolescent Wellbeing Project (ASAP) - P507865',
    '2025-09-19',
    '',
    'Environmental and Social Commitment Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925015521866/pdf/P507865-c677e55d-4ee2-4201-aa29-fcd145f4aaa8.pdf',
    'English',
    'India',
    '',
    '',
    'Environmental and Social Commitment Plan (ESCP) - Assam: School Education and Adolescent Wellbeing Project (ASAP) - P507865'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044410',
    'Official Documents- Letter Agreement for Grant E5780-RW.pdf',
    '2025-09-19',
    '',
    'Agreement',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925091519798/pdf/P182116-d9b54ce7-b953-40a9-a22a-a1cd925ff551.pdf',
    'English',
    'Rwanda',
    '',
    '',
    'Official Documents- Letter Agreement for Grant E5780-RW.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044355',
    'The Container Port Performance Index 2020 to 2024 : Trends and Lessons Learned',
    '2025-09-19',
    '',
    'Report',
    'Publications & Research',
    1,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925073051415/pdf/P509479-9781ba16-3dbc-4064-9d8f-8eaf9951e09d.pdf',
    'English',
    'World',
    '',
    '',
    'The Container Port Performance Index 2020 to 2024 : Trends and Lessons Learned'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044165',
    'China - EAST ASIA AND PACIFIC- P168061- HUBEI SMART AND SUSTAINABLE AGRICULTURE PROJECT - Procurement Plan',
    '2025-09-19',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925031028494/pdf/P168061-9d3ce94c-e8db-4603-ab22-ab3cfb5b530e.pdf',
    'English',
    'China',
    '',
    '',
    'China - EAST ASIA AND PACIFIC- P168061- HUBEI SMART AND SUSTAINABLE AGRICULTURE PROJECT - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044134',
    'Rwanda - EASTERN AND SOUTHERN AFRICA- P178161- Volcanoes Community Resilience Project - Procurement Plan',
    '2025-09-19',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925022522779/pdf/P178161-df400de3-3aac-40da-b7a3-6a0867d281eb.pdf',
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
    '40044493',
    'Angola - EASTERN AND SOUTHERN AFRICA- P151224- Second Water Sector Institutional Development Project - Procurement Plan',
    '2025-09-19',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925114535805/pdf/P151224-c7c412de-48e8-487e-b40c-598f20f4d5c2.pdf',
    'English',
    'Angola',
    '',
    '',
    'Angola - EASTERN AND SOUTHERN AFRICA- P151224- Second Water Sector Institutional Development Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044517',
    'Disclosable Restructuring Paper - Temane Regional Electricity Project - P160427',
    '2025-09-19',
    '',
    'Project Paper',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925122578922/pdf/P160427-4fd55756-e35e-415c-8324-d977dc4715de.pdf',
    'English',
    'Eastern and Southern Africa',
    '',
    '',
    'Disclosable Restructuring Paper - Temane Regional Electricity Project - P160427'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044445',
    'Disclosable Version of the ISR - Sudan SANAD - Emergency Crisis Response Safety Net Project - P505963 - Sequence No : 2',
    '2025-09-19',
    '',
    'Implementation Status and Results Report',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925103035254/pdf/P505963-29e6468c-9705-464a-a172-383e7b1bf9e4.pdf',
    'English',
    'Sudan',
    '',
    '',
    'Disclosable Version of the ISR - Sudan SANAD - Emergency Crisis Response Safety Net Project - P505963 - Sequence No : 2'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044549',
    'Unlivable : Confronting Extreme Urban Heat in Latin America and the Caribbean',
    '2025-09-19',
    '',
    'Report',
    'Publications & Research',
    1,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925132542945/pdf/P504085-d53bd008-c83a-446f-9f07-0fc363794cfb.pdf',
    'English',
    'Latin America and Caribbean',
    '',
    '',
    'Unlivable : Confronting Extreme Urban Heat in Latin America and the Caribbean'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044595',
    'Honduras - LATIN AMERICA AND CARIBBEAN- P175977- Honduras Tropical Cyclones Eta and Iota Emergency Recovery Project - Procurement Plan',
    '2025-09-19',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925145556087/pdf/P175977-4d60e665-ebbd-48bc-9ca6-4073a3ed2451.pdf',
    'English',
    'Honduras',
    '',
    '',
    'Honduras - LATIN AMERICA AND CARIBBEAN- P175977- Honduras Tropical Cyclones Eta and Iota Emergency Recovery Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044610',
    'El Salvador - LATIN AMERICA AND CARIBBEAN- P171316- Growing Up and Learning Together: Comprehensive Early Childhood Development in El Salvador - Procurement Plan',
    '2025-09-19',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925190038090/pdf/P171316-6977181d-10eb-48bc-a06a-4a5651a6328b.pdf',
    'English',
    'El Salvador',
    '',
    '',
    'El Salvador - LATIN AMERICA AND CARIBBEAN- P171316- Growing Up and Learning Together: Comprehensive Early Childhood Development in El Salvador - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046287',
    'Congo, Democratic Republic of - EASTERN AND SOUTHERN AFRICA - P173825 - DRC COVID-19 Strategic Preparedness and Response Project (SPRP) - Audited Financial Statement',
    '2025-09-19',
    '',
    'Auditing Document',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325073526795/pdf/P173825-4c06fbec-cd0f-4dee-9ae6-04e19d6cee37.pdf',
    'English',
    'Congo, Democratic Republic of',
    '',
    '',
    'Congo, Democratic Republic of - EASTERN AND SOUTHERN AFRICA - P173825 - DRC COVID-19 Strategic Preparedness and Response Project (SPRP) - Audited Financial Statement'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046737',
    'Nigeria - WESTERN AND CENTRAL AFRICA - P170734 - Nigeria Sustainable Urban and Rural Water Supply, Sanitation and Hygiene Program-for-Results - Audited Financial Statement',
    '2025-09-19',
    '',
    'Auditing Document',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092425051542748/pdf/P170734-f6b390d5-bb67-458c-911b-082d1af9537b.pdf',
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
    '40044052',
    'Ukraine - EUROPE AND CENTRAL ASIA- P181200- Housing Repair for People''s Empowerment Project (HOPE) - Procurement Plan',
    '2025-09-19',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925002016233/pdf/P181200-ffd271c3-5d7e-46a1-bec8-d0c80b3cc99d.pdf',
    'English',
    'Ukraine',
    '',
    '',
    'Ukraine - EUROPE AND CENTRAL ASIA- P181200- Housing Repair for People''s Empowerment Project (HOPE) - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044034',
    'Tuvalu - EAST ASIA AND PACIFIC- P179599- Pacific Islands Regional Oceanscape Program - Second Phase for Economic Resilience: Tuvalu - Procurement Plan',
    '2025-09-19',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091825232537315/pdf/P179599-0c80a6e9-71a8-4575-acdf-82e45623bd8b.pdf',
    'English',
    'Tuvalu',
    '',
    '',
    'Tuvalu - EAST ASIA AND PACIFIC- P179599- Pacific Islands Regional Oceanscape Program - Second Phase for Economic Resilience: Tuvalu - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044594',
    'Pakistan - MID EAST,NORTH AFRICA,AFG,PAK- P164785- Punjab Human Capital Investment Project - Procurement Plan',
    '2025-09-19',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925144535413/pdf/P164785-c09f444c-3a66-4d4c-bfab-8dd7d770c78c.pdf',
    'English',
    'Pakistan',
    '',
    '',
    'Pakistan - MID EAST,NORTH AFRICA,AFG,PAK- P164785- Punjab Human Capital Investment Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044116',
    'Stakeholder Engagement Plan (SEP) - Assam: School Education and Adolescent Wellbeing Project (ASAP) - P507865',
    '2025-09-19',
    '',
    'Stakeholder Engagement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925015511930/pdf/P507865-34f9c0d6-7e1c-48d8-9e6a-206290d5790b.pdf',
    'English',
    'India',
    '',
    '',
    'Stakeholder Engagement Plan (SEP) - Assam: School Education and Adolescent Wellbeing Project (ASAP) - P507865'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044069',
    'Turkiye - EUROPE AND CENTRAL ASIA- P158418- T?rkiye Irrigation Modernization - Procurement Plan',
    '2025-09-19',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925010021519/pdf/P158418-2092dcae-d410-452f-b6cf-9f2b3ae51669.pdf',
    'English',
    'Turkiye',
    '',
    '',
    'Turkiye - EUROPE AND CENTRAL ASIA- P158418- T?rkiye Irrigation Modernization - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40043884',
    'Tajikistan - Poverty and Equity Assessment : Transformation at Home',
    '2025-09-19',
    '',
    'Poverty Assessment',
    'Economic & Sector Work',
    1,
    NULL,
    'https://documents.worldbank.org/curated/en/099091825032032367/pdf/P500758-944805c9-3b47-4447-8fb8-f00495f6546f.pdf',
    'English',
    'Tajikistan',
    '',
    '',
    'Tajikistan - Poverty and Equity Assessment : Transformation at Home'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044511',
    'Niger - WESTERN AND CENTRAL AFRICA- P179276- Livestock and Agriculture Modernization Project (LAMP) - Procurement Plan',
    '2025-09-19',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925122026498/pdf/P179276-95ff26e7-2ca1-453f-b60b-92c8e1d1ebaf.pdf',
    'English',
    'Niger',
    '',
    '',
    'Niger - WESTERN AND CENTRAL AFRICA- P179276- Livestock and Agriculture Modernization Project (LAMP) - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044380',
    'Disclosable Version of the ISR - Albania National Water Supply and Sanitation Sector Modernization Program - P170891 - Sequence No : 6',
    '2025-09-19',
    '',
    'Implementation Status and Results Report',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925084046254/pdf/P170891-580fd493-a35c-460b-98d1-944bf6a71271.pdf',
    'English',
    'Albania',
    '',
    '',
    'Disclosable Version of the ISR - Albania National Water Supply and Sanitation Sector Modernization Program - P170891 - Sequence No : 6'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044413',
    'Disclosable Version of the ISR - Comoros National Water Resilience Project - P504691 - Sequence No : 4',
    '2025-09-19',
    '',
    'Implementation Status and Results Report',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925091612645/pdf/P504691-dd9fadd0-148c-402c-b2f3-a023581ce43e.pdf',
    'English',
    'Comoros',
    '',
    '',
    'Disclosable Version of the ISR - Comoros National Water Resilience Project - P504691 - Sequence No : 4'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044028',
    'Kiribati - EAST ASIA AND PACIFIC- P176478- South Tarawa Sanitation Project - Procurement Plan',
    '2025-09-19',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091825224586865/pdf/P176478-ca9dff2b-93d2-49ce-92a2-8c8b42a0cd25.pdf',
    'English',
    'Kiribati',
    '',
    '',
    'Kiribati - EAST ASIA AND PACIFIC- P176478- South Tarawa Sanitation Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044269',
    'Nepal - SOUTH ASIA- P501985- Electricity Supply Reliability Improvement Project - Procurement Plan',
    '2025-09-19',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925053557245/pdf/P501985-7bf553b3-992e-4ae5-ac8c-dd8376c4bc4f.pdf',
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
    '40044281',
    'Disclosable Version of the ISR - Mali Community Resilience and Inclusive Services Project - Malidenko - P505025 - Sequence No : 2',
    '2025-09-19',
    '',
    'Implementation Status and Results Report',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925054521539/pdf/P505025-bee4bba6-44ae-4e68-b5a5-55e4371e8682.pdf',
    'English',
    'Mali',
    '',
    '',
    'Disclosable Version of the ISR - Mali Community Resilience and Inclusive Services Project - Malidenko - P505025 - Sequence No : 2'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044300',
    'Bhutan - SOUTH ASIA- P181278- Accelerating Transport and Trade Connectivity in Eastern South Asia Phase 2 - Bhutan Project - Procurement Plan',
    '2025-09-19',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925060534086/pdf/P181278-b8a32b02-4f1e-4179-8ba0-1ef0bd2cc671.pdf',
    'English',
    'Bhutan',
    '',
    '',
    'Bhutan - SOUTH ASIA- P181278- Accelerating Transport and Trade Connectivity in Eastern South Asia Phase 2 - Bhutan Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044351',
    'Nigeria - WESTERN AND CENTRAL AFRICA- P164001- Power Sector Recovery Performance Based Operation - Procurement Plan',
    '2025-09-19',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925072520517/pdf/P164001-052b86db-9993-4b75-9e95-6a7a3de86195.pdf',
    'English',
    'Nigeria',
    '',
    '',
    'Nigeria - WESTERN AND CENTRAL AFRICA- P164001- Power Sector Recovery Performance Based Operation - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044240',
    'Cote d''Ivoire - WESTERN AND CENTRAL AFRICA- P159697- GREATER ABIDJAN PORT - CITY INTEGRATION PROJECT - Procurement Plan',
    '2025-09-19',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925045563661/pdf/P159697-96301df8-f00c-4d29-9e8c-ea4609bf63be.pdf',
    'English',
    'Cote d''Ivoire',
    '',
    '',
    'Cote d''Ivoire - WESTERN AND CENTRAL AFRICA- P159697- GREATER ABIDJAN PORT - CITY INTEGRATION PROJECT - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044161',
    'Ethiopia - EASTERN AND SOUTHERN AFRICA- P176731- Power Sector Reform, Investment and Modernization in Ethiopia (PRIME-1) - Procurement Plan',
    '2025-09-19',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925030528253/pdf/P176731-9c276f0b-dae1-4e69-99d7-7df87ccf41ae.pdf',
    'English',
    'Ethiopia',
    '',
    '',
    'Ethiopia - EASTERN AND SOUTHERN AFRICA- P176731- Power Sector Reform, Investment and Modernization in Ethiopia (PRIME-1) - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044087',
    'Guinee - Projet de Developpemnt de L’agriculture Commerciale : Plan D’action de Reinstallation (PAR) des Travaux d’amenagement de 88 Km de Pistes Dans la Prefecture de Mandiana',
    '2025-09-19',
    '',
    'Resettlement Plan',
    'Project Documents',
    1,
    NULL,
    'https://documents.worldbank.org/curated/en/099514509192558151/pdf/IDU-52a84b8a-8d22-4516-b103-5601f4020e3e.pdf',
    'French',
    'Guinea',
    '',
    '',
    'Guinee - Projet de Developpemnt de L’agriculture Commerciale : Plan D’action de Reinstallation (PAR) des Travaux d’amenagement de 88 Km de Pistes Dans la Prefecture de Mandiana'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044415',
    'Mozambique - EASTERN AND SOUTHERN AFRICA- P502471- Capacity Building for Improved Gender-based Violence Response Project - Procurement Plan',
    '2025-09-19',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925094032529/pdf/P502471-a2abefec-4ecc-4e45-99dd-2404699b8e6c.pdf',
    'English',
    'Mozambique',
    '',
    '',
    'Mozambique - EASTERN AND SOUTHERN AFRICA- P502471- Capacity Building for Improved Gender-based Violence Response Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044533',
    'Comoros - EASTERN AND SOUTHERN AFRICA- P173114- Comoros Interisland Connectivity Project - Procurement Plan',
    '2025-09-19',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925130011569/pdf/P173114-3fc1481d-49f4-46dd-bbfc-7c513f03f497.pdf',
    'English',
    'Comoros',
    '',
    '',
    'Comoros - EASTERN AND SOUTHERN AFRICA- P173114- Comoros Interisland Connectivity Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044448',
    'Gabon - WESTERN AND CENTRAL AFRICA- P175987- Digital Gabon Project - Procurement Plan',
    '2025-09-19',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925104520813/pdf/P175987-14d0cf94-33b3-4527-8696-1747d26f11b6.pdf',
    'English',
    'Gabon',
    '',
    '',
    'Gabon - WESTERN AND CENTRAL AFRICA- P175987- Digital Gabon Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044299',
    'Lebanon - MID EAST,NORTH AFRICA,AFG,PAK- P506127- Support for Social Recovery Needs of Vulnerable Groups Phase II - Procurement Plan',
    '2025-09-19',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925060511310/pdf/P506127-aaa15cd6-edbc-4fad-8c7f-96327649bdd7.pdf',
    'English',
    'Lebanon',
    '',
    '',
    'Lebanon - MID EAST,NORTH AFRICA,AFG,PAK- P506127- Support for Social Recovery Needs of Vulnerable Groups Phase II - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044302',
    'Environmental and Social Impact Assessment Huila-Cunene Interconnection Project (P512716)',
    '2025-09-19',
    '',
    'Environmental Assessment; Environmental and Social Assessment; Social Assessment',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925060513818/pdf/P512716-12549d2e-453e-4da4-9c80-b876da3de894.pdf',
    'English',
    'Angola',
    '',
    '',
    'Environmental and Social Impact Assessment Huila-Cunene Interconnection Project (P512716)'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044148',
    'India - SOUTH ASIA- P174798- Fisheries Sector Prosperity Project - Procurement Plan',
    '2025-09-19',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925024580007/pdf/P174798-70e0440d-423e-4b20-8a75-f9fc158d836a.pdf',
    'English',
    'India',
    '',
    '',
    'India - SOUTH ASIA- P174798- Fisheries Sector Prosperity Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044343',
    'Mozambique - EASTERN AND SOUTHERN AFRICA- P171040- Mozambique: Cyclone Idai and Kenneth Emergency Recovery and Resilience Project - Procurement Plan',
    '2025-09-19',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925072026555/pdf/P171040-fd76cd0e-71b4-407b-8554-7656a04f03b0.pdf',
    'English',
    'Mozambique',
    '',
    '',
    'Mozambique - EASTERN AND SOUTHERN AFRICA- P171040- Mozambique: Cyclone Idai and Kenneth Emergency Recovery and Resilience Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40046391',
    'Congo, Democratic Republic of - EASTERN AND SOUTHERN AFRICA - P147555 - Health System Strengthening for Better Maternal and Child Health Results Project (PDSS) - Audited Financial Statement',
    '2025-09-19',
    '',
    'Auditing Document',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099092325115029575/pdf/P147555-9b56f41f-261c-4d3f-a00c-ae5f44c923e3.pdf',
    'English',
    'Congo, Democratic Republic of',
    '',
    '',
    'Congo, Democratic Republic of - EASTERN AND SOUTHERN AFRICA - P147555 - Health System Strengthening for Better Maternal and Child Health Results Project (PDSS) - Audited Financial Statement'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044497',
    'Western and Central Africa - WESTERN AND CENTRAL AFRICA- P180085- Harmonizing and Improving Statistics in West and Central Africa - Series of Projects Two (HISWACA - SOP 2) - Procurement Plan',
    '2025-09-19',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925120029392/pdf/P180085-2b7e6367-221f-42ea-a74f-9709b57525be.pdf',
    'English',
    'Western and Central Africa',
    '',
    '',
    'Western and Central Africa - WESTERN AND CENTRAL AFRICA- P180085- Harmonizing and Improving Statistics in West and Central Africa - Series of Projects Two (HISWACA - SOP 2) - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044431',
    'Western and Central Africa - WESTERN AND CENTRAL AFRICA- P175525- West Africa Coastal Areas Resilience Investment Project 2 - Procurement Plan',
    '2025-09-19',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925102011525/pdf/P175525-3b3087cd-8987-4188-b049-fdbbc5524e9f.pdf',
    'English',
    'Western and Central Africa',
    '',
    '',
    'Western and Central Africa - WESTERN AND CENTRAL AFRICA- P175525- West Africa Coastal Areas Resilience Investment Project 2 - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044468',
    'Gambia, The - WESTERN AND CENTRAL AFRICA- P176924- The Gambia Public Administration Modernization for Citizen Centric Service Delivery - Procurement Plan',
    '2025-09-19',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925111025298/pdf/P176924-831a1b27-8be7-4331-84a0-2b37ec4006e4.pdf',
    'English',
    'Gambia, The',
    '',
    '',
    'Gambia, The - WESTERN AND CENTRAL AFRICA- P176924- The Gambia Public Administration Modernization for Citizen Centric Service Delivery - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044409',
    'Disclosable Version of the ISR - Adaptive and Productive Social Safety Net Project - P179211 - Sequence No : 3',
    '2025-09-19',
    '',
    'Implementation Status and Results Report',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925091538299/pdf/P179211-cfa51ee0-d280-4fe6-b637-ab9dfc7ff988.pdf',
    'English',
    'Central African Republic',
    '',
    '',
    'Disclosable Version of the ISR - Adaptive and Productive Social Safety Net Project - P179211 - Sequence No : 3'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044586',
    'Resettlement Plan Liberia: Rural Economic Transformation Project (P175263)',
    '2025-09-19',
    '',
    'Resettlement Plan; Environmental and Social Management Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925141028413/pdf/P175263-8ec25522-b450-43c2-b044-6ef2ace4e4d6.pdf',
    'English',
    'Liberia',
    '',
    '',
    'Resettlement Plan Liberia: Rural Economic Transformation Project (P175263)'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044534',
    'Nigeria - WESTERN AND CENTRAL AFRICA- P160865- Livestock Productivity and Resilience Support Project - Procurement Plan',
    '2025-09-19',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925130537733/pdf/P160865-a818a945-77c3-43ef-9cb0-8e237b4d4898.pdf',
    'English',
    'Nigeria',
    '',
    '',
    'Nigeria - WESTERN AND CENTRAL AFRICA- P160865- Livestock Productivity and Resilience Support Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044031',
    'Disclosable Version of the ISR - Mpatamanga Hydropower Storage Project - P165704 - Sequence No : 1',
    '2025-09-19',
    '',
    'Implementation Status and Results Report',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091825230036278/pdf/P165704-702083e0-cc31-49e5-8bc2-56c721c9b9c4.pdf',
    'English',
    'Malawi',
    '',
    '',
    'Disclosable Version of the ISR - Mpatamanga Hydropower Storage Project - P165704 - Sequence No : 1'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044033',
    'China - EAST ASIA AND PACIFIC- P154716- Anhui Aged Care System Demonstration Project - Procurement Plan',
    '2025-09-19',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091825232024354/pdf/P154716-fbdb21d3-d8d9-4b2c-b8e3-12d468ff5bcf.pdf',
    'English',
    'China',
    '',
    '',
    'China - EAST ASIA AND PACIFIC- P154716- Anhui Aged Care System Demonstration Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044064',
    'Digital Skills Profiles of Adolescent Girls in Northern Nigeria : Implications for School-based Digital Literacy Programs',
    '2025-09-19',
    '',
    'Brief',
    'Publications & Research',
    1,
    NULL,
    'https://documents.worldbank.org/curated/en/099440009192526026/pdf/IDU-6660fa9d-7f18-4851-81bc-01f0208ecf67.pdf',
    'English',
    'World',
    '',
    '',
    'Digital Skills Profiles of Adolescent Girls in Northern Nigeria : Implications for School-based Digital Literacy Programs'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044219',
    'Eastern and Southern Africa - EASTERN AND SOUTHERN AFRICA- P177816- Food Systems Resilience Program for Eastern and Southern Africa (Phase 3) FSRP - Procurement Plan',
    '2025-09-19',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925043033700/pdf/P177816-4621d888-d28a-40c7-a1c6-4633519580e2.pdf',
    'English',
    'Eastern and Southern Africa',
    '',
    '',
    'Eastern and Southern Africa - EASTERN AND SOUTHERN AFRICA- P177816- Food Systems Resilience Program for Eastern and Southern Africa (Phase 3) FSRP - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044209',
    'Benin - WESTERN AND CENTRAL AFRICA- P175768- Benin Vocational Education and Entrepreneurship for Jobs Project - Procurement Plan',
    '2025-09-19',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925041540160/pdf/P175768-75c3f01a-fec1-46ad-a4af-4ac0f14043b7.pdf',
    'English',
    'Benin',
    '',
    '',
    'Benin - WESTERN AND CENTRAL AFRICA- P175768- Benin Vocational Education and Entrepreneurship for Jobs Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044423',
    'Official Documents- Letter Agreement for Grant E577-BD.pdf',
    '2025-09-19',
    '',
    'Agreement',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925101021722/pdf/P182069-76128491-89f1-49fa-854b-b381b990d473.pdf',
    'English',
    'Bangladesh',
    '',
    '',
    'Official Documents- Letter Agreement for Grant E577-BD.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044481',
    'Romania - EUROPE AND CENTRAL ASIA- P179786- Romania Rural Pollution Prevention and Reduction Project (RAPID) - Procurement Plan',
    '2025-09-19',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925112598253/pdf/P179786-d9a7738a-a6c8-4245-a485-9c086a290422.pdf',
    'English',
    'Romania',
    '',
    '',
    'Romania - EUROPE AND CENTRAL ASIA- P179786- Romania Rural Pollution Prevention and Reduction Project (RAPID) - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044601',
    'Environmental and Social Management Plan (ESMP) Kyrgyz Republic Contingent Emergency Response Project (P509818)',
    '2025-09-19',
    '',
    'Environmental and Social Management Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925154567725/pdf/P509818-f1b98da8-d7c8-459a-97f5-faae89a7049b.pdf',
    'English',
    'Kyrgyz Republic',
    '',
    '',
    'Environmental and Social Management Plan (ESMP) Kyrgyz Republic Contingent Emergency Response Project (P509818)'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044603',
    'Disclosable Version of the ISR - Asuncion Riverfront Urban Resilience Project - P175320 - Sequence No : 6',
    '2025-09-19',
    '',
    'Implementation Status and Results Report',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925171019501/pdf/P175320-6eeb3234-b381-4a77-834a-58b129d9cf43.pdf',
    'English',
    'Paraguay',
    '',
    '',
    'Disclosable Version of the ISR - Asuncion Riverfront Urban Resilience Project - P175320 - Sequence No : 6'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044600',
    'Disclosable Version of the ISR - Improving Mobility and Urban Inclusion in the Amazonas Corridor in Belo Horizonte - P169134 - Sequence No : 11',
    '2025-09-19',
    '',
    'Implementation Status and Results Report',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925154014841/pdf/P169134-7f71e04e-bd60-4579-8d6a-1af32c181ce0.pdf',
    'English',
    'Brazil',
    '',
    '',
    'Disclosable Version of the ISR - Improving Mobility and Urban Inclusion in the Amazonas Corridor in Belo Horizonte - P169134 - Sequence No : 11'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044385',
    'Brazil - LATIN AMERICA AND CARIBBEAN- P172605- Salvador Social Multi-Sector Service Delivery Project II - Procurement Plan',
    '2025-09-19',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925084540589/pdf/P172605-88f301e0-1bf7-49cf-b5a9-1714e4320d40.pdf',
    'English',
    'Brazil',
    '',
    '',
    'Brazil - LATIN AMERICA AND CARIBBEAN- P172605- Salvador Social Multi-Sector Service Delivery Project II - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40044395',
    'Turkiye - EUROPE AND CENTRAL ASIA- P171645- Turkey Organized Industrial Zones Project - Procurement Plan',
    '2025-09-19',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091925090015822/pdf/P171645-69a02402-418c-4832-914c-1191e5d4c824.pdf',
    'English',
    'Turkiye',
    '',
    '',
    'Turkiye - EUROPE AND CENTRAL ASIA- P171645- Turkey Organized Industrial Zones Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40043977',
    'St Maarten - LATIN AMERICA AND CARIBBEAN- P179067- SINT MAARTEN: WASTEWATER MANAGEMENT PROJECT - Procurement Plan',
    '2025-09-18',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091825125034884/pdf/P179067-40fa8577-66df-4087-840d-9ebce49fe506.pdf',
    'English',
    'St Maarten',
    '',
    '',
    'St Maarten - LATIN AMERICA AND CARIBBEAN- P179067- SINT MAARTEN: WASTEWATER MANAGEMENT PROJECT - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40043888',
    'Uzbekistan - EUROPE AND CENTRAL ASIA- P504420- INnovative SOcial Protection System for inclusiON of Vulnerable People Project - Procurement Plan',
    '2025-09-18',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091825040029804/pdf/P504420-cd04d97e-3e4f-4c36-aca8-91e870dac15c.pdf',
    'English',
    'Uzbekistan',
    '',
    '',
    'Uzbekistan - EUROPE AND CENTRAL ASIA- P504420- INnovative SOcial Protection System for inclusiON of Vulnerable People Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40043972',
    'Official Documents- Supplemental Contribution Amendment to the Contribution Agreement by the Principality of Monaco, acting through its Ministry of Foreign Affairs and Cooperation, for TF069031.pdf',
    '2025-09-18',
    '',
    'Agreement',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091825120518003/pdf/TF069031-3f17ce57-6289-4ccd-a7d5-e0965074f000.pdf',
    'English',
    '',
    '',
    '',
    'Official Documents- Supplemental Contribution Amendment to the Contribution Agreement by the Principality of Monaco, acting through its Ministry of Foreign Affairs and Cooperation, for TF069031.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40043907',
    'Eastern and Southern Africa - EASTERN AND SOUTHERN AFRICA- P178566- Food Systems Resilience Program for Eastern and Southern Africa - Procurement Plan',
    '2025-09-18',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091825065029707/pdf/P178566-bc9afd91-e9f9-404f-af1d-2f07ab9503be.pdf',
    'English',
    'Eastern and Southern Africa',
    '',
    '',
    'Eastern and Southern Africa - EASTERN AND SOUTHERN AFRICA- P178566- Food Systems Resilience Program for Eastern and Southern Africa - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40043909',
    'India - SOUTH ASIA- P163533- Odisha Integrated Irrigation Project for Climate Resilient Agriculture - Procurement Plan',
    '2025-09-18',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091825072035567/pdf/P163533-81ee83a4-c300-4b62-9aad-cc60f08a8a3e.pdf',
    'English',
    'India',
    '',
    '',
    'India - SOUTH ASIA- P163533- Odisha Integrated Irrigation Project for Climate Resilient Agriculture - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40043922',
    'Official Documents- Amendment Letter to the Financing Agreement for Credit 7081-KG and Grant E009-KG Ref. Changes in the Disbursement Categories.pdf',
    '2025-09-18',
    '',
    'Agreement',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091825090013267/pdf/P173734-83f79290-564a-403e-b8ff-4972927a5dee.pdf',
    'English',
    'Kyrgyz Republic',
    '',
    '',
    'Official Documents- Amendment Letter to the Financing Agreement for Credit 7081-KG and Grant E009-KG Ref. Changes in the Disbursement Categories.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40043809',
    'Disclosable Restructuring Paper - EC Guayaquil Wastewater Management Project - P151439',
    '2025-09-18',
    '',
    'Project Paper',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091725214023781/pdf/P151439-4f113949-38df-46ee-91c9-bafa30ad4940.pdf',
    'English',
    'Ecuador',
    '',
    '',
    'Disclosable Restructuring Paper - EC Guayaquil Wastewater Management Project - P151439'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40043860',
    'Papua New Guinea - EAST ASIA AND PACIFIC- P174637- Child Nutrition and Social Protection Project - Procurement Plan',
    '2025-09-18',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091825013029191/pdf/P174637-eaf6cbed-2b97-4e24-ad3a-e0a652d36b28.pdf',
    'English',
    'Papua New Guinea',
    '',
    '',
    'Papua New Guinea - EAST ASIA AND PACIFIC- P174637- Child Nutrition and Social Protection Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40043864',
    'Nepal - SOUTH ASIA- P177902- Accelerating Transport and Trade Connectivity in Eastern South Asia ? Nepal Phase 1 Project - Procurement Plan',
    '2025-09-18',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091825014019711/pdf/P177902-eb6791d1-4ffd-4f1f-8f88-776f3fb9de3d.pdf',
    'English',
    'Nepal',
    '',
    '',
    'Nepal - SOUTH ASIA- P177902- Accelerating Transport and Trade Connectivity in Eastern South Asia ? Nepal Phase 1 Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40043881',
    'Djibouti - MID EAST,NORTH AFRICA,AFG,PAK- P176690- Micro, Small and Medium Enterprises Business Development Services Project - Procurement Plan',
    '2025-09-18',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091825025567984/pdf/P176690-21f64d14-cdb5-447c-9b1e-a61d2b54a038.pdf',
    'English',
    'Djibouti',
    '',
    '',
    'Djibouti - MID EAST,NORTH AFRICA,AFG,PAK- P176690- Micro, Small and Medium Enterprises Business Development Services Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40040240',
    'How Scale-Up Happens : Financing, Political Economy, and Delivery in Social Assistance Expansion',
    '2025-09-18',
    '',
    'Report',
    'Publications & Research',
    1,
    NULL,
    'https://documents.worldbank.org/curated/en/099082825150531902/pdf/P176435-62bc3103-ac50-4f88-b01e-6b5e04242120.pdf',
    'English',
    'World',
    '',
    '',
    'How Scale-Up Happens : Financing, Political Economy, and Delivery in Social Assistance Expansion'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40043911',
    'Niger - WESTERN AND CENTRAL AFRICA- P168779- Niger Learning Improvement for Results in Education Project - Procurement Plan',
    '2025-09-18',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091825073021668/pdf/P168779-a2b229ed-9b51-4f1b-a2a2-5b2bf3170554.pdf',
    'English',
    'Niger',
    '',
    '',
    'Niger - WESTERN AND CENTRAL AFRICA- P168779- Niger Learning Improvement for Results in Education Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40043914',
    'Uzbekistan - EUROPE AND CENTRAL ASIA- P162263- Water Services and Institutional Support Project - Procurement Plan',
    '2025-09-18',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091825082034172/pdf/P162263-be5f8780-a781-4d2f-a0f5-05b18da74ecc.pdf',
    'English',
    'Uzbekistan',
    '',
    '',
    'Uzbekistan - EUROPE AND CENTRAL ASIA- P162263- Water Services and Institutional Support Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40043963',
    'Burkina Faso - WESTERN AND CENTRAL AFRICA- P178598- Burkina Faso Livestock Resilience and Competitiveness Project - Procurement Plan',
    '2025-09-18',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091825110538426/pdf/P178598-207d25c1-cccd-43cf-b7e5-4aa9a52b11a2.pdf',
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
    '40043924',
    'Dominican Republic - LATIN AMERICA AND CARIBBEAN- P180163- Dominican Republic Emergency Response and Resilience Project - Procurement Plan',
    '2025-09-18',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091825090589909/pdf/P180163-997bbd88-dd9e-4b2a-a6c9-9cc2d323016a.pdf',
    'English',
    'Dominican Republic',
    '',
    '',
    'Dominican Republic - LATIN AMERICA AND CARIBBEAN- P180163- Dominican Republic Emergency Response and Resilience Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, lang, country, author, publisher, content_text
) VALUES (
    '40043902',
    'Morocco - MID EAST,NORTH AFRICA,AFG,PAK- P175747- Resilient and Sustainable Water in Agriculture - Procurement Plan',
    '2025-09-18',
    '',
    'Procurement Plan',
    'Project Documents',
    NULL,
    NULL,
    'https://documents.worldbank.org/curated/en/099091825062523318/pdf/P175747-e73f6d61-0aee-4101-ae3c-8e693bad0476.pdf',
    'English',
    'Morocco',
    '',
    '',
    'Morocco - MID EAST,NORTH AFRICA,AFG,PAK- P175747- Resilient and Sustainable Water in Agriculture - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

