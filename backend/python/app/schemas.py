from datetime import date
from typing import List, Optional
from pydantic import BaseModel, Field

class DocumentSearchRequest(BaseModel):
    search_text: Optional[str] = Field(None, description="Text to search for in document title or abstract")
    start_date: Optional[date] = Field(None, description="Start date for document search range")
    end_date: Optional[date] = Field(None, description="End date for document search range")
    doc_type: Optional[str] = Field(None, description="Exact match on type of document to search for")
    language: Optional[str] = Field(None, description="Exact match on language of the documents")
    country: Optional[str] = Field(None, description="Exact match on country associated with the documents")

class DocumentResult(BaseModel):
    id: str = Field(..., description="Unique document identifier")
    title: str = Field(..., description="Document title")
    abstract: Optional[str] = Field(None, description="Document abstract or summary")
    doc_date: Optional[date] = Field(None, description="Document publication date")
    doc_type: Optional[str] = Field(None, description="Type of document")
    language: Optional[str] = Field(None, description="Document language")
    country: Optional[str] = Field(None, description="Country associated with the document")

    class Config:
        from_attributes = True

class DocumentSearchResponse(BaseModel):
    results: List[DocumentResult] = Field(..., description="List of matching documents")
    result_count: int = Field(..., description="Total number of matching documents")
    search_time_ms: int = Field(..., description="Time taken to perform the search in milliseconds")

class DocumentSummaryRequest(BaseModel):
    ids: List[str] = Field(..., description="List of document IDs to summarize")
    model: Optional[str] = Field("gpt-4", description="AI model to use for summarization")
    model_options: Optional[dict] = Field(None, description="Additional options for the AI model")

class DocumentSummaryResponse(BaseModel):
    summary_text: str = Field(..., description="Generated summary text")
    summary_time_ms: int = Field(..., description="Time taken to generate the summary in milliseconds")

class ErrorResponse(BaseModel):
    error: str = Field(..., description="Error code")
    message: str = Field(..., description="Human-readable error message")
    details: Optional[dict] = Field(None, description="Additional error details")

