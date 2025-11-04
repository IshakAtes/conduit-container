# Conduit Container
**Guide:**<br>
[Link to Pdf Checklist](https://github.com/IshakAtes/conduit-container/blob/e317db84d754bef8609d07e03e4f50e828255f58/Conduit%20Container%20Checkliste.pdf)<br><br>

Containerized full-stack Conduit application with a Angular frontend and Django backend, fully orchestrated via Docker Compose for cloud deployment.

## Table of Contents
1. [Project Overview](#project-overview)  
2. [Quickstart](#quickstart)  
3. [Conclusion](#conclusion)  
4. [Usage](#usage)  

## Project Overview
This repository contains a containerized version of the **Conduit full-stack web application**.  
It includes:
- a **frontend** built with **Angular** and served through **Nginx**  
- a **backend** implemented with **Django REST Framework**  
- a **PostgreSQL** database container for persistent storage  
- a **Docker Compose** configuration for orchestrating all components

The goal of this setup is to provide a reproducible, cloud-ready environment for deploying the Conduit app with minimal manual configuration.


## Quickstart

### Prerequisites
Before starting, ensure you have the following installed on your server:
- **Docker**
- **Docker Compose**
- SSH access to the machine

### 1. Clone the repositories
```bash
git clone git@github.com:IshakAtes/conduit-container.git # Conduit Containerized fullstack repo
cd conduit-container

# Initialize and update submodules for frontend and backend
git submodule update --init --recursive
```

### 2. Create an environment configuration file
```bash
cp example.env .env
```

### 3. Build and start the containers
```bash
docker compose up -d
```

## Conclusion:
**Once all containers are up and running:**
- The frontend will be available at: `http://<server-ip>:80`
- The backend API will be available at: `http://<server-ip>:8000`
- PostgreSQL Database: accessible inside the Docker network at: `db:5432`


## Usage

**Stop all running containers**
Stops and removes all running containers, networks, and volumes created by Docker Compose.
Use the `-v` flag to also delete associated volumes for a completely clean setup.
``` bash
docker compose down -v
```

**Rebuild after changes**
Forces Docker to rebuild the image from scratch, ignoring all cached layers.
Useful when dependencies or base images have changed and you want a completely fresh build.
``` bash
docker compose build --no-cache
```

**Rebuild after changes**
If you modify your `code` or `Dockerfiles`, rebuild the containers:
``` bash
docker compose up -d --build
```

**View container logs**
``` bash
docker compose logs -f
```

**Save logs to a file**
``` bash
docker logs <container-name> > conduit-logs.txt
```

**Configurations**<br>
Change environment variables in `.env` to customize database name, user, password, and server port mapping.
