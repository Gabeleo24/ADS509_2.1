# ADS509 Module 2.1: Text Mining with Docker

## Project Overview

This repository contains the code and configuration for Assignment 2.1 in the ADS509 Applied Text Mining course. The project focuses on tokenization, normalization, and descriptive statistics of text data from Twitter descriptions and song lyrics.

The project uses Docker to create a consistent environment for handling large data files and running Jupyter notebooks for text analysis.

## Project Structure

```
ADS509_2.1/
├── data/                    # Data directory (created at runtime)
│   ├── input/               # Place zip files here
│   ├── processed/           # Processed zip files are moved here
│   └── extracted/           # Files extracted from zips
├── notebooks/               # Jupyter notebooks
│   └── M1 Results/          # Results from Module 1
├── Dockerfile               # Docker image configuration
├── docker-compose.yml       # Docker container configuration
├── process_zip_files.sh     # Script to process zip files
├── requirements.txt         # Python dependencies
└── README.md                # This file
```

## Setup and Running the Project

### Prerequisites

- [Docker](https://www.docker.com/get-started) and Docker Compose installed on your system
- Git for cloning the repository

### Quick Start

1. **Clone the repository:**
   ```bash
   git clone https://github.com/Gabeleo24/ADS509_2.1.git
   cd ADS509_2.1
   ```

2. **Create the data directories:**
   ```bash
   mkdir -p data/input data/processed data/extracted
   ```

3. **Place your data files:**
   - Put `M1 Assignment Data.zip` in the `data/input` directory

4. **Build and start the Docker container:**
   ```bash
   docker-compose up
   ```

5. **Access Jupyter Notebook:**
   - Open your browser and go to: http://localhost:8890
   - Enter token: `ads509`

### How the Data Processing Works

When the container starts:
1. The `process_zip_files.sh` script automatically runs
2. It processes any zip files in the `data/input` directory
3. Files are extracted to `data/extracted`
4. Processed zip files are moved to `data/processed`
5. For `M1 Assignment Data.zip`, symbolic links are created to the expected locations

### Working with the Notebooks

1. After starting the container, navigate to http://localhost:8890
2. Enter the token `ads509` when prompted
3. Open the `Lyrics and Description EDA.ipynb` notebook
4. The notebook is pre-configured to access the data in the correct locations
5. Run the cells to perform text analysis on the Twitter and lyrics data

## Dependencies

The Docker environment includes:
- Python 3.11
- Jupyter Notebook
- NLTK with pre-downloaded data (punkt, stopwords, wordnet)
- NumPy, Pandas, Matplotlib, Seaborn
- Other dependencies listed in `requirements.txt`

## Troubleshooting

### Common Issues

1. **Port already in use:**
   - If port 8890 is already in use, modify the port mapping in `docker-compose.yml`
   - Change `"8890:8888"` to use a different port, e.g., `"8891:8888"`

2. **Data files not found:**
   - Ensure zip files are placed in the `data/input` directory
   - Check that the directory structure matches what's expected in the Docker volume mounts
   - Verify that the `process_zip_files.sh` script has execute permissions

3. **Multiple Jupyter servers:**
   - If you have multiple Jupyter servers running locally, use `jupyter server list` to see them
   - Stop unnecessary servers with `jupyter server stop 8888`

4. **Docker container not starting:**
   - Check Docker logs with `docker-compose logs`
   - Ensure Docker has sufficient resources allocated

### Accessing Files in the Container

If you need to access the container directly:
```bash
docker exec -it ads509_2_1_jupyter_1 bash
```

## License

This project is created for educational purposes as part of the ADS509 course.

## Contact

For questions or issues, please open an issue on the GitHub repository.
