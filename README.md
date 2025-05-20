# ADS509_2.1

## Running with Docker

This project includes Docker support to handle large files and ensure a consistent environment.

### Prerequisites
- Docker and Docker Compose installed on your system
- Large data files (optional - can be downloaded separately)

### Setup and Run

1. Clone the repository:
   ```bash
   git clone https://github.com/Gabeleo24/ADS509_2.1.git
   cd ADS509_2.1
   ```

2. Place large files in the `large_files` directory (optional):
   - M1 Results/twitter/cher_followers_data.txt
   - clean_twitter/cher_followers_data_clean.txt
   - M1 Assignment Data.zip

3. Build and start the Docker container:
   ```bash
   docker-compose up
   ```

4. Access Jupyter Notebook:
   - Open your browser and go to: http://localhost:8888
   - Enter token: ads509

### Large Files Handling

The large files can be:
1. Placed in the `large_files` directory before starting the container
2. Downloaded automatically from a storage service (configure in `download_large_files.sh`)
3. Generated using the data processing notebooks

## Original Project Information

[Your existing project information here]
 
