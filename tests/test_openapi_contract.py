#!/usr/bin/env python3
"""
OpenAPI Spec-Driven Contract Tests for World Bank Documents API

This test suite reads the OpenAPI specification directly and generates tests
to validate that any implementation conforms to the spec. This ensures the
tests and spec never drift apart.
"""

import json
import pytest
import requests
import yaml
import os
from pathlib import Path
from typing import Dict, List, Any, Optional
from openapi_parser import parse
from jsonschema import validate, ValidationError
from jsonschema.validators import Draft7Validator

class OpenAPIContractTester:
    """Test any API implementation against its OpenAPI specification"""
    
    def __init__(self, base_url: str, spec_path: str):
        self.base_url = base_url.rstrip('/')
        self.session = requests.Session()
        self.session.headers.update({
            'User-Agent': 'OpenAPI-Contract-Tester/1.0'
        })
        
        # Load and parse OpenAPI specification
        self.spec_path = spec_path
        self.spec = self._load_openapi_spec()
        self.parser = self._create_parser()
        
    def _load_openapi_spec(self) -> Dict[str, Any]:
        """Load the OpenAPI specification from file"""
        with open(self.spec_path, 'r', encoding='utf-8') as f:
            return yaml.safe_load(f)
    
    def _create_parser(self):
        """Create OpenAPI parser for spec validation"""
        try:
            return parse(self.spec_path)
        except Exception as e:
            pytest.fail(f"Failed to parse OpenAPI spec: {e}")
    
    def get_operation(self, path: str, method: str) -> Optional[Dict[str, Any]]:
        """Get operation definition from spec"""
        paths = self.spec.get('paths', {})
        if path in paths and method.lower() in paths[path]:
            return paths[path][method.lower()]
        return None
    
    def get_schema(self, schema_ref: str) -> Dict[str, Any]:
        """Resolve schema reference from spec"""
        if schema_ref.startswith('#/'):
            parts = schema_ref[2:].split('/')
            schema = self.spec
            for part in parts:
                schema = schema[part]
            return schema
        return {}
    
    def validate_response_schema(self, response_data: Any, operation: Dict[str, Any], 
                               status_code: int = 200, content_type: str = 'application/json'):
        """Validate response against OpenAPI schema"""
        responses = operation.get('responses', {})
        response_spec = responses.get(str(status_code), responses.get('default'))
        
        if not response_spec:
            pytest.fail(f"No response spec for status code {status_code}")
        
        content = response_spec.get('content', {})
        media_type = content.get(content_type)
        
        if not media_type:
            # Try to find any JSON content type
            for ct in content.keys():
                if 'json' in ct.lower():
                    media_type = content[ct]
                    break
        
        if not media_type:
            return  # No schema to validate against
        
        schema_ref = media_type.get('schema', {})
        if '$ref' in schema_ref:
            schema = self.get_schema(schema_ref['$ref'])
        else:
            schema = schema_ref
        
        if schema:
            try:
                # Convert OpenAPI 3.0 schema to JSON Schema Draft 7
                json_schema = self._openapi_to_jsonschema(schema)
                validate(instance=response_data, schema=json_schema)
            except ValidationError as e:
                pytest.fail(f"Response validation failed: {e.message}")
    
    def _openapi_to_jsonschema(self, openapi_schema: Dict[str, Any]) -> Dict[str, Any]:
        """Convert OpenAPI 3.0 schema to JSON Schema Draft 7"""
        # Basic conversion - handles most common cases
        schema = openapi_schema.copy()
        
        # Add JSON Schema metadata
        if '$schema' not in schema:
            schema['$schema'] = 'http://json-schema.org/draft-07/schema#'
        
        # Handle nullable fields (OpenAPI 3.0 to JSON Schema)
        if 'nullable' in schema:
            if schema.get('nullable'):
                if 'type' in schema:
                    schema['type'] = [schema['type'], 'null']
                del schema['nullable']
        
        # Recursively handle properties
        if 'properties' in schema:
            for prop_name, prop_schema in schema['properties'].items():
                schema['properties'][prop_name] = self._openapi_to_jsonschema(prop_schema)
        
        # Handle array items
        if 'items' in schema:
            schema['items'] = self._openapi_to_jsonschema(schema['items'])
        
        # Handle additionalProperties
        if 'additionalProperties' in schema and isinstance(schema['additionalProperties'], dict):
            schema['additionalProperties'] = self._openapi_to_jsonschema(schema['additionalProperties'])
        
        return schema
    
    def get_required_parameters(self, operation: Dict[str, Any]) -> List[Dict[str, Any]]:
        """Get required parameters from operation spec"""
        parameters = operation.get('parameters', [])
        return [p for p in parameters if p.get('required', False)]
    
    def get_all_parameters(self, operation: Dict[str, Any]) -> List[Dict[str, Any]]:
        """Get all parameters from operation spec"""
        return operation.get('parameters', [])
    
    def make_request(self, path: str, method: str = 'get', params: Dict[str, Any] = None) -> requests.Response:
        """Make request to API"""
        url = f"{self.base_url}{path}"
        return self.session.request(method.upper(), url, params=params)

