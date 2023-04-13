# `containerd`

## Introduction

**Containerd** is an industry-standard container runtime focused on simplicity, robustness, and portability. It is a core component of the Docker ecosystem and also serves as an independent project under the Cloud Native Computing Foundation (CNCF). The primary goal of containerd is to provide a lightweight, standalone runtime for managing containers.

### 1. Overview of containerd

- **Minimalist Design**: containerd emphasizes a stripped-down design that focuses on the core functionality of managing containers, such as creating, starting, stopping, and monitoring them.
- **Performance**: containerd is designed for improved performance and reduced footprint compared to Docker, making it suitable for resource-constrained environments and large-scale deployments.
- **Modularity**: containerd can be used as a component in more extensive container platforms or integrated with other tools, providing flexibility and customization options.
- **OCI Compatibility**: containerd is compatible with the Open Container Initiative (OCI) runtime and image specifications, ensuring interoperability with other OCI-compliant tools and platforms.

### 2. Key components of containerd

- **containerd daemon**: The core component of containerd, responsible for managing containers and their life cycles. The daemon communicates with clients via a gRPC API.
- **ctr**: A lightweight command-line interface (CLI) tool for interacting with the containerd daemon, enabling users to manage containers directly.
- **runc**: The default OCI-compliant runtime used by containerd to run containers. Users can also use alternative OCI-compliant runtimes, such as kata-containers or gVisor.
- **snapshotters**: Pluggable components that manage filesystem snapshots for containers, providing support for various storage backends and filesystems.
- **content store**: A content-addressable storage system for managing container images and binary data in a secure and efficient manner.

### 3. Working with containerd

- **Installing containerd**: Containerd can be installed on various platforms, such as Linux and Windows, through package managers or by downloading pre-built binaries.
- **Managing containers**: Users can interact with containerd through the `ctr` CLI tool or by directly accessing the containerd API via gRPC.
- **Container images**: containerd supports pulling and managing container images from OCI-compliant image registries, such as Docker Hub.
- **Integration with Kubernetes**: containerd can be used as the container runtime for Kubernetes clusters, enabling users to leverage its performance and modularity benefits in a Kubernetes environment.

### 4. Use cases and scenarios

- **Edge computing**: containerd's lightweight design and resource efficiency make it well-suited for edge computing environments with limited resources.
- **Large-scale deployments**: containerd's focus on performance and simplicity makes it a strong choice for large-scale container deployments where resource utilization and management overhead are critical concerns.
- **Custom container platforms**: containerd's modular design allows it to be integrated with custom container platforms and orchestrators, providing a flexible and customizable container runtime solution.

## Getting Started with Containerd

In this section, we will walk you through the process of installing and using **containerd** to manage containers. We will cover the following topics:

1. Installing containerd
2. Using the `ctr` command-line tool
3. Running a simple container
4. Managing container images
5. Inspecting container details

### 1. Installing containerd

**On Ubuntu:**

To install containerd on Ubuntu, run the following commands:

```bash
sudo apt-get update
sudo apt-get install -y containerd
```

**On CentOS:**

To install containerd on CentOS, first enable the EPEL repository and then install containerd:

```bash
sudo yum install -y epel-release
sudo yum install -y containerd
```

**On Windows:**

