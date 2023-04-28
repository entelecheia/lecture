# Unix Password Managers

**`pass` and `passage` - Unix Password Managers**

## Introduction

`pass` is a simple yet powerful password manager for Unix-based systems that leverages the robustness and security of GnuPG (GNU Privacy Guard) to encrypt and manage passwords. `passage` is a fork of `pass` that replaces GnuPG with `age` ([https://age-encryption.org](https://age-encryption.org)) as its backend encryption tool. This lecture note will introduce both `pass` and 'passage,' discuss their installation and usage, provide examples to help you better understand the tools, and explain the differences between them.

## Installation

### Installing `pass`

For Debian/Ubuntu:

```bash
sudo apt-get install pass
```

For MacOS (with Homebrew):

```bash
brew install pass
```

### Installing `age` and `rage`

`age`:

```basgh
go get -u github.com/FiloSottile/age/cmd/age

```

`rage`:

```bash
cargo install rage
```

### Installing 'age-plugin-yubikey'

```bash
cargo install age-plugin-yubikey
```

## Initialization

### Initializing `pass`

Create a GPG key (if you do not have one):

```bash
gpg --gen-key
```

Initialize `pass` with the key's ID:

```basg
pass init <GPG-key-ID>
```

### Initializing `passage`

#### Simple Setup

Save the key on disk:

```bash
age-keygen >> $HOME/.passage/identities
```

#### Setup with Password-Protected Key

Use the identity file password as the primary password to unlock the store:

```bash
KEY="$(age-keygen)"
echo "$KEY" | age -p -a >> $HOME/.passage/identities
echo "$KEY" | age-keygen -y >> $HOME/.passage/store/.age-recipients
```

#### Setup with age-plugin-yubikey

Requires age v1.1.0 or rage ([https://github.com/str4d/rage](https://github.com/str4d/rage)), and the PIV plugin age-plugin-yubikey ([https://github.com/str4d/age-plugin-yubikey](https://github.com/str4d/age-plugin-yubikey)). Add more YubiKeys or age keys to the `.age-recipients` file as recovery options.

```
bashage-plugin-yubikey # run interactive setup
age-plugin-yubikey --identity >> $HOME/.passage/identities
age-plugin-yubikey --list >> $HOME/.passage/store/.age-recipients

```

## Usage

### Adding Passwords

`pass`:

```bash
pass insert <entry-name>
```

`passage`:

```bash
passage insert <entry-name>
```

### Generating Passwords

`pass`:

```bash
pass generate <entry-name> <password-length>
```

`passage`:

```bash
passage generate <entry-name> <password-length>
```

### Retrieving Passwords

`pass`:

```bash
pass show <entry-name>
```

`passage`:

```bash
passage show <entry-name>
```

### Updating Passwords

`pass`:

```bash
pass edit <entry-name>
```

`passage`:

```bash
passage edit <entry-name>
```

4.5. Deleting Passwords

`pass`:

```bash
pass rm <entry-name>
```

`passage`:

```bash
passage rm <entry-name>
```

## Differences between `pass` and `passage`

- Default password store location: `$HOME/.passage/store` for `passage` and `$HOME/.password-store` for `pass`.
- Encryption backend: `passage` uses `age` encryption, while `pass` uses GnuPG.
- Decryption: `passage` uses Age identities at `$HOME/.passage/identities` with the `-i age` CLI option, while `pass` uses GPG keys.
- Encryption: `passage` uses the nearest `.age-recipients` file with the `-R age` CLI option or the identities file with the `-i` option. `pass` uses GPG recipient keys.
- Extensions: Stored in `$HOME/.passage/extensions` for `passage` and `$HOME/.password-store/.extensions` for `pass`. Extensions compatible with both tools can switch on the `PASSAGE` variable.
- Init command: Not available in 'passage,' but present in 'pass.'
- Moving/Copying secrets: Always re-encrypts the secret in 'passage,' while `pass` keeps the original encryption.

## Additional Features

### Integrating with fzf

This script invokes `passage` with any (or no) flags and spawns a fuzzy search dialog using fzf ([https://github.com/junegunn/fzf](https://github.com/junegunn/fzf)) for selecting the secret.

```bash
#! /usr/bin/env bash
set -eou pipefail
PREFIX="${PASSAGE_DIR:-$HOME/.passage/store}"
FZF_DEFAULT_OPTS=""
name="$(find "$PREFIX" -type f -name '*.age' | \
  sed -e "s|$PREFIX/||" -e 's|\.age$||' | \
  fzf --height 40% --reverse --no-multi)"
passage "${@}" "$name"

```

### Migrating from `pass` to `passage`

This script migrates your secrets from `pass` to 'passage.'

```bash
#! /usr/bin/env bash
set -eou pipefail
cd "${PASSWORD_STORE_DIR:-$HOME/.password-store}"
while read -r -d "" passfile; do
  name="${passfile#./}"; name="${name%.gpg}"
  [[ -f "${PASSAGE_DIR:-$HOME/.passage/store}/$name.age" ]] && continue
  pass "$name" | passage insert -m "$name" || { passage rm "$name"; break; }
done < <(find . -path '*/.git' -prune -o -iname '*.gpg' -print0)

```

## Conclusion

`pass` and `passage` are secure password managers for Unix-based systems, with `pass` using GnuPG encryption and `passage` using `age` encryption. By understanding their differences and following the examples provided, you can set up and manage your password store with either tool. The integration with fzf and the migration script from `pass` to `passage` make it easy to transition and enhance your password management experience.

## Helper Scripts

There are a few helper scripts that can be used to make `pass` and `passage` more convenient to use. These scripts are installed in the process of setting up `dotfiles` and can be found in the `.local/bin` directory.

### `pass-clone`

The `pass-clone` script is a simple utility to clone or update the `pass` and `passage` repositories, which are used for managing password-store and passage directories, respectively.

Before running the script, ensure that it is executable and located in a directory included in your PATH variable.

To use the script, simply run the following command:

```bash
pass-clone
```

The script will perform the following actions:

1. If the `pass` feature is enabled: a. Check if the password-store directory exists. b. If it exists, prompt the user to remove the existing directory. c. If the user confirms, remove the directory. d. Clone the `pass` repository to the password-store directory.
2. If the `passage` feature is enabled: a. Check if the passage directory exists. b. If it exists, prompt the user to remove the existing directory. c. If the user confirms, remove the directory. d. Clone the `passage` repository to the passage directory.

Note: For private repositories, GitHub authentication is required to clone or update them.

### `pass-init`

The `pass-init` script is a utility for initializing and configuring the `pass` password manager. It sets up the necessary environment variables, initializes the `pass` storage directory, and configures the remote Git repository for synchronization.

Before running the script, ensure that it is executable and located in a directory included in your PATH variable.

To use the script, simply run the following command:

```bash
pass-init
```

The script will perform the following actions:

1.  Check if the password-store directory and the `.gpg-id` file exist.
2.  If the `.gpg-id` file doesn't exist or the `PASSWORD_STORE_KEY` environment variable is different from the one in the `.gpg-id` file, initialize or reinitialize `pass`.
3.  If the Git repository is not initialized in the password-store directory, initialize it.
4.  If the remote Git repository is not set, set it to the `PASS_REPO` environment variable.
5.  If GitHub authentication is available, fetch and checkout the main branch, set the upstream, and pull the changes.

Note: Before running the script, ensure you have generated a GPG key and set the `PASSWORD_STORE_KEY` environment variable. Additionally, set the `PASS_REPO` environment variable to the remote pass repository URL. For private repositories, GitHub authentication is required.

### `passage-init`

The `passage-init` script is a utility for initializing and configuring the `passage` password manager. It ensures `passage` is installed, sets up the necessary environment variables, initializes the `passage` storage directory, and configures the remote Git repository for synchronization.

Before running the script, ensure that it is executable and located in a directory included in your PATH variable.

To use the script, simply run the following command:

```
passage-init
```

The script will perform the following actions:

1. Check if `passage` is installed; if not, clone the `PASSAGE_SHARE_REPO` and install `passage`.
2. Check if the `AGE_KEY_FILE` exists; if not, prompt the user to generate an age key using `age-keygen`.
3. If the `PASSAGE_DIR` directory doesn't exist, create it.
4. If the Git repository is not initialized in the `PASSAGE_DIR`, initialize it.
5. If the remote Git repository is not set, set it to the `PASSAGE_REPO` environment variable.
6. If GitHub authentication is available, fetch and checkout the main branch, set the upstream, and pull the changes.

Note: Before running the script, ensure you have generated an age key and set the `AGE_KEY_FILE` environment variable. Additionally, set the `PASSAGE_REPO` environment variable to the remote passage repository URL. For private repositories, GitHub authentication is required.

### `pass-insert`

The `pass-insert` script is a utility for inserting or updating passwords in both `pass` and `passage` password managers. It checks whether the specified password entry exists in each manager, and if not, it inserts the provided password or prompts the user to enter one. If the entry exists, it updates the password if the provided password is different from the existing one.

Before running the script, ensure that it is executable and located in a directory included in your PATH variable.

To use the script, run the following command:

```
pass-insert pass-name [password]
```

Arguments:

- `pass-name`: The name of the password entry (required).
- `password`: The password to insert or update (optional).

The script performs the following actions:

1. Checks if `pass` and `passage` are installed and initialized.
2. If `pass` is installed and initialized, it checks whether the specified `pass-name` exists in the password store.
   - If the entry exists and the provided password is different, it updates the password.
   - If the entry doesn't exist, it inserts the provided password or prompts the user to enter one.
3. If `passage` is installed and initialized, it checks whether the specified `pass-name` exists in the passage store.
   - If the entry exists and the provided password is different, it updates the password.
   - If the entry doesn't exist, it inserts the provided password or prompts the user to enter one.

Note: Ensure that both `pass` and `passage` are installed and initialized before using the script. Also, set the `AGE_KEY_FILE` environment variable to the age key file path.

### `pass-rm`

The `pass-rm` script is a utility for removing password entries from both `pass` and `passage` password managers. It checks whether the specified password entry exists in each manager, and if so, it removes the entry according to the provided options.

Before running the script, ensure that it is executable and located in a directory included in your PATH variable.

To use the script, run the following command:

```bash
pass-rm [--recursive,-r] [--force,-f] pass-name
```

Arguments:

- `--recursive, -r`: Optional flag to remove a directory and its contents recursively.
- `--force, -f`: Optional flag to force the removal without confirmation.
- `pass-name`: The name of the password entry to remove (required).

The script performs the following actions:

1. Parses options and extracts the `pass-name`.
2. Checks if `pass` and `passage` are installed.
3. If `pass` is installed, it checks whether the specified `pass-name` exists in the password store.
   - If the entry exists, it removes the entry according to the provided options.
   - If the entry doesn't exist, it logs an information message.
4. If `passage` is installed, it checks whether the specified `pass-name` exists in the passage store.
   - If the entry exists, it removes the entry according to the provided options.
   - If the entry doesn't exist, it logs an information message.

Note: Ensure that both `pass` and `passage` are installed before using the script.

### `pass-pull`

The `pass-pull` script is a utility for pulling changes from remote repositories for both `pass` and `passage` password managers. It checks whether the password managers are initialized and have remote repositories set, and if so, it pulls the changes from the remote repositories.

Before running the script, ensure that it is executable and located in a directory included in your PATH variable.

To use the script, simply run the following command:

```
pass-pull
```

The script performs the following actions:

1. Checks if GitHub is authenticated. If not, it logs an information message and exits.
2. Checks if the `PASSWORD_STORE_DIR` is set and has a `.gpg-id` file for `pass`.
   - If the directory exists and has a remote repository set, it pulls changes from the remote repository.
   - If the directory doesn't exist or the remote is not set, it logs an information message.
3. Checks if the `PASSAGE_DIR` is set and has the `AGE_KEY_FILE` for `passage`.
   - If the directory exists and has a remote repository set, it pulls changes from the remote repository.
   - If the directory doesn't exist or the remote is not set, it logs an information message.

Note: Ensure that you have authenticated with GitHub and both `pass` and `passage` are initialized before using the script.

### `pass-push`

The `pass-push` script is a utility for committing and pushing changes to remote repositories for both `pass` and `passage` password managers. It checks whether the password managers are initialized and have remote repositories set, and if so, it commits and pushes the changes to the remote repositories.

Before running the script, ensure that it is executable and located in a directory included in your PATH variable.

To use the script, simply run the following command:

```
pass-push
```

The script performs the following actions:

1. Checks if the `PASSWORD_STORE_DIR` is set and has a `.gpg-id` file for `pass`.
   - If the directory exists and has a remote repository set, it commits changes and pushes them to the remote repository.
   - If the directory doesn't exist or the remote is not set, it logs an information message.
2. Checks if the `PASSAGE_DIR` is set and has the `AGE_KEY_FILE` for `passage`.
   - If the directory exists and has a remote repository set, it commits changes and pushes them to the remote repository.
   - If the directory doesn't exist or the remote is not set, it logs an information message.

Note: Ensure that both `pass` and `passage` are initialized before using the script.

### `pass-sync`

The `pass-sync` script is a utility for synchronizing passwords between the `pass` and `passage` password managers. It checks whether both password managers are initialized and then performs a bidirectional sync between them.

Before running the script, ensure that it is executable and located in a directory included in your PATH variable.

To use the script, simply run the following command:

```
pass-sync
```

The script performs the following actions:

1. Checks if the `PASSWORD_STORE_DIR` is set and has a `.gpg-id` file for `pass`. If not, it logs an information message and exits.
2. Checks if the `PASSAGE_DIR` is set and has the `AGE_KEY_FILE` for `passage`. If not, it logs an information message and exits.
3. Syncs from `pass` to `passage`:
   - Iterates through all password entries in the `pass` password store.
   - If an entry does not exist in the `passage` store, it inserts the entry into the `passage` store.
4. Syncs from `passage` to `pass`:
   - Iterates through all password entries in the `passage` password store.
   - If an entry does not exist in the `pass` store, it inserts the entry into the `pass` store.

Note: Ensure that both `pass` and `passage` are initialized before using the script.
