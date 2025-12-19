# Conduit Container

**Guide:**
[Link to Pdf Checklist](https://github.com/IshakAtes/conduit-container/blob/e317db84d754bef8609d07e03e4f50e828255f58/Conduit%20Container%20Checkliste.pdf)

Containerized full-stack **Conduit** application with an **Angular frontend** and **Django backend**, deployed via **Docker Compose** and **fully automated using GitHub Actions (CI/CD)**.

---

## Table of Contents

1. [Project Overview](#project-overview)
2. [Deployment Concept](#deployment-concept)
3. [Quickstart (Automated Deployment)](#quickstart-automated-deployment)
4. [Secrets & Configuration](#secrets--configuration)
5. [Result](#result)

---

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

---

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

---

### 1. Fork or clone the repository

```bash
git clone https://github.com/IshakAtes/conduit-container.git
cd conduit-container
```

No repository files need to be copied to the server manually.

---

### 2. Configure GitHub Secrets

The deployment is fully controlled via **GitHub Actions secrets**.

Add the following secrets in your repository:
Go to your `conduit-container project -> settings -> Secrets and variables -> Actions`
click the button -> **New repository secret**
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

---

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

No manual server interaction is required.

---

## Result

After a successful workflow run:

* **Frontend** is available at:
  `http://<server-ip>:<frontend-port>`

* **Backend API** is available at:
  `http://<server-ip>:<backend-port>`

* All containers run in detached mode

* Future updates are deployed automatically on every push to `main`

---

## Conclusion

This project demonstrates how a traditional Docker Compose setup can be transformed into a **fully automated CI/CD pipeline** using GitHub Actions.

By separating:

* build responsibility (GitHub)
* runtime responsibility (server)

the system remains clean, secure, and easily reproducible for any user who clones the repository and provides the required secrets.
