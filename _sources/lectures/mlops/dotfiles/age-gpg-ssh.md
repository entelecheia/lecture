# SSH, GPG, and AGE

**A Comparative Study of SSH, GPG, and AGE: Encryption and Authentication Tools**

## Introduction

Secure communication is a vital aspect of modern computing, and encryption plays a crucial role in ensuring data privacy and integrity. In this lecture, we will explore three widely-used tools for encryption and authentication: Secure Shell (SSH), GNU Privacy Guard (GPG), and age. We will compare their features, use cases, and limitations to help you better understand which tool is most suitable for your specific needs.

### Secure Shell (SSH)

SSH is a cryptographic network protocol that enables secure communication between two devices. It is widely used for remote administration, file transfers, and secure command execution. Some key features of SSH are:

- Public-key authentication: SSH uses a key pair (public and private keys) for authentication. The public key is shared with the server, while the private key remains securely on the client.
- Encryption: SSH uses symmetric encryption algorithms to protect data in transit, ensuring confidentiality and integrity.
- Port forwarding and tunneling: SSH can create secure tunnels for forwarding network traffic, providing additional security and privacy.

### GNU Privacy Guard (GPG)

GPG is an open-source implementation of the OpenPGP standard, providing encryption, decryption, and digital signatures. GPG is popular for encrypting emails, files, and communication channels. Key features of GPG are:

- Asymmetric encryption: GPG uses public-key cryptography, allowing users to encrypt data using the recipient's public key, which can only be decrypted by the recipient's private key.
- Digital signatures: GPG enables users to sign data using their private key, allowing the recipient to verify the sender's identity and the integrity of the data using the sender's public key.
- Key management: GPG supports a web of trust, allowing users to verify and trust other users' public keys through a decentralized network of signatures.

### age

age is a modern file encryption tool designed for simplicity and ease of use. It aims to provide secure encryption without the complexities associated with tools like GPG. Some features of age are:

- User-friendly: age is designed with simplicity in mind, making it accessible for users who may not be familiar with cryptography.
- Asymmetric and symmetric encryption: age supports both public-key encryption using X25519 key pairs and passphrase-based encryption using scrypt.
- Streamable and seekable: age can handle large files efficiently, as it splits files into smaller chunks and encrypts them individually, allowing for streaming and seeking.

### Comparison

- Complexity: SSH and GPG can be complex and challenging to configure correctly, while age is designed with simplicity in mind.
- Use cases: SSH is primarily focused on secure remote access and communication, GPG is widely used for email and file encryption, and age is tailored for file encryption.
- Encryption and authentication: SSH provides strong encryption and public-key authentication, GPG supports asymmetric encryption, and digital signatures, while age offers both asymmetric and symmetric encryption.
- Key management: GPG has a more comprehensive key management system with its web of trust, while age relies on simpler key distribution methods.

### Conclusion

SSH, GPG, and age are all powerful encryption and authentication tools, each with its unique strengths and use cases. While SSH excels in secure remote communication and administration, GPG is an excellent choice for email and file encryption with a robust key management system. On the other hand, age provides a user-friendly and efficient file encryption solution without the complexities associated with GPG. By understanding the features and limitations of each tool, you can make an informed decision about which tool best meets your security needs.

## Using SSH, GPG, and AGE: A Practical Guide

In this section, we will explore how to use SSH, GPG, and AGE for common tasks, such as secure communication, file encryption, and authentication.

### Using SSH

