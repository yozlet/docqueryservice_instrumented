from typing import List, Optional
import os
from sqlalchemy import create_engine, text
from sqlalchemy.exc import SQLAlchemyError
from ..models import Document, DocumentSearchRequest
from opentelemetry.instrumentation.sqlalchemy import SQLAlchemyInstrumentor
from opentelemetry import trace

tracer = trace.get_tracer(__name__)

class DocumentSearchService:
    """
    Service for searching documents in the PostgreSQL database
    """
    def __init__(self):
        """
        Initialize the database connection
        """
        db_url = os.getenv("DATABASE_URL")
        if not db_url:
            raise ValueError("DATABASE_URL environment variable is not set")
        # Convert the URL to use pg8000 instead of psycopg2
        if db_url.startswith("postgresql://"):
            db_url = db_url.replace("postgresql://", "postgresql+pg8000://")
        self.engine = create_engine(db_url)
        SQLAlchemyInstrumentor().instrument(engine=self.engine)

    async def search_documents(self, search_request: DocumentSearchRequest) -> tuple[int, List[Document]]:
        """
        Search for documents based on the provided criteria
        Returns a tuple of (total_count, matching_documents)
        """
        try:
            with tracer.start_as_current_span("search_documents") as span:
                span.set_attribute("search_request", search_request.model_dump_json())
                
                # Build the base query
                query = """
                    SELECT 
                        id, title, docdt as document_date, abstract, docty as document_type,
                        majdocty as major_document_type, volnb as volume_number, totvolnb as total_volume_number,
                        url, lang as language, country, author, publisher,
                        created_at, updated_at
                    FROM documents
                    WHERE 1=1
                """
                params = {}
                
                # Add search conditions. In case the id is provided, we don't need to search by other criteria.
                if search_request.id:
                    query += " AND id = :id"
                    params["id"] = search_request.id
                    span.set_attribute("id", search_request.id)
                else:
                    if search_request.search_text:
                        query += " AND ( title ILIKE :search_text OR abstract ILIKE :search_text )"
                        params["search_text"] = f"%{search_request.search_text}%"
                        span.set_attribute("search_text", search_request.search_text)

                    if search_request.title:
                        query += " AND title ILIKE :title"
                        params["title"] = f"%{search_request.title}%"
                        span.set_attribute("title", search_request.title)
                    
                    if search_request.abstract:
                        query += " AND abstract ILIKE :abstract"
                        params["abstract"] = f"%{search_request.abstract}%"
                        span.set_attribute("abstract", search_request.abstract)
                    
                    if search_request.doc_type:
                        query += " AND docty = :document_type"
                        params["document_type"] = search_request.doc_type
                        span.set_attribute("document_type", search_request.doc_type)
                    
                    if search_request.major_document_type:
                        query += " AND majdocty = :major_document_type"
                        params["major_document_type"] = search_request.major_document_type
                        span.set_attribute("major_document_type", search_request.major_document_type)
                    
                    if search_request.language:
                        query += " AND lang = :language"
                        params["language"] = search_request.language
                        span.set_attribute("language", search_request.language)
                    
                    if search_request.country:
                        query += " AND country = :country"
                        params["country"] = search_request.country
                        span.set_attribute("country", search_request.country)

                    if search_request.start_date:
                        query += " AND created_at >= :start_date"
                        params["start_date"] = search_request.start_date
                        span.set_attribute("start_date", search_request.start_date)
                    
                    if search_request.end_date:
                        query += " AND created_at <= :end_date"
                        params["end_date"] = search_request.end_date
                        span.set_attribute("end_date", search_request.end_date)

                # Get total count
                count_query = f"SELECT COUNT(*) FROM ({query}) as subquery"
                
                # Add limit to the main query
                query += f" LIMIT {search_request.max_results}"

                with self.engine.connect() as conn:
                    # Get total count
                    total_count = conn.execute(text(count_query), params).scalar()

                    # Get matching documents
                    result = conn.execute(text(query), params)
                    documents = []
                    for row in result:
                        doc = Document(
                            id=row.id,
                            title=row.title,
                            abstract=row.abstract,
                            document_date=row.document_date,
                            document_type=row.document_type,
                            major_document_type=row.major_document_type,
                            volume_number=row.volume_number,
                            total_volume_number=row.total_volume_number,
                            url=row.url,
                            language=row.language,
                            country=row.country,
                            author=row.author,
                            publisher=row.publisher,
                            created_at=row.created_at,
                            updated_at=row.updated_at
                        )
                        documents.append(doc)

                    return total_count, documents

        except SQLAlchemyError as e:
            raise RuntimeError(f"Database error: {str(e)}")