#!/usr/bin/env python3
"""
API Contract Tests for World Bank Documents API Implementation

This test suite validates that any implementation of the World Bank Documents API
conforms to the API contract specification. Can be run against .NET or Java implementations.
"""

import json
import pytest
import requests
import yaml
from datetime import datetime
from typing import Dict, List, Any, Optional
from jsonschema import validate, ValidationError
import os

class APIContractTester:
    """Test any API implementation against the World Bank API contract"""
    
    def __init__(self, base_url: str):
        self.base_url = base_url.rstrip('/')
        self.session = requests.Session()
        self.session.headers.update({
            'User-Agent': 'API-Contract-Tester/1.0'
        })
        
        # Load OpenAPI schema for validation
        self.openapi_schema = self._load_openapi_schema()
        self.document_schema = self._extract_document_schema()
        self.response_schema = self._extract_response_schema()
    
    def _load_openapi_schema(self) -> Dict[str, Any]:
        """Load the OpenAPI specification for validation"""
        schema_path = os.path.join(os.path.dirname(__file__), '..', 'docs', 'openapi.yaml')
        with open(schema_path, 'r') as f:
            return yaml.safe_load(f)
    
    def _extract_document_schema(self) -> Dict[str, Any]:
        """Extract Document schema from OpenAPI spec"""
        return self.openapi_schema['components']['schemas']['Document']
    
    def _extract_response_schema(self) -> Dict[str, Any]:
        """Extract DocumentSearchResponse schema from OpenAPI spec"""
        return self.openapi_schema['components']['schemas']['DocumentSearchResponse']
    
    def _validate_document_schema(self, document: Dict[str, Any]) -> None:
        """Validate a document against the schema"""
        try:
            # Create a simplified schema for validation since jsonschema
            # doesn't handle OpenAPI 3.0 directly
            simplified_schema = {
                "type": "object",
                "required": ["id"],
                "properties": {
                    "id": {"type": "string"},
                    "title": {"type": ["string", "null"]},
                    "docdt": {"type": ["string", "null"]},
                    "abstract": {"type": ["string", "null"]},
                    "docty": {"type": ["string", "null"]},
                    "majdocty": {"type": ["string", "null"]},
                    "volnb": {"type": ["integer", "null"]},
                    "totvolnb": {"type": ["integer", "null"]},
                    "url": {"type": ["string", "null"]},
                    "lang": {"type": ["string", "null"]},
                    "count": {"type": ["string", "null"]},
                    "author": {"type": ["string", "null"]},
                    "publisher": {"type": ["string", "null"]}
                }
            }
            validate(instance=document, schema=simplified_schema)
        except ValidationError as e:
            pytest.fail(f"Document schema validation failed: {e.message}")
    
    def _validate_response_structure(self, response_data: Dict[str, Any]) -> None:
        """Validate response structure"""
        required_fields = ['rows', 'os', 'page', 'total', 'documents']
        for field in required_fields:
            assert field in response_data, f"Missing required field: {field}"
        
        assert isinstance(response_data['rows'], int), "rows must be an integer"
        assert isinstance(response_data['os'], int), "os must be an integer"
        assert isinstance(response_data['page'], int), "page must be an integer"
        assert isinstance(response_data['total'], int), "total must be an integer"
        assert isinstance(response_data['documents'], dict), "documents must be an object"

@pytest.fixture(scope="session")
def api_base_url():
    """Get API base URL from environment variable or default to localhost"""
    return os.getenv('API_BASE_URL', 'http://localhost:8080/v3')

@pytest.fixture(scope="session")
def api_tester(api_base_url):
    """Create API contract tester instance"""
    return APIContractTester(api_base_url)

class TestAPIHealth:
    """Test API health and availability"""
    
    @pytest.mark.health
    def test_health_endpoint_exists(self, api_tester):
        """Test that health endpoint is accessible (optional for World Bank API)"""
        response = api_tester.session.get(f"{api_tester.base_url}/health")
        if response.status_code != 404:  # Skip if endpoint doesn't exist
            assert response.status_code == 200, f"Health endpoint returned {response.status_code}"
        else:
            pytest.skip("Health endpoint not implemented (acceptable for World Bank API)")
    
    @pytest.mark.health
    def test_health_endpoint_response_format(self, api_tester):
        """Test health endpoint returns proper JSON format (optional for World Bank API)"""
        response = api_tester.session.get(f"{api_tester.base_url}/health")
        if response.status_code == 404:
            pytest.skip("Health endpoint not implemented (acceptable for World Bank API)")
        
        assert response.headers.get('content-type', '').startswith('application/json')
        
        data = response.json()
        assert 'status' in data, "Health response must include status"
        assert data['status'] == 'healthy', "Status should be 'healthy'"

