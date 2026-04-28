# Docker Management — Interactive Bash Menu

A polished, user-friendly Bash script to manage Docker from the terminal using a simple numbered menu. Quickly run, inspect, control and clean up containers and images, manage networks and volumes, and access Docker Compose — all without memorizing long docker CLI commands.

## Table of Contents
- [Features](#features)
- [Screenshots](#screenshots)
- [Installation](#installation)
- [Requirements](#requirements)
- [Usage](#usage)
- [Features Breakdown](#features-breakdown)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

## Features

- ✅ **Container Management** — Start, stop, restart, pause, kill containers
- ✅ **Container Inspection** — List containers (running & all), view logs, exec into containers, rename containers
- ✅ **Image Management** — Search, list and remove images
- ✅ **System Management** — Docker info & version, system cleanup
- ✅ **Network & Volume Management** — Manage networks and volumes
- ✅ **Registry Management** — Login / Logout for registries
- ✅ **Docker Compose** — Optional Docker Compose access with ready-to-use profiles
- ✅ **Interactive Menu** — Clear, numbered menu for fast and intuitive workflows

## Screenshots

### Main Menu
<img width="341" height="458" alt="image" src="https://github.com/user-attachments/assets/53c36c72-7ce5-4e61-8576-3c1fd7bf573b" />

Quick overview of available categories and actions.

### Network Manager
<img width="498" height="203" alt="image" src="https://github.com/user-attachments/assets/9354ba16-954a-41a3-ad32-0c8e8bd2590b" />

Manage all Docker network settings.

### Volume Management
<img width="335" height="151" alt="image" src="https://github.com/user-attachments/assets/955e75a4-3490-49ad-ba99-925bd619d1ff" />

Manage all Docker volumes with ease.

### Docker Compose
<img width="1214" height="364" alt="image" src="https://github.com/user-attachments/assets/fca40f29-0536-4345-ab7c-a374a49f8651" />

Ready-to-use Docker Compose profiles.

## Installation

### Quick Start

Open a terminal and run:

```bash
git clone git@github.com:Jdhdx/docker-management.git
cd docker-management
chmod +x docker.sh
./docker.sh
```

## Requirements

- **Docker** — 20.10 or later, installed and running
- **Bash** — 4.0 or later (Linux / macOS)
- **Windows** — Use WSL (Windows Subsystem for Linux) or Git Bash
- **Permissions** — Execute permissions on `docker.sh`

## Usage

### Running the Script

1. Run the script: `./docker.sh`
2. Enter the number shown in the menu to choose an action
3. Follow on-screen prompts (e.g., container name/ID, image name)
4. Press the menu number for submenus (Containers, Images, Network & Volume, Advanced, etc.)

### Common Examples

**Start a container:**
- Choose menu option "Run container"
- Provide the image name and any options when prompted

**View container logs:**
- Choose menu option "Logs of container"
- Select a container to tail logs in real-time

**Manage networks:**
- Choose menu option "Network & Volume"
- View, create, or remove Docker networks

**Clean up system:**
- Choose menu option "Advanced"
- Select "System cleanup" to remove unused images, containers, and volumes

## Features Breakdown

### Container Management
Easily start, stop, restart, pause, or kill containers without memorizing CLI commands.

### Image Management
Search Docker Hub, list local images, and remove images you no longer need.

### Network & Volume Management
Create, inspect, and delete networks and volumes for your containerized applications.

### System Maintenance
View Docker version and system info, and clean up unused resources in one command.

### Docker Compose Support
Quick access to Docker Compose commands with pre-configured profiles.

## Troubleshooting

### Permission Denied
```bash
chmod +x docker.sh
```

### Docker Daemon Not Running
Make sure Docker Desktop (on macOS/Windows) or the Docker daemon (on Linux) is running:
```bash
sudo systemctl start docker  # Linux
# or start Docker Desktop manually on macOS/Windows
```

### Command Not Found: docker
Ensure Docker is installed and in your PATH. Check your installation:
```bash
docker --version
```

### Bash Version Too Old
Check your Bash version:
```bash
bash --version
```
Update to Bash 4.0 or later if needed.

## Contributing

Contributions are welcome! Feel free to:
- Report issues or bugs
- Suggest new features
- Submit pull requests with improvements
- Improve documentation

## License

This project is licensed under the MIT License. See the LICENSE file for details.

---

**Happy Docker managing!** 🐳