You can download the latest containerd release for Windows from the [GitHub releases page](https://github.com/containerd/containerd/releases). Extract the archive and add the `bin` directory to your system's PATH.

After installation, start the containerd service:

```bash
sudo systemctl start containerd
sudo systemctl enable containerd
```

### 2. Using the `ctr` command-line tool

The `ctr` tool is the primary command-line interface for interacting with containerd. You can use it to manage containers, images, and other resources. To see a list of available commands, run `ctr --help`.

### 3. Running a simple container

In this example, we will run an Nginx container using containerd. First, pull the Nginx image:

```bash
sudo ctr images pull docker.io/library/nginx:latest
```

Next, create a new container using the pulled image:

```bash
sudo ctr containers create docker.io/library/nginx:latest nginx-container
```

Finally, start the container:

```bash
sudo ctr containers start nginx-container
```

The Nginx container should now be running. To check its status, use the following command:

```bash
sudo ctr containers list
```

### 4. Managing container images

containerd supports managing container images from OCI-compliant image registries. You can pull, list, and remove images using the `ctr` tool.

- **Pulling images**: Use the `ctr images pull` command to download container images. For example:

  ```bash
  sudo ctr images pull docker.io/library/alpine:latest
  ```

- **Listing images**: To see a list of downloaded images, run the following command:

  ```bash
  sudo ctr images list
  ```

- **Removing images**: To remove an image, use the `ctr images remove` command:

  ```bash
  sudo ctr images remove docker.io/library/alpine:latest
  ```

### 5. Inspecting container details

You can inspect various aspects of a running container, such as its configuration, environment variables, and mounts, using the `ctr` tool.

- **Inspecting container configuration**: To view the configuration of a container, use the following command:

  ```bash
  sudo ctr containers info nginx-container
  ```

- **Inspecting container processes**: To view the processes running inside a container, use the `ctr containers exec` command:

  ```bash
  sudo ctr containers exec --exec-id my-exec-id nginx-container ps aux
  ```

- **Inspecting container logs**: To view the logs of a running container, use the `ctr containers logs` command:

  ```bash
  sudo ctr containers logs nginx-container
  ```

## How to create a container image

Creating an image for containerd involves building an OCI (Open Container Initiative) compliant image, which can be used by containerd and other OCI-compliant container runtimes. In this guide, we will walk through the process of creating a container image using BuildKit, an advanced toolkit for building container images that works with containerd.

### 1. Install BuildKit

First, we need to install BuildKit. You can find installation instructions for various platforms in the [BuildKit repository](https://github.com/moby/buildkit).

For Ubuntu, you can install BuildKit using the following commands:

```bash
sudo apt-get update
sudo apt-get install -y buildkit
```

For CentOS, you can install BuildKit with the following commands:

```bash
sudo yum install -y epel-release
sudo yum install -y buildkit
```

### 2. Create a Dockerfile

Next, create a `Dockerfile` that describes the image you want to build. As an example, we will create a simple Alpine-based image that includes the `curl` utility:

```
FROM alpine:latest
RUN apk add --no-cache curl
CMD ["curl", "--help"]
```

Save this content in a file named `Dockerfile` in your working directory.

### 3. Build the image using BuildKit

To build the image using BuildKit, first set the `BUILDKIT_HOST` environment variable to point to the BuildKit daemon:

```bash
export BUILDKIT_HOST="unix:///var/run/buildkit/buildkitd.sock"
```

Next, run the `buildctl` command to build the image:

```bash
buildctl build \
  --frontend dockerfile.v0 \
  --local context=. \
  --local dockerfile=. \
  --output type=image,name=my-containerd-image,oci-mediatypes=true,push=false
```

In this command:

- `--frontend dockerfile.v0`: Specifies the Dockerfile frontend for BuildKit.
- `--local context=.`: Sets the build context to the current directory.
- `--local dockerfile=.`: Indicates that the Dockerfile is located in the current directory.
- `--output type=image,name=my-containerd-image,oci-mediatypes=true,push=false`: Configures the output as an OCI-compliant image named `my-containerd-image` and disables pushing the image to a registry.

After the build is complete, the image will be available locally in containerd.

### 4. Verify the image in containerd

To verify that the image is available in containerd, use the `ctr` command:

```bash
sudo ctr images list | grep my-containerd-image
```

You should see the `my-containerd-image` listed among the available images.

That's it! You've successfully created an image for containerd using BuildKit. You can now use this image to create and run containers with containerd or any other OCI-compliant container runtime.

## Relationship between containerd and Kubernetes

Kubernetes is an open-source container orchestration platform that automates the deployment, scaling, and management of containerized applications. It works with various container runtimes, including Docker, containerd, and CRI-O, through the Container Runtime Interface (CRI).

The relationship between Kubernetes and containerd can be summarized as follows:

1. **Container Runtime**: Containerd is one of the supported container runtimes for Kubernetes. It provides the necessary features to run containers and manage their lifecycle, as well as image distribution and storage. Containerd can replace Docker as the container runtime in Kubernetes clusters, providing a more lightweight and focused runtime that is tailored for use with Kubernetes.

2. **Container Runtime Interface (CRI)**: Kubernetes uses the CRI to communicate with container runtimes like containerd. The CRI is a standard API that abstracts the underlying container runtime from the Kubernetes components, allowing Kubernetes to work with different container runtimes without modification. Containerd implements the CRI through the `containerd/cri` plugin, which translates CRI API calls from Kubernetes into containerd API calls.

3. **Runtime Class**: Kubernetes supports selecting the container runtime for each pod through the RuntimeClass feature. This allows you to choose between different container runtimes (e.g., Docker, containerd, or CRI-O) on a per-pod basis. By configuring the appropriate RuntimeClass, you can instruct Kubernetes to use containerd for specific pods in your cluster.

4. **Simplified Stack**: In some cases, using containerd instead of Docker as the container runtime in Kubernetes clusters can result in a simpler and more efficient stack. This is because containerd is a more focused and lightweight runtime compared to Docker, which includes additional components that may not be necessary in a Kubernetes environment (e.g., Docker Compose or Docker Swarm). By using containerd, you can potentially reduce the resource footprint and complexity of your Kubernetes nodes.
