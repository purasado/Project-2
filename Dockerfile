# ====== Builder stage ======
FROM python:3.11-slim AS builder
WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    wget \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --upgrade pip && pip install --prefix=/install -r requirements.txt

# ====== Runtime stage ======
FROM python:3.11-slim
RUN useradd -m appuser
WORKDIR /app

COPY --from=builder /install /usr/local
COPY app.py .

EXPOSE 8000

HEALTHCHECK --interval=30s --timeout=3s --retries=3 CMD wget -qO- http://127.0.0.1:8000/health || exit 1

USER appuser
CMD ["python", "-m", "uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
