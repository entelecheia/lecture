# Dotfiles

```{image} ../figs/mlops/dotfiles/dotfiles-logo.png
:alt: dotfiles-logo
:class: bg-primary mb-1
:width: 50%
:align: center
```

Dotfiles are configuration files that are used to customize your shell and other applications. Dotfiles are a great way to standardize your development environment. You can use the same dotfiles in your local development environment, in your CI/CD pipeline, and in your production environment.

## Dotfiles in a GitOps workflow

Dotfiles management is not a core component of GitOps; however, it can complement the GitOps approach by applying similar principles of version control, collaboration, and automation to managing personal configurations and settings.

In a GitOps workflow, Git is used as the single source of truth for managing infrastructure and application configurations. Dotfiles, on the other hand, are configuration files for various tools, applications, and environments, typically used to personalize a user's system.

Although dotfiles management is not directly related to the GitOps process, it can benefit from some of the best practices that GitOps promotes:

- Version Control: By storing dotfiles in a Git repository, you can track changes, create backups, and easily restore previous versions if needed. This is similar to how GitOps uses Git as the single source of truth for managing infrastructure and application configurations.

- Collaboration: Storing dotfiles in a Git repository enables sharing and collaboration with others, which allows you to learn from others' configurations and apply best practices. In a similar vein, GitOps leverages Git's collaboration features for managing infrastructure and applications.

- Automation: You can use scripts or tools to automate the setup and management of your dotfiles, making it easier to replicate your environment across multiple systems or when setting up a new machine. GitOps also emphasizes automation in synchronizing the desired state with the actual state of your infrastructure and applications.

- Organization and Modularity: Organizing your dotfiles in a structured and modular way makes it easier to manage, maintain, and understand your configurations. This mirrors the GitOps approach, which emphasizes the use of declarative and modular configurations for infrastructure and applications.

While dotfiles management is focused on personalizing user environments and tool configurations, the principles of version control, collaboration, automation, and organization can be applied in a similar manner as GitOps. This allows users to manage their dotfiles more efficiently and consistently across multiple systems.

## Tools for Dotfiles Management

Dotfiles are configuration files used to personalize and set up a user's environment in Unix-based systems. These files typically start with a dot (.) and are hidden by default in the file explorer. Managing dotfiles is important for maintaining a consistent and portable configuration across multiple machines or users. There are several tools available for managing dotfiles:

### Version control systems:

- **Git**: Git is the most popular version control system and can be used to manage and version your dotfiles. By storing your dotfiles in a Git repository, you can easily synchronize, backup, and share your configurations across multiple machines.

### Dotfiles managers:

- **GNU Stow**: GNU Stow is a symlink manager that can be used to manage dotfiles by organizing them in a central location and creating symlinks to the appropriate locations in the home directory. This makes it easy to keep dotfiles organized and version-controlled.
- **yadm** (Yet Another Dotfiles Manager): yadm is a dotfiles manager built on top of Git that offers additional features like encryption, bootstrapping, and profiles for managing different configurations.
- **chezmoi**: chezmoi is another dotfiles manager that uses a Git-based approach and offers features like templating, secret management, and support for multiple platforms.
- **dotdrop**: dotdrop is a dotfiles manager that uses YAML files to define dotfiles and their destinations. It can be used to manage dotfiles across multiple machines and platforms.

### Synchronization tools:

- **rsync**: rsync is a popular file synchronization tool that can be used to synchronize dotfiles across multiple machines. With rsync, you can ensure that your dotfiles are always up-to-date on all your systems.
- **Unison**: Unison is another file synchronization tool that offers two-way synchronization between different machines. It can be used to synchronize dotfiles and maintain a consistent configuration across multiple environments.

### Configuration frameworks:

- **Oh My Zsh**: Oh My Zsh is a framework for managing Zsh configurations, including themes and plugins. It simplifies the process of customizing and extending the Zsh shell, which is often part of dotfiles management.
- **Oh My Fish**: Oh My Fish is a similar framework to Oh My Zsh but for the Fish shell. It provides a way to manage Fish configurations, themes, and plugins.

### Backup and sharing tools:

- **Dropbox, Google Drive, or other cloud storage services**: You can store your dotfiles in a cloud storage service to easily backup and sync them across multiple machines. This method may require manual intervention to set up symlinks or copy the files to the correct locations.

When selecting tools for dotfiles management, consider your specific needs, such as ease of use, platform support, and integration with other tools or services. Additionally, make sure to keep your dotfiles organized and version-controlled to simplify synchronization and sharing with other users or machines.

## Dotfiles in Practice

[![version-image]][release-url]
[![release-date-image]][release-url]
[![test-image]][test-url]
[![license-image]][license-url]

<!-- Links: -->

[test-image]: https://github.com/entelecheia/dotfiles/actions/workflows/test.yaml/badge.svg
[test-url]: https://github.com/entelecheia/dotfiles/actions/workflows/test.yaml
[license-image]: https://img.shields.io/github/license/entelecheia/dotfiles
[license-url]: https://github.com/entelecheia/dotfiles/blob/main/LICENSE
[version-image]: https://img.shields.io/github/v/release/entelecheia/dotfiles?sort=semver
[release-date-image]: https://img.shields.io/github/release-date/entelecheia/dotfiles
[release-url]: https://github.com/entelecheia/dotfiles/releases
[conventional-commits-image]: https://img.shields.io/badge/Conventional%20Commits-1.0.0-%23FE5196?logo=conventionalcommits&logoColor=white
[conventional commits]: https://conventionalcommits.org
[repo-url]: https://github.com/entelecheia/dotfiles
[pypi-url]: https://pypi.org/project/dotfiles
[docs-url]: https://dotfiles.entelecheia.cc
[changelog]: https://github.com/entelecheia/dotfiles/blob/main/CHANGELOG.md
[contributing guidelines]: https://github.com/entelecheia/dotfiles/blob/main/CONTRIBUTING.md

