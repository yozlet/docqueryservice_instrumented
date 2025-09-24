from datetime import datetime
from enum import Enum
from typing import Optional, List
from pydantic import BaseModel, Field, conint

class LLMModel(str, Enum):
    """
    Supported LLM models for document processing
    """
    GPT35_TURBO = "gpt-3.5-turbo-16k"
    GPT4_TURBO = "gpt-4-turbo-preview"
    CLAUDE_3_SONNET = "claude-3-sonnet"
    CLAUDE_3_OPUS = "claude-3-opus"

class DocumentSearchRequest(BaseModel):
    """
    Request model for document search
    """
    model_config = {
        'protected_namespaces': ()
    }
    id: Optional[str] = Field(None, description="Search by document ID")
    search_text: Optional[str] = Field(None, description="Search by document title or abstract")
    title: Optional[str] = Field(None, description="Search by document title")
    abstract: Optional[str] = Field(None, description="Search by document abstract")
    doc_type: Optional[str] = Field(None, description="Filter by document type")
    major_document_type: Optional[str] = Field(None, description="Filter by major document type")
    language: Optional[str] = Field(None, description="Filter by language code")
    country: Optional[str] = Field(None, description="Filter by country")
    start_date: Optional[datetime] = Field(None, description="Filter by start date")
    end_date: Optional[datetime] = Field(None, description="Filter by end date")
    max_results: Optional[conint(ge=1)] = Field(3, description="Maximum number of results to return (default: 3)")

class Document(BaseModel):
    """
    Document model compatible with the .NET backend's Document class
    """
    model_config = {
        'protected_namespaces': ()
    }
    id: str = Field(..., description="Unique document identifier")
    title: str = Field(..., description="Document title")
    abstract: Optional[str] = Field(None, description="Document abstract or summary")
    document_date: Optional[datetime] = Field(None, description="Document date")
    document_type: Optional[str] = Field(None, description="Document type")
    major_document_type: Optional[str] = Field(None, description="Major document type category")
    volume_number: Optional[int] = Field(None, description="Volume number")
    total_volume_number: Optional[int] = Field(None, description="Total volume number")
    url: Optional[str] = Field(None, description="Document URL")
    language: Optional[str] = Field(None, description="Language code")
    country: Optional[str] = Field(None, description="Country")
    author: Optional[str] = Field(None, description="Author information")
    publisher: Optional[str] = Field(None, description="Publisher information")
    created_at: datetime = Field(default_factory=datetime.utcnow, description="Creation timestamp")
    updated_at: datetime = Field(default_factory=datetime.utcnow, description="Last update timestamp")
    content: Optional[str] = Field(None, description="Document content to summarize")
    model: Optional[LLMModel] = Field(default=LLMModel.GPT35_TURBO, description="LLM model to use for processing")

class DocumentSummaryRequest(BaseModel):
    """
    Request model for document summarization
    """
    model_config = {
        'protected_namespaces': ()
    }
    ids: List[str] = Field(..., description="List of document IDs to summarize")
    model: Optional[str] = Field(None, description="AI model to use for summarization")
    modelOptions: Optional[dict[str, str]] = Field(None, description="Additional options for the AI model")

class DocumentSummaryResponse(BaseModel):
    """
    Response model for document summarization
    """
    model_config = {
        'protected_namespaces': ()
    }
    summary_text: str = Field(..., description="Generated summary text")
    summary_time_ms: int = Field(..., description="Time taken to generate the summary in milliseconds")

class ErrorResponse(BaseModel):
    """
    Error response model
    """
    model_config = {
        'protected_namespaces': ()
    }
    error: str = Field(..., description="Error code")
    message: str = Field(..., description="Human-readable error message")
    details: Optional[dict] = Field(None, description="Additional error details")

class DocumentSearchResponse(BaseModel):
    """
    Response model for document search results
    """
    model_config = {
        'protected_namespaces': ()
    }
    total_results: int = Field(..., description="Total number of matching documents")
    documents: List[Document] = Field(..., description="List of matching documents")
