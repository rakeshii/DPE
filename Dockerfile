FROM python:3.13-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends libreoffice && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Tell Python to always look in /app for modules — fixes 'No module named routes/core'
ENV PYTHONPATH=/app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Verify folders landed correctly — shows in build log so you can confirm
RUN echo "=== /app contents ===" && ls -la /app && \
    echo "=== routes/ ===" && ls /app/routes/ && \
    echo "=== core/ ===" && ls /app/core/

RUN mkdir -p /tmp/fsproj_uploads /tmp/fsproj_outputs

EXPOSE 10000

CMD gunicorn wsgi:app --bind 0.0.0.0:${PORT:-10000} --timeout 120 --workers 2
