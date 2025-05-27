# ADS 509 Module 3: Group Comparison

A comprehensive text analysis project comparing lyrics and Twitter descriptions between two artists (Robyn and Cher) using natural language processing techniques. This project demonstrates group comparison analysis, descriptive statistics, unique word identification, and word cloud visualization.

## Project Description

This repository contains an assignment for ADS 509 Module 3, focusing on comparative text analysis. The project analyzes two distinct text corpora for each artist:
- **Lyrics data**: Song lyrics from both artists
- **Twitter data**: Follower descriptions from each artist's Twitter account

The analysis employs various NLP techniques including tokenization, normalization, stopword removal, and statistical comparison to identify patterns and differences between the text groups.

## Features

- **Text Preprocessing**: Comprehensive text cleaning pipeline with tokenization and normalization
- **Descriptive Statistics**: Detailed statistical analysis of token counts, lexical diversity, and frequency distributions
- **Unique Word Analysis**: Identification of words unique to each corpus
- **Word Cloud Visualization**: Visual representation of word frequency for all four corpora
- **Dockerized Environment**: Consistent development environment with all dependencies pre-installed

## Prerequisites

Before running this project, ensure you have the following installed:

- **Docker Desktop** (version 4.0 or higher)
- **Git** (for cloning the repository)
- **Web browser** (for accessing Jupyter Lab interface)

### System Requirements

- **Operating System**: macOS, Windows, or Linux
- **RAM**: Minimum 4GB (8GB recommended for large datasets)
- **Storage**: At least 2GB free space for Docker images and data
- **Network**: Internet connection for initial Docker image download

## Installation Instructions

### Quick Start (Automated Setup)

For the fastest setup experience, use one of our automated setup scripts:

#### Option 1: Cross-Platform Python Script (Recommended)
```bash
# 1. Clone the repository
git clone https://github.com/your-username/ADS509_2.1.git
cd ADS509_2.1

# 2. Place your 'M1 Assignment Data (1).zip' file in this directory

# 3. Run the automated setup
python setup.py
```

#### Option 2: Linux/macOS Shell Script
```bash
# 1. Clone the repository
git clone https://github.com/your-username/ADS509_2.1.git
cd ADS509_2.1

# 2. Place your 'M1 Assignment Data (1).zip' file in this directory

# 3. Run the automated setup
./setup.sh
```

#### Option 3: Windows Batch Script
```cmd
REM 1. Clone the repository
git clone https://github.com/your-username/ADS509_2.1.git
cd ADS509_2.1

REM 2. Place your 'M1 Assignment Data (1).zip' file in this directory

REM 3. Run the automated setup
setup.bat
```

The automated scripts will:
- ✅ Check Docker installation and status
- ✅ Verify the data file exists
- ✅ Build the Docker environment
- ✅ Start all services
- ✅ Wait for Jupyter Lab to be ready
- ✅ Extract and organize the data
- ✅ Verify the setup
- ✅ Open Jupyter Lab in your browser

### Manual Setup (Step-by-Step)

If you prefer to set up manually or need to troubleshoot:

#### 1. Clone the Repository

```bash
git clone https://github.com/your-username/ADS509_2.1.git
cd ADS509_2.1
```

#### 2. Obtain the Data

Download the required data file `M1 Assignment Data (1).zip` and place it in the project root directory. This file should contain:
- Lyrics files for both artists
- Twitter follower data files

#### 3. Build and Start the Environment

```bash
# Build and start the Docker containers
docker compose up --build
```

This command will:
- Build the custom Jupyter environment with all required packages
- Start the Jupyter Lab server
- Mount the project directory for development

#### 4. Access Jupyter Lab

Open your web browser and navigate to:
```
http://localhost:8889/lab
```

Note: Authentication is disabled for development convenience.

#### 5. Extract the Data

In the Jupyter Lab terminal, run the data extraction script:
```bash
bash docker/extract_data.sh
```

This will extract and organize the data files into the proper directory structure.

## Usage Instructions

### Running the Analysis

1. **Open the Main Notebook**: Navigate to `Group Comparison copy.ipynb` in Jupyter Lab

2. **Execute the Analysis**: Run the notebook cells sequentially to perform:
   - Data ingestion and preprocessing
   - Text tokenization and normalization
   - Descriptive statistical analysis
   - Unique word identification
   - Word cloud generation

3. **View Results**: The notebook will generate:
   - Statistical comparisons between artist corpora
   - Lists of unique words for each corpus
   - Word cloud visualizations
   - Comparative analysis insights

