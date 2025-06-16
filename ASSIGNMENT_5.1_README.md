# Assignment 5.1: Topic Modeling

## Overview

This assignment implements and compares three different topic modeling approaches using the Brown University corpus from NLTK:

1. **NMF (Non-negative Matrix Factorization)**
2. **LSA (Latent Semantic Analysis)** 
3. **LDA (Latent Dirichlet Allocation)**

## Files

- `Topic Models.ipynb` - Main notebook containing all analysis and code
- `ASSIGNMENT_5.1_README.md` - This documentation file

## Requirements

### Python Libraries
- `numpy`
- `pandas`
- `matplotlib`
- `seaborn`
- `scikit-learn`
- `nltk`

### NLTK Data
The notebook will automatically download required NLTK data:
- Brown corpus
- Stopwords
- Punkt tokenizer
- WordNet lemmatizer
- POS tagger

## Assignment Tasks

### 1. Data Exploration
- Explore the Brown corpus structure and categories
- Preprocess text data (tokenization, stopword removal, lemmatization)
- Prepare documents for topic modeling

### 2. NMF Topic Modeling
- Build NMF model using TF-IDF features
- Extract and interpret topics
- Analyze top words for each topic

### 3. LSA Topic Modeling
- Build LSA model using TruncatedSVD
- Extract and interpret topics
- Compare with NMF results

### 4. LDA Topic Modeling
- Build LDA model using count features
- Extract and interpret topics
- Compare with NMF and LSA results

### 5. Model Comparison
- Compare topic assignments across all three models
- Analyze alignment with official Brown corpus categories
- Visualize topic distributions
- Provide comprehensive analysis and recommendations

## Usage

### Running with Docker (Recommended)
```bash
# Start the Jupyter environment
docker-compose up

# Access Jupyter at http://localhost:8888
# Open Topic Models.ipynb
```

### Running Locally
```bash
# Install requirements
pip install numpy pandas matplotlib seaborn scikit-learn nltk

# Start Jupyter
jupyter notebook

# Open Topic Models.ipynb
```

## Expected Deliverables

1. **Completed Notebook**: `Topic Models.ipynb` with all cells executed and analysis completed
2. **PDF Export**: Convert notebook to PDF for Canvas submission
3. **GitHub Repository**: Commit all changes and push to GitHub
4. **AI Tool Attribution**: Document any AI tools used in the analysis

## Key Analysis Points

### NMF Analysis
- Interpret topics based on top words
- Discuss coherence and interpretability
- Compare with document categories

### LSA Analysis
- Analyze explained variance
- Compare topics with NMF
- Discuss dimensionality reduction aspects

### LDA Analysis
- Interpret probabilistic topic assignments
- Compare with NMF and LSA
- Discuss document-topic distributions

### Overall Comparison
- Which model best captures document structure?
- How do topics align with Brown corpus categories?
- Recommendations for different use cases

## Notes

- The notebook includes placeholder sections for your interpretations
- Fill in analysis sections marked with *[Add your analysis here]*
- Ensure all code cells run without errors
- Provide thoughtful interpretations of results
- Compare model performance objectively

## Academic Integrity

- Properly cite any external resources used
- Document AI tool usage if applicable
- Ensure understanding of all implemented code
- Provide original analysis and interpretations

## Troubleshooting

### Common Issues
1. **NLTK Data Download**: Ensure internet connection for automatic downloads
2. **Memory Issues**: Reduce `max_features` if running into memory constraints
3. **Convergence Warnings**: Increase `max_iter` for models if needed

### Performance Tips
- Start with smaller vocabulary sizes for faster iteration
- Use random_state for reproducible results
- Monitor model convergence and adjust parameters as needed

## Contact

For questions about this assignment, refer to the course materials or contact the instructor through the appropriate channels.
