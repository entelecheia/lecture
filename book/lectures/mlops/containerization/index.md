# Containerization - Docker

## Introduction

Docker is an open-source platform that simplifies the process of building, shipping, and running applications by utilizing containerization technology. Containers allow developers to package an application with all its dependencies, libraries, and configuration files, making it easy to deploy and run on any system consistently. This lecture note will provide an overview of Docker, its core components, and basic usage examples to help you understand how Docker can enhance your development workflow.

## Core Components

### Docker Engine

The Docker Engine is the core component that powers the Docker platform. It is responsible for creating, managing, and orchestrating containers. It consists of a daemon process (dockerd), a REST API, and a command-line interface (CLI).

### Docker Images

Docker images are read-only templates containing the application code, dependencies, libraries, and configuration files required to create and run a container. Images are stored in Docker registries and can be pulled to create containers.

### Docker Containers

A Docker container is a lightweight, standalone, and executable software package created from a Docker image. It includes everything needed to run an application, ensuring consistency across different environments.

### Dockerfile

A Dockerfile is a script containing instructions to build a Docker image. It specifies the base image, dependencies, configurations, and any other settings necessary to create a custom image tailored to your application.

### Docker Registry

A Docker registry is a centralized storage location for Docker images. Docker Hub is a public registry maintained by Docker Inc., but you can also create private registries or use third-party solutions.

## Installation

Install Docker on your system by following the official installation guide:

- Linux: [https://docs.docker.com/engine/install/](https://docs.docker.com/engine/install/)
- MacOS: [https://docs.docker.com/docker-for-mac/install/](https://docs.docker.com/docker-for-mac/install/)
- Windows: [https://docs.docker.com/docker-for-windows/install/](https://docs.docker.com/docker-for-windows/install/)

## Basic Docker Commands

### Pull an Image

Download an image from a registry:

```bash
docker pull <image-name>
```

### List Images

Display all images available locally:

```bash
docker images
```

### Create and Run a Container

Create a container from an image and start it:

```bash
docker run -it --name <container-name> <image-name>
```

### List Containers

List all running containers:

```bash
docker ps
```

List all containers, including stopped ones:

```bash
docker ps -a
```

### Stop a Container

Stop a running container:

```bash
docker stop <container-name>
```

### Remove a Container

Remove a stopped container:

```bash
docker rm <container-name>
```

### Remove an Image

Remove an unused image:

```bash
docker rmi <image-name>
```

## Building Docker Images with Dockerfile

### Create a Dockerfile

Create a file named `Dockerfile` in your project directory, and add instructions based on your application requirements.

Example Dockerfile:

```dockerfile
# Use the official Python base image
FROM python:3.8-slim

# Set the working directory
WORKDIR /app

# Copy requirements file
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Expose the application port
EXPOSE 8080

# Start the application
CMD ["python", "app.py"]
```

### Build the Image

Build the image from the Dockerfile:

```bash
docker build -t <image-name> .
```

## Docker Compose

Docker Compose is a tool for defining and running multi-container Docker applications. It allows you to configure your application's services, networks, and volumes in a single `docker-compose.yml` file, simplifying the process of managing complex applications with multiple dependencies.

### Install Docker Compose

Follow the official installation guide:

- Linux: [https://docs.docker.com/compose/install/](https://docs.docker.com/compose/install/)
- MacOS & Windows: Docker Compose comes pre-installed with Docker Desktop.

### Create a `docker-compose.yml` File

Create a `docker-compose.yml` file in your project directory and define your application's services, networks, and volumes.

Example `docker-compose.yml` file:

```yaml
version: "3.8"

services:
  web:
    build: .
    ports:
      - "8080:8080"
  redis:
    image: "redis:alpine"
```

In this example, we have two services: `web` and `redis`. The `web` service is built from the current directory, and its port 8080 is mapped to the host's port 8080. The `redis` service uses the official Redis image from Docker Hub.

### Start Services

Start all services defined in the `docker-compose.yml` file:

```bash
docker-compose up
```

### Stop Services

Stop all services:

```bash
docker-compose down
```

## Docker Volumes

Docker volumes are used to persist data generated by and used by Docker containers. They allow you to separate your application's data from the container's lifecycle, ensuring that your data remains intact even if the container is removed.

### Create a Volume

Create a new Docker volume:

```bash
docker volume create <volume-name>
```

### Use a Volume in a Container

To use a volume in a container, you need to mount it using the `-v` or `--mount` flag:

```bash
docker run -v <volume-name>:/data <image-name>
```

## Conclusion

Docker is a powerful platform that simplifies the process of building, deploying, and managing applications using containerization. Understanding its core components and commands, building custom images with Dockerfiles, managing multi-container applications with Docker Compose, and persisting data with Docker volumes will help you streamline your development workflow and ensure consistent application behavior across different environments.
