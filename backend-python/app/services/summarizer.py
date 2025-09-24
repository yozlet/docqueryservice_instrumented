from typing import Optional
from langchain.docstore.document import Document as LangChainDocument
from langchain.chains.summarize import load_summarize_chain
from langchain.prompts import PromptTemplate

from ..models import Document
from .llm_config import LLMConfig

class DocumentSummarizer:
    def __init__(self):
        self.llm_config = LLMConfig()
        
        # Use regular PromptTemplate with text variable
        self.prompt_template = PromptTemplate(
            input_variables=["text"],  # Changed back to "text"
            template="""You are a helpful assistant that creates comprehensive yet concise summaries of documents.
            Focus on the main points, key findings, and important conclusions.
            If the document appears to be a report or research paper, include methodology and results.

            Please summarize the following document:

            {text}

            Summary:"""
        )
    
    async def summarize(self, document: Document) -> str:
        """
        Generate a summary for the given document using LangChain and OpenAI.
        
        Args:
            document: The document to summarize
            
        Returns:
            str: The generated summary
            
        Raises:
            ValueError: If no content is provided for summarization
        """
        # Combine title, abstract, and content for context
        text_to_summarize = self._prepare_text(document)
        
        if not text_to_summarize:
            raise ValueError("No content provided for summarization")
        
        # Create LangChain document
        doc = LangChainDocument(
            page_content=text_to_summarize,
            metadata={
                "title": document.title,
                "id": document.id,
                "type": document.document_type
            }
        )
        
        # Get the LLM instance for the selected model
        llm = self.llm_config.get_llm(document.model)
        
        # Create the chain for this request
        chain = load_summarize_chain(
            llm=llm,
            chain_type="stuff",
            prompt=self.prompt_template,
            document_variable_name="text",  # This tells the chain to use "text" as the variable name
            verbose=False
        )
        
        # Generate summary
        try:
            result = await chain.ainvoke({"input_documents": [doc]})  # Keep this as input_documents
            summary = result.get("output_text", "")
            return summary.strip()
        except Exception as e:
            print(f"Error during summarization: {str(e)}")
            raise
    
    def _prepare_text(self, document: Document) -> str:
        """
        Prepare the text for summarization by combining relevant fields.
        """
        parts = [
            f"Title: {document.title}",
            f"Abstract: {document.abstract}" if document.abstract else None,
            document.content
        ]
        return "\n\n".join(part for part in parts if part)