# Document Query Service Frontend

This is the frontend application for the Document Query Service, built with React and TypeScript. It provides a modern web interface for document search and management functionality.

## Technologies Used

- React 18
- TypeScript
- Material-UI (MUI) with dark mode support
- React Router for navigation
- React Query for data fetching
- OpenTelemetry for monitoring
- Nginx for production serving
- Docker for containerization
- System-aware dark mode
- Multiple AI model support

## Prerequisites

- Node.js 18 or higher
- npm or yarn
- Docker (for production builds)

## Getting Started

### Environment Configuration

The application uses environment variables for configuration. There are different environment files for development and production:

- Development: Copy the example environment file and modify it for development:
  ```bash
  cp env.example .env.local
  ```

- Production: Create a `.env.production` file with production settings:
  ```bash
  cp env.example .env.production
  ```
  Update `REACT_APP_API_URL` to `http://localhost:8080/v1` for production.

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

3. Start the server:
   ```bash
   # For development mode (default)
   ./start.sh
   # OR
   ./start.sh development

   # For production mode
   ./start.sh production
   ```
   Or run manually:
   ```bash
   # Development
   npm start
   # Production
   npm run build && serve -s build
   ```

4. To stop the server:
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

## Features

### Dark Mode Support

The application automatically adapts to your system's color scheme preference:

- Automatically detects system dark mode preference
- Updates in real-time when system preference changes
- Uses Material UI's theme system for consistent styling
- Custom color palettes for both light and dark modes

To change the color scheme:
1. Use your system's color scheme settings
2. The application will automatically adjust its theme

### AI Model Selection

The document summarization feature supports multiple AI models:

- GPT-3.5 Turbo (16k context)
- GPT-4 Turbo
- Claude 3 Sonnet
- Claude 3 Opus

Select the appropriate model based on your needs:
- GPT-3.5 Turbo: Fast, cost-effective, good for most summaries
- GPT-4 Turbo: More accurate, better for complex documents
- Claude 3 Sonnet: Balanced performance and accuracy
- Claude 3 Opus: Highest accuracy, best for critical documents

## Project Structure

- `/src` - Source code
  - `/api` - API client and service definitions
  - `/components` - Reusable React components
  - `/pages` - Page components
  - `/telemetry` - OpenTelemetry configuration
  - `/theme` - MUI theme customization with dark mode support

## Available Scripts

- `npm start` - Runs the app in development mode
- `npm test` - Launches the test runner
- `npm run build` - Builds the app for production
- `npm run eject` - Ejects from Create React App

## Monitoring

This application is instrumented with OpenTelemetry for monitoring and tracing. The telemetry configuration can be found in `/src/telemetry.ts`.

## Production Deployment

The application is containerized using Docker and served using Nginx. The Nginx configuration can be found in `nginx.conf`.

## Nginx Setup and Configuration

### Installing Nginx

1. **For macOS (using Homebrew):**
   ```bash
   brew install nginx
   ```

2. **For Ubuntu/Debian:**
   ```bash
   sudo apt update
   sudo apt install nginx
   ```

3. **For CentOS/RHEL:**
   ```bash
   sudo yum install epel-release
   sudo yum install nginx
   ```

### Configuring Nginx

1. **Create a configuration directory (if it doesn't exist):**
   ```bash
   sudo mkdir -p /etc/nginx/sites-available
   sudo mkdir -p /etc/nginx/sites-enabled
   ```

2. **Copy the provided configuration:**
   ```bash
   # For macOS (Homebrew)
   sudo cp nginx.conf /usr/local/etc/nginx/servers/docquery.conf

   # For Linux
   sudo cp nginx.conf /etc/nginx/sites-available/docquery.conf
   sudo ln -s /etc/nginx/sites-available/docquery.conf /etc/nginx/sites-enabled/
   ```

3. **Test the configuration:**
   ```bash
   # For macOS (Homebrew)
   nginx -t

   # For Linux
   sudo nginx -t
   ```

### Running Nginx

1. **Start Nginx:**
   ```bash
   # For macOS (Homebrew)
   brew services start nginx

   # For Linux
   sudo systemctl start nginx
   ```

2. **Enable Nginx to start on boot (Linux only):**
   ```bash
   sudo systemctl enable nginx
   ```

3. **Manage Nginx:**
   ```bash
   # Restart Nginx
   sudo systemctl restart nginx  # Linux
   brew services restart nginx   # macOS

   # Stop Nginx
   sudo systemctl stop nginx     # Linux
   brew services stop nginx      # macOS

   # Check status
   sudo systemctl status nginx   # Linux
   brew services list           # macOS
   ```

The provided `nginx.conf` includes:
- Reverse proxy configuration for both frontend and backend services:
  - Frontend (React) at `http://localhost:3000`
  - Backend (Python) at `http://localhost:5002`
  - All requests to `/v1/*` are forwarded to the backend
  - All other requests are forwarded to the frontend
- WebSocket support for React development server
- Security headers configuration
- Gzip compression for better performance
- Static file caching
- Health check endpoint
- SPA routing support
- Error page handling

### Proxy Configuration Details

The Nginx server acts as a reverse proxy, routing requests to either the frontend React application or the backend Python service based on the URL path:

1. **Frontend Routing**:
   - Base URL: `http://localhost:8080/`
   - All requests not starting with `/v1/` are routed to the React development server
   - Includes WebSocket support for hot reloading

2. **Backend API Routing**:
   - Base URL: `http://localhost:8080/v1/`
   - All requests starting with `/v1/` are routed to the Python backend
   - The `/v1/` prefix is automatically stripped when forwarding to the backend

3. **Development URLs**:
   ```
   Frontend (direct): http://localhost:3000
   Backend (direct):  http://localhost:5002
   
   Through Nginx proxy:
   Frontend: http://localhost:8080/
   Backend:  http://localhost:8080/v1/
   ```

4. **Headers and Security**:
   - Forwards client IP addresses
   - Maintains secure headers
   - Supports WebSocket upgrades
   - Includes CORS and security policies

### Verifying the Setup

After starting Nginx, verify the setup by:

1. Building the React application:
   ```bash
   npm run build
   ```

2. Copying the build files:
   ```bash
   # For macOS (Homebrew)
   sudo cp -r build/* /usr/local/var/www/

   # For Linux
   sudo cp -r build/* /usr/share/nginx/html/
   ```

3. Visit [http://localhost:8080](http://localhost:8080) to verify the application is being served correctly.

## Contributing

Please refer to the project's main README for contribution guidelines.
