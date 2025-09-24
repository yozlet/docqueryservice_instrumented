# Use the official OpenTelemetry Collector Contrib image
FROM otel/opentelemetry-collector-contrib:latest

# Copy configuration
COPY config.yaml /etc/otelcol/config.yaml

# Expose ports
EXPOSE 4317 4318

# Set the config file location
CMD ["--config", "/etc/otelcol/config.yaml"]

