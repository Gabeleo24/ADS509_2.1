#!/bin/bash

# Enhanced data extraction script for ADS 509 Modules 3 & 4
# Handles both Group Comparison (Module 3) and Political Naive Bayes (Module 4) data
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

print_status "Starting multi-module data extraction process..."
print_status "Detecting available data files for ADS 509 Modules 3 & 4..."

# Initialize module detection flags
module3_available=false
module4_available=false

# Check for Module 3 data (Group Comparison)
if [ -f "M1 Assignment Data (1).zip" ]; then
    print_success "Found Module 3 data: M1 Assignment Data (1).zip"
    module3_available=true
else
    print_warning "Module 3 data not found: M1 Assignment Data (1).zip"
fi

# Check for Module 4 data (Political Naive Bayes)
if [ -f "2020_Conventions.db" ] && [ -f "congressional_data.db" ]; then
    print_success "Found Module 4 data: Database files for Political Naive Bayes"
    module4_available=true
else
    print_warning "Module 4 data not found: Missing database files"
    if [ ! -f "2020_Conventions.db" ]; then
        print_warning "  - Missing: 2020_Conventions.db"
    fi
    if [ ! -f "congressional_data.db" ]; then
        print_warning "  - Missing: congressional_data.db"
    fi
fi

# Check if any data is available
if [ "$module3_available" = false ] && [ "$module4_available" = false ]; then
    print_error "No data files found for either module!"
    echo ""
    echo "For Module 3 (Group Comparison): Place 'M1 Assignment Data (1).zip' in this directory"
    echo "For Module 4 (Political Naive Bayes): Place '2020_Conventions.db' and 'congressional_data.db' in this directory"
    exit 1
fi

# Process Module 3 data if available
if [ "$module3_available" = true ]; then
    print_status "Processing Module 3 data..."

    # Check if data already exists
    if [ -d "M1 Results" ]; then
        print_warning "M1 Results directory already exists"
        read -p "Do you want to overwrite existing Module 3 data? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            print_status "Removing existing M1 Results directory..."
            rm -rf "M1 Results"
        else
            print_status "Skipping Module 3 extraction"
            module3_available=false
        fi
    fi

    if [ "$module3_available" = true ]; then
        # Extract the zip file
        print_status "Extracting Module 3 data files..."
        if unzip -o "M1 Assignment Data (1).zip"; then
            print_success "Module 3 zip file extracted successfully"
        else
            print_error "Failed to extract Module 3 zip file"
            module3_available=false
        fi

        # Clean up macOS metadata files
        print_status "Cleaning up system metadata files..."
        rm -rf __MACOSX 2>/dev/null || true
        find . -name "._*" -type f -delete 2>/dev/null || true
        find . -name ".DS_Store" -type f -delete 2>/dev/null || true
        print_success "Metadata cleanup complete"
    fi
fi

# Process Module 4 data if available
if [ "$module4_available" = true ]; then
    print_status "Processing Module 4 data..."

    # Verify database files are accessible
    print_status "Verifying database file integrity..."

    if sqlite3 "2020_Conventions.db" "SELECT COUNT(*) FROM sqlite_master;" >/dev/null 2>&1; then
        print_success "2020_Conventions.db is accessible"
    else
        print_error "2020_Conventions.db appears to be corrupted or inaccessible"
        module4_available=false
    fi

    if sqlite3 "congressional_data.db" "SELECT COUNT(*) FROM sqlite_master;" >/dev/null 2>&1; then
        print_success "congressional_data.db is accessible"
    else
        print_error "congressional_data.db appears to be corrupted or inaccessible"
        module4_available=false
    fi
fi

# Verify extraction and provide summary
print_status "Verifying extracted/available data..."

echo ""
echo "=========================================="
print_success "Data Processing Summary"
echo "=========================================="

if [ "$module3_available" = true ]; then
    if [ -d "M1 Results" ]; then
        print_success "Module 3 (Group Comparison) - Ready"

        # Check lyrics directories
        lyrics_dir="M1 Results/lyrics"
        if [ -d "$lyrics_dir" ]; then
            cher_count=$(find "$lyrics_dir/cher" -name "*.txt" 2>/dev/null | wc -l)
            robyn_count=$(find "$lyrics_dir/robyn" -name "*.txt" 2>/dev/null | wc -l)
            echo "  ✓ Lyrics data: Cher ($cher_count files), Robyn ($robyn_count files)"
        fi

        # Check twitter directories
        twitter_dir="M1 Results/twitter"
        if [ -d "$twitter_dir" ]; then
            twitter_files=$(find "$twitter_dir" -name "*.txt" 2>/dev/null | wc -l)
            echo "  ✓ Twitter data: $twitter_files files"
        fi

        echo "  📓 Notebook: Group Comparison copy.ipynb"
    fi
else
    print_warning "Module 3 (Group Comparison) - Not available"
fi

if [ "$module4_available" = true ]; then
    print_success "Module 4 (Political Naive Bayes) - Ready"
    echo "  ✓ Convention data: 2020_Conventions.db"
    echo "  ✓ Congressional data: congressional_data.db"
    echo "  📓 Notebook: Module 4-Political Naive Bayes.ipynb"
else
    print_warning "Module 4 (Political Naive Bayes) - Not available"
fi

echo ""
echo "Project Structure:"
echo "ADS509_2.1/"
if [ "$module3_available" = true ]; then
    echo "├── M1 Results/              # Module 3 data"
    echo "│   ├── lyrics/"
    echo "│   │   ├── cher/           # Cher's lyrics"
    echo "│   │   └── robyn/          # Robyn's lyrics"
    echo "│   └── twitter/            # Twitter follower data"
fi
if [ "$module4_available" = true ]; then
    echo "├── 2020_Conventions.db     # Module 4 convention speeches"
    echo "├── congressional_data.db   # Module 4 congressional tweets"
fi
echo "├── Group Comparison copy.ipynb      # Module 3 analysis"
echo "└── Module 4-Political Naive Bayes.ipynb  # Module 4 analysis"

echo ""
print_success "Setup complete! You can now run the available analysis notebooks."
