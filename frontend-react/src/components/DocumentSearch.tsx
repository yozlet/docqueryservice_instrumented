import { useState, useEffect } from 'react'
import { Input, Button, Card, Row, Col, Typography, Space, Pagination, Spin, Alert, Tag } from 'antd'
import { SearchOutlined } from '@ant-design/icons'
import axios from 'axios'

const { Search } = Input
const { Title, Text, Paragraph } = Typography
const { Meta } = Card

interface Document {
  id: string
  title: string
  abstract?: string
  url?: string
  docdate?: string
  countryName?: string
  languageName?: string
  docType?: string
  authors?: string[]
  topics?: string[]
}

interface SearchResponse {
  total: number
  rows: number
  os: number
  page: number
  documents: { [key: string]: Document }
}

const DocumentSearch = () => {
  const [searchTerm, setSearchTerm] = useState('')
  const [documents, setDocuments] = useState<Document[]>([])
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState<string | null>(null)
  const [total, setTotal] = useState(0)
  const [currentPage, setCurrentPage] = useState(1)
  const [pageSize] = useState(10)

  const API_BASE_URL = 'http://localhost:5001/api/v3'

  const searchDocuments = async (term: string = '', page: number = 1) => {
    setLoading(true)
    setError(null)
    
    try {
      const params = new URLSearchParams({
        rows: pageSize.toString(),
        os: ((page - 1) * pageSize).toString(),
        format: 'json'
      })
      
      if (term.trim()) {
        params.append('qterm', term.trim())
      }

      const response = await axios.get<SearchResponse>(`${API_BASE_URL}/wds?${params}`)
      
      const documentsArray = Object.values(response.data.documents || {})
      setDocuments(documentsArray)
      setTotal(response.data.total || 0)
      setCurrentPage(page)
    } catch (err) {
      console.error('Search error:', err)
      if (axios.isAxiosError(err)) {
        if (err.code === 'ECONNREFUSED') {
          setError('Cannot connect to the backend API. Please ensure the .NET backend is running on http://localhost:5001')
        } else {
          setError(`API Error: ${err.response?.status} - ${err.response?.statusText || err.message}`)
        }
      } else {
        setError('An unexpected error occurred while searching documents')
      }
    } finally {
      setLoading(false)
    }
  }

  const handleSearch = (value: string) => {
    setSearchTerm(value)
    setCurrentPage(1)
    searchDocuments(value, 1)
  }

  const handlePageChange = (page: number) => {
    searchDocuments(searchTerm, page)
  }

  useEffect(() => {
    searchDocuments()
  }, [])

  const formatDate = (dateStr?: string) => {
    if (!dateStr) return 'Unknown'
    try {
      return new Date(dateStr).toLocaleDateString()
    } catch {
      return dateStr
    }
  }

  return (
    <div className="document-search">
      <Title level={2}>Document Search</Title>
      <Paragraph>
        Search through the World Bank Documents & Reports database. 
        Enter keywords to find relevant documents by title, abstract, or content.
      </Paragraph>

      <div className="search-filters">
        <Row gutter={[16, 16]}>
          <Col span={20}>
            <Search
              placeholder="Enter search terms (e.g., 'renewable energy', 'climate change')"
              enterButton={<SearchOutlined />}
              size="large"
              onSearch={handleSearch}
              loading={loading}
            />
          </Col>
          <Col span={4}>
            <Button 
              size="large" 
              onClick={() => handleSearch('')}
              disabled={loading}
            >
              Clear
            </Button>
          </Col>
        </Row>
      </div>

      {error && (
        <Alert
          message="Search Error"
          description={error}
          type="error"
          showIcon
          style={{ marginBottom: 24 }}
        />
      )}

      <Spin spinning={loading}>
        <div style={{ minHeight: '200px' }}>
          {total > 0 && (
            <div style={{ marginBottom: 16 }}>
              <Text strong>
                Found {total.toLocaleString()} documents
                {searchTerm && ` for "${searchTerm}"`}
              </Text>
            </div>
          )}

          <Row gutter={[16, 16]}>
            {documents.map((doc) => (
              <Col span={24} key={doc.id}>
                <Card
                  className="document-card"
                  hoverable
                  actions={doc.url ? [
                    <Button type="link" href={doc.url} target="_blank" rel="noopener noreferrer">
                      View Document
                    </Button>
                  ] : undefined}
                >
                  <Meta
                    title={
                      <div>
                        <Title level={4} style={{ marginBottom: 8 }}>
                          {doc.title}
                        </Title>
                        <div className="document-meta">
                          <Space wrap>
                            {doc.docdate && <Text type="secondary">Date: {formatDate(doc.docdate)}</Text>}
                            {doc.countryName && <Tag color="blue">{doc.countryName}</Tag>}
                            {doc.languageName && <Tag color="green">{doc.languageName}</Tag>}
                            {doc.docType && <Tag color="orange">{doc.docType}</Tag>}
                          </Space>
                        </div>
                      </div>
                    }
                    description={
                      <div>
                        {doc.abstract && (
                          <Paragraph ellipsis={{ rows: 3, expandable: true }}>
                            {doc.abstract}
                          </Paragraph>
                        )}
                        {doc.authors && doc.authors.length > 0 && (
                          <div style={{ marginTop: 8 }}>
                            <Text strong>Authors: </Text>
                            <Text>{doc.authors.join(', ')}</Text>
                          </div>
                        )}
                        {doc.topics && doc.topics.length > 0 && (
                          <div style={{ marginTop: 8 }}>
                            <Space wrap>
                              <Text strong>Topics: </Text>
                              {doc.topics.slice(0, 3).map((topic, index) => (
                                <Tag key={index} color="purple">{topic}</Tag>
                              ))}
                              {doc.topics.length > 3 && (
                                <Text type="secondary">+{doc.topics.length - 3} more</Text>
                              )}
                            </Space>
                          </div>
                        )}
                      </div>
                    }
                  />
                </Card>
              </Col>
            ))}
          </Row>

          {!loading && documents.length === 0 && !error && (
            <div style={{ textAlign: 'center', padding: '50px 0' }}>
              <Text type="secondary">
                {searchTerm ? 'No documents found matching your search criteria.' : 'Enter a search term to find documents.'}
              </Text>
            </div>
          )}
        </div>
      </Spin>

      {total > pageSize && (
        <div className="pagination-container">
          <Pagination
            current={currentPage}
            total={total}
            pageSize={pageSize}
            showSizeChanger={false}
            showQuickJumper
            showTotal={(total, range) => 
              `${range[0]}-${range[1]} of ${total.toLocaleString()} documents`
            }
            onChange={handlePageChange}
            disabled={loading}
          />
        </div>
      )}
    </div>
  )
}

export default DocumentSearch