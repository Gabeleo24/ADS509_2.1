# Data Setup Guide

This guide explains how to obtain and set up the data files required for ADS 509 Modules 3 & 4.

## Required Data Files

### Module 3: Group Comparison
- **File**: `M1 Assignment Data (1).zip`
- **Size**: ~50MB
- **Contents**: 
  - Lyrics files for Cher and Robyn
  - Twitter follower data files
- **Source**: Course materials or assignment portal

### Module 4: Political Naive Bayes
- **Files**: 
  - `2020_Conventions.db` (~5MB)
  - `congressional_data.db` (~350MB)
- **Contents**:
  - 2020 Democratic and Republican convention speeches
  - Congressional candidate Twitter data
- **Source**: Course materials or assignment portal

## Setup Instructions

### Option 1: Download from Course Materials
1. Access your course learning management system
2. Navigate to the ADS 509 assignments section
3. Download the required data files for your module(s)
4. Place the files in your project root directory

### Option 2: Manual File Placement
If you already have the data files:

1. **For Module 3**: Place `M1 Assignment Data (1).zip` in the project root
2. **For Module 4**: Place both database files in the project root:
   ```
   ADS509_2.1/
   ├── 2020_Conventions.db
   ├── congressional_data.db
   └── ... (other project files)
   ```

### Option 3: Alternative Data Sources
If you need to recreate the data:

#### Module 3 Data
- Lyrics can be obtained from lyrics APIs or web scraping
- Twitter data can be collected using Twitter API v2
- Format the data to match the expected structure

#### Module 4 Data
- Convention speeches: Available from party websites or news archives
- Congressional tweets: Can be collected using Twitter API with candidate handles
- Store in SQLite databases with appropriate schema

## Data Verification

After placing the files, you can verify they're correctly set up:

### Using the Automated Setup
```bash
python setup.py
```
The script will automatically detect and verify your data files.

### Manual Verification

#### Module 3
```bash
# Check if zip file exists
ls -la "M1 Assignment Data (1).zip"

# Check zip contents (optional)
unzip -l "M1 Assignment Data (1).zip"
```

#### Module 4
```bash
# Check if database files exist
ls -la *.db

# Verify database integrity
sqlite3 2020_Conventions.db "SELECT COUNT(*) FROM sqlite_master;"
sqlite3 congressional_data.db "SELECT COUNT(*) FROM sqlite_master;"
```

## File Structure After Setup

Once you've placed the data files and run the setup, your directory should look like:

```
ADS509_2.1/
├── README.md
├── setup.py
├── setup.sh
├── setup.bat
├── docker/
│   ├── Dockerfile
│   └── extract_data.sh
├── M1 Assignment Data (1).zip          # Module 3 data
├── 2020_Conventions.db                 # Module 4 data
├── congressional_data.db               # Module 4 data
├── M1 Results/                         # Extracted Module 3 data
│   ├── lyrics/
│   └── twitter/
├── Group Comparison copy.ipynb         # Module 3 notebook
└── Module 4-Political Naive Bayes.ipynb # Module 4 notebook
```

## Troubleshooting

### Common Issues

#### "Data file not found"
- Ensure the file name matches exactly (including spaces and parentheses)
- Check that the file is in the project root directory
- Verify file permissions allow reading

#### "Database appears corrupted"
- Re-download the database files
- Check file integrity with `sqlite3 filename.db ".schema"`
- Ensure sufficient disk space during download

#### "Permission denied"
- On Unix systems: `chmod 644 *.db *.zip`
- Ensure your user has read access to the files

### File Size Considerations

The database files are large (especially `congressional_data.db` at ~350MB):
- Ensure you have sufficient disk space (at least 1GB free)
- Download may take time depending on your internet connection
- Consider using a download manager for large files

### Alternative Formats

If you have data in different formats:
- **CSV files**: Can be imported into SQLite databases
- **JSON files**: Can be processed and converted to the expected format
- **Text files**: Can be organized into the expected directory structure

## Security Note

These data files may contain personal information (Twitter handles, etc.):
- Do not commit data files to public repositories
- Follow your institution's data handling policies
- Respect privacy and terms of service for social media data

## Support

If you encounter issues with data setup:
1. Check the main [TROUBLESHOOTING.md](TROUBLESHOOTING.md) guide
2. Verify your file names and locations match exactly
3. Ensure you have the latest version of the setup scripts
4. Contact your course instructor for data access issues
