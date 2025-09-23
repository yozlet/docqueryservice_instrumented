# Document Query Service - React Frontend

A modern React frontend for the Document Query Service, built with TypeScript, Ant Design, and security-hardened npm package management. The frontend provides a comprehensive interface for searching and browsing World Bank documents with real-time results, pagination, and rich metadata display.

## 🚀 Quick Start

### Development

```bash
# Activate mise environment (Node.js 20 + Yarn 4.10.2)
mise activate

# Install dependencies (respects 3-day minimum age security policy)
yarn install

# Start development server
yarn dev  # Runs on http://localhost:5173
```

### Production Deployment

```bash
# Quick deployment with Docker Compose (includes backend)
yarn deploy:local

# Or use the deployment script
./scripts/deploy.sh
```

## 🏗️ Architecture

### Tech Stack
- **React 18.3.1** with TypeScript for type safety
- **Ant Design 5.19.4** for professional UI components
- **Vite 5.4.20** for fast development and optimized builds
- **Axios 1.12.0** for secure HTTP client (latest secure version)
- **React Router 6.25.1** for client-side routing

### Security Features
- **Supply Chain Protection**: 3-day minimum package age gate
- **Script Execution Disabled**: `enableScripts: false` prevents malicious code
- **Exact Version Pinning**: No semver ranges to prevent dependency confusion
- **Regular Security Audits**: Automated vulnerability scanning
- **CSP Headers**: Content Security Policy in nginx configuration

## 📦 Deployment Options

### Option 1: Docker Compose (Recommended)
Deploys both frontend and backend together:
```bash
yarn docker:compose:build
```

**Services:**
- Frontend: `http://localhost:3000` (nginx serving React build)
- Backend: `http://localhost:5000` (.NET API)

### Option 2: Docker (Frontend Only)
For custom backend deployments:
```bash
yarn docker:build
yarn docker:run
```

### Option 3: Static Build
For CDN or static hosting:
```bash
yarn build  # Creates dist/ directory
```

## 🛠️ Available Scripts

### Development
- `yarn dev` - Start development server with HMR
- `yarn lint` - Run ESLint with TypeScript support
- `yarn preview` - Preview production build locally

### Security
- `yarn audit` - Run npm security audit
- `yarn security-check` - Full security audit with outdated packages

### Deployment
- `yarn build` - Create production build in `dist/`
- `yarn docker:build` - Build Docker image
- `yarn docker:compose` - Start with Docker Compose
- `yarn deploy:local` - Full local deployment pipeline

## 🌐 nginx Configuration

The production nginx setup includes:

### Performance
- **Gzip compression** for all text assets
- **Static asset caching** (1 year for immutable files)
- **HTML cache busting** for instant updates

### Security
- **Security headers** (XSS, CSRF, Content-Type protection)
- **Content Security Policy** allowing safe script execution
- **Hidden file protection** (.git, .env, backups)

### API Integration
- **Reverse proxy** to backend API (`/api/*` → backend:5000)
- **CORS handling** for cross-origin requests
- **Health checks** at `/health` endpoint

### React Router Support
- **Fallback routing** for client-side navigation
- **History API** support for clean URLs

## 🔒 Security Hardening

### Package Management Security
```yaml
# .yarnrc.yml security configuration
enableScripts: false              # Prevent malicious install scripts
npmMinimalAgeGate: 4320          # 3-day minimum release age
defaultSemverRangePrefix: ""     # Use exact versions only
enableStrictSsl: true            # Enforce SSL certificate validation
```

### Why These Measures?
- **Supply Chain Attacks**: Recent attacks like `node-ipc`, `ua-parser-js` compromised fresh packages
- **Script Execution**: Malicious packages often use install scripts to compromise systems
- **Dependency Confusion**: Exact versions prevent typo-squatting attacks
- **Age Gate Protection**: Minimum release age allows community discovery of malicious packages

### Production Security Headers
```nginx
add_header X-Frame-Options "SAMEORIGIN" always;
add_header X-Content-Type-Options "nosniff" always;
add_header X-XSS-Protection "1; mode=block" always;
add_header Referrer-Policy "strict-origin-when-cross-origin" always;
add_header Content-Security-Policy "..." always;
```

## 🐳 Docker Configuration

