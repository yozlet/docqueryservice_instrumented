# Multi-stage Dockerfile for React frontend with nginx
# Stage 1: Build the React application
FROM node:20-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package files for dependency installation
COPY package.json yarn.lock .yarnrc.yml ./

# Copy Yarn configuration
COPY .yarn ./.yarn

# Set Yarn version and install dependencies
RUN corepack enable && \
    corepack prepare yarn@4.10.2 --activate && \
    yarn install --immutable

# Copy source code
COPY . .

# Build the application
RUN yarn build

# Stage 2: Serve with nginx
FROM nginx:1.25-alpine

# Install curl for health checks
RUN apk add --no-cache curl

# Copy built application from builder stage
COPY --from=builder /app/dist /usr/share/nginx/html

# Copy nginx configuration template and static config
COPY nginx.conf.template /etc/nginx/templates/default.conf.template
COPY nginx.conf /etc/nginx/conf.d/nginx.conf.backup

# Remove default nginx configuration
RUN rm /etc/nginx/conf.d/default.conf.bak 2>/dev/null || true

# Set proper permissions for nginx
RUN chown -R nginx:nginx /usr/share/nginx/html

# Expose port 8080
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8080/health || exit 1

# Labels for documentation
LABEL maintainer="Document Query Service Team"
LABEL description="React frontend for Document Query Service with nginx"
LABEL version="1.0"

# Start nginx
CMD ["nginx", "-g", "daemon off;"]