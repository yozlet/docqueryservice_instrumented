import os
import time
from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from opentelemetry import trace
from opentelemetry.instrumentation.fastapi import FastAPIInstrumentor
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import BatchSpanProcessor
# from opentelemetry.exporter.otlp.proto.grpc.trace_exporter import OTLPSpanExporter
from opentelemetry.exporter.otlp.proto.http.trace_exporter import OTLPSpanExporter
from opentelemetry.instrumentation.langchain import LangchainInstrumentor

# from honeycomb_opentelemetry import HoneycombSpanExporter

from .models import (
    Document, DocumentSearchRequest, DocumentSearchResponse,
    DocumentSummaryRequest, DocumentSummaryResponse, ErrorResponse
)
from .services.summarizer import DocumentSummarizer
from .services.document_search import DocumentSearchService
from .services.pdf_service import PDFService

# Initialize FastAPI app
app = FastAPI(
    title="Document Summarization Service",
    description="API for summarizing documents using LangChain and OpenAI",
    version="1.0.0"
)

# Configure CORS
origins = [
    os.getenv("FRONTEND_URL", ""),  # Production URL from environment variable
]

# Filter out empty strings from origins
origins = [origin for origin in origins if origin]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Configure OpenTelemetry
if os.getenv("OTEL_EXPORTER_OTLP_ENDPOINT"):
    # Use OTLP exporter if endpoint is provided
    exporter = OTLPSpanExporter(
        endpoint=os.getenv("OTEL_EXPORTER_OTLP_ENDPOINT")
    )
else:
    exporter = None

if exporter:
    provider = TracerProvider()
    processor = BatchSpanProcessor(exporter)
    provider.add_span_processor(processor)
    trace.set_tracer_provider(provider)
    FastAPIInstrumentor.instrument_app(app)
    LangchainInstrumentor().instrument(tracer_provider=provider)

# Initialize services
document_search = DocumentSearchService()
document_summarizer = DocumentSummarizer()
pdf_service = PDFService()

@app.post("/v1/search", response_model=DocumentSearchResponse)
async def search_documents(search_request: DocumentSearchRequest):
    """
    Search for documents based on the provided criteria
    """
    try:
        start_time = time.time()
        total_count, documents = await document_search.search_documents(search_request)
        search_time_ms = int((time.time() - start_time) * 1000)
        
        return DocumentSearchResponse(
            results=documents,
            result_count=total_count,
            search_time_ms=search_time_ms
        )
    except ValueError as e:
        raise HTTPException(
            status_code=400,
            detail=ErrorResponse(
                error="INVALID_PARAMETER",
                message=str(e)
            ).model_dump()
        )
    except Exception as e:
        raise HTTPException(
            status_code=500,
            detail=ErrorResponse(
                error="INTERNAL_ERROR",
                message="An unexpected error occurred",
                details={"error": str(e)}
            ).model_dump()
        )

@app.post("/v1/summary", response_model=DocumentSummaryResponse)
async def generate_summaries(request: DocumentSummaryRequest):
    """
    Generate AI-powered summaries for specified documents
    """
    start_time = time.time()
    try:
        # Get the first document (we'll enhance this for multiple documents later)
        doc_id = request.ids[0] if request.ids else None
        if not doc_id:
            raise ValueError("No document IDs provided")

        # Get document details from search
        _, documents = await document_search.search_documents(
            DocumentSearchRequest(id=doc_id)
        )
        
        if not documents:
            raise ValueError(f"Document not found: {doc_id}")
        
        document = documents[0]
        
        # If URL is provided, download and extract text
        if document.url:
            try:
                document.content = await pdf_service.download_and_extract_text(
                    doc_id=doc_id,
                    url=document.url
                )
            except (ValueError, IOError) as e:
                raise HTTPException(
                    status_code=400,
                    detail=ErrorResponse(
                        error="PDF_PROCESSING_ERROR",
                        message=str(e)
                    ).model_dump()
                )
        
        # If no content available, use abstract
        if not document.content and document.abstract:
            document.content = document.abstract
        
        if not document.content:
            raise ValueError("No content available for summarization")
        
        # Update model if specified in request
        if request.model:
            document.model = request.model
            
        # Generate summary
        summary = await document_summarizer.summarize(document)
        
        # Calculate time taken
        summary_time_ms = int((time.time() - start_time) * 1000)
        
        return DocumentSummaryResponse(
            summary_text=summary,
            summary_time_ms=summary_time_ms
        )
        
    except ValueError as e:
        raise HTTPException(
            status_code=400,
            detail=ErrorResponse(
                error="INVALID_PARAMETER",
                message=str(e)
            ).model_dump()
        )
    except Exception as e:
        raise HTTPException(
            status_code=500,
            detail=ErrorResponse(
                error="INTERNAL_ERROR",
                message="An unexpected error occurred",
                details={"error": str(e)}
            ).model_dump()
        )

@app.get("/v1/health")
async def health_check():
    """
    Health check endpoint
    """
    return {"status": "healthy"}