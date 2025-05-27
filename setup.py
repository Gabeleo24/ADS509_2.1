#!/usr/bin/env python3
"""
ADS 509 Module 3: Cross-platform Automated Setup Script
This script automates the entire setup process for the text analysis project
"""

import os
import sys
import subprocess
import time
import webbrowser
import platform
from pathlib import Path

class Colors:
    """ANSI color codes for terminal output"""
    RED = '\033[0;31m'
    GREEN = '\033[0;32m'
    YELLOW = '\033[1;33m'
    BLUE = '\033[0;34m'
    NC = '\033[0m'  # No Color
    
    @classmethod
    def disable_on_windows(cls):
        """Disable colors on Windows if not supported"""
        if platform.system() == 'Windows':
            cls.RED = cls.GREEN = cls.YELLOW = cls.BLUE = cls.NC = ''

class SetupManager:
    """Manages the automated setup process"""
    
    def __init__(self):
        self.project_dir = Path.cwd()
        self.zip_file = self.project_dir / "M1 Assignment Data (1).zip"
        
        # Disable colors on Windows if needed
        if platform.system() == 'Windows':
            Colors.disable_on_windows()
    
    def print_status(self, message):
        """Print info message"""
        print(f"{Colors.BLUE}[INFO]{Colors.NC} {message}")
    
    def print_success(self, message):
        """Print success message"""
        print(f"{Colors.GREEN}[SUCCESS]{Colors.NC} {message}")
    
    def print_warning(self, message):
        """Print warning message"""
        print(f"{Colors.YELLOW}[WARNING]{Colors.NC} {message}")
    
    def print_error(self, message):
        """Print error message"""
        print(f"{Colors.RED}[ERROR]{Colors.NC} {message}")
    
    def run_command(self, command, shell=True, capture_output=False):
        """Run a shell command and return the result"""
        try:
            if capture_output:
                result = subprocess.run(command, shell=shell, capture_output=True, text=True)
                return result.returncode == 0, result.stdout, result.stderr
            else:
                result = subprocess.run(command, shell=shell)
                return result.returncode == 0, "", ""
        except Exception as e:
            return False, "", str(e)
    
    def check_docker(self):
        """Check if Docker is installed and running"""
        self.print_status("Checking Docker installation...")
        
        # Check if docker command exists
        success, _, _ = self.run_command("docker --version", capture_output=True)
        if not success:
            self.print_error("Docker is not installed. Please install Docker Desktop first.")
            print("Download from: https://www.docker.com/products/docker-desktop")
            return False
        
        # Check if Docker is running
        success, _, _ = self.run_command("docker info", capture_output=True)
        if not success:
            self.print_error("Docker is not running. Please start Docker Desktop.")
            return False
        
        self.print_success("Docker is installed and running")
        return True
    
    def check_data_file(self):
        """Check if the required zip file exists"""
        self.print_status("Checking for data file...")
        
        if not self.zip_file.exists():
            self.print_error(f"Data file '{self.zip_file.name}' not found in current directory.")
            print("\nPlease ensure the zip file is in the same directory as this script.")
            print("You can download it from your course materials or assignment portal.")
            return False
        
        self.print_success("Data file found")
        return True
    
    def build_environment(self):
        """Build the Docker environment"""
        self.print_status("Building Docker environment...")
        
        success, _, stderr = self.run_command("docker compose build")
        if not success:
            self.print_error("Failed to build Docker environment")
            if stderr:
                print(f"Error details: {stderr}")
            return False
        
        self.print_success("Docker environment built successfully")
        return True
    
    def start_services(self):
        """Start the Docker services"""
        self.print_status("Starting services...")
        
        # Stop any existing containers
        self.run_command("docker compose down", capture_output=True)
        
        # Start services in detached mode
        success, _, stderr = self.run_command("docker compose up -d")
        if not success:
            self.print_error("Failed to start services")
            if stderr:
                print(f"Error details: {stderr}")
            return False
        
        self.print_success("Services started successfully")
        return True
    
    def wait_for_jupyter(self, max_attempts=30):
        """Wait for Jupyter Lab to be ready"""
        self.print_status("Waiting for Jupyter Lab to be ready...")
        
        for attempt in range(1, max_attempts + 1):
            try:
                import urllib.request
                urllib.request.urlopen("http://localhost:8889/lab", timeout=2)
                self.print_success("Jupyter Lab is ready")
                return True
            except:
                print(f"Waiting... (attempt {attempt}/{max_attempts})")
                time.sleep(2)
        
        self.print_error("Jupyter Lab failed to start within expected time")
        return False
    
    def extract_data(self):
        """Extract the data using the container"""
        self.print_status("Extracting data files...")
        
        command = 'docker compose exec jupyter bash -c "cd /home/jovyan/work && bash docker/extract_data.sh"'
        success, _, stderr = self.run_command(command)
        
        if not success:
            self.print_error("Failed to extract data")
            if stderr:
                print(f"Error details: {stderr}")
            return False
        
        self.print_success("Data extracted successfully")
        return True
    
    def verify_setup(self):
        """Verify that the setup was successful"""
        self.print_status("Verifying setup...")
        
        # Check if data directories exist
        success, _, _ = self.run_command(
            'docker compose exec jupyter bash -c "[ -d \'/home/jovyan/work/M1 Results\' ]"',
            capture_output=True
        )
        if success:
            self.print_success("Data directories created")
        else:
            self.print_warning("Data directories not found - extraction may have failed")
        
        # Check if notebook exists
        success, _, _ = self.run_command(
            'docker compose exec jupyter bash -c "[ -f \'/home/jovyan/work/Group Comparison copy.ipynb\' ]"',
            capture_output=True
        )
        if success:
            self.print_success("Analysis notebook found")
        else:
            self.print_warning("Analysis notebook not found")
    
    def show_completion_message(self):
        """Display the completion message and instructions"""
        print("\n" + "=" * 42)
        self.print_success("Setup completed successfully!")
        print("=" * 42)
        print("\nNext steps:")
        print("1. Open your web browser")
        print("2. Navigate to: http://localhost:8889/lab")
        print("3. Open 'Group Comparison copy.ipynb'")
        print("4. Run the notebook cells to perform the analysis")
        print("\nTo stop the environment later, run:")
        print("  docker compose down")
        print("\nTo restart the environment, run:")
        print("  docker compose up -d")
        print()
        
        # Ask if user wants to open browser
        try:
            response = input("Would you like to open Jupyter Lab in your browser now? (y/N): ")
            if response.lower().startswith('y'):
                self.print_status("Opening Jupyter Lab in your default browser...")
                webbrowser.open("http://localhost:8889/lab")
        except KeyboardInterrupt:
            print("\nSetup completed. You can manually open http://localhost:8889/lab")
    
    def cleanup_on_failure(self):
        """Clean up resources if setup fails"""
        self.print_error("Setup failed. Cleaning up...")
        self.run_command("docker compose down", capture_output=True)
    
    def run_setup(self):
        """Run the complete setup process"""
        print("=" * 42)
        print("ADS 509 Module 3: Automated Setup")
        print("=" * 42)
        print()
        
        try:
            # Run all setup steps
            if not self.check_docker():
                return False
            
            if not self.check_data_file():
                return False
            
            if not self.build_environment():
                return False
            
            if not self.start_services():
                return False
            
            if not self.wait_for_jupyter():
                return False
            
            if not self.extract_data():
                return False
            
            self.verify_setup()
            self.show_completion_message()
            return True
            
        except KeyboardInterrupt:
            print("\nSetup interrupted by user")
            self.cleanup_on_failure()
            return False
        except Exception as e:
            self.print_error(f"Unexpected error: {e}")
            self.cleanup_on_failure()
            return False

def main():
    """Main entry point"""
    setup_manager = SetupManager()
    success = setup_manager.run_setup()
    sys.exit(0 if success else 1)

if __name__ == "__main__":
    main()
