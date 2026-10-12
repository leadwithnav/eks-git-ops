FROM python:3.12-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt && useradd -u 10001 appuser
COPY app/ ./app/
USER appuser
EXPOSE 8080
CMD ["python", "-m", "app.main"]
