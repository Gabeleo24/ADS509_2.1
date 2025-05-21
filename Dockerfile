# Use a Python base image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install system dependencies including unzip
RUN apt-get update && apt-get install -y \
    git \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements (if you have them)
COPY requirements.txt* ./
RUN if [ -f requirements.txt ]; then pip install -r requirements.txt; fi

# Install common data science packages
RUN pip install numpy pandas matplotlib seaborn nltk jupyter

# Download NLTK data
RUN python -m nltk.downloader punkt stopwords wordnet

# Copy project files
COPY . .

# Copy data files from your local machine
COPY /Users/home/Documents/GitHub/ADS509_2.1/ADS509_2.1/notebooks /app/notebooks/
COPY /Users/home/Documents/GitHub/ADS509_2.1/ADS509_2.1/notebooks/M1\ Results /app/M1\ Results/
COPY "/Users/home/Documents/GitHub/ADS509_2.1/Lyrics and Description EDA.ipynb" /app/

# Create directories for data
RUN mkdir -p /app/data/input
RUN mkdir -p /app/data/processed
RUN mkdir -p /app/data/extracted

# Add a script to process zip files at runtime
COPY process_zip_files.sh /app/
RUN chmod +x /app/process_zip_files.sh

# Expose port for Jupyter
EXPOSE 8888

# Command to run when container starts
CMD ["/bin/bash", "-c", "/app/process_zip_files.sh && jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --allow-root"]
