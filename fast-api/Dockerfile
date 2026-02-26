FROM python:3.11-slim
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
WORKDIR /app
EXPOSE 8000
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--post", "8000"]