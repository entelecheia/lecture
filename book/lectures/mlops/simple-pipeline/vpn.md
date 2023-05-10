# VPN Connectivity

A Virtual Private Network (VPN) is a secure and encrypted communication tunnel between your device and a private network. VPNs provide a layer of security and privacy to your internet connection by encrypting data traffic and masking your IP address. By connecting to a VPN server, you can bypass censorship, access geo-restricted content, and protect your online activities from being monitored or intercepted.

## Using FortiClient for VPN Connectivity

FortiClient is a comprehensive security suite that includes VPN functionality. It enables users to establish a secure connection to a remote network, such as your server's network, through an encrypted tunnel. In this section, we will guide you through the process of setting up and using FortiClient to connect to your server via VPN.

### 1. Download and install FortiClient

Download the FortiClient VPN software for your operating system from the official website:

https://www.fortinet.com/support/product-downloads

Install the software by following the installation instructions specific to your operating system.

### 2. Obtain VPN connection details

Before you can connect to your server via VPN, you need to obtain the necessary connection details from your network administrator. These details may include:

- VPN server address
- VPN protocol (e.g., SSL-VPN or IPsec)
- Authentication method (e.g., username/password, certificate)
- Pre-shared key or certificate file (if applicable)

### 3. Configure FortiClient

Launch FortiClient and follow these steps to configure your VPN connection:

- Click on the padlock icon to access the VPN functionality.
- Click on the "Configure VPN" button or the "+" icon to create a new VPN connection.
- Choose the appropriate VPN type (e.g., SSL-VPN or IPsec) and click "Create."
- Enter the VPN connection details obtained in step 2.
  - Connection Name: Enter a descriptive name for the connection.
  - Remote Gateway: Enter the VPN server address.
  - Customize Port: Specify the VPN server port (if different from the default).
  - Authentication method: Choose the appropriate method (e.g., username/password, certificate).
  - Pre-shared key or certificate file: Provide the required key or certificate file (if applicable).
- Save the VPN connection settings by clicking "Save."

#### 4. Connect to the VPN

To connect to the VPN, click on the VPN connection you created in the FortiClient dashboard and click the "Connect" button. You will be prompted to enter your authentication credentials (username/password or certificate).

Once connected, all your internet traffic will be routed through the secure VPN tunnel, providing a secure connection to your server's network.

#### 5. Connect to the server via SSH

After establishing a VPN connection, you can connect to your server using SSH. Replace `USERNAME` and `SERVER_IP` with the appropriate username and server IP address or hostname:

```bash
ssh USERNAME@SERVER_IP
```

With FortiClient and VPN connectivity, your team can securely access the server and collaborate on your MLOps pipeline project.

## Conclusion

In this section, we explained the concept of a VPN and provided a guide for using FortiClient to establish a secure VPN connection to your server. By leveraging VPN technology, you can ensure that your team's communication with the server remains private and secure.
