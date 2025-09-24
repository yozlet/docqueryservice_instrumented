# Document Query Service

A distributed application demonstrating observability features across a full-stack setup deployed on AWS and Azure.

## Architecture

The application consists of the following components:

- **Frontend**: React application deployed on AWS EC2
- **Backend Services**:
  - Python API service (AWS EC2)
  - .NET API service (Azure App Services)
- **Database**: Azure PostgreSQL
- **Observability**: Honeycomb.io with OpenTelemetry

## Directory Structure

```
.
├── frontend/               # React frontend application
├── backend/
│   ├── python/            # Python backend service (AWS)
│   └── dotnet/            # .NET backend service (Azure)
├── infrastructure/
│   ├── aws/              # AWS Terraform configuration
│   ├── azure/            # Azure Terraform configuration
│   └── shared/           # Shared Terraform modules
├── nginx/                # NGINX configuration
└── docs/                 # Documentation
```

## Prerequisites

- AWS CLI configured with appropriate credentials
- Azure CLI configured with appropriate credentials
- Terraform >= 1.0
- Node.js >= 18
- Python >= 3.9
- .NET 7.0
- Docker

## Getting Started

1. Set up infrastructure:
   ```bash
   cd infrastructure
   terraform init
   terraform apply
   ```

2. Set up database:
   ```bash
   # Run database migrations
   ```

3. Start backend services:
   ```bash
   # Start Python backend
   cd backend/python
   python -m venv venv
   source venv/bin/activate
   pip install -r requirements.txt
   python app.py

   # Start .NET backend
   cd backend/dotnet
   dotnet restore
   dotnet run
   ```

4. Start frontend:
   ```bash
   cd frontend
   npm install
   npm start
   ```

## Observability

The application is instrumented with OpenTelemetry for:
- Distributed tracing
- Metrics collection
- Logging
- Real User Monitoring (RUM)

All telemetry data is sent to Honeycomb.io for analysis and visualization.

## Development

### Local Development

1. Create a `.env` file in each service directory with the required environment variables
2. Start the services in development mode
3. Use the provided Docker Compose file for local dependencies

### Testing

Each component includes:
- Unit tests
- Integration tests
- End-to-end tests
- Load tests

### Deployment

The application uses separate deployment pipelines for AWS and Azure components:
- AWS CodePipeline for AWS components
- Azure DevOps for Azure components

## License

MIT