### Key Analysis Components

#### Text Preprocessing Pipeline
```python
# Example preprocessing pipeline
my_pipeline = [str.lower, remove_emoji, remove_punctuation, tokenize, remove_stop]
```

#### Descriptive Statistics
- Token counts and unique token analysis
- Lexical diversity calculations
- Most frequent word identification
- Character count analysis

#### Corpus Comparison
- Identification of words unique to each artist's lyrics
- Comparison of Twitter description patterns
- Statistical significance testing

## Project Structure

```
ADS509_2.1/
├── README.md                           # This file
├── setup.py                            # Cross-platform automated setup script
├── setup.sh                            # Linux/macOS automated setup script
├── setup.bat                           # Windows automated setup script
├── Group Comparison copy.ipynb         # Main analysis notebook
├── Group Comparison copy.pdf           # PDF version of notebook
├── compose.yaml                        # Docker Compose configuration
├── docker/
│   ├── Dockerfile                      # Custom Jupyter environment
│   ├── extract_data.sh                 # Enhanced data extraction script
│   └── nginx.conf                      # Web server configuration
├── M1 Assignment Data (1).zip          # Raw data (to be downloaded)
└── M1 Results/                         # Extracted data directory
    ├── lyrics/
    │   ├── cher/                       # Cher's lyrics (316 files)
    │   └── robyn/                      # Robyn's lyrics (104 files)
    └── twitter/
        ├── cher_followers.txt          # Cher follower data
        ├── cher_followers_data.txt     # Processed Cher data
        ├── robynkonichiwa_followers.txt # Robyn follower data
        └── robynkonichiwa_followers_data.txt # Processed Robyn data
```

## Dependencies

The project uses the following Python packages (automatically installed in Docker):

### Core Libraries
- **pandas**: Data manipulation and analysis
- **numpy**: Numerical computing
- **matplotlib**: Data visualization

### NLP Libraries
- **nltk**: Natural language processing toolkit
- **emoji**: Emoji handling and processing
- **wordcloud**: Word cloud generation
- **scikit-learn**: Machine learning and text analysis

### Development Environment
- **jupyter/datascience-notebook**: Base Jupyter environment
- **Docker**: Containerization platform

## Contributing Guidelines

We welcome contributions to improve this text analysis project. Please follow these guidelines:

### Getting Started

1. **Fork the Repository**: Create your own fork of the project
2. **Create a Branch**: Make a feature branch for your changes
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. **Set Up Development Environment**: Follow the installation instructions above

### Development Standards

#### Code Style
- Follow the [Google Python Style Guide](https://google.github.io/styleguide/pyguide.html)
- Use meaningful variable names and add comments for complex logic
- Keep functions focused and well-documented

#### Notebook Guidelines
- Clear markdown explanations for each analysis section
- Remove unnecessary cells and clean up outputs before committing
- Include proper headers and documentation

#### Testing
- Test any new preprocessing functions with sample data
- Verify that changes don't break existing analysis
- Include example outputs for new features

### Submission Process

1. **Commit Changes**: Make clear, descriptive commit messages
   ```bash
   git add .
   git commit -m "Add feature: improved text preprocessing pipeline"
   ```

2. **Push to Fork**: Push your changes to your forked repository
   ```bash
   git push origin feature/your-feature-name
   ```

3. **Create Pull Request**: Submit a pull request with:
   - Clear description of changes
   - Explanation of why the changes are needed
   - Any relevant test results or examples

### Areas for Contribution

- **Enhanced Text Preprocessing**: Improved cleaning and normalization techniques
- **Additional Visualizations**: New ways to visualize text comparison results
- **Performance Optimization**: Faster processing for large datasets
- **Documentation**: Improved explanations and examples
- **Error Handling**: Better error messages and edge case handling

### Reporting Issues

When reporting bugs or requesting features:
1. Check existing issues first
2. Provide clear reproduction steps
3. Include relevant error messages
4. Specify your environment (OS, Docker version, etc.)

## License

This project is part of an academic assignment for ADS 509. Please respect academic integrity guidelines when using or referencing this work.

## Support

For questions or issues:
1. Check the existing documentation and comments in the notebook
2. Review the Docker logs if experiencing environment issues
3. Create an issue in the repository for bugs or feature requests

## Acknowledgments

- Course materials and guidance from ADS 509
- Jupyter Project for the excellent notebook environment
- NLTK team for comprehensive NLP tools
- Docker community for containerization best practices
