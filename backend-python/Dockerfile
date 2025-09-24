# Use Python 3.9 slim image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first to leverage Docker cache
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY app/ ./app/

# Set environment variables
ENV PYTHONUNBUFFERED=1
ENV LISTEN_HOST=0.0.0.0
ENV LISTEN_PORT=5002

# Expose port
EXPOSE 5002

# Run the application
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "5002"]
