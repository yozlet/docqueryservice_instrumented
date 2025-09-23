import { Layout, Typography } from 'antd'
import { useEffect } from 'react'
import DocumentSearch from './components/DocumentSearch'
import { initializeHoneycomb, trackPageView } from './telemetry/honeycomb'
import { config } from './config/environment'
import './App.css'

const { Header, Content } = Layout
const { Title } = Typography

function App() {
  useEffect(() => {
    // Initialize Honeycomb telemetry on app startup
    const telemetryInitialized = initializeHoneycomb({
      serviceName: 'docquery-frontend',
      serviceVersion: '1.0.0',
      honeycombApiKey: config.honeycombApiKey,
      honeycombDataset: config.honeycombDataset,
      environment: config.environment,
      debug: config.environment === 'development'
    })

    if (telemetryInitialized) {
      // Track initial page view
      trackPageView('app_home', {
        user_agent: navigator.userAgent,
        screen_resolution: `${screen.width}x${screen.height}`,
        language: navigator.language
      })
    }
  }, [])

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