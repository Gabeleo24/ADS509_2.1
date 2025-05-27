# Troubleshooting Guide

This guide helps resolve common issues when setting up and running the ADS 509 Module 3 project.

## Common Setup Issues

### Docker Issues

#### Problem: "Docker is not installed" or "docker command not found"
**Solution:**
1. Download and install Docker Desktop from https://www.docker.com/products/docker-desktop
2. Follow the installation instructions for your operating system
3. Restart your terminal/command prompt after installation

#### Problem: "Docker is not running"
**Solution:**
1. Start Docker Desktop application
2. Wait for Docker to fully start (you'll see the Docker icon in your system tray)
3. Try the setup script again

#### Problem: "Permission denied" when running Docker commands
**Solution (Linux/macOS):**
```bash
# Add your user to the docker group
sudo usermod -aG docker $USER
# Log out and log back in, or restart your terminal
```

**Solution (Windows):**
- Make sure you're running the command prompt as Administrator
- Or use PowerShell as Administrator

### Data File Issues

#### Problem: "Data file not found"
**Solution:**
1. Ensure `M1 Assignment Data (1).zip` is in the same directory as the setup scripts
2. Check the exact filename (including spaces and parentheses)
3. Download the file again if it's corrupted

#### Problem: "Failed to extract data"
**Solution:**
1. Check if the zip file is corrupted by trying to open it manually
2. Ensure you have enough disk space (at least 1GB free)
3. Try running the extraction manually:
   ```bash
   docker compose exec jupyter bash -c "cd /home/jovyan/work && unzip -o 'M1 Assignment Data (1).zip'"
   ```

### Port Issues

#### Problem: "Port 8889 is already in use"
**Solution:**
1. Stop any existing containers:
   ```bash
   docker compose down
   ```
2. Check what's using the port:
   ```bash
   # On Linux/macOS:
   lsof -i :8889
   
   # On Windows:
   netstat -ano | findstr :8889
   ```
3. Kill the process or change the port in `compose.yaml`

### Network Issues

#### Problem: "Cannot connect to Jupyter Lab"
**Solution:**
1. Wait a bit longer - Jupyter can take 30-60 seconds to start
2. Check if the container is running:
   ```bash
   docker compose ps
   ```
3. Check container logs:
   ```bash
   docker compose logs jupyter
   ```
4. Try accessing directly: http://localhost:8889/lab

## Platform-Specific Issues

### Windows Issues

#### Problem: "bash: command not found" when running .sh scripts
**Solution:**
Use the Windows batch file instead:
```cmd
setup.bat
```

#### Problem: Scripts don't run due to execution policy
**Solution:**
1. Open PowerShell as Administrator
2. Run: `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`
3. Try running the Python script: `python setup.py`

### macOS Issues

#### Problem: "Permission denied" when running setup.sh
**Solution:**
```bash
chmod +x setup.sh
./setup.sh
```

#### Problem: Python script fails with SSL errors
**Solution:**
```bash
# Install certificates for Python
/Applications/Python\ 3.x/Install\ Certificates.command
```

### Linux Issues

#### Problem: "Cannot connect to the Docker daemon"
**Solution:**
```bash
# Start Docker service
sudo systemctl start docker

# Enable Docker to start on boot
sudo systemctl enable docker
```

## Manual Recovery Steps

If automated setup fails completely, try these manual steps:

### 1. Clean Start
```bash
# Stop all containers
docker compose down

# Remove any existing containers and images
docker system prune -a

# Start fresh
docker compose up --build
```

### 2. Manual Data Extraction
```bash
# Start just the container
docker compose up -d

# Copy zip file to container
docker cp "M1 Assignment Data (1).zip" ads509_2.1_jupyter_1:/home/jovyan/work/

# Extract manually
docker compose exec jupyter bash -c "cd /home/jovyan/work && unzip -o 'M1 Assignment Data (1).zip'"
```

### 3. Alternative Access Methods
If Jupyter Lab doesn't work, try:
- Jupyter Notebook: http://localhost:8889/tree
- Direct file access through Docker:
  ```bash
  docker compose exec jupyter bash
  ```

## Performance Issues

### Problem: Setup is very slow
**Possible causes and solutions:**
1. **Slow internet**: Docker needs to download large images
2. **Low disk space**: Ensure at least 2GB free space
3. **Low RAM**: Close other applications, ensure 4GB+ available
4. **Antivirus interference**: Add Docker directory to antivirus exclusions

### Problem: Jupyter Lab is slow or unresponsive
**Solutions:**
1. Restart the container:
   ```bash
   docker compose restart jupyter
   ```
2. Increase Docker memory allocation in Docker Desktop settings
3. Close unused browser tabs and applications

## Getting Help

If you're still experiencing issues:

1. **Check the logs:**
   ```bash
   docker compose logs jupyter
   ```

2. **Verify your environment:**
   ```bash
   docker --version
   docker compose --version
   python --version
   ```

3. **Create an issue** in the repository with:
   - Your operating system and version
   - Docker version
   - Complete error message
   - Steps you've already tried

4. **Common log locations:**
   - Docker Desktop logs: Docker Desktop → Troubleshoot → Show logs
   - Container logs: `docker compose logs`

## Quick Reference Commands

```bash
# Check Docker status
docker info

# View running containers
docker compose ps

# View container logs
docker compose logs jupyter

# Restart services
docker compose restart

# Stop everything
docker compose down

# Start fresh
docker compose up --build

# Access container shell
docker compose exec jupyter bash

# Check Jupyter status
curl http://localhost:8889/lab
```