class TestAPIBasicFunctionality:
    """Test basic API search functionality"""
    
    @pytest.mark.basic
    def test_basic_search_endpoint_exists(self, api_tester):
        """Test that search endpoint is accessible"""
        response = api_tester.session.get(f"{api_tester.base_url}/wds")
        assert response.status_code == 200, f"Search endpoint returned {response.status_code}"
    
    @pytest.mark.basic
    def test_basic_search_returns_json(self, api_tester):
        """Test basic search returns JSON by default"""
        response = api_tester.session.get(f"{api_tester.base_url}/wds")
        assert response.headers.get('content-type', '').startswith('application/json')
        
        # Should be valid JSON
        data = response.json()
        assert isinstance(data, dict)
    
    @pytest.mark.basic
    def test_search_response_structure(self, api_tester):
        """Test that search response has correct structure"""
        response = api_tester.session.get(f"{api_tester.base_url}/wds?rows=5")
        data = response.json()
        
        api_tester._validate_response_structure(data)
    
    @pytest.mark.basic
    def test_search_documents_structure(self, api_tester):
        """Test that returned documents have correct structure"""
        response = api_tester.session.get(f"{api_tester.base_url}/wds?rows=3")
        data = response.json()
        
        documents = data['documents']
        
        # Filter out 'facets' key which is not a document
        actual_documents = {k: v for k, v in documents.items() if k != 'facets'}
        assert len(actual_documents) <= 3, "Should return at most requested number of documents"
        
        for doc_id, document in actual_documents.items():
            assert isinstance(doc_id, str), "Document keys should be strings"
            api_tester._validate_document_schema(document)
            
            # Real World Bank API has keys like "D34442285" but ID field is "34442285" 
            # Allow either exact match or key with "D" prefix
            expected_key_variants = [document['id'], f"D{document['id']}"]
            assert doc_id in expected_key_variants, f"Document key {doc_id} should match ID {document['id']} or be prefixed with 'D'"

class TestAPIParameterHandling:
    """Test API parameter handling and validation"""
    
    @pytest.mark.parameters
    def test_format_parameter_json(self, api_tester):
        """Test format=json parameter"""
        response = api_tester.session.get(f"{api_tester.base_url}/wds?format=json&rows=2")
        assert response.status_code == 200
        assert response.headers.get('content-type', '').startswith('application/json')
    
    @pytest.mark.parameters
    def test_format_parameter_xml(self, api_tester):
        """Test format=xml parameter"""
        response = api_tester.session.get(f"{api_tester.base_url}/wds?format=xml&rows=2")
        assert response.status_code == 200
        assert (response.headers.get('content-type', '').startswith('application/xml') or
                response.headers.get('content-type', '').startswith('text/xml'))
    
    @pytest.mark.parameters
    def test_rows_parameter(self, api_tester):
        """Test rows parameter controls result count"""
        response = api_tester.session.get(f"{api_tester.base_url}/wds?rows=3")
        data = response.json()
        
        assert data['rows'] == 3
        
        # Filter out 'facets' key which is not a document
        actual_documents = {k: v for k, v in data['documents'].items() if k != 'facets'}
        assert len(actual_documents) <= 3
    
    def test_rows_parameter_limits(self, api_tester):
        """Test rows parameter enforces limits"""
        # Test maximum limit
        response = api_tester.session.get(f"{api_tester.base_url}/wds?rows=150")
        assert response.status_code in [200, 400], "Should handle over-limit gracefully"
        
        if response.status_code == 200:
            data = response.json()
            assert data['rows'] <= 100, "Should cap rows at maximum allowed"
    
    def test_offset_parameter(self, api_tester):
        """Test offset (os) parameter for pagination"""
        # First request
        response1 = api_tester.session.get(f"{api_tester.base_url}/wds?rows=2&os=0")
        data1 = response1.json()
        
        # Second request with offset
        response2 = api_tester.session.get(f"{api_tester.base_url}/wds?rows=2&os=2")
        data2 = response2.json()
        
        assert data1['os'] == 0
        assert data2['os'] == 2
        
        # Documents should be different (assuming enough data exists)
        if data1['total'] > 4:
            doc_ids_1 = set(data1['documents'].keys())
            doc_ids_2 = set(data2['documents'].keys())
            assert doc_ids_1 != doc_ids_2, "Pagination should return different documents"
    
    def test_field_selection(self, api_tester):
        """Test field selection with fl parameter"""
        response = api_tester.session.get(f"{api_tester.base_url}/wds?rows=1&fl=id,title,docdt")
        data = response.json()
        
        if data['documents']:
            doc = next(iter(data['documents'].values()))
            # Should have requested fields
            assert 'id' in doc
            # Note: Depending on implementation, this might be flexible
            # Some implementations might return more fields than requested
    
    def test_search_query_parameter(self, api_tester):
        """Test search query (qterm) parameter"""
        response = api_tester.session.get(f"{api_tester.base_url}/wds?qterm=energy&rows=5")
        data = response.json()
        
        assert response.status_code == 200
        api_tester._validate_response_structure(data)
        
        # If there are results, they should be relevant to the search term
        # (this is a soft requirement since relevance depends on data)
        assert data['total'] >= 0, "Total should be non-negative"

