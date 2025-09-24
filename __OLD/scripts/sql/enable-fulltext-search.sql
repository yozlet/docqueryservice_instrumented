-- Enable Full-Text Search for Document Query Service
-- Run this AFTER loading data into the documents table

USE DocQueryService;

-- Create full-text catalog
IF NOT EXISTS (SELECT * FROM sys.fulltext_catalogs WHERE name = 'DocQueryCatalog')
BEGIN
    CREATE FULLTEXT CATALOG DocQueryCatalog AS DEFAULT;
    PRINT 'Full-text catalog created successfully.';
END
ELSE
BEGIN
    PRINT 'Full-text catalog already exists.';
END

-- Create full-text index on documents table
IF NOT EXISTS (SELECT * FROM sys.fulltext_indexes WHERE object_id = OBJECT_ID('documents'))
BEGIN
    CREATE FULLTEXT INDEX ON documents(
        title LANGUAGE 1033,           -- English
        abstract LANGUAGE 1033,        -- English  
        content_text LANGUAGE 1033     -- English
    )
    KEY INDEX PK__documents  -- Primary key constraint name
    ON DocQueryCatalog
    WITH (
        CHANGE_TRACKING = AUTO,
        STOPLIST = SYSTEM
    );
    PRINT 'Full-text index created successfully on documents table.';
END
ELSE
BEGIN
    PRINT 'Full-text index already exists on documents table.';
END

-- Wait for full-text index population
PRINT 'Waiting for full-text index population to complete...';
WHILE FULLTEXTCATALOGPROPERTY('DocQueryCatalog', 'PopulateStatus') <> 0
BEGIN
    WAITFOR DELAY '00:00:02';  -- Wait 2 seconds
END
PRINT 'Full-text index population completed.';

-- Create stored procedures for full-text search

-- Procedure for basic document search
CREATE OR ALTER PROCEDURE sp_SearchDocuments
    @SearchTerm NVARCHAR(1000),
    @Language NVARCHAR(50) = NULL,
    @Country NVARCHAR(100) = NULL,
    @DocumentType NVARCHAR(100) = NULL,
    @StartDate DATE = NULL,
    @EndDate DATE = NULL,
    @PageSize INT = 10,
    @PageNumber INT = 1,
    @SortBy NVARCHAR(50) = 'relevance' -- 'relevance', 'date', 'title'
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @Offset INT = (@PageNumber - 1) * @PageSize;
    DECLARE @TotalCount INT;
    
    -- Get total count first
    WITH SearchResults AS (
        SELECT d.id
        FROM documents d
        WHERE 
            (@SearchTerm IS NULL OR @SearchTerm = '' OR 
             CONTAINS((title, abstract, content_text), @SearchTerm))
            AND (@Language IS NULL OR d.lang = @Language)
            AND (@Country IS NULL OR d.country = @Country)
            AND (@DocumentType IS NULL OR d.majdocty = @DocumentType)
            AND (@StartDate IS NULL OR d.docdt >= @StartDate)
            AND (@EndDate IS NULL OR d.docdt <= @EndDate)
    )
    SELECT @TotalCount = COUNT(*) FROM SearchResults;
    
    -- Return paginated results
    WITH SearchResults AS (
        SELECT 
            d.id,
            d.title,
            d.abstract,
            d.docdt,
            d.lang,
            d.country,
            d.docty,
            d.majdocty,
            d.url,
            d.author,
            d.publisher,
            CASE 
                WHEN @SearchTerm IS NULL OR @SearchTerm = '' THEN 0
                ELSE ISNULL(ft.RANK, 0)
            END as relevance_score
        FROM documents d
        LEFT JOIN FREETEXTTABLE(documents, (title, abstract, content_text), @SearchTerm) ft
            ON d.id = ft.[KEY]
        WHERE 
            (@SearchTerm IS NULL OR @SearchTerm = '' OR ft.[KEY] IS NOT NULL OR
             CONTAINS((title, abstract, content_text), @SearchTerm))
            AND (@Language IS NULL OR d.lang = @Language)
            AND (@Country IS NULL OR d.country = @Country)
            AND (@DocumentType IS NULL OR d.majdocty = @DocumentType)
            AND (@StartDate IS NULL OR d.docdt >= @StartDate)
            AND (@EndDate IS NULL OR d.docdt <= @EndDate)
    )
    SELECT 
        *,
        @TotalCount as TotalCount,
        @PageNumber as PageNumber,
        @PageSize as PageSize,
        CEILING(CAST(@TotalCount AS FLOAT) / @PageSize) as TotalPages
    FROM SearchResults
    ORDER BY 
        CASE 
            WHEN @SortBy = 'relevance' THEN relevance_score 
        END DESC,
        CASE 
            WHEN @SortBy = 'date' THEN docdt 
        END DESC,
        CASE 
            WHEN @SortBy = 'title' THEN title 
        END ASC
    OFFSET @Offset ROWS
    FETCH NEXT @PageSize ROWS ONLY;
