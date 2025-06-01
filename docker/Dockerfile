FROM jupyter/datascience-notebook:latest

USER root

# Install additional Python packages for both Module 3 and Module 4
RUN pip install emoji wordcloud nltk pandas matplotlib scikit-learn sqlite3

# Download NLTK data for both modules
RUN python -c "import nltk; nltk.download('stopwords'); nltk.download('punkt'); nltk.download('vader_lexicon')"

# Install system dependencies if needed
RUN apt-get update && apt-get install -y \
    sqlite3 \
    && rm -rf /var/lib/apt/lists/*

# Switch back to jovyan user
USER jovyan

# Set working directory
WORKDIR /home/jovyan/work
