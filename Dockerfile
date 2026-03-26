FROM python:3.13-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends libreoffice && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN mkdir -p /tmp/fsproj_uploads /tmp/fsproj_outputs

EXPOSE 10000

CMD gunicorn wsgi:app --bind 0.0.0.0:${PORT:-10000} --timeout 120 --workers 2
