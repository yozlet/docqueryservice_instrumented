import { Layout, Typography } from 'antd'
import DocumentSearch from './components/DocumentSearch'
import './App.css'

const { Header, Content } = Layout
const { Title } = Typography

function App() {
  return (
    <Layout style={{ minHeight: '100vh' }}>
      <Header style={{ background: '#001529', padding: '0 50px' }}>
        <div style={{ color: 'white', display: 'flex', alignItems: 'center', height: '100%' }}>
          <Title level={3} style={{ color: 'white', margin: 0 }}>
            Document Query Service
          </Title>
        </div>
      </Header>
      <Content style={{ padding: '50px' }}>
        <DocumentSearch />
      </Content>
    </Layout>
  )
}

export default App