a) Generate an SSH key pair: Before using SSH, you need to generate a key pair (public and private keys). Open a terminal and run the following command:

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```

This will create an Ed25519 key pair, storing the private key in `~/.ssh/id_ed25519` and the public key in `~/.ssh/id_ed25519.pub`.

b) Copy the public key to the remote server: To enable public-key authentication, copy your public key to the remote server using the `ssh-copy-id` command:

```bash
ssh-copy-id user@remote_server
```

c) Connect to the remote server: Now, you can connect to the remote server securely using SSH:

```bash
ssh user@remote_server
```

### Using GPG

a) Generate a GPG key pair: First, generate a GPG key pair by running the following command:

```bash
gpg --full-generate-key
```

Follow the prompts to create a key pair with your desired parameters.

b) Encrypt a file: To encrypt a file using the recipient's public key, run the following command:

```bash
gpg --encrypt --recipient recipient@example.com input_file.txt
```

This will create an encrypted file named `input_file.txt.gpg`.

c) Decrypt a file: To decrypt a file encrypted with your public key, run the following command:

```bash
gpg --decrypt --output output_file.txt input_file.txt.gpg
```

### Using AGE

a) Generate an AGE key pair: First, generate an AGE key pair by running the following command:

```bash
Copy codeage-keygen -o age_key
```

This will create an X25519 key pair, with the private key and public key stored in the `age_key` file.

b) Encrypt a file using a public key: To encrypt a file using the recipient's public key, run the following command:

```bash
age -r "age1xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" input_file.txt -o input_file.txt.age
```

Replace the recipient's public key inside the quotes with the appropriate value. This will create an encrypted file named `input_file.txt.age`.

c) Decrypt a file using a private key: To decrypt a file encrypted with your public key, run the following command:

```bash
age -d -i age_key input_file.txt.age -o output_file.txt
```

Replace `age_key` with the path to your private key file.

These examples provide a basic understanding of how to use SSH, GPG, and AGE for secure communication, file encryption, and authentication. Each tool has additional features and options that can be explored in their respective documentation to further enhance your security and privacy.

## SSH in Git and GitHub Operations

Secure Shell (SSH) is a cryptographic network protocol used to securely access and manage network devices and servers over an unsecured network. In the context of Git and GitHub operations, SSH is used to authenticate and establish secure connections between a local machine and a remote Git repository hosted on a platform like GitHub, GitLab, or Bitbucket. This section will discuss the importance of SSH in Git and GitHub operations and guide you through the process of setting up and using SSH for secure Git operations.

### A. Importance of SSH in Git and GitHub Operations

SSH provides several benefits for Git and GitHub operations, including:

1.  **Security**: SSH encrypts the communication between the local machine and the remote repository, protecting sensitive data and ensuring that the connection remains secure even on unsecured networks.
2.  **Authentication**: SSH enables the use of public-key authentication, which is a stronger and more convenient method of authentication compared to using a username and password.
3.  **Ease of use**: Once the SSH keys are set up, users can perform Git operations without entering their credentials repeatedly, streamlining the development workflow.

### B. Setting Up SSH for Git and GitHub Operations

To set up SSH for Git and GitHub operations, follow these steps:

1.  **Generate an SSH key pair**: On your local machine, use the `ssh-keygen` command to generate an SSH key pair, consisting of a public key and a private key. The public key will be shared with the remote Git repository, while the private key should be kept secure and confidential on your local machine.

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```

2.  **Add the public key to your GitHub account**: Log in to your GitHub account, go to Settings > SSH and GPG keys, and click on the "New SSH key" button. Provide a title for the key and paste the content of the public key file (typically named `id_ed25519.pub`) into the "Key" field. Save the new SSH key.
3.  **Test the SSH connection**: To verify that the SSH key has been correctly set up, run the following command:

```bash
ssh -T git@github.com
```

If the connection is successful, you will receive a message indicating that you have successfully authenticated with GitHub.

### C. Using SSH for Git and GitHub Operations

Once SSH is set up, you can use it to perform secure Git operations with the remote repository. When cloning a new repository or adding a remote repository to an existing local Git repository, use the SSH URL instead of the HTTPS URL.

For example, when cloning a repository:

```bash
git clone git@github.com:username/repository.git
```

By using the SSH URL, you can securely push, pull, and fetch changes between your local machine and the remote repository without entering your credentials every time.

### D. SSH Signing

SSH signing is a feature that allows you to sign your Git commits and tags using your SSH key instead of using a GPG key. This can be useful if you already have an SSH key set up and don't want to manage a separate GPG key for signing. It is important to note that this feature is currently supported by GitHub and may not be available on other Git hosting platforms.

The process of setting up SSH signing is similar to setting up SSH for Git and GitHub operations. Here's how you can enable SSH signing for your Git commits and tags:

1.  **Enable SSH signing in your GitHub account**: Log in to your GitHub account, go to Settings > SSH and GPG keys. Ensure that the public key you want to use for signing is added to your account. Then, click on the "Enable SSH signing" button next to the SSH key you want to use for signing.
2.  **Configure Git to use SSH signing**: On your local machine, run the following Git commands to configure your Git client to use SSH signing with your SSH key:

```bash
git config --global user.signingkey key_id
git config --global commit.gpgsign true
```

Replace `key_id` with the fingerprint of the SSH key you want to use for signing. This can be found in the details of the SSH key in your GitHub account settings.

3.  **Sign Git commits and tags**: With SSH signing enabled, you can now sign your Git commits and tags using your SSH key. When creating a new commit or tag, use the `-S` option to sign it:

```bash
git commit -S -m "Your commit message"
git tag -s v1.0.0 -m "Your tag message"
```

These commands will create a signed commit or tag using your SSH key. The signature will be verified by GitHub when you push the commit or tag to the remote repository.

In summary, SSH signing is an alternative method to GPG signing for Git commits and tags that allows you to use your SSH key for signing purposes. This can be a convenient option if you already have an SSH key set up for Git and GitHub operations and want to simplify your key management. However, keep in mind that SSH signing support may vary across different Git hosting platforms.

## Helper Scripts

There are a few helper scripts that can be used to make the process of setting up and using SSH, GPG, and AGE easier. These scripts are installed in the process of setting up `dotfiles` and can be found in the `.local/bin` directory.

### `dotfiles-setup-ssh`

The `dotfiles-setup-ssh` script is a utility for setting up SSH keys, configuring git for GPG signing, and managing SSH-related files. Before running the script, ensure that it is executable and located in a directory included in your PATH variable.

To use the script, simply run the following command:

```bash
dotfiles-setup-ssh
```

The script performs the following actions:

1. Creates the `${SSH_HOME}` directory if it does not exist.
2. Generates an SSH key with the specified algorithm and email if `${SSH_KEY_FILE}` does not exist; otherwise, changes the SSH key file permissions to `600`.
3. Copies the SSH config file to `${SSH_CONFIG_FILE}` if it does not exist.
4. Copies the gitconfig file to the `.gitconfig` file in the home directory.
5. Adds the SSH key to the `allowed_signers` and `authorized_keys` files, and configures git for GPG signing using the SSH key.
6. For macOS, adds the SSH key to the macOS keychain.
7. Refreshes the `ssh-agent` to load new keys if the `ssh-agent` command is available.

Note: Before running the script, make sure you have the necessary dependencies and configurations in place.

### `dotfiles-setup-age`

The `dotfiles-setup-age` script is a utility for setting up the Age encryption tool, generating Age keys, and managing Age-related files. Before running the script, ensure that it is executable and located in a directory included in your PATH variable (e.g., `${HOME}/.local/bin`).

To use the script, simply run the following command:

```
dotfiles-setup-age
```

The script performs the following actions:

1. Ensures that `${HOME}/.local/bin`, `${GOROOT}/bin`, and `${GOPATH}/bin` are included in the PATH variable.
2. Creates the `${SSH_HOME}` directory if it does not exist.
3. Generates an Age key using `age-keygen` if `${AGE_KEY_FILE}` does not exist.
4. Adds the Age key (AGE_RECIPIENT) to the `authorized_age_keys` file, or creates the file with the key if it does not exist.

Note: Before running the script, make sure you have the Age encryption tool installed. If it is not installed, the script will prompt you to install it manually.

### `dotfiles-setup-gpg [OPTION]`

The `dotfiles-setup-gpg` script is a utility for setting up and managing GPG keys, as well as exporting GPG public and private keys. Before running the script, ensure that it is executable and located in a directory included in your PATH variable (e.g., `${HOME}/.local/bin`).

To use the script, simply run the following command:

```
dotfiles-setup-gpg
```

Optionally, you can use the `--interactive` or `-i` flag to run the script in interactive mode:

```
dotfiles-setup-gpg --interactive
```

The script performs the following actions:

1. Determines if the script should run in interactive mode based on the provided flag.
2. Sets the necessary environment variables and exports them.
3. Creates the `${SSH_HOME}` directory if it does not exist.
4. Checks if the GPG public key and private key are valid and imported. If not, it imports them.
5. Generates a new GPG key if none exists, exports the public and private keys, and saves them to respective files.
6. Saves the GPG key ID to a file if it's different or if the file doesn't exist.
7. (Optional) Adds the GPG key to the Git configuration and enables commit signing if the `GPGSIGN` variable is set to "true".

Note: Before running the script, make sure you have the GPG encryption tool installed.

### `github-auth [OPTION]`

The `github-auth` script is a utility for logging in to GitHub and configuring Git authentication using the GitHub CLI (`gh`). Before running the script, ensure that it is executable and located in a directory included in your PATH variable (e.g., `${HOME}/.local/bin`).

To use the script, simply run the following command:

```
github-auth
```

Optionally, you can use the `--interactive` or `-i` flag to run the script in interactive mode:

```
github-auth --interactive
```

The script performs the following actions:

1. Determines if the script should run in interactive mode based on the provided flag.
2. Checks if the `GITHUB_USERNAME` environment variable is set. If not, it skips the GitHub authentication process.
3. Checks if the `gh` (GitHub CLI) command is installed. If not, it skips the GitHub authentication process.
4. Configures the Git protocol to use HTTPS for GitHub.
5. If in interactive mode, logs in to GitHub using `gh auth login`. If not in interactive mode, logs in using the provided `GITHUB_TOKEN` environment variable.

Note: Before running the script, make sure you have the GitHub CLI (`gh`) installed. To install it, follow the instructions at https://github.com/cli/cli#installation.

### `dotfiles-setup-github-keys`

The `dotfiles-setup-github-keys` script is a utility for adding your SSH and GPG keys to your GitHub account, assuming you have already authenticated using the `gh` (GitHub CLI) tool. Before running the script, ensure that it is executable and located in a directory included in your PATH variable (e.g., `${HOME}/.local/bin`).

To use the script, simply run the following command:

```bash
dotfiles-setup-github-keys
```

The script performs the following actions:

1. Checks if the `GITHUB_USERNAME` environment variable is set. If not, it skips the GitHub authentication process.
2. Checks if the `gh` (GitHub CLI) command is installed and if you are authenticated to GitHub.
3. If authenticated, it attempts to add your SSH key to your GitHub account, if not already added.
4. If your GPG public key file exists, it provides instructions for manually adding your GPG key to your GitHub account, as the GitHub CLI does not currently support this functionality.

Note: Before running the script, make sure you have the GitHub CLI (`gh`) installed and authenticated. To install it, follow the instructions at https://github.com/cli/cli#installation, and to authenticate, use the `github-auth` script described in a previous section or refer to the `gh` documentation.