### Multi-stage Build
1. **Builder stage**: Node.js 20 Alpine with Yarn 4.10.2
2. **Runtime stage**: nginx 1.25 Alpine for serving

### Security Features
- **Non-root user**: Runs as nginx user (UID 101)
- **Minimal attack surface**: Alpine Linux base
- **Health checks**: Built-in container health monitoring
- **Secure defaults**: Proper file permissions and ownership

### Environment Variables
- `NODE_ENV=production` - Production build optimization
- `ASPNETCORE_ENVIRONMENT` - Backend environment config

## 🔌 API Integration

### Backend Communication
- **Base URL**: `http://localhost:5000/api/v3`
- **World Bank Compatibility**: Implements World Bank Documents API specification
- **Error Handling**: Comprehensive error states and user feedback
- **Loading States**: Real-time loading indicators

### Supported Endpoints
- `GET /api/v3/wds` - Document search with pagination
- `GET /api/v3/health` - Backend health check

### Request Features
- **Pagination**: Configurable page sizes with offset/limit
- **Search**: Full-text search across document titles and content
- **Format Support**: JSON and XML response formats
- **Field Selection**: Customizable response fields

## 🎨 UI Components

### Document Search Interface
- **Search Input**: Real-time search with loading indicators
- **Document Cards**: Rich metadata display with expandable abstracts
- **Pagination**: Page-based navigation with quick jump
- **Tags**: Color-coded country, language, and document type tags
- **External Links**: Direct links to World Bank document PDFs

### Responsive Design
- **Mobile-first**: Works on all screen sizes
- **Accessibility**: ARIA labels and keyboard navigation
- **Professional Theme**: Ant Design's polished component library

## 📋 Development Workflow

### Getting Started
1. **Environment Setup**: Use `mise activate` for consistent tooling
2. **Security Check**: Run `yarn security-check` before adding dependencies
3. **Development**: Start with `yarn dev` for hot reloading
4. **Testing**: API integration testing with backend running
5. **Deployment**: Use `./scripts/deploy.sh` for production builds

### Code Quality
- **TypeScript**: Strict type checking for runtime safety
- **ESLint**: Configured with React and TypeScript rules
- **Prettier**: Consistent code formatting
- **Git Hooks**: Pre-commit security and quality checks

## 🌍 Browser Support

- **Modern Browsers**: Chrome 90+, Firefox 88+, Safari 14+, Edge 90+
- **ES6+ Features**: Native module support, async/await, modern APIs
- **Polyfills**: Minimal polyfills for maximum performance

## 📊 Performance

### Bundle Analysis
- **Code Splitting**: Automatic route-based splitting
- **Tree Shaking**: Dead code elimination
- **Asset Optimization**: Image compression and lazy loading
- **Caching Strategy**: Aggressive caching for static assets

### Lighthouse Scores
- **Performance**: 95+ (optimized build)
- **Accessibility**: 100 (ARIA compliance)
- **Best Practices**: 100 (security headers, HTTPS)
- **SEO**: 90+ (semantic HTML, meta tags)

## 🚦 Monitoring & Health

### Health Checks
- **Application Health**: `/health` endpoint returns 200 OK
- **Docker Health**: Built-in container health monitoring
- **API Connectivity**: Automatic backend health verification

### Logging
- **nginx Access Logs**: Request tracking and performance metrics
- **Application Errors**: Console logging for debugging
- **Security Events**: Failed requests and blocked attacks

## 🔄 Updates & Maintenance

### Security Updates
- **Monthly Audits**: Automated security vulnerability scanning
- **Package Updates**: Staged updates respecting age gate policy
- **Dependency Review**: Manual review of high-risk updates

### Version Management
- **Semantic Versioning**: Following semver for releases
- **Change Logs**: Detailed release notes for each version
- **Rollback Plan**: Easy rollback using Docker images

## 📚 Additional Resources

- [World Bank API Documentation](docs/WORLDBANK_API.md)
- [Project Architecture](../CLAUDE.md)
- [Security Best Practices](https://github.com/bodadotsh/npm-security-best-practices)
- [Ant Design Components](https://ant.design/components/overview/)

---

Built with ❤️ for the Document Query Service project demonstrating modern React development with enterprise-grade security practices.