END;

-- Procedure for getting document suggestions/autocomplete
CREATE OR ALTER PROCEDURE sp_GetDocumentSuggestions
    @Prefix NVARCHAR(100),
    @MaxResults INT = 10
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT TOP (@MaxResults)
        title,
        id,
        majdocty,
        docdt
    FROM documents
    WHERE title LIKE @Prefix + '%'
    ORDER BY 
        CASE WHEN title LIKE @Prefix + '%' THEN 1 ELSE 2 END,
        LEN(title),
        title;
END;

-- Procedure for getting faceted search results (for analytics)
CREATE OR ALTER PROCEDURE sp_GetSearchFacets
    @SearchTerm NVARCHAR(1000) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Countries facet
    SELECT 
        'country' as facet_type,
        country as facet_value,
        COUNT(*) as doc_count
    FROM documents d
    WHERE (@SearchTerm IS NULL OR @SearchTerm = '' OR 
           CONTAINS((title, abstract, content_text), @SearchTerm))
        AND country IS NOT NULL
    GROUP BY country
    ORDER BY COUNT(*) DESC;
    
    -- Languages facet  
    SELECT 
        'language' as facet_type,
        lang as facet_value,
        COUNT(*) as doc_count
    FROM documents d
    WHERE (@SearchTerm IS NULL OR @SearchTerm = '' OR 
           CONTAINS((title, abstract, content_text), @SearchTerm))
        AND lang IS NOT NULL
    GROUP BY lang
    ORDER BY COUNT(*) DESC;
    
    -- Document types facet
    SELECT 
        'document_type' as facet_type,
        majdocty as facet_value,
        COUNT(*) as doc_count
    FROM documents d
    WHERE (@SearchTerm IS NULL OR @SearchTerm = '' OR 
           CONTAINS((title, abstract, content_text), @SearchTerm))
        AND majdocty IS NOT NULL
    GROUP BY majdocty
    ORDER BY COUNT(*) DESC;
    
    -- Year facet
    SELECT 
        'year' as facet_type,
        CAST(YEAR(docdt) AS NVARCHAR) as facet_value,
        COUNT(*) as doc_count
    FROM documents d
    WHERE (@SearchTerm IS NULL OR @SearchTerm = '' OR 
           CONTAINS((title, abstract, content_text), @SearchTerm))
        AND docdt IS NOT NULL
    GROUP BY YEAR(docdt)
    ORDER BY YEAR(docdt) DESC;
END;

-- Test the full-text search setup
PRINT 'Testing full-text search...';

-- Simple test query (will only work if there's data)
DECLARE @TestCount INT;
SELECT @TestCount = COUNT(*) FROM documents WHERE CONTAINS((title, abstract), 'development');
PRINT 'Documents containing "development": ' + CAST(@TestCount AS NVARCHAR);

PRINT 'Full-text search setup completed successfully!';
PRINT 'Available stored procedures:';
PRINT '- sp_SearchDocuments: Main search with filters and pagination';
PRINT '- sp_GetDocumentSuggestions: Autocomplete suggestions';
PRINT '- sp_GetSearchFacets: Faceted search results for analytics';