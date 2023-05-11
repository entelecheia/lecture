# Server Setup & Usage

## Introduction

In this tutorial, we will guide you through the process of connecting to, managing, and using a server for your simple MLOps pipeline project. The server will be used to host the pipeline, manage resources, and allow team members to collaborate effectively.

## Prerequisites:

- A local or remote server with root access
- Basic knowledge of Git, GitHub, and SSH
- Familiarity with the command-line interface (CLI)

## Basic User Management for an Ubuntu Server

In this section, we will guide you through the process of basic user management on an Ubuntu server. User management is essential for controlling access to server resources, setting permissions, and ensuring the security of your server. We will cover creating new users, adding users to the sudoers group, and removing users.

### 1. Create a new user

To create a new user on the Ubuntu server, use the `adduser` command followed by the desired username:

```bash
sudo adduser new_username
```

You will be prompted to enter a password for the new user and provide optional user information, such as full name, room number, work phone, etc. You can leave these fields blank by pressing Enter.

### 2. Add a user to the sudoers group

By default, a new user does not have administrative privileges on the server. To grant a user sudo privileges, add them to the sudoers group:

```bash
sudo usermod -aG sudo new_username
```

The user will now have the ability to execute commands with superuser privileges by prefixing the command with `sudo`.

### 3. Remove a user

To remove a user from the Ubuntu server, use the `deluser` command:

```bash
sudo deluser --remove-home username_to_remove
```

This command will delete the user and their home directory. If you only want to remove the user without deleting the home directory, omit the `--remove-home` option.

### 4. Switch between users

To switch to another user account, use the `su` command followed by the target username:

```bash
su target_username
```

You will be prompted to enter the target user's password. To return to your previous user session, type `exit` and press Enter.

### 5. List users on the server

To list all users on the server, you can use the `getent` command:

```bash
getent passwd
```

This command displays the content of the `/etc/passwd` file, which contains user account information. Each line represents a user account and includes the username, user ID (UID), group ID (GID), home directory, and default shell.

### 6. Change a user's password

To change a user's password, use the `passwd` command:

```bash
sudo passwd target_username
```

You will be prompted to enter a new password for the target user.

## Workflow for a Simple MLOps Pipeline Project

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

In this section, you learned how to connect to, manage, and use a server for your simple MLOps pipeline project. This server setup allows your team to collaborate efficiently, manage resources, and maintain the pipeline.