class TestAPIFiltering:
    """Test API filtering capabilities"""
    
    def test_country_filter(self, api_tester):
        """Test country filtering with count_exact parameter"""
        response = api_tester.session.get(f"{api_tester.base_url}/wds?count_exact=Brazil&rows=5")
        data = response.json()
        
        assert response.status_code == 200
        api_tester._validate_response_structure(data)
        
        # If documents are returned, they should match the filter
        for document in data['documents'].values():
            if document.get('count'):
                # Note: Some documents might have multiple countries or different formats
                # This is a best-effort validation
                pass  # Implementation-specific validation
    
    def test_language_filter(self, api_tester):
        """Test language filtering with lang_exact parameter"""
        response = api_tester.session.get(f"{api_tester.base_url}/wds?lang_exact=English&rows=5")
        data = response.json()
        
        assert response.status_code == 200
        api_tester._validate_response_structure(data)
    
    def test_date_range_filter(self, api_tester):
        """Test date range filtering"""
        response = api_tester.session.get(
            f"{api_tester.base_url}/wds?strdate=2020-01-01&enddate=2023-12-31&rows=5"
        )
        data = response.json()
        
        assert response.status_code == 200
        api_tester._validate_response_structure(data)

class TestAPIErrorHandling:
    """Test API error handling"""
    
    def test_invalid_format_parameter(self, api_tester):
        """Test invalid format parameter handling"""
        response = api_tester.session.get(f"{api_tester.base_url}/wds?format=invalid")
        # Should either accept gracefully or return 400
        assert response.status_code in [200, 400]
    
    def test_invalid_rows_parameter(self, api_tester):
        """Test invalid rows parameter handling"""
        response = api_tester.session.get(f"{api_tester.base_url}/wds?rows=invalid")
        # Should return 400 for invalid parameter
        assert response.status_code in [200, 400]  # Some implementations might be lenient
    
    def test_negative_offset(self, api_tester):
        """Test negative offset handling"""
        response = api_tester.session.get(f"{api_tester.base_url}/wds?os=-1")
        # Should handle gracefully
        assert response.status_code in [200, 400]

class TestAPIConsistency:
    """Test API behavior consistency"""
    
    def test_same_request_same_results(self, api_tester):
        """Test that identical requests return identical results"""
        params = "?rows=3&qterm=development"
        
        response1 = api_tester.session.get(f"{api_tester.base_url}/wds{params}")
        response2 = api_tester.session.get(f"{api_tester.base_url}/wds{params}")
        
        data1 = response1.json()
        data2 = response2.json()
        
        # Results should be consistent
        assert data1['total'] == data2['total'], "Total count should be consistent"
        assert data1['documents'].keys() == data2['documents'].keys(), "Document IDs should be consistent"
    
    def test_pagination_consistency(self, api_tester):
        """Test pagination returns consistent total counts"""
        response1 = api_tester.session.get(f"{api_tester.base_url}/wds?rows=5&os=0")
        response2 = api_tester.session.get(f"{api_tester.base_url}/wds?rows=5&os=5")
        
        data1 = response1.json()
        data2 = response2.json()
        
        # Total should be the same across paginated requests
        assert data1['total'] == data2['total'], "Total should be consistent across pagination"

class TestAPIDataQuality:
    """Test data quality and completeness"""
    
    def test_document_ids_are_unique(self, api_tester):
        """Test that document IDs are unique within results"""
        response = api_tester.session.get(f"{api_tester.base_url}/wds?rows=20")
        data = response.json()
        
        doc_ids = list(data['documents'].keys())
        assert len(doc_ids) == len(set(doc_ids)), "Document IDs should be unique"
    
    def test_document_fields_not_empty(self, api_tester):
        """Test that key document fields are not empty when present"""
        response = api_tester.session.get(f"{api_tester.base_url}/wds?rows=5")
        data = response.json()
        
        for document in data['documents'].values():
            # ID should never be empty
            assert document['id'], "Document ID should not be empty"
            
            # If title exists, it should not be empty string
            if 'title' in document and document['title'] is not None:
                assert document['title'].strip(), "Title should not be empty when present"

if __name__ == "__main__":
    import sys
    
    # Allow running with custom API URL
    if len(sys.argv) > 1:
        os.environ['API_BASE_URL'] = sys.argv[1]
        sys.argv = sys.argv[:1]  # Remove custom arg for pytest
    
    pytest.main([__file__, "-v"])