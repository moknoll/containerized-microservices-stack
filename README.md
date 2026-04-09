# Containerized WordPress Stack

A multi-container WordPress infrastructure built with Docker and Docker Compose, demonstrating container orchestration, secure service networking, persistent storage, and service configuration for a production-like environment.

## Project Overview

This project implements a full infrastructure stack using Docker. It includes:
- **NGINX** as reverse proxy and SSL terminator
- **WordPress** as a PHP-based CMS
- **MariaDB** as a persistent database
- **Custom bridge network** for internal service communication

The goal is to orchestrate multiple containers, manage persistent data with volumes, and configure services for reliable deployment.

## Key Skills Demonstrated

- Docker container creation using custom Dockerfiles  
- Multi-container orchestration with Docker Compose  
- Service networking and name resolution between containers  
- Persistent storage via Docker volumes  
- HTTPS and reverse proxy setup  
- Environment configuration best practices

## Stack & Tools

- Docker  
- Docker Compose  
- NGINX  
- WordPress  
- MariaDB  
- Makefile for build automation

## Architecture Overview

The containers are connected via a user-defined Docker network:

![Architecture Overview](/images/screenshot.png)


- NGINX acts as the web entrypoint and reverse proxy
- WordPress connects to MariaDB for database operations
- Docker volumes persist data across container restarts

## Build & Run

Please refer to the USER_DOC.md mor DEV_DOC.md for a detailed setup. 

## Persistent Storage

Two Docker volumes ensure data persistence:
- `wordpress_data` – WordPress files
- `mariadb_data` – Database files

These ensure that data remains intact even after rebuilds.

## Contact

Developed by **Moritz Knoll** – backend & systems engineer  
LinkedIn: https://www.linkedin.com/in/moritz-knoll-13b11a199/  
Email: moritz.knoll@gmx.net

## Resources 
- https://docs.docker.com/build/building/best-practices/
- https://hub.docker.com/_/mariadb
- https://github.com/MariaDB/mariadb-docker/blob/master/docker-entrypoint.sh
- https://github.com/docker/awesome-compose
- https://docs.nginx.com/tls
- https://www.cyberciti.biz/faq/configure-nginx-to-use-only-tls-1-2-and-1-3/
- https://hostim.dev/learn/foundations/env-vars-secrets/
- https://docs.docker.com/get-started/workshop/05_persisting_data/

### AI Usage
AI tools (GitHub Copilot, ChatGPT) were used in this project for the following tasks:
- **Debugging:** Analyzing error logs from Docker containers and suggesting fixes for configuration issues (e.g., Nginx SSL setup, MariaDB initialization).
- **Explanation:** Clarifying concepts like the difference between Docker Volumes and Bind Mounts, or the specific syntax for Nginx configuration files.
- **Scripting:** Assistance in writing and refining shell scripts (`setup.sh`, entrypoint scripts) to ensure robustness and proper error handling.
- **Best Practices:** Providing recommendations for security (e.g., removing Port 80, using TLS 1.3) and folder structure optimization.
