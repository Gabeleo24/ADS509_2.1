#!/bin/bash

# Enhanced data extraction script for ADS 509 Module 3
# Provides better error handling and detailed feedback

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Change to work directory
cd /home/jovyan/work

print_status "Starting data extraction process..."

# Check if zip file exists
if [ ! -f "M1 Assignment Data (1).zip" ]; then
    print_error "Zip file 'M1 Assignment Data (1).zip' not found in work directory."
    echo ""
    echo "Please ensure the zip file is uploaded to your work directory."
    echo "You can upload it through the Jupyter Lab file browser."
    exit 1
fi

print_success "Found data zip file"

# Check if data already exists
if [ -d "M1 Results" ]; then
    print_warning "M1 Results directory already exists"
    read -p "Do you want to overwrite existing data? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_status "Extraction cancelled by user"
        exit 0
    fi
    print_status "Removing existing data directory..."
    rm -rf "M1 Results"
fi

# Extract the zip file
print_status "Extracting data files..."
if unzip -o "M1 Assignment Data (1).zip"; then
    print_success "Zip file extracted successfully"
else
    print_error "Failed to extract zip file"
    exit 1
fi

# Clean up macOS metadata files
print_status "Cleaning up system metadata files..."
rm -rf __MACOSX 2>/dev/null || true
find . -name "._*" -type f -delete 2>/dev/null || true
find . -name ".DS_Store" -type f -delete 2>/dev/null || true
print_success "Metadata cleanup complete"

# Verify extraction
print_status "Verifying extracted data..."

if [ ! -d "M1 Results" ]; then
    print_error "M1 Results directory not found after extraction"
    exit 1
fi

# Check lyrics directories
lyrics_dir="M1 Results/lyrics"
if [ -d "$lyrics_dir" ]; then
    cher_count=$(find "$lyrics_dir/cher" -name "*.txt" 2>/dev/null | wc -l)
    robyn_count=$(find "$lyrics_dir/robyn" -name "*.txt" 2>/dev/null | wc -l)
    print_success "Lyrics data found: Cher ($cher_count files), Robyn ($robyn_count files)"
else
    print_warning "Lyrics directory not found"
fi

# Check twitter directories
twitter_dir="M1 Results/twitter"
if [ -d "$twitter_dir" ]; then
    twitter_files=$(find "$twitter_dir" -name "*.txt" 2>/dev/null | wc -l)
    print_success "Twitter data found: $twitter_files files"
else
    print_warning "Twitter directory not found"
fi

print_success "Data extraction completed successfully!"
echo ""
echo "Data structure:"
echo "M1 Results/"
echo "├── lyrics/"
echo "│   ├── cher/     (song lyrics files)"
echo "│   └── robyn/    (song lyrics files)"
echo "└── twitter/      (follower data files)"
echo ""
echo "You can now run the analysis notebook: 'Group Comparison copy.ipynb'"
