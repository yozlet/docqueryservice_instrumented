#!/usr/bin/env python3
"""
Tests for the World Bank API Scraper
"""

import json
import pytest
import responses
import tempfile
import os
from unittest.mock import patch, mock_open
from worldbank_scraper import WorldBankScraper

class TestWorldBankScraper:
    """Test suite for WorldBankScraper class"""

    def setup_method(self):
        """Set up test fixtures before each test method"""
        self.scraper = WorldBankScraper()
        self.sample_api_response = {
            "rows": 2,
            "os": 0,
            "page": 1,
            "total": 573844,
            "documents": {
                "D12345": {
                    "id": "12345",
                    "display_title": "Test Document 1",
                    "docdt": "2023-01-15T00:00:00Z",
                    "abstract": "This is a test document about renewable energy.",
                    "docty": "Project Document",
                    "majdocty": "Project Documents",
                    "volnb": 1,
                    "totvolnb": 1,
                    "url": "http://documents.worldbank.org/test1",
                    "pdfurl": "https://documents.worldbank.org/test1.pdf",
                    "lang": "English",
                    "count": "Brazil",
                    "author": "World Bank Team",
                    "publisher": "World Bank"
                },
                "D67890": {
                    "id": "67890",
                    "display_title": "Test Document 2",
                    "docdt": "2023-02-20T00:00:00Z",
                    "abstract": "",
                    "docty": "Analytical Work",
                    "majdocty": "Research",
                    "volnb": None,
                    "totvolnb": None,
                    "url": "http://documents.worldbank.org/test2",
                    "lang": ["English", "Spanish"],
                    "count": ["Kenya", "Tanzania"],
                    "author": "",
                    "publisher": "",
                    "docna": [{"docna": "Alternative document name"}]
                }
            }
        }

    def test_init(self):
        """Test scraper initialization"""
        assert self.scraper.base_url == "https://search.worldbank.org/api/v3/wds"
        assert "WorldBank-Scraper" in self.scraper.session.headers['User-Agent']

    def test_clean_text_basic(self):
        """Test basic text cleaning functionality"""
        # Test normal text
        result = self.scraper.clean_text("Normal text")
        assert result == "Normal text"
        
        # Test None input
        result = self.scraper.clean_text(None)
        assert result == ""
        
        # Test with special characters
        result = self.scraper.clean_text("Text with 'quotes' and \n newlines \r returns")
        assert result == "Text with ''quotes'' and newlines returns"
        
        # Test with null bytes
        result = self.scraper.clean_text("Text\x00with\x00nulls")
        assert result == "Textwithnulls"
        
        # Test length limiting
        long_text = "a" * 6000
        result = self.scraper.clean_text(long_text)
        assert len(result) == 5000

    def test_extract_countries_from_docs(self):
        """Test country extraction from document list"""
        docs = [
            {"count": "Brazil"},
            {"count": ["Kenya", "Tanzania"]},
            {"count": "Brazil"},  # Duplicate should be removed
            {"count": None},  # Should be ignored
            {}  # Missing count should be ignored
        ]
        
        result = self.scraper.extract_countries_from_docs(docs)
        expected = ["Brazil", "Kenya", "Tanzania"]
        assert result == expected

    def test_extract_languages_from_docs(self):
        """Test language extraction from document list"""
        docs = [
            {"lang": "English"},
            {"lang": ["Spanish", "French"]},
            {"lang": "English"},  # Duplicate should be removed
            {"lang": None},  # Should be ignored
            {}  # Missing lang should be ignored
        ]
        
        result = self.scraper.extract_languages_from_docs(docs)
        expected = ["English", "French", "Spanish"]
        assert result == expected

    def test_extract_doctypes_from_docs(self):
        """Test document type extraction from document list"""
        docs = [
            {"docty": "Project Document", "majdocty": "Project Documents"},
            {"docty": ["Analytical Work"], "majdocty": ["Research"]},
            {"docty": "Project Document", "majdocty": "Project Documents"},  # Duplicate
            {"docty": None},  # Should be ignored
            {}  # Missing docty should be ignored
        ]
        
        result = self.scraper.extract_doctypes_from_docs(docs)
        
        # Should have unique document types
        assert len(result) == 2
        
        # Check specific entries exist
        project_doc = next((dt for dt in result if dt['type_name'] == 'Project Document'), None)
        assert project_doc is not None
        assert project_doc['major_type'] == 'Project Documents'
        
        analytical = next((dt for dt in result if dt['type_name'] == 'Analytical Work'), None)
        assert analytical is not None
        assert analytical['major_type'] == 'Research'

    @responses.activate
    def test_fetch_documents_success(self):
        """Test successful document fetching from API"""
        # Mock the API response
        responses.add(
            responses.GET,
            "https://search.worldbank.org/api/v3/wds",
            json=self.sample_api_response,
            status=200
        )
        
        result = self.scraper.fetch_documents(count=2)
        
        assert len(result) == 2
        assert result[0]['id'] == '12345'
        assert result[1]['id'] == '67890'
        assert result[0]['display_title'] == 'Test Document 1'

    @responses.activate
    def test_fetch_documents_with_query_params(self):
        """Test document fetching with query parameters"""
        responses.add(
            responses.GET,
            "https://search.worldbank.org/api/v3/wds",
            json=self.sample_api_response,
            status=200
        )
        
        result = self.scraper.fetch_documents(
            count=1, 
            start_offset=10, 
            query_term="renewable energy",
            country="Brazil"
        )
        
        # Check that the request was made with correct parameters
        assert len(responses.calls) == 1
        request = responses.calls[0].request
        assert "qterm=renewable+energy" in request.url
        assert "count_exact=Brazil" in request.url
        assert "os=10" in request.url
        assert "rows=1" in request.url

    @responses.activate
    def test_fetch_documents_empty_response(self):
        """Test handling of empty API response"""
        empty_response = {"documents": {}}
        responses.add(
            responses.GET,
            "https://search.worldbank.org/api/v3/wds",
            json=empty_response,
            status=200
        )
        
        result = self.scraper.fetch_documents(count=5)
        assert result == []

    @responses.activate
    def test_fetch_documents_api_error(self):
        """Test handling of API errors"""
        responses.add(
            responses.GET,
            "https://search.worldbank.org/api/v3/wds",
            status=500
        )
        
        with pytest.raises(Exception):
            self.scraper.fetch_documents(count=1)

    def test_generate_sql_inserts(self):
        """Test SQL INSERT generation"""
        docs = list(self.sample_api_response["documents"].values())
        
        with tempfile.NamedTemporaryFile(mode='w', delete=False, suffix='.sql') as f:
            temp_file = f.name
        
        try:
            self.scraper.generate_sql_inserts(docs, temp_file)
            
            # Read the generated SQL file
            with open(temp_file, 'r') as f:
                sql_content = f.read()
            
            # Check that SQL content contains expected elements
            assert "INSERT INTO countries" in sql_content
            assert "INSERT INTO languages" in sql_content
            assert "INSERT INTO document_types" in sql_content
            assert "INSERT INTO documents" in sql_content
            
            # Check specific data
            assert "'Brazil'" in sql_content
            assert "'Kenya'" in sql_content
            assert "'English'" in sql_content
            assert "'Test Document 1'" in sql_content
            assert "'12345'" in sql_content
            
            # Check conflict handling
            assert "ON CONFLICT" in sql_content
            
        finally:
            # Clean up temp file
            os.unlink(temp_file)

    def test_generate_sql_inserts_field_mapping(self):
        """Test correct field mapping in SQL generation"""
        docs = [{
            "id": "test123",
            "display_title": "Test Title",
            "docdt": "2023-01-01T00:00:00Z",
            "abstract": "Test abstract",
            "docty": "Agreement",
            "majdocty": "Project Documents",
            "url": "http://test.url",
            "pdfurl": "https://test.pdf",
            "lang": "English",
            "count": "TestCountry",
            "author": "Test Author",
            "publisher": "Test Publisher"
        }]
        
        with tempfile.NamedTemporaryFile(mode='w', delete=False, suffix='.sql') as f:
            temp_file = f.name
        
        try:
            self.scraper.generate_sql_inserts(docs, temp_file)
            
            with open(temp_file, 'r') as f:
                sql_content = f.read()
            
            # Verify key field mappings
            assert "'test123'" in sql_content  # ID
            assert "'Test Title'" in sql_content  # display_title -> title
            assert "'2023-01-01'" in sql_content  # docdt parsed correctly
            assert "'Test abstract'" in sql_content  # abstract
            assert "'https://test.pdf'" in sql_content  # pdfurl preferred over url
            assert "'English'" in sql_content  # lang
            assert "'TestCountry'" in sql_content  # count -> country
            
        finally:
            os.unlink(temp_file)

    def test_generate_sql_inserts_nested_docna(self):
        """Test handling of nested docna field for abstract"""
        docs = [{
            "id": "test456",
            "display_title": "Test Title",
            "abstract": "",  # Empty abstract
            "docna": [{"docna": "Document name from nested field"}],
            "docty": "Report",
            "lang": "English",
            "count": "TestCountry"
        }]
        
        with tempfile.NamedTemporaryFile(mode='w', delete=False, suffix='.sql') as f:
            temp_file = f.name
        
        try:
            self.scraper.generate_sql_inserts(docs, temp_file)
            
            with open(temp_file, 'r') as f:
                sql_content = f.read()
            
            # Should use docna content when abstract is empty
            assert "'Document name from nested field'" in sql_content
            
        finally:
            os.unlink(temp_file)

    @patch('builtins.print')
    def test_fetch_documents_rate_limiting(self, mock_print):
        """Test that rate limiting delay is applied"""
        with patch('time.sleep') as mock_sleep:
            with responses.RequestsMock() as rsps:
                rsps.add(
                    responses.GET,
                    "https://search.worldbank.org/api/v3/wds",
                    json=self.sample_api_response,
                    status=200
                )
                
                self.scraper.fetch_documents(count=2)
                
                # Should call sleep for rate limiting
                mock_sleep.assert_called_with(1)

    def test_date_parsing_edge_cases(self):
        """Test various date format parsing scenarios"""
        docs = [
            {"id": "1", "docdt": "2023-01-15T00:00:00Z", "display_title": "Test 1"},
            {"id": "2", "docdt": "2023-02-20", "display_title": "Test 2"},
            {"id": "3", "docdt": None, "display_title": "Test 3"},
            {"id": "4", "docdt": "invalid-date", "display_title": "Test 4"},
            {"id": "5", "display_title": "Test 5"}  # Missing docdt
        ]
        
        with tempfile.NamedTemporaryFile(mode='w', delete=False, suffix='.sql') as f:
            temp_file = f.name
        
        try:
            self.scraper.generate_sql_inserts(docs, temp_file)
            
            with open(temp_file, 'r') as f:
                sql_content = f.read()
            
            # Should handle various date formats gracefully
            assert "'2023-01-15'" in sql_content  # ISO format
            assert "'2023-02-20'" in sql_content  # Simple date
            assert "NULL" in sql_content  # NULL for invalid/missing dates
            
        finally:
            os.unlink(temp_file)

