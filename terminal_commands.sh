# First remove it from the index if you've already added it
git rm --cached ADS509

# Add it as a submodule (replace with the actual repository URL)
git submodule add https://github.com/yourusername/ADS509.git ADS509

# Commit the submodule addition
git commit -m "Add ADS509 as a submodule"
