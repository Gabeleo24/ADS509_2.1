#!/bin/bash
# Script to set up Git LFS and handle oversized files for ADS509_2.1 project

# Navigate to your project directory
cd /Users/home/Documents/GitHub/ADS509_2.1

# Create a directory for oversized files if it doesn't exist
mkdir -p oversized_files_backup

# Move oversized files to backup directory
mv "M1 Results/twitter/cher_followers_data.txt" oversized_files_backup/ 2>/dev/null || true
mv "clean_twitter/cher_followers_data_clean.txt" oversized_files_backup/ 2>/dev/null || true
mv "M1 Assignment Data.zip" oversized_files_backup/ 2>/dev/null || true

# Create placeholder files with instructions
echo "This file exceeds GitHub's 100MB limit. The original file was backed up locally in oversized_files_backup/" > "M1 Results/twitter/cher_followers_data.txt"
echo "This file exceeds GitHub's 100MB limit. The original file was backed up locally in oversized_files_backup/" > "clean_twitter/cher_followers_data_clean.txt"
echo "This file exceeds GitHub's 100MB limit. The original file was backed up locally in oversized_files_backup/" > "M1 Assignment Data.zip"

# Add the backup directory to .gitignore
echo "# Ignore oversized files backup directory" >> .gitignore
echo "oversized_files_backup/" >> .gitignore

# Initialize Git LFS
git lfs install

# Track remaining large files (under 100MB) in your project
git lfs track "M1 Results/**/*.txt"
git lfs track "clean_twitter/*.txt"
git lfs track "clean_lyrics/**/*.txt"

# Add .gitattributes to your repository
git add .gitattributes
git add .gitignore

# Remove the oversized files from git tracking
git rm --cached "oversized_files_backup/cher_followers_data.txt" 2>/dev/null || true
git rm --cached "oversized_files_backup/cher_followers_data_clean.txt" 2>/dev/null || true
git rm --cached "oversized_files_backup/M1 Assignment Data.zip" 2>/dev/null || true

# Add your files
git add .

# Commit your changes
git commit -m "Add files using Git LFS, with placeholders for oversized files"

# Push to GitHub
git push