class TestScraperCLI:
    """Test the command-line interface"""

    @patch('worldbank_scraper.WorldBankScraper.fetch_documents')
    @patch('worldbank_scraper.WorldBankScraper.generate_sql_inserts')
    def test_cli_basic_usage(self, mock_generate, mock_fetch):
        """Test basic CLI functionality"""
        # Mock return values
        mock_fetch.return_value = [{"id": "test", "display_title": "Test Doc"}]
        
        from worldbank_scraper import main
        import sys
        
        # Mock command line arguments
        test_args = ['worldbank_scraper.py', '--count', '10', '--output', 'test.sql']
        with patch.object(sys, 'argv', test_args):
            main()
        
        # Verify methods were called with correct parameters
        mock_fetch.assert_called_once_with(
            count=10,
            start_offset=0,
            query_term=None,
            country=None
        )
        mock_generate.assert_called_once()

    @patch('worldbank_scraper.WorldBankScraper.fetch_documents')
    @patch('worldbank_scraper.WorldBankScraper.generate_sql_inserts')
    def test_cli_with_all_params(self, mock_generate, mock_fetch):
        """Test CLI with all parameters"""
        mock_fetch.return_value = [{"id": "test", "display_title": "Test Doc"}]
        
        from worldbank_scraper import main
        import sys
        
        test_args = [
            'worldbank_scraper.py', 
            '--count', '50',
            '--output', 'custom.sql',
            '--query', 'renewable energy',
            '--country', 'Brazil',
            '--offset', '100'
        ]
        
        with patch.object(sys, 'argv', test_args):
            main()
        
        mock_fetch.assert_called_once_with(
            count=50,
            start_offset=100,
            query_term='renewable energy',
            country='Brazil'
        )

if __name__ == "__main__":
    pytest.main([__file__, "-v"])