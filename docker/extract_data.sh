#!/bin/bash
cd /home/jovyan/work
if [ -f "M1 Assignment Data (1).zip" ]; then
  echo "Extracting data files..."
  unzip -o "M1 Assignment Data (1).zip"
  echo "Cleaning up macOS metadata files..."
  rm -rf __MACOSX
  find . -name "._*" -type f -delete
  find . -name ".DS_Store" -type f -delete
  echo "Data extraction complete!"
else
  echo "Zip file not found. Please upload 'M1 Assignment Data (1).zip' to your work directory."
fi