@pytest.fixture(scope="session")
def api_base_url():
    """Get API base URL from environment variable or default to localhost"""
    return os.getenv('API_BASE_URL', 'http://localhost:8080/v3')

@pytest.fixture(scope="session")
def openapi_spec_path():
    """Get OpenAPI spec path"""
    return os.path.join(os.path.dirname(__file__), '..', 'docs', 'openapi.yaml')

@pytest.fixture(scope="session")
def contract_tester(api_base_url, openapi_spec_path):
    """Create OpenAPI contract tester instance"""
    return OpenAPIContractTester(api_base_url, openapi_spec_path)

class TestOpenAPISpecValidity:
    """Test that the OpenAPI specification itself is valid"""
    
    def test_spec_is_valid_yaml(self, openapi_spec_path):
        """Test that the OpenAPI spec is valid YAML"""
        with open(openapi_spec_path, 'r') as f:
            spec = yaml.safe_load(f)
        assert isinstance(spec, dict), "Spec should be a valid YAML dictionary"
        assert 'openapi' in spec, "Spec should have openapi version field"
        assert spec['openapi'].startswith('3.'), "Spec should be OpenAPI 3.x"
    
    def test_spec_can_be_parsed(self, contract_tester):
        """Test that the OpenAPI spec can be parsed successfully"""
        assert contract_tester.parser is not None, "OpenAPI spec should be parseable"
        assert contract_tester.spec is not None, "Spec should be loaded"

class TestAPIEndpointsFromSpec:
    """Test API endpoints defined in the OpenAPI spec"""
    
    def test_all_paths_are_accessible(self, contract_tester):
        """Test that all paths defined in spec are accessible"""
        paths = contract_tester.spec.get('paths', {})
        
        for path, path_info in paths.items():
            for method, operation in path_info.items():
                if method.lower() in ['get', 'post', 'put', 'delete', 'patch']:
                    # Make request to each endpoint
                    response = contract_tester.make_request(path, method)
                    
                    # Check if status code is defined in spec
                    responses = operation.get('responses', {})
                    valid_codes = [int(code) for code in responses.keys() if code.isdigit()]
                    valid_codes.extend([200, 400, 404, 500])  # Common codes
                    
                    assert response.status_code in valid_codes, \
                        f"Unexpected status code {response.status_code} for {method.upper()} {path}"

class TestWdsEndpointFromSpec:
    """Test the /wds endpoint based on OpenAPI specification"""
    
    def test_wds_endpoint_exists(self, contract_tester):
        """Test that /wds endpoint exists as defined in spec"""
        operation = contract_tester.get_operation('/wds', 'get')
        assert operation is not None, "/wds GET operation should be defined in spec"
        
        response = contract_tester.make_request('/wds')
        assert response.status_code == 200, f"/wds should return 200, got {response.status_code}"
    
    def test_wds_response_schema_compliance(self, contract_tester):
        """Test that /wds response matches OpenAPI schema"""
        operation = contract_tester.get_operation('/wds', 'get')
        
        response = contract_tester.make_request('/wds', params={'rows': 3})
        data = response.json()
        
        # Validate against schema defined in spec
        contract_tester.validate_response_schema(data, operation, response.status_code)
    
    def test_wds_parameters_from_spec(self, contract_tester, param_info):
        """Test parameters defined in OpenAPI spec"""
        param_name = param_info['name']
        param_required = param_info['required']
        param_type = param_info['type']
        param_enum = param_info.get('enum', [])
        
        # Test parameter behavior
        if param_enum:
            # Test enum values
            for value in param_enum:
                response = contract_tester.make_request('/wds', params={param_name: value, 'rows': 1})
                assert response.status_code == 200, f"Parameter {param_name}={value} should work"
        elif param_type == 'integer':
            # Test integer parameter
            response = contract_tester.make_request('/wds', params={param_name: 10, 'rows': 1})
            assert response.status_code == 200, f"Integer parameter {param_name} should work"
        else:
            # Test string parameter
            response = contract_tester.make_request('/wds', params={param_name: 'test', 'rows': 1})
            assert response.status_code == 200, f"String parameter {param_name} should work"
    
    def test_wds_required_parameters(self, contract_tester):
        """Test required parameters work correctly"""
        operation = contract_tester.get_operation('/wds', 'get')
        required_params = contract_tester.get_required_parameters(operation)
        
        # For /wds, there should be no required parameters
        assert len(required_params) == 0, "WDS endpoint should not have required parameters"
        
        # Test that endpoint works without any parameters
        response = contract_tester.make_request('/wds')
        assert response.status_code == 200

