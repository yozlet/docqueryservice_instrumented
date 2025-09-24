from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    # Database settings
    DB_HOST: str
    DB_PORT: int = 5432
    DB_NAME: str
    DB_USER: str
    DB_PASSWORD: str

    # OpenTelemetry settings
    OTEL_EXPORTER_OTLP_ENDPOINT: str = "http://localhost:4317"
    OTEL_SERVICE_NAME: str = "docquery-backend-python"

    # CORS settings
    CORS_ORIGINS: list[str] = [
        "http://localhost:3000",  # Local development
        "http://localhost:8080",  # Local development alternative
    ]

    # API settings
    API_V1_PREFIX: str = "/v1"

    class Config:
        env_file = ".env"
        case_sensitive = True

settings = Settings()

