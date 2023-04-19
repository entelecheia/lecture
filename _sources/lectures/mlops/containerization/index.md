# Containerization - Docker and containerd

## Introduction

**Containerization** is a lightweight virtualization technology that allows developers to package applications and their dependencies into portable units called **containers**. These containers can be deployed and run on different platforms and environments, ensuring consistent behavior and performance. Two popular containerization technologies are **Docker** and **containerd**.

**Docker** is a widely-used platform that simplifies the creation, deployment, and management of containers. Docker has become synonymous with containerization due to its user-friendly interface, extensive ecosystem, and comprehensive toolset. Some key features of Docker include:

- **Docker Engine**: The core component of Docker, responsible for creating, managing, and orchestrating containers.
- **Docker Images**: Snapshots of containers containing the application, dependencies, and configurations, which can be shared and reused across different environments.
- **Docker Hub**: A public registry for sharing and distributing Docker images, making it easy to find and deploy pre-built images.
- **Docker Compose**: A tool for defining and running multi-container applications using a YAML configuration file.
- **Docker Swarm**: A native clustering and orchestration solution for Docker, allowing users to create and manage a swarm of Docker nodes and deploy services across them.

On the other hand, **containerd** is a lightweight, standalone runtime for managing containers. Originally developed as a component of Docker, containerd has evolved into an independent project under the Cloud Native Computing Foundation (CNCF). While it lacks some of the high-level features and user-friendliness of Docker, containerd is designed to be a more focused and efficient runtime. Some key aspects of containerd include:

- **Minimalist Design**: containerd focuses on the core functionality of managing containers, such as creating, starting, and stopping them.
- **Performance**: containerd is designed for better performance and a smaller footprint compared to Docker, making it suitable for resource-constrained environments.
- **Modularity**: containerd can be used as a component in more extensive container platforms or integrated with other tools, providing flexibility and customization options.
- **OCI Compatibility**: containerd is compatible with the Open Container Initiative (OCI) runtime and image specifications, ensuring interoperability with other OCI-compliant tools and platforms.

In conclusion, **Docker** is a comprehensive and user-friendly containerization platform, offering a wide range of tools and features that make it easy to create, deploy, and manage containers. **containerd**, on the other hand, is a minimalist and focused runtime that can be integrated with other tools and platforms, providing better performance and modularity. Choosing between Docker and containerd depends on the specific needs and constraints of the project, with Docker being more suitable for those looking for a complete, out-of-the-box solution, and containerd being a good fit for more customized and performance-oriented scenarios.

## Core Components of Docker

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

## Helper Scripts

There are a few helper scripts that can be used to simplify the process of building and running Docker containers. These scripts are installed in the process of setting up `dotfiles` and can be found in the `.local/bin` directory.

### `dockerfiles-clone` Script

The `dockerfiles-clone` script is designed to help you clone or update the Dockerfiles repository on your system. To use this script, follow these steps:

1. **Configure Environment Variables (optional):**
   If you have specific values for `DOCKERFILES_REPO` or `DOCKERFILES_DIR`, you can set these environment variables before running the script. Otherwise, the script will use the default values specified in the script.

   ```bash
   export DOCKERFILES_REPO="https://github.com/username/dockerfiles.git"
   export DOCKERFILES_DIR="/path/to/dockerfiles"
   ```

2. **Run the Script:**
   Execute the `dockerfiles-clone` script:

   ```bash
   dockerfiles-clone
   ```

   This script will perform the following tasks:

   - Check if the Dockerfiles repository is set. If not, it will display a message and exit.
   - If the Dockerfiles directory exists, it will prompt you to remove the existing directory.
     - If you choose to remove the existing directory, it will delete the directory and proceed to clone the repository.
     - If you choose not to remove the existing directory, it will display a message and exit.
   - If the Dockerfiles directory does not exist, it will clone the Dockerfiles repository to the specified directory.

After running the `dockerfiles-clone` script, your Dockerfiles repository will be cloned or updated, and you can start using the Dockerfiles on your system.

### `dockerfiles-pull` Script

The `dockerfiles-pull` script helps you update the Dockerfiles repository on your system. To use this script, follow these steps:

1. **Configure Environment Variables (optional):**
   If you have specific values for `DOCKERFILES_REPO` or `DOCKERFILES_DIR`, you can set these environment variables before running the script. Otherwise, the script will use the default values specified in the script.

   ```bash
   export DOCKERFILES_REPO="https://github.com/username/dockerfiles.git"
   export DOCKERFILES_DIR="/path/to/dockerfiles"
   ```

2. **Run the Script:**
   Execute the `dockerfiles-pull` script:

   ```bash
   dockerfiles-pull
   ```

   This script will perform the following tasks:

   - Check if the Dockerfiles directory exists.
   - If the directory exists and is a valid Git repository, it will update the Dockerfiles repository using `git pull --rebase --autostash`.

After running the `dockerfiles-pull` script, your Dockerfiles repository will be updated, and you can continue using the latest Dockerfiles on your system.

### `dockerfiles-sync` Script

The `dockerfiles-sync` script helps you synchronize Dockerfiles between your project directory and the shared Dockerfiles directory. To use this script, follow these steps:

