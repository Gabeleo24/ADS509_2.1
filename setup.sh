#!/bin/bash

# ADS 509 Module 3: Automated Project Setup Script
# This script automates the entire setup process for the text analysis project

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

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check Docker status
check_docker() {
    print_status "Checking Docker installation..."
    
    if ! command_exists docker; then
        print_error "Docker is not installed. Please install Docker Desktop first."
        echo "Download from: https://www.docker.com/products/docker-desktop"
        exit 1
    fi
    
    if ! docker info >/dev/null 2>&1; then
        print_error "Docker is not running. Please start Docker Desktop."
        exit 1
    fi
    
    print_success "Docker is installed and running"
}

# Function to check for zip file
check_data_file() {
    print_status "Checking for data file..."
    
    if [ ! -f "M1 Assignment Data (1).zip" ]; then
        print_error "Data file 'M1 Assignment Data (1).zip' not found in current directory."
        echo ""
        echo "Please ensure the zip file is in the same directory as this script."
        echo "You can download it from your course materials or assignment portal."
        exit 1
    fi
    
    print_success "Data file found"
}

# Function to build Docker environment
build_environment() {
    print_status "Building Docker environment..."
    
    if docker compose build; then
        print_success "Docker environment built successfully"
    else
        print_error "Failed to build Docker environment"
        exit 1
    fi
}

# Function to start services
start_services() {
    print_status "Starting services..."
    
    # Stop any existing containers
    docker compose down >/dev/null 2>&1 || true
    
    # Start services in detached mode
    if docker compose up -d; then
        print_success "Services started successfully"
    else
        print_error "Failed to start services"
        exit 1
    fi
}

# Function to wait for Jupyter to be ready
wait_for_jupyter() {
    print_status "Waiting for Jupyter Lab to be ready..."
    
    local max_attempts=30
    local attempt=1
    
    while [ $attempt -le $max_attempts ]; do
        if curl -s http://localhost:8889/lab >/dev/null 2>&1; then
            print_success "Jupyter Lab is ready"
            return 0
        fi
        
        echo -n "."
        sleep 2
        attempt=$((attempt + 1))
    done
    
    print_error "Jupyter Lab failed to start within expected time"
    return 1
}

# Function to extract data
extract_data() {
    print_status "Extracting data files..."
    
    # Copy the zip file to the container and extract it
    if docker compose exec jupyter bash -c "cd /home/jovyan/work && bash docker/extract_data.sh"; then
        print_success "Data extracted successfully"
    else
        print_error "Failed to extract data"
        exit 1
    fi
}

# Function to verify setup
verify_setup() {
    print_status "Verifying setup..."
    
    # Check if data directories exist
    if docker compose exec jupyter bash -c "[ -d '/home/jovyan/work/M1 Results' ]"; then
        print_success "Data directories created"
    else
        print_warning "Data directories not found - extraction may have failed"
    fi
    
    # Check if notebook exists
    if docker compose exec jupyter bash -c "[ -f '/home/jovyan/work/Group Comparison copy.ipynb' ]"; then
        print_success "Analysis notebook found"
    else
        print_warning "Analysis notebook not found"
    fi
}

# Function to display final instructions
show_completion_message() {
    echo ""
    echo "=========================================="
    print_success "Setup completed successfully!"
    echo "=========================================="
    echo ""
    echo "Next steps:"
    echo "1. Open your web browser"
    echo "2. Navigate to: http://localhost:8889/lab"
    echo "3. Open 'Group Comparison copy.ipynb'"
    echo "4. Run the notebook cells to perform the analysis"
    echo ""
    echo "To stop the environment later, run:"
    echo "  docker compose down"
    echo ""
    echo "To restart the environment, run:"
    echo "  docker compose up -d"
    echo ""
}

# Function to handle cleanup on exit
cleanup() {
    if [ $? -ne 0 ]; then
        print_error "Setup failed. Cleaning up..."
        docker compose down >/dev/null 2>&1 || true
    fi
}

# Main execution
main() {
    echo "=========================================="
    echo "ADS 509 Module 3: Automated Setup"
    echo "=========================================="
    echo ""
    
    # Set up cleanup trap
    trap cleanup EXIT
    
    # Run setup steps
    check_docker
    check_data_file
    build_environment
    start_services
    wait_for_jupyter
    extract_data
    verify_setup
    show_completion_message
    
    # Remove cleanup trap on successful completion
    trap - EXIT
}

# Run main function
main "$@"
