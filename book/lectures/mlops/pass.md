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

```
bashCopy code#! /usr/bin/env bash
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

```
bashCopy code#! /usr/bin/env bash
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
