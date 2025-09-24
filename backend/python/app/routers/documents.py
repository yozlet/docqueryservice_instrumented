import time
from typing import List
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy import or_, and_
from sqlalchemy.orm import Session

from app.database import get_db
from app.models import Document
from app.schemas import DocumentSearchRequest, DocumentSearchResponse, DocumentResult

router = APIRouter()

@router.post("/search", response_model=DocumentSearchResponse)
async def search_documents(
    request: DocumentSearchRequest,
    db: Session = Depends(get_db)
):
    """
    Search for documents using various criteria including text, dates, and metadata.
    """
    start_time = time.time()

    # Build query
    query = db.query(Document)

    # Apply filters
    if request.search_text:
        search_text = f"%{request.search_text}%"
        query = query.filter(
            or_(
                Document.title.ilike(search_text),
                Document.abstract.ilike(search_text),
                Document.content_text.ilike(search_text)
            )
        )

    if request.start_date:
        query = query.filter(Document.docdt >= request.start_date)

    if request.end_date:
        query = query.filter(Document.docdt <= request.end_date)

    if request.doc_type:
        query = query.filter(Document.docty == request.doc_type)

    if request.language:
        query = query.filter(Document.lang == request.language)

    if request.country:
        query = query.filter(Document.country == request.country)

    # Execute query
    try:
        total_count = query.count()
        documents = query.limit(100).all()  # Limit to 100 results
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

    # Calculate search time
    search_time_ms = int((time.time() - start_time) * 1000)

    # Convert to response model
    results = [
        DocumentResult(
            id=doc.id,
            title=doc.title,
            abstract=doc.abstract,
            doc_date=doc.docdt,
            doc_type=doc.docty,
            language=doc.lang,
            country=doc.country
        )
        for doc in documents
    ]

    return DocumentSearchResponse(
        results=results,
        result_count=total_count,
        search_time_ms=search_time_ms
    )

