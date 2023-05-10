# Server Setup & Usage

## Introduction

In this tutorial, we will guide you through the process of connecting to, managing, and using a server for your simple MLOps pipeline project. The server will be used to host the pipeline, manage resources, and allow team members to collaborate effectively.

## Prerequisites:

- A local or remote server with root access
- Basic knowledge of Git, GitHub, and SSH
- Familiarity with the command-line interface (CLI)

## Workflow

### 1. Set up the server

If you are using a local server, make sure it is powered on and connected to the network. If you are using a remote server, such as a cloud-based virtual machine, ensure that you have root access and the necessary credentials. In either case, the server should have a Linux-based operating system, such as Ubuntu or CentOS, installed.

### 2. Update the server

Before proceeding, update the server's packages to ensure you have the latest software and security patches:

```bash
sudo apt-get update && sudo apt-get upgrade -y
```

### 3. Install the necessary software

For this project, you will need to install Git, containerd, and MicroK8s. Follow the steps in the earlier sections of this tutorial to install and configure these tools.

### 4. Set up SSH access for the team

As described in a previous section, set up SSH access for each team member by creating user accounts and adding their public SSH keys to the `authorized_keys` file.

### 5. Clone the GitHub repository

Clone your project's GitHub repository to the server:

```bash
git clone https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git
```

### 6. Create a dedicated directory for the project

To keep things organized, create a dedicated directory for your project:

```bash
mkdir -p /opt/YOUR_PROJECT_NAME
```

Move the cloned GitHub repository to the dedicated project directory:

```bash
mv YOUR_REPO_NAME /opt/YOUR_PROJECT_NAME/
```

### 7. Connect to the server

Team members can now connect to the server using SSH. Replace `USERNAME` and `SERVER_IP` with the appropriate username and server IP address or hostname:

```bash
ssh USERNAME@SERVER_IP
```

### 8. Manage the server

As a team member, you can now manage the server by navigating to the project directory and executing commands:

```bash
cd /opt/YOUR_PROJECT_NAME
```

To apply the MLOps pipeline configurations, run:

```bash
microk8s kubectl apply -f configs/
```

### 9. Use the server for the project

With the server set up, your team can now use it for various tasks:

- Collaborate on the project by committing and pushing changes to the GitHub repository
- Monitor the pipeline components using `microk8s kubectl get all`
- Update the pipeline by pulling the latest changes and re-applying the configurations

## Conclusion

In this tutorial, you learned how to connect to, manage, and use a server for your simple MLOps pipeline project. This server setup allows your team to collaborate efficiently, manage resources, and maintain the pipeline.
