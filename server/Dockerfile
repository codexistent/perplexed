FROM python:3.14-slim
WORKDIR /app
ENV PIP_NO_CACHE_DIR=1

RUN pip install torch --index-url https://download.pytorch.org/whl/cpu

# download dependencies
COPY requirements.txt .
RUN pip install -r requirements.txt

# download embedding model so server doesn't on every cold start
RUN python -c "from sentence_transformers import SentenceTransformer; SentenceTransformer('all-MiniLM-L6-v2')"

COPY . . 
CMD uvicorn main:app --host 0.0.0.0 --port ${PORT:-8000}