<!-- Links: -->

- Documentation: [https://dotfiles.entelecheia.cc][docs-url]
- GitHub: [https://github.com/entelecheia/dotfiles][repo-url]

### Install dotfiles

You can use the [install dotfiles script](https://dotfiles.entelecheia.cc/install) to install the dotfiles on any machine with a single command. Simply run the following command in your terminal:

```bash
sh -c "$(wget -qO- https://dotfiles.entelecheia.cc/install)"
```

> 💡 For most Ubuntu-based distributions, `wget` is already installed. If you want to use `curl` instead:
>
> ```bash
>  sh -c "$(curl -fsSL https://dotfiles.entelecheia.cc/install)"
> ```

![install dotfiles script](https://github.com/entelecheia/dotfiles/blob/main/docs/figs/install_dotfiles_script.png?raw=true)

For unattended installations such as in a dockerfile, you can use the environment variables to initialize the dotfiles automatically. For example:

```dockerfile
# install dotfiles
ARG USER_FULLNAME="John Doe"
ARG USER_EMAIL="john.doe@email.com"
ARG GITHUB_USERNAME="john-doe"
ARG SYSTEM_HOSTNANE="devcon-arm64"

ENV USER_FULLNAME=$USER_FULLNAME
ENV USER_EMAIL=$USER_EMAIL
ENV GITHUB_USERNAME=$GITHUB_USERNAME
ENV SYSTEM_HOSTNAME=$SYSTEM_HOSTNAME
ENV WORKSPACE_LOCATION="/"
ENV DOTFILES_APPLY_ROOTMOI=0
ENV REMOTE_CONTAINERS=1

RUN sh -c "$(wget -qO- https://dotfiles.entelecheia.cc/install)"

CMD ["zsh"]
```

Or you can provide the environment variables in the command line:

```bash
USER_FULLNAME="John Doe" \
USER_EMAIL="john.doe@email.com" \
GITHUB_USERNAME="john-doe" \
SYSTEM_HOSTNAME="devcon-arm64" \
WORKSPACE_LOCATION="/" \
DOTFILES_APPLY_ROOTMOI=0 \
REMOTE_CONTAINERS=1 \
sh -c "$(wget -qO- https://dotfiles.entelecheia.cc/install)"
```

### Initialize dotfiles

When installing the dotfiles, initialization starts automatically. If you want to initialize the dotfiles manually, you can run the following command:

```bash
chezmoi init --apply
```

![initialize dotfiles](https://github.com/entelecheia/dotfiles/blob/main/docs/figs/initialize_dotfiles.png?raw=true)

### Repositories and repository templates for setting up your own dotfiles

- [dockerfiles](https://github.com/entelecheia/dockerfiles)
- [dotdrop-files](https://github.com/entelecheia/dotdrop-files)
- [password-store](https://github.com/entelecheia/password-store)
- [passage-store](https://github.com/entelecheia/passage-store)

### Installing the font on **Windows**

1. [Download Fira Code Regular Nerd Font Complete](https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/FiraCode/Regular/complete/Fira%20Code%20Regular%20Nerd%20Font%20Complete.ttf).
2. Open the downloaded file and click **Install**.
3. Restart **Windows Terminal** or **VS Code**.

### Configuring the font in **VS Code**

1. Open settings by pressing <kbd>Ctrl/Cmd</kbd>+<kbd>,</kbd>.
2. Change the font family to **FiraCode Nerd Font** in **_Terminal › Integrated: Font Family_**.

### Configuring the font in **Windows Terminal**

1. On **Windows Terminal**, press <kbd>Ctrl</kbd>+<kbd>,</kbd> to open the settings.
2. Go to **_Profiles -> Defaults_** in the left panel. Then, go to **_Additional settings -> Appearance_**.
3. At **_Text -> Font face_**, enable the **_Show all fonts_** option and select **_FiraCode Nerd Font_**. Like below:

## References

- [chezmoi](https://chezmoi.io)
- [dotdrop](https://github.com/deadc0de6/dotdrop)
- [dotfiles](https://dotfiles.github.io/)
- [git-secret](https://git-secret.io/)
- [Use git-secret to encrypt secrets](https://www.pascallandau.com/blog/git-secret-encrypt-repository-docker/#git-secret-installation)
- [Secrets at the Command Line](https://blog.gitguardian.com/secrets-at-the-command-line/)
- [Using Command-Line Passphrase Input for GPG with Git](https://betakuang.medium.com/using-command-line-passphrase-input-for-gpg-with-git-for-windows-f78ae2c7cd2e)
- [Using SOPS with Age and Git like a Pro](https://devops.datenkollektiv.de/using-sops-with-age-and-git-like-a-pro.html)
- [Goodbye Sealed Secrets, hello SOPS](https://itnext.io/goodbye-sealed-secrets-hello-sops-3ee6a92662bb)
- [Signing Git Commits with Your SSH Key](https://calebhearth.com/sign-git-with-ssh#:%7E:text=configured%20signing%20correctly.-,Verifying,-Git%20also%20lets)
- [Backup to Backblaze B2 using restic and rclone](https://jdheyburn.co.uk/blog/backup-to-backblaze-b2-using-restic-and-rclone/)
- [Set up your new machine in a blink of an eye](https://dev.to/vvidovic/set-up-your-new-machine-in-a-blink-of-an-eye-43j7)
- [AGE AND AUTHENTICATED ENCRYPTION](https://words.filippo.io/dispatches/age-authentication/)
- [How I Use Restic to Back up My Home Folders to Backblaze B2](https://www.seanh.cc/2022/04/03/restic/#3-install-pass)
