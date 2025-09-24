import time
from typing import List
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from app.database import get_db
from app.models import Document
from app.schemas import DocumentSummaryRequest, DocumentSummaryResponse

router = APIRouter()

@router.post("/summary", response_model=DocumentSummaryResponse)
async def generate_summaries(
    request: DocumentSummaryRequest,
    db: Session = Depends(get_db)
):
    """
    Generate AI-powered summaries for specified documents.
    """
    start_time = time.time()

    # Get documents
    documents = db.query(Document).filter(Document.id.in_(request.ids)).all()
    if not documents:
        raise HTTPException(status_code=404, detail="No documents found with the provided IDs")

    # Prepare document content for summarization
    content = "\n\n".join([
        f"Title: {doc.title}\n"
        f"Abstract: {doc.abstract or 'N/A'}\n"
        f"Content: {doc.content_text or 'N/A'}"
        for doc in documents
    ])

    # TODO: Implement actual AI summarization
    # For now, return a placeholder summary
    summary = (
        "This is a placeholder summary. In a production environment, "
        "this would be generated using the specified AI model: "
        f"{request.model}"
    )

    # Calculate processing time
    summary_time_ms = int((time.time() - start_time) * 1000)

    return DocumentSummaryResponse(
        summary_text=summary,
        summary_time_ms=summary_time_ms
    )

