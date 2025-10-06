# Conduit Container
Containerized full-stack Conduit application with a Vue.js frontend and Django backend, fully orchestrated via Docker Compose for cloud deployment.

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
git clone https://github.com/IshakAtes/conduit-container.git # Conduit Containerized repo
git clone https://github.com/IshakAtes/conduit-frontend.git # Conduit Frontend
git clone https://github.com/IshakAtes/conduit-backend.git # Conduit Backend
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
- The backend API will be available at: `http://<server-ip>:3000`
- PostgreSQL Database: accessible inside the Docker network at: `db:5432`


## Usage

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

**Stop all running containers**
``` bash
docker compose down
```

**Configurations**<br>
Change environment variables in `.env` to customize database name, user, password, and server port mapping.
