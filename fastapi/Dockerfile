FROM python:3.9-slim
WORKDIR /app
COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY app/main.py .
EXPOSE 8000
CMD ["uvicorn", "main.py:app", "--host", "0.0.0.0", "--port", "8000"]
