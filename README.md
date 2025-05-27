# ADS 509 Module 3: Group Comparison

This repository contains the assignment for ADS 509 Module 3, focusing on group comparison analysis of text data.

## Project Overview

The task involves comparing two groups of text data using the ideas learned in reading and lecture. This assignment analyzes lyrics and Twitter descriptions for two artists (Robyn and Cher).

## Assignment Tasks

- Read in the data, normalize the text, and tokenize it
- Calculate descriptive statistics on the two sets of lyrics and compare results
- Find words that are unique to each corpus
- Build word clouds for all four corpora

## Files Structure

- `Group Comparison.ipynb` - Main assignment notebook
- `compose.yaml` - Docker Compose configuration
- `docker/Dockerfile` - Docker image configuration
- `docker/extract_data.sh` - Data extraction script

## Setup Instructions

### Prerequisites
- Docker Desktop installed and running
- Git

### Running the Environment

1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd ADS509_2.1
   ```

2. Download the data file `M1 Assignment Data (1).zip` and place it in the project root directory

3. Start the Docker environment:
   ```bash
   docker compose up
   ```

4. Access Jupyter Lab at: `http://localhost:8889/lab`

5. Extract the data by running the extraction script in a terminal within Jupyter:
   ```bash
   bash docker/extract_data.sh
   ```

## Data Structure

After extraction, the data will be organized as:
```
M1 Results/
├── lyrics/
│   ├── robyn/          (104 lyrics files)
│   └── cher/           (316 lyrics files)
└── twitter/            (4 Twitter data files)
```

## Notes

- The Docker environment includes all necessary Python packages for text analysis
- Authentication is disabled for easier development access
- The environment automatically cleans up macOS metadata files during extraction
