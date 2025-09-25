-- World Bank Documents Data
-- Generated on 2025-09-24 18:39:02
-- Total documents: 50

-- Insert countries
INSERT INTO countries (name, code, region) VALUES
('Angola', 'ANG', 'Unknown'),
('Bolivia,Brazil,Ecuador,Colombia,Guyana,Suriname,Peru', 'BOL', 'Unknown'),
('Brazil', 'BRA', 'Unknown'),
('Burkina Faso', 'BUR', 'Unknown'),
('Chad', 'CHA', 'Unknown'),
('Eastern and Southern Africa', 'EAS', 'Unknown'),
('Ecuador', 'ECU', 'Unknown'),
('Ethiopia', 'ETH', 'Unknown'),
('Gambia, The', 'GAM', 'Unknown'),
('Georgia', 'GEO', 'Unknown'),
('Ghana', 'GHA', 'Unknown'),
('Guatemala', 'GUA', 'Unknown'),
('Haiti', 'HAI', 'Unknown'),
('India', 'IND', 'Unknown'),
('Jamaica', 'JAM', 'Unknown'),
('Kosovo', 'KOS', 'Unknown'),
('Lebanon', 'LEB', 'Unknown'),
('Liberia', 'LIB', 'Unknown'),
('Maldives', 'MAL', 'Unknown'),
('Mali', 'MAL', 'Unknown'),
('Mauritania', 'MAU', 'Unknown'),
('Moldova', 'MOL', 'Unknown'),
('Nepal', 'NEP', 'Unknown'),
('Nigeria', 'NIG', 'Unknown'),
('Pakistan', 'PAK', 'Unknown'),
('Peru', 'PER', 'Unknown'),
('Sri Lanka', 'SRI', 'Unknown'),
('Sudan', 'SUD', 'Unknown'),
('Tajikistan', 'TAJ', 'Unknown'),
('Turkiye', 'TUR', 'Unknown'),
('Tuvalu', 'TUV', 'Unknown'),
('Ukraine', 'UKR', 'Unknown'),
('West Bank and Gaza', 'WES', 'Unknown'),
('Western and Central Africa', 'WES', 'Unknown'),
('World', 'WOR', 'Unknown')
ON CONFLICT (name) DO NOTHING;