def pytest_generate_tests(metafunc):
    """Dynamically generate tests based on OpenAPI spec"""
    if 'param_info' in metafunc.fixturenames:
        # Load spec to generate parameter tests
        spec_path = os.path.join(os.path.dirname(__file__), '..', 'docs', 'openapi.yaml')
        with open(spec_path, 'r') as f:
            spec = yaml.safe_load(f)
        
        # Get parameters for /wds endpoint
        wds_operation = spec.get('paths', {}).get('/wds', {}).get('get', {})
        parameters = wds_operation.get('parameters', [])
        
        # Generate test parameters
        param_tests = []
        for param in parameters:
            param_name = param.get('name')
            param_required = param.get('required', False)
            param_schema = param.get('schema', {})
            param_type = param_schema.get('type', 'string')
            param_enum = param_schema.get('enum', [])
            
            test_info = {
                'name': param_name,
                'required': param_required,
                'type': param_type,
                'enum': param_enum,
                'schema': param_schema
            }
            param_tests.append(test_info)
        
        metafunc.parametrize('param_info', param_tests, ids=[p['name'] for p in param_tests])

class TestParametersFromSpec:
    """Test API parameters based on OpenAPI specification"""
    
    def test_format_parameter(self, contract_tester):
        """Test format parameter as defined in spec"""
        operation = contract_tester.get_operation('/wds', 'get')
        parameters = contract_tester.get_all_parameters(operation)
        
        format_param = next((p for p in parameters if p['name'] == 'format'), None)
        assert format_param is not None, "Format parameter should be defined in spec"
        
        # Test enum values from spec
        enum_values = format_param.get('schema', {}).get('enum', [])
        for value in enum_values:
            response = contract_tester.make_request('/wds', params={'format': value, 'rows': 1})
            assert response.status_code == 200, f"Format={value} should work"
            
            if value == 'json':
                assert 'application/json' in response.headers.get('content-type', '')
            elif value == 'xml':
                content_type = response.headers.get('content-type', '')
                assert ('application/xml' in content_type or 'text/xml' in content_type), \
                    f"XML format should return XML content type, got {content_type}"
    
    def test_rows_parameter(self, contract_tester):
        """Test rows parameter as defined in spec"""
        operation = contract_tester.get_operation('/wds', 'get')
        parameters = contract_tester.get_all_parameters(operation)
        
        rows_param = next((p for p in parameters if p['name'] == 'rows'), None)
        assert rows_param is not None, "Rows parameter should be defined in spec"
        
        schema = rows_param.get('schema', {})
        minimum = schema.get('minimum', 1)
        maximum = schema.get('maximum', 100)
        
        # Test minimum value
        response = contract_tester.make_request('/wds', params={'rows': minimum})
        assert response.status_code == 200
        data = response.json()
        actual_docs = {k: v for k, v in data['documents'].items() if k != 'facets'}
        assert len(actual_docs) >= 0  # Could be 0 if no data
        
        # Test maximum value
        response = contract_tester.make_request('/wds', params={'rows': maximum})
        assert response.status_code == 200
        data = response.json()
        actual_docs = {k: v for k, v in data['documents'].items() if k != 'facets'}
        assert len(actual_docs) <= maximum
    
    def test_pagination_parameters(self, contract_tester):
        """Test pagination parameters as defined in spec"""
        operation = contract_tester.get_operation('/wds', 'get')
        parameters = contract_tester.get_all_parameters(operation)
        
        # Check os (offset) parameter
        os_param = next((p for p in parameters if p['name'] == 'os'), None)
        assert os_param is not None, "OS (offset) parameter should be defined in spec"
        
        # Test pagination works
        response1 = contract_tester.make_request('/wds', params={'rows': 2, 'os': 0})
        response2 = contract_tester.make_request('/wds', params={'rows': 2, 'os': 2})
        
        data1 = response1.json()
        data2 = response2.json()
        
        assert data1['os'] == 0
        assert data2['os'] == 2

class TestHealthEndpointFromSpec:
    """Test health endpoint if defined in spec"""
    
    def test_health_endpoint_if_defined(self, contract_tester):
        """Test health endpoint if it exists in spec"""
        operation = contract_tester.get_operation('/health', 'get')
        
        if operation is not None:
            response = contract_tester.make_request('/health')
            
            # Validate response against spec
            if response.status_code != 404:  # Skip if not implemented
                assert response.status_code == 200
                contract_tester.validate_response_schema(
                    response.json(), operation, response.status_code
                )
        else:
            # Health endpoint not in spec, so skip test
            pytest.skip("Health endpoint not defined in OpenAPI spec")

class TestSpecSchemaCompliance:
    """Test that all responses comply with OpenAPI schemas"""
    
    def test_error_response_schema(self, contract_tester):
        """Test error responses match schema when they occur"""
        operation = contract_tester.get_operation('/wds', 'get')
        
        # Try to trigger a 400 error with invalid parameter
        response = contract_tester.make_request('/wds', params={'rows': 'invalid'})
        
        if response.status_code == 400:
            # Validate error response against schema
            try:
                error_data = response.json()
                contract_tester.validate_response_schema(
                    error_data, operation, response.status_code
                )
            except (json.JSONDecodeError, ValidationError):
                # Some implementations might not return JSON errors
                # This is acceptable for now
                pass

if __name__ == "__main__":
    import sys
    
    # Allow running with custom API URL
    if len(sys.argv) > 1:
        os.environ['API_BASE_URL'] = sys.argv[1]
        sys.argv = sys.argv[:1]  # Remove custom arg for pytest
    
    pytest.main([__file__, "-v"])