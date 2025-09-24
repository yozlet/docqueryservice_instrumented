import os
import tempfile
from typing import Optional
import aiohttp
from PyPDF2 import PdfReader
from opentelemetry import trace

tracer = trace.get_tracer(__name__)

class PDFService:
    def __init__(self):
        self.max_tokens = int(os.getenv("MAX_TOKENS", 1000))
        self.temp_dir = tempfile.gettempdir()

    async def download_and_extract_text(self, doc_id: str, url: str) -> Optional[str]:
        """
        Downloads a PDF file and extracts its text content.
        
        Args:
            doc_id: Document ID to use as filename
            url: URL to download the PDF from
            
        Returns:
            str: Extracted text from the PDF
            
        Raises:
            ValueError: If URL is invalid or file is not a PDF
            IOError: If download or file operations fail
        """
        with tracer.start_as_current_span("download_and_extract_text") as span:
            span.set_attribute("doc_id", doc_id)
            span.set_attribute("url", url)
            
            # Validate URL
            if not url.lower().endswith('.pdf'):
                raise ValueError("URL does not point to a PDF file")
            
            # Create temp file path
            pdf_path = os.path.join(self.temp_dir, f"{doc_id}.pdf")
            
            try:
                # Download file
                async with aiohttp.ClientSession() as session:
                    with tracer.start_span("download_pdf") as download_span:
                        async with session.get(url) as response:
                            if response.status != 200:
                                raise IOError(f"Failed to download PDF: HTTP {response.status}")
                            
                            # Check content type
                            content_type = response.headers.get('content-type', '')
                            if 'application/pdf' not in content_type.lower():
                                raise ValueError(f"Invalid content type: {content_type}")
                            
                            # Save to temp file
                            with open(pdf_path, 'wb') as f:
                                while True:
                                    chunk = await response.content.read(8192)
                                    if not chunk:
                                        break
                                    f.write(chunk)
                
                # Extract text
                with tracer.start_span("extract_text") as extract_span:
                    try:
                        reader = PdfReader(pdf_path)
                        text = ""
                        print(f">>> pages to extract: {len(reader.pages)}")
                        tokens = 0
                        for page in reader.pages:
                            text += page.extract_text() + "\n"
                            # count the words in the text
                            words = text.split()
                            tokens += len(words)
                            if tokens > self.max_tokens:
                                break

                        return text.strip()
                    except Exception as e:
                        raise IOError(f"Failed to extract text from PDF: {str(e)}")
                    
            finally:
                # Clean up temp file
                if os.path.exists(pdf_path):
                    os.remove(pdf_path)