-- Insert languages
INSERT INTO languages (name, code) VALUES
('Arabic', 'ar'),
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
('Project Information Document', 'Project Documents')
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
    'P165557-f25f8ee3-ba39-43fe-a0eb-cd711d88eb49.pdf',
    'DOWNLOADED',
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
    'P179365-20b99485-9b6e-49ed-93ee-9976c1043be5.pdf',
    'DOWNLOADED',
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
    'P165557-2c1083ca-3f3c-4534-ac20-d1dc178b09ab.pdf',
    'DOWNLOADED',
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
    'P165557-501197d3-f4a0-49af-aaeb-23f786589fb4.pdf',
    'DOWNLOADED',
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
    'P165557-c57a4522-84fd-4b36-aaac-4051420ea046.pdf',
    'DOWNLOADED',
    'English',
    'Ghana',
    '',
    '',
    'Official Documents- Amendment No. 3 to the Financing Agreement for Credit 6482-GH.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
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
    'P168481-34503cea-b0e6-432a-ba9e-98dd51ef9f88.pdf',
    'DOWNLOADED',
    'English',
    'Georgia',
    '',
    '',
    'Official Documents- Second Amendment to the Loan Agreement for Loan 8955-GE.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
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
    'P180849-8d22f7cf-6d7c-4b68-aa48-b3a6e065b60b.pdf',
    'DOWNLOADED',
    'English',
    'Turkiye',
    '',
    '',
    'Official Documents- Second Amendment to the Loan Agreement for Loan 9580-TR.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
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
    'P181495-588c8f8d-f594-4727-99a6-dbffa3628018.pdf',
    'DOWNLOADED',
    'English',
    'Angola',
    '',
    '',
    'Official Documents- Loan Agreement for Loan 9718-AO.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
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
    'P507921-07da4923-b94e-4de1-944b-2f4d7666ebb0.pdf',
    'DOWNLOADED',
    'English',
    'Mali',
    '',
    '',
    'Official Documents- Disbursement and Financial Information Letter for V5320-ML.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
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
    'P507921-e305b9a6-56cc-4e86-8024-34bbbb65d211.pdf',
    'DOWNLOADED',
    'English',
    'Mali',
    '',
    '',
    'Official Documents- Agreement for Advance No. V5320-ML.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
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
    'BOSIB-9b099c36-ec91-4c49-a173-24653c9e3697.pdf',
    'DOWNLOADED',
    'English',
    'Ethiopia',
    '',
    '',
    'Ethiopia - Joint World Bank-IMF Debt Sustainability Analysis'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
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
    'BOSIB-f3c4c161-7123-4c2d-a412-7d3be29fa34a.pdf',
    'DOWNLOADED',
    'English',
    'Tajikistan',
    '',
    '',
    'Tajikistan - Joint World Bank-IMF Debt Sustainability Analysis'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
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
    'IDU-7acd5b7f-043a-4f3c-a963-fa12b7096a84.pdf',
    'DOWNLOADED',
    'English',
    'World',
    '',
    '',
    ''
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
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
    'P511828-705be4ac-50c6-4243-a6cd-73d947cfcf55.pdf',
    'DOWNLOADED',
    'English',
    'Sri Lanka',
    '',
    '',
    'Official Documents- Disbursement and Financial Information Letter for Grant E572-LK.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
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
    'P178598-eca71dfc-0099-4397-b3ed-5e73f2b1edbb.pdf',
    'DOWNLOADED',
    'English',
    'Burkina Faso',
    '',
    '',
    'Disclosable Version of the ISR - Burkina Faso Livestock Resilience and Competitiveness Project - P178598 - Sequence No : 5'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
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
    'IDU-4dbeb6f9-cd9c-45e8-9557-35fba01b0036.pdf',
    'DOWNLOADED',
    'English',
    'World',
    '',
    '',
    'Rethinking Resilience : Challenges for Developing Countries in the Face of Climate Change and Disaster Risks'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
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
    'P506083-0b9341e6-aefc-4c82-b1c1-263b0dcd7b9a.pdf',
    'DOWNLOADED',
    'English',
    'Ukraine',
    '',
    '',
    'Ukraine - EUROPE AND CENTRAL ASIA- P506083- Transforming Healthcare through Reform and Investments in Efficiency - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
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
    'P171627-f0bb1665-5cf0-46ab-9d39-7bb2a7488419.pdf',
    'DOWNLOADED',
    'English',
    'Ethiopia',
    '',
    '',
    'Ethiopia - EASTERN AND SOUTHERN AFRICA- P171627- Financial Sector Strengthening Project (FSSP) - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
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
    'P506528-7b62f98c-1528-48d8-bcaf-d32e9eaed7e9.pdf',
    'DOWNLOADED',
    'English',
    'Burkina Faso',
    '',
    '',
    'Revised Environmental and Social Commitment Plan (ESCP) Human Capital Protection Project (P506528)'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
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
    'P179558-625f8913-26fa-4d67-8619-43b6752549af.pdf',
    'DOWNLOADED',
    'English',
    'Mauritania',
    '',
    '',
    'Mauritania - WESTERN AND CENTRAL AFRICA- P179558- Mauritania Health System Support Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
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
    'P181354-99857001-1e99-48d0-affb-ce5112e6531f.pdf',
    'DOWNLOADED',
    'English',
    'West Bank and Gaza',
    '',
    '',
    'West Bank and Gaza - MID EAST,NORTH AFRICA,AFG,PAK- P181354- Innovative Private Sector Development II - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
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
    'P509428-8183afa5-2d83-4fd5-9788-2230e5216342.pdf',
    'DOWNLOADED',
    'English',
    'Lebanon',
    '',
    '',
    'Disclosable Version of the ISR - Lebanon Emergency Assistance Project - P509428 - Sequence No : 1'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
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
    'P166279-4080417f-0793-415a-9ecc-3d2f212f9d70.pdf',
    'DOWNLOADED',
    'English',
    'Jamaica',
    '',
    '',
    'Jamaica - LATIN AMERICA AND CARIBBEAN- P166279- Second Rural Economic Development Initiative (REDI II) Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
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
    'P501985-90b75bed-aa38-46bc-9dfe-431134be79fa.pdf',
    'DOWNLOADED',
    'English',
    'Nepal',
    '',
    '',
    'Nepal - SOUTH ASIA- P501985- Electricity Supply Reliability Improvement Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
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
    'P172834-a90b0a4e-c6c9-484c-b7bf-8c13011ca3b6.pdf',
    'DOWNLOADED',
    'English',
    'Pakistan',
    '',
    '',
    'Pakistan - MID EAST,NORTH AFRICA,AFG,PAK- P172834- Sindh Early Learning Enhancement through Classroom Transformation - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
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
    'P504629-f8992420-6b24-4296-bf70-918431a5811f.pdf',
    'DOWNLOADED',
    'English',
    'Sudan',
    '',
    '',
    'Disclosable Version of the ISR - Sudan Health Assistance and Response to Emergencies - P504629 - Sequence No : 2'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
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
    'P173830-4f3f1f2d-6594-465f-8b03-da42f7299505.pdf',
    'DOWNLOADED',
    'English',
    'Western and Central Africa',
    '',
    '',
    'Western and Central Africa - WESTERN AND CENTRAL AFRICA- P173830- Community-Based Recovery and Stabilization Project for the Sahel - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
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
    'P179363-5cff9b86-e90b-4cb5-a39e-e2b9ec196d20.pdf',
    'DOWNLOADED',
    'English',
    'Moldova',
    '',
    '',
    'Moldova - EUROPE AND CENTRAL ASIA- P179363- Education Quality Improvement Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
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
    'P502008-b822b07a-6edc-4186-9742-3dedbf84b77f.pdf',
    'DOWNLOADED',
    'Arabic',
    'World',
    '',
    '',
    'الهجرة : إمكانات أفريقيا غير المستغلة'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
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
    NULL,
    'PENDING',
    'English',
    'Sudan',
    '',
    '',
    'Gender-Based Violence (GBV) Assessment Sudan - Enhancing Community Resilience Project (P181490)'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
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
    'P180688-c0260530-8b9d-4aab-be28-809e4f30f19f.pdf',
    'DOWNLOADED',
    'English',
    'Ecuador',
    '',
    '',
    'Ecuador - LATIN AMERICA AND CARIBBEAN- P180688- Strengthening the Resilience of Ecuadorian Schools Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
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
    'IDU-b811c80c-834e-4e93-9b99-1214ee5b1884.pdf',
    'DOWNLOADED',
    'French',
    'World',
    '',
    '',
    'Transparence Radicale de la dette'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
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
    'IDU-97c071f0-a309-4213-9ca4-96ddea75bf3f.pdf',
    'DOWNLOADED',
    'Portuguese',
    'World',
    '',
    '',
    'Repensando a Resiliência : Desafios para Países em Desenvolvimento Diante das Mudanças Climáticas e Riscos para Desastres'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
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
    'P170734-6628aa03-b7dd-434c-a938-aae425668f40.pdf',
    'DOWNLOADED',
    'English',
    'Nigeria',
    '',
    '',
    'Nigeria - WESTERN AND CENTRAL AFRICA - P170734 - Nigeria Sustainable Urban and Rural Water Supply, Sanitation and Hygiene Program-for-Results - Audited Financial Statement'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
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
    'P157043-9a5d852e-cc3d-4fbc-a471-2b1e7f8d0fa8.pdf',
    'DOWNLOADED',
    'English',
    'Peru',
    '',
    '',
    'Peru - LATIN AMERICA AND CARIBBEAN- P157043- Modernization of Water Supply and Sanitation Services - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
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
    'P176375-88084d73-84bf-426a-8163-72fd293050cd.pdf',
    'DOWNLOADED',
    'English',
    'Turkiye',
    '',
    '',
    'Disclosable Version of the ISR - Accelerating the Market Transition for Distributed Energy Program as part of ECARES MPA - P176375 - Sequence No : 4'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
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
    'P175731-3cb5b7cd-6964-4123-9a05-8c4aaedcf728.pdf',
    'DOWNLOADED',
    'English',
    'Eastern and Southern Africa',
    '',
    '',
    'Eastern and Southern Africa - EASTERN AND SOUTHERN AFRICA- P175731- SADC Regional Statistics Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
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
    'P172012-e3fc5206-76a2-422f-b4ee-da3e501abd6a.pdf',
    'DOWNLOADED',
    'English',
    'Liberia',
    '',
    '',
    'Liberia - WESTERN AND CENTRAL AFRICA- P172012- Liberia Sustainable Management of Fisheries Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
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
    'P510691-fbd97f10-0e5e-4b72-a2c1-cf38d5ee1356.pdf',
    'DOWNLOADED',
    'English',
    'Brazil',
    '',
    '',
    'Concept Project Information Document (PID)'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
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
    'P173743-a4c560a8-8a41-4584-a3b4-3ac8529b7661.pdf',
    'DOWNLOADED',
    'English',
    'Haiti',
    '',
    '',
    'Haiti - LATIN AMERICA AND CARIBBEAN- P173743- Private Sector Jobs and Economic Transformation (PSJET) - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
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
    'P178162-ddee12a2-43fc-4780-87ce-68f950d40be4.pdf',
    'DOWNLOADED',
    'English',
    'Kosovo',
    '',
    '',
    'Kosovo - EUROPE AND CENTRAL ASIA- P178162- Strengthening Digital Governance for Service Delivery - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
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
    'P179749-5b81308e-fe7c-4505-b7b9-a8795b85791e.pdf',
    'DOWNLOADED',
    'English',
    'India',
    '',
    '',
    'India - SOUTH ASIA- P179749- Uttarakhand Disaster Preparedness and Resilience Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
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
    'P504762-58c8e924-7071-4434-9855-506e5497a046.pdf',
    'DOWNLOADED',
    'English',
    'Gambia, The',
    '',
    '',
    'Gambia, The - WESTERN AND CENTRAL AFRICA- P504762- The Gambia Infrastructure Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
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
    'P179599-3bbea9d4-397d-465b-b112-2e0e1050b2f9.pdf',
    'DOWNLOADED',
    'English',
    'Tuvalu',
    '',
    '',
    'Official Documents- First Restatement of the Disbursement and Financial Information Letter for Grant E275-TV.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
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
    'TF074190-b4b6c4fe-7282-4a8b-ab79-b5815b347eb4.pdf',
    'DOWNLOADED',
    'English',
    '',
    '',
    '',
    'Official Documents- Administration Agreement with the Government of Flanders, acting through the Flemish Department of Foreign Affairs, for TF074190.pdf'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
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
    'P177768-502d7582-334f-4bd5-9859-73c4414957c0.pdf',
    'DOWNLOADED',
    'English',
    'Maldives',
    '',
    '',
    'Maldives - SOUTH ASIA- P177768- Maldives Atoll Education Development Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
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
    'P174495-423356b7-4229-456b-a9c8-289154fa0df7.pdf',
    'DOWNLOADED',
    'English',
    'Chad',
    '',
    '',
    'Chad - WESTERN AND CENTRAL AFRICA- P174495- Chad Energy Access Scale Up Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
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
    'P159213-c55cd564-7c2e-4be0-b594-900dc9170dc1.pdf',
    'DOWNLOADED',
    'English',
    'Guatemala',
    '',
    '',
    'Guatemala - LATIN AMERICA AND CARIBBEAN- P159213- Crecer Sano: Guatemala Nutrition and Health Project - Procurement Plan'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
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
    'IDU-bedb75da-f03b-4364-852c-685bbabd6f23.pdf',
    'DOWNLOADED',
    'English',
    'Bolivia,Brazil,Ecuador,Colombia,Guyana,Suriname,Peru',
    '',
    '',
    'Amazonia Viva GCF Program : Environmental and Social Sustainability Framework'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO documents (
    id, title, docdt, abstract, docty, majdocty, volnb, totvolnb, 
    url, document_location, document_status, lang, country, author, publisher, content_text
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
    'IDU-ea11837f-1b0f-46b5-bc1a-cbdc0e0f7997.pdf',
    'DOWNLOADED',
    'Spanish',
    'World',
    '',
    '',
    'Repensando la Resiliencia : Desafíos para Países en Desarrollo Ante El Cambio Climático y Los Riesgos de Desastres'
) ON CONFLICT (id) DO NOTHING;

