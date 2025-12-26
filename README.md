# Conduit Container

**Guide:**
[Link to Pdf Checklist](https://github.com/IshakAtes/conduit-container/blob/lab/Conduit%20Deployment%20Checkliste.pdf)

Containerized full-stack Conduit application demonstrating a production-grade **CI/CD** deployment workflow using **Docker Compose** and **GitHub Actions**.

The stack consists of an **Angular frontend** and a **Django REST backend**, **fully automated** from build to deployment without manual server interaction.

## Table of Contents

1. [Project Overview](#project-overview)
2. [Quickstart (Automated Deployment)](#quickstart-automated-deployment)
3. [Usage](#usage)
4. [Result](#result)
5. [Conclusion](#conclusion)


## Project Overview

This repository contains a production-ready, containerized version of the **Conduit full-stack web application**.

It includes:

* a **frontend** built with **Angular**, served via **Nginx**
* a **backend** implemented with **Django REST Framework**
* containerized services orchestrated using **Docker Compose**
* a complete **CI/CD pipeline using GitHub Actions** for automated build, image publishing, signing, and deployment

The goal of this project is to demonstrate a **realistic DevOps / CI-CD workflow** where:

* application images are built and published automatically
* deployments are executed remotely via SSH
* no manual Docker commands are required on the server

Unlike a traditional Docker Compose setup, this project **does not require cloning the repository on the target server**.
All server-specific configuration is handled via **GitHub Secrets**.

This makes the deployment:

* reproducible
* secure
* cloud-provider agnostic


## Quickstart (Automated Deployment)

### Prerequisites

Before using this repository, ensure the following:

**Local / GitHub side:**

* Fork or clone access to this repository

**Target server:**

* Linux server (VPS or VM)
* Docker installed
* Docker Compose v2 installed
* SSH access (key-based authentication recommended)


### 1. Fork the repository (required)

To use this deployment setup, fork this repository into your own GitHub account.

All CI/CD workflows run entirely inside GitHub Actions.
No local clone is required for deployment.

### Optional: Clone locally (development / inspection)

Cloning the repository locally is only required if you want to:

* inspect or modify the workflow
* adjust Dockerfiles
* extend the application itself

```bash
git clone git@github.com:IshakAtes/conduit-container.git
cd conduit-container
```


### 2. Configure GitHub Secrets

The deployment is fully controlled via **GitHub Actions secrets**.

Add the following secrets in your repository:
Go to your `conduit-container project -> settings -> Secrets and variables -> Actions`
click the button -> **`New repository secret`**
and create these secrets

| Secret Name       | Description                                                     |
| ----------------- | --------------------------------------------------------------- |
| `SECRET_IP`       | Public IP or hostname of the server                             |
| `SSH_USER`        | SSH username on the server                                      |
| `SSH_PRIVATE_KEY` | Private SSH key used for deployment                             |
| `PORT`            | SSH port (usually `22`)                                         |
| `ENV_FILE`        | Full `.env` file content (Docker Compose environment variables) |
| `API_URL`         | Public backend API URL for frontend configuration               |

The `.env` file is **generated automatically on the server** during deployment.


### 3. Trigger the deployment

The deployment starts automatically when:

* a commit is pushed to the `main` branch, or
* a pull request is merged into `main`

The workflow will:

1. build backend and frontend Docker images
2. push images to GitHub Container Registry
3. cryptographically sign the images
4. connect to the server via SSH
5. create the `.env` file on the server
6. start the application using Docker Compose

**No manual server interaction is required.**


## Usage

This section explains how the deployment can be configured and customized without modifying the server or manually interacting with Docker.

The entire behavior of the deployment is controlled via **GitHub Secrets** and environment variables.


### Configuration Overview

The deployment is driven by three configuration layers:

1. **GitHub Actions workflow**
2. **GitHub Secrets**
3. **Docker Compose environment variables (`.env`)**

The target server itself remains static and only requires Docker, Docker Compose, and SSH access.


### GitHub Secrets Configuration

All runtime configuration is injected via repository secrets.

#### Required Secrets

| Secret Name       | Purpose |
|------------------|--------|
| `SECRET_IP` | Public IP or hostname of the target server |
| `SSH_USER` | SSH user used by GitHub Actions |
| `SSH_PRIVATE_KEY` | Private key for SSH authentication |
| `PORT` | SSH port (default: 22) |
| `ENV_FILE` | Full `.env` file content used by Docker Compose |
| `API_URL` | Public backend URL consumed by the frontend |

Changing any **secret** requires re-running the workflow to apply the new configuration.


### `.env` File (Runtime Configuration)

The `.env` file is **not stored in the repository**.  
Instead, it is defined as a single multi-line GitHub Secret (`ENV_FILE`) and written to disk on the server during deployment.

This allows full control over the runtime behavior without rebuilding images.

#### Example `.env` content
``` env
# Server IP for allowed hosts
SECRET_IP=<SECRET_IP>
LOCALHOST=localhost
LOCALHOST_2=127.0.0.1

# Public-facing ports on the host
SERVER_PORT_FRONTEND=8282
CONTAINER_PORT_FRONTEND=80
SERVER_PORT_BACKEND=8000
CONTAINER_PORT_BACKEND=8000

# Database
POSTGRES_USER=conduit
POSTGRES_PASSWORD=conduit
POSTGRES_DB=conduit_db
POSTGRES_HOST=db
POSTGRES_PORT=5432

# Superuser
SUPER_USER_NAME=mrfoo
SUPER_USER_EMAIL=foo@gmail.com
SUPER_USER_PASSWORD=test123
```


## Result

After a successful workflow run:

* **Frontend** is available at:
  `http://<server-ip>:<frontend-port>`

* **Backend API** is available at:
  `http://<server-ip>:<backend-port>`

* All containers run in detached mode

* Future updates are deployed automatically on every push to `main`


## Conclusion

This project demonstrates how a traditional Docker Compose setup can be transformed into a **fully automated CI/CD pipeline** using GitHub Actions.

By separating:

* build responsibility (GitHub)
* runtime responsibility (server)

the system remains clean, secure, and easily reproducible for any user who forks the repository and configures the required GitHub Secrets.
