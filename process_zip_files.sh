#!/bin/bash
# Script to process zip files placed in the input directory

INPUT_DIR="/app/data/input"
PROCESSED_DIR="/app/data/processed"
EXTRACT_DIR="/app/data/extracted"

# Create directories if they don't exist
mkdir -p "$PROCESSED_DIR"
mkdir -p "$EXTRACT_DIR"

# Process any zip files in the input directory
echo "Checking for zip files in $INPUT_DIR..."
for zip_file in "$INPUT_DIR"/*.zip; do
    # Check if there are any zip files
    if [ -f "$zip_file" ]; then
        filename=$(basename "$zip_file")
        echo "Processing $filename..."
        
        # Create a directory for this specific zip file
        extract_subdir="$EXTRACT_DIR/${filename%.*}"
        mkdir -p "$extract_subdir"
        
        # Extract the zip file
        unzip -o "$zip_file" -d "$extract_subdir"
        
        # Move the zip file to processed directory
        mv "$zip_file" "$PROCESSED_DIR/$filename"
        
        echo "Extracted $filename to $extract_subdir"
        
        # If this is the M1 Assignment Data.zip, create symbolic links to the expected locations
        if [[ "$filename" == "M1 Assignment Data.zip" ]]; then
            echo "Setting up M1 Assignment Data..."
            
            # Create necessary directories
            mkdir -p "/app/M1 Results/twitter"
            mkdir -p "/app/clean_twitter"
            
            # Find and link the large files to their expected locations
            find "$extract_subdir" -name "cher_followers_data.txt" -exec ln -sf {} "/app/M1 Results/twitter/cher_followers_data.txt" \;
            find "$extract_subdir" -name "cher_followers_data_clean.txt" -exec ln -sf {} "/app/clean_twitter/cher_followers_data_clean.txt" \;
            
            echo "Symbolic links created for M1 Assignment Data files"
        fi
    else
        echo "No zip files found in $INPUT_DIR"
        break
    fi
done

echo "Zip file processing complete."
echo "Starting Jupyter Notebook..."
