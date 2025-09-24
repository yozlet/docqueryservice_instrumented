from datetime import datetime
from sqlalchemy import Column, Integer, String, Text, Date, DateTime, ForeignKey, Table
from sqlalchemy.orm import relationship

from app.database import Base

# Association table for document-country relationship
document_countries = Table(
    'document_countries',
    Base.metadata,
    Column('document_id', String(255), ForeignKey('documents.id', ondelete='CASCADE'), primary_key=True),
    Column('country_id', Integer, ForeignKey('countries.id', ondelete='CASCADE'), primary_key=True),
    Column('created_at', DateTime, default=datetime.utcnow)
)

# Association table for document-collection relationship
document_collection_memberships = Table(
    'document_collection_memberships',
    Base.metadata,
    Column('document_id', String(255), ForeignKey('documents.id', ondelete='CASCADE'), primary_key=True),
    Column('collection_id', Integer, ForeignKey('document_collections.id', ondelete='CASCADE'), primary_key=True),
    Column('sequence_number', Integer),
    Column('created_at', DateTime, default=datetime.utcnow)
)

class Document(Base):
    __tablename__ = 'documents'

    id = Column(String(255), primary_key=True)
    title = Column(Text, nullable=False)
    docdt = Column(Date)
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    abstract = Column(Text)
    content_text = Column(Text)
    
    docty = Column(String(100))
    majdocty = Column(String(100))
    
    volnb = Column(Integer)
    totvolnb = Column(Integer)
    url = Column(String(2048))
    
    lang = Column(String(50))
    country = Column(String(100))
    
    author = Column(String(500))
    publisher = Column(String(500))
    isbn = Column(String(50))
    issn = Column(String(50))
    
    # Relationships
    countries = relationship('Country', secondary=document_countries, back_populates='documents')
    tags = relationship('DocumentTag', back_populates='document', cascade='all, delete-orphan')
    collections = relationship('DocumentCollection', secondary=document_collection_memberships, back_populates='documents')

class Country(Base):
    __tablename__ = 'countries'

    id = Column(Integer, primary_key=True)
    name = Column(String(100), unique=True, nullable=False)
    code = Column(String(3), unique=True)
    region = Column(String(100))
    created_at = Column(DateTime, default=datetime.utcnow)

    # Relationships
    documents = relationship('Document', secondary=document_countries, back_populates='countries')

class Language(Base):
    __tablename__ = 'languages'

    id = Column(Integer, primary_key=True)
    name = Column(String(50), unique=True, nullable=False)
    code = Column(String(5), unique=True)
    created_at = Column(DateTime, default=datetime.utcnow)

class DocumentType(Base):
    __tablename__ = 'document_types'

    id = Column(Integer, primary_key=True)
    type_name = Column(String(100), unique=True, nullable=False)
    major_type = Column(String(100))
    description = Column(Text)
    created_at = Column(DateTime, default=datetime.utcnow)

class DocumentTag(Base):
    __tablename__ = 'document_tags'

    id = Column(Integer, primary_key=True)
    document_id = Column(String(255), ForeignKey('documents.id', ondelete='CASCADE'))
    tag = Column(String(100), nullable=False)
    tag_type = Column(String(50))
    created_at = Column(DateTime, default=datetime.utcnow)

    # Relationships
    document = relationship('Document', back_populates='tags')

class DocumentCollection(Base):
    __tablename__ = 'document_collections'

    id = Column(Integer, primary_key=True)
    name = Column(String(200), nullable=False)
    description = Column(Text)
    created_at = Column(DateTime, default=datetime.utcnow)

    # Relationships
    documents = relationship('Document', secondary=document_collection_memberships, back_populates='collections')

