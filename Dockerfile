# Use a Python base image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements (if you have them)
COPY requirements.txt* ./
RUN if [ -f requirements.txt ]; then pip install -r requirements.txt; fi

# Install common data science packages
RUN pip install numpy pandas matplotlib seaborn nltk jupyter

# Download NLTK data
RUN python -m nltk.downloader punkt stopwords wordnet

# Copy project files (excluding large files)
COPY . .

# Create directory for large files
RUN mkdir -p /app/large_files

# Add a script to download large files at runtime
COPY download_large_files.sh /app/
RUN chmod +x /app/download_large_files.sh

# Expose port for Jupyter
EXPOSE 8888

# Command to run when container starts
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]