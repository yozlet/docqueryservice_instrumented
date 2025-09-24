# Use the official NGINX image as base
FROM nginx:mainline

# Install build dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    libpcre3-dev \
    zlib1g-dev \
    libssl-dev \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Download and extract NGINX source
WORKDIR /usr/src
RUN wget http://nginx.org/download/nginx-$(nginx -v 2>&1 | cut -d/ -f2).tar.gz \
    && tar zxf nginx-*.tar.gz \
    && rm nginx-*.tar.gz

# Clone OpenTelemetry NGINX module
RUN git clone https://github.com/open-telemetry/opentelemetry-cpp-contrib.git

# Build and install OpenTelemetry NGINX module
WORKDIR /usr/src/nginx-$(nginx -v 2>&1 | cut -d/ -f2)
RUN ./configure \
    --with-compat \
    --add-dynamic-module=../opentelemetry-cpp-contrib/instrumentation/nginx \
    && make modules \
    && cp objs/ngx_otel_module.so /etc/nginx/modules/

# Copy NGINX configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Create required directories
RUN mkdir -p /var/log/nginx

# Expose ports
EXPOSE 80 8080

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]

