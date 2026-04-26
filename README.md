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

1. Clone the repository  
2. Run `./setup.sh`  
3. Execute `make up`  
4. Visit https://localhost

For detailed information: 
- USER_DOC.md
- DEV_DOC.md

## Persistent Storage

Two Docker volumes ensure data persistence:
- `wordpress_data` – WordPress files
- `mariadb_data` – Database files

These ensure that data remains intact even after rebuilds.

## Contact

Developed by **Moritz Knoll** – backend & systems engineer  
LinkedIn: https://www.linkedin.com/in/moritz-knoll-13b11a199/  
Email: moritz.knoll@gmx.net
