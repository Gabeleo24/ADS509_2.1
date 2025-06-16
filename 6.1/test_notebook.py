#!/usr/bin/env python3
"""
Test script to run the sentiment analysis notebook
"""

import os
import sys
import json
import subprocess
from pathlib import Path

def test_notebook_json():
    """Test if the notebook is valid JSON"""
    try:
        with open('Sentiment Assignment.ipynb', 'r') as f:
            json.load(f)
        print("✓ Notebook JSON is valid")
        return True
    except json.JSONDecodeError as e:
        print(f"✗ Notebook JSON is invalid: {e}")
        return False

def test_data_files():
    """Test if required data files exist"""
    required_files = [
        '/Users/home/Documents/GitHub/ADS509_2.1/M1 Results/lyrics/cher',
        '/Users/home/Documents/GitHub/ADS509_2.1/M1 Results/lyrics/robyn',
        '/Users/home/Documents/GitHub/ADS509_2.1/M1 Results/twitter/cher_followers_data.txt',
        '/Users/home/Documents/GitHub/ADS509_2.1/M1 Results/twitter/robynkonichiwa_followers_data.txt',
        'positive-words.txt',
        'negative-words.txt',
        'tidytext_sentiments.txt'
    ]
    
    all_exist = True
    for file_path in required_files:
        if Path(file_path).exists():
            print(f"✓ Found: {file_path}")
        else:
            print(f"✗ Missing: {file_path}")
            all_exist = False
    
    return all_exist

def main():
    print("Testing Sentiment Analysis Notebook Setup")
    print("=" * 50)
    
    # Test JSON validity
    json_valid = test_notebook_json()
    
    print("\nTesting data files:")
    data_valid = test_data_files()
    
    print(f"\nOverall status:")
    if json_valid and data_valid:
        print("✓ All tests passed! Notebook should be ready to run.")
        return 0
    else:
        print("✗ Some tests failed. Please fix the issues above.")
        return 1

if __name__ == "__main__":
    sys.exit(main())
