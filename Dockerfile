
FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

WORKDIR /app

# Install system dependencies and update Python packaging tools
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        gcc \
        python3-dev \
        libssl-dev \
        curl && \
    rm -rf /var/lib/apt/lists/* && \
    python -m pip install --no-cache-dir --upgrade \
        pip \
        "setuptools>=78.1.1" \
        wheel

# Install application dependencies
COPY requirements.txt .
RUN python -m pip install --no-cache-dir -r requirements.txt

# Remove pip's bundled SBOM metadata referencing outdated setuptools
RUN rm -f /usr/local/lib/python3.12/site-packages/pip/_vendor/bom.cdx.json

# Create non-root user
RUN groupadd -r appgroup && \
    useradd -r -g appgroup appuser

# Copy application code
COPY . .

# Set permissions
RUN chown -R appuser:appgroup /app

USER appuser

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8000/health || exit 1

CMD python -m app.database_init && \
    uvicorn app.main:app --host 0.0.0.0 --port 8000 --workers 4