1. **Configure Environment Variables (optional):**
   If you have specific values for `WORKSPACE_PROJECT_DIR` or `DOCKERFILES_SHARE_DIR`, you can set these environment variables before running the script. Otherwise, the script will use the default values specified in the script.

   ```bash
   export WORKSPACE_PROJECT_DIR="/path/to/workspace/project/directory"
   export DOCKERFILES_SHARE_DIR="/path/to/dockerfiles/share/directory"
   ```

2. **Run the Script:**
   Execute the `dockerfiles-sync` script with the desired options:

   ```bash
   dockerfiles-sync [DOCKER_NAME] [--from-project] [--project-directory PROJECT_DIR] [--dockerfiles-directory DOCKERFILES_DIR] [-h|--help]
   ```

   Available options:

   - `DOCKER_NAME`: Specify the name of a specific Docker project to sync.
   - `--from-project`: Sync Dockerfiles from the project directory to the shared Dockerfiles directory.
   - `--project-directory PROJECT_DIR`: Set the project directory path.
   - `--dockerfiles-directory DOCKERFILES_DIR`: Set the shared Dockerfiles directory path.
   - `-h|--help`: Display usage information.

   Examples:

   - Sync all Dockerfiles from the shared Dockerfiles directory to the workspace project directory:

     ```bash
     dockerfiles-sync
     ```

   - Sync a specific Dockerfile from the shared Dockerfiles directory to the workspace project directory:

     ```bash
     dockerfiles-sync my-docker-project
     ```

   - Sync all Dockerfiles from the workspace project directory to the shared Dockerfiles directory:

     ```bash
     dockerfiles-sync --from-project
     ```

   - Sync a specific Dockerfile from the workspace project directory to the shared Dockerfiles directory:

     ```bash
     dockerfiles-sync my-docker-project --from-project
     ```

After running the `dockerfiles-sync` script, your Dockerfiles will be synchronized between the specified directories.
The `dk-compose` script is a convenient wrapper for managing Docker Compose projects. To use the script, follow the usage format below:

### `dk-compose` Script

```bash
Usage: dk-compose COMMAND DOCKER_NAME [-t|--tag TAG] [--from-project] [--project-directory PROJECT_DIR] [--dockerfiles-directory DOCKERFILES_DIR] [-c|--compose-filename COMPOSE_FILENAME] [-e|--env-filename ENV_FILENAME] [-v|--version VERSION] [-l|--latest] [--push] [-n|--name CONTAINER_NAME] [--network DOCKER_NETWORK_NAME] [-u|--username USERNAME] [-h|--help]
```

**COMMAND** - One of the following Docker Compose commands:

- `build`: Build the Docker services defined in the Compose file.
- `run`: Run a one-off command on a service.
- `up`: Create and start the containers defined in the Compose file.
- `down`: Stop and remove containers, networks, and volumes defined in the Compose file.

**DOCKER_NAME** - The name of the Docker project.

**Options:**

- `-t, --tag TAG`: Specify a tag to use for the Docker Compose file and environment file. The script will look for files named `docker-compose-TAG.yaml` and `docker.TAG.env`, where `TAG` is the provided tag.

- `--from-project`: Use the project directory as the source of the Docker Compose files instead of the default Dockerfiles directory.

- `--project-directory PROJECT_DIR`: Provide a custom path to the project directory. If not specified, the script will use the default project directory.

- `--dockerfiles-directory DOCKERFILES_DIR`: Provide a custom path to the directory containing the Dockerfiles. If not specified, the script will use the default Dockerfiles directory.

- `-c, --compose-filename COMPOSE_FILENAME`: Specify a custom Docker Compose file name. If not specified, the script will use the default `docker-compose.yaml` or `docker-compose-TAG.yaml` based on the provided tag.

- `-e, --env-filename ENV_FILENAME`: Specify a custom environment file name. If not specified, the script will use the default `docker.env` or `docker.TAG.env` based on the provided tag.

- `-v, --version VERSION`: Specify the version of the Docker image to use. This will be set as the `VERSION` environment variable for the Docker Compose process.

- `-l, --latest`: Use the latest version of the Docker image. Sets the `VERSION` environment variable to "latest".

- `--push`: After successfully building the Docker image, push the image to a remote repository.

- `-n, --name CONTAINER_NAME`: Specify a custom name for the container that will be created.

- `--network DOCKER_NETWORK_NAME`: Specify the name of the Docker network to use or create. If the network does not exist, the script will create it.

- `-u, --username USERNAME`: Specify the username to use for the Docker image. If not provided, the script will use the default username from the configuration.

- `-h, --help`: Display the usage information for the script.

**Examples:**

1. Build a Docker project named `my_project` with tag `dev`:

```
dk-compose build my_project -t dev
```

2. Run a one-off command (`some_command`) on the `my_service` service in the `my_project` Docker project:

```
dk-compose run my_project --name my_service some_command
```

3. Start the containers defined in the `my_project` Docker project with tag `prod`:

```
dk-compose up my_project -t prod
```

4. Stop and remove the containers, networks, and volumes defined in the `my_project` Docker project with tag `prod`:

```
dk-compose down my_project -t prod
```

Remember that the `dk-compose` script should be executable and located in a directory included in the `PATH` variable (e.g., `.local/bin`).

## Next

```{tableofcontents}

```
