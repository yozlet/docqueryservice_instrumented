# Build stage
FROM node:24-alpine

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./
COPY tsconfig.json ./

# Install dependencies
RUN npm ci

# Copy source code
COPY src/ src/
COPY public/ public/

# Build the application
RUN npm run build

# Expose port
EXPOSE 3000

# Start application
CMD ["npm", "start"]

