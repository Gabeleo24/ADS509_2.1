FROM jupyter/datascience-notebook:latest

USER root

# Install additional Python packages
RUN pip install emoji wordcloud nltk pandas matplotlib scikit-learn

# Download NLTK data
RUN python -c "import nltk; nltk.download('stopwords')"

# Switch back to jovyan user
USER jovyan

# Set working directory
WORKDIR /home/jovyan/work
