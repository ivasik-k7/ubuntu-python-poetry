# Docker Image: Python Development Environment (Ubuntu 22.04 - Jammy)

This Docker image provides a Python development environment based on Ubuntu 22.04 (Jammy), with Python 3.11 installed from the deadsnakes PPA. It includes essential development tools and sets up pip and Poetry for managing Python packages.

## Features

- **Operating System**: Ubuntu Jammy (22.04)
- **Python Version**: 3.11
- **Python Tools**: Poetry and pip installed for Python package management
- **Timezone**: Configured to Europe/London

## Installed Packages

- **Core Utilities**:

  - ca-certificates
  - vim
  - sudo
  - make
  - tree
  - wget
  - git
  - curl
  - bash-completion

- **Python**:
  - python3.11
  - python3.11-venv
  - python3.11-dev

## Notes

- This Dockerfile assumes you have access to the deadsnakes/ppa repository for installing Python 3.11. If you encounter issues with the repository, ensure it's available or adjust accordingly.

- Ensure Docker is properly configured to run on your system, especially regarding permissions and network access for downloading packages during the build process.
