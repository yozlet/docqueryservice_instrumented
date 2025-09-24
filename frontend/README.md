# Document Query Service Frontend

This is the frontend application for the Document Query Service, built with React and TypeScript. It provides a modern web interface for document search and management functionality.

## Technologies Used

- React 18
- TypeScript
- Material-UI (MUI)
- React Router
- React Query
- OpenTelemetry for monitoring
- Nginx for production serving
- Docker for containerization

## Prerequisites

- Node.js 18 or higher
- npm or yarn
- Docker (for production builds)

## Getting Started

### Environment Configuration

The application uses environment variables for configuration. Copy the example environment file and modify it according to your needs:

```bash
cp env.example .env.local
```

Available environment variables:

- `REACT_APP_API_URL` - Backend API URL
- `REACT_APP_OTEL_COLLECTOR_URL` - OpenTelemetry collector URL
- `REACT_APP_HONEYCOMB_API_KEY` - Honeycomb API key for telemetry
- `REACT_APP_ENABLE_TELEMETRY` - Enable/disable telemetry
- `REACT_APP_ENABLE_DEBUG_MODE` - Enable/disable debug mode
- `REACT_APP_MAX_UPLOAD_SIZE` - Maximum file upload size in bytes
- `REACT_APP_SUPPORTED_FILE_TYPES` - Comma-separated list of supported file types

### Local Development

1. Install dependencies:
   ```bash
   npm install
   ```

2. Set up environment variables:
   ```bash
   cp env.example .env.local
   # Edit .env.local with your configuration
   ```

3. Start the development server:
   ```bash
   ./start.sh
   ```
   Or run manually:
   ```bash
   npm start
   ```

3. To stop the development server:
   ```bash
   ./stop.sh
   ```
   Or press `Ctrl+C` if running manually

The application will be available at [http://localhost:3000](http://localhost:3000)

### Production Build

To create a production build:

```bash
npm run build
```

### Docker Build

To build and run using Docker:

```bash
docker build -t docquery-frontend .
docker run -p 8080:8080 docquery-frontend
```

The application will be available at [http://localhost:8080](http://localhost:8080)

## Project Structure

- `/src` - Source code
  - `/api` - API client and service definitions
  - `/components` - Reusable React components
  - `/pages` - Page components
  - `/telemetry` - OpenTelemetry configuration
  - `/theme` - MUI theme customization

## Available Scripts

- `npm start` - Runs the app in development mode
- `npm test` - Launches the test runner
- `npm run build` - Builds the app for production
- `npm run eject` - Ejects from Create React App

## Monitoring

This application is instrumented with OpenTelemetry for monitoring and tracing. The telemetry configuration can be found in `/src/telemetry.ts`.

## Production Deployment

The application is containerized using Docker and served using Nginx. The Nginx configuration can be found in `nginx.conf`.

## Contributing

Please refer to the project's main README for contribution guidelines.
