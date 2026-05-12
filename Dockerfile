# Use a slim Python 3.10 image as the base
FROM python:3.10-slim

# Install system dependencies (if needed for building some Python packages)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory in the container
WORKDIR /app

# Copy requirements.txt and install Python dependencies
COPY requirements.txt .

RUN pip install --upgrade pip setuptools wheel build && pip install -r requirements.txt

# Pre-download HuggingFace models so they are baked into the image (no network needed at runtime)
RUN python -c "from sentence_transformers import SentenceTransformer; SentenceTransformer('all-mpnet-base-v2')"
RUN python -c "from sentence_transformers import CrossEncoder; CrossEncoder('cross-encoder/ms-marco-MiniLM-L-6-v2')"

# Copy the rest of the code into the container
COPY . .

# Bind Gradio to all interfaces and prevent re-downloading models at runtime
ENV GRADIO_SERVER_NAME=0.0.0.0
ENV GRADIO_SERVER_PORT=7860
ENV TRANSFORMERS_OFFLINE=1

EXPOSE 7860

CMD ["python", "app.py"]