# Project Templating Tools

## Introduction

In software development, **project templating tools** (also known as [scaffolding](<https://en.wikipedia.org/wiki/Scaffold_(programming)>), project bootstrap tools, boilerplate generation, or skeletons) are essential for streamlining the process of starting new projects. They help developers adhere to structures, standards, and agreements and include mandatory files without the tedious legwork. **Cookiecutter** is one of the most popular project templating tools, but alternatives like **Yeoman** and **Copier** also offer valuable functionality.

## 1. Cookiecutter: The Industry Standard

- Easy-to-install **command-line utility** for creating project templates
- **Cross-platform** and supports multiple programming languages
- Stable, configuration-driven, with a **large and active community**
- More information can be found in the initial question

## 2. Yeoman: A New Alternative for Web Apps

- Developed for **web apps**, automates frontend and backend tasks
- Open-source, cross-platform, and based on **JavaScript**
- Offers a **scaffolding tool** (yo), package manager, and various plugins
- More information can be found in the initial question

## 3. Copier: A Newer Alternative (Main Focus)

**Copier** is a modern, open-source templating tool that can be installed as a **command-line interface** or used as a library directly in your Python code. It has three primary components: **templates**, **questionnaires**, and **projects**.

### Key Features:

- **Templates**: Define how to generate subprojects
- **Questionnaires**: Configure the template, users provide answers to generate projects
- **Projects**: Generated program from the template
- **Scaffolding**: Allows users to create a working source code tree
- Supports **local paths** and **git URL**, file uploads, and migrations

### Benefits of Copier:

- **Modern user experience**
- Allows updates for **code lifecycle management** (in some templates)
- **Configuration** from single or multiple YAML files

### Disadvantages of Copier:

- **Smaller community** and fewer templates available compared to Cookiecutter
- Under active development, meaning it is **not as stable** as Cookiecutter

## Comparison of Project Templating Tools

When choosing a project templating tool, it's important to consider their features and capabilities. Here, we compare **Copier** to two popular alternatives, **Cookiecutter** and **Yeoman**. Although Copier was initially a code scaffolding tool, it has evolved into a **code lifecycle management tool**, making it unique compared to the other options.

### Feature Comparison

| Feature                                  | Copier                                      | Cookiecutter                                | Yeoman                 |
| ---------------------------------------- | ------------------------------------------- | ------------------------------------------- | ---------------------- |
| Can template file names                  | Yes                                         | Yes                                         | Yes                    |
| Configuration                            | Single YAML file                            | Single JSON file                            | JS module              |
| Migrations                               | Yes                                         | No                                          | No                     |
| Programmed in                            | Python                                      | Python                                      | NodeJS                 |
| Requires handwriting JSON                | No                                          | Yes                                         | Yes                    |
| Requires installing templates separately | No                                          | No                                          | Yes                    |
| Requires programming                     | No                                          | No                                          | Yes, JS                |
| Requires templates to have a suffix      | Yes by default, configurable                | No, not configurable                        | You choose             |
| Task hooks                               | Yes                                         | Yes                                         | Yes                    |
| Context hooks                            | Yes                                         | Yes                                         | ?                      |
| Template in a subfolder                  | Not required, but you choose                | Yes, required                               | Yes, required          |
| Template package format                  | Git repo, Git bundle, folder                | Git or Mercurial repo, Zip file             | NPM package            |
| Template updates                         | **Yes**                                     | No                                          | No                     |
| Templating engine                        | [Jinja](https://jinja.palletsprojects.com/) | [Jinja](https://jinja.palletsprojects.com/) | [EJS](https://ejs.co/) |

### Key Differences

1. **Configuration**: Copier uses a single YAML file, while Cookiecutter uses a single JSON file, and Yeoman relies on a JavaScript module.

2. **Migrations**: Copier supports migrations, whereas Cookiecutter and Yeoman do not.

3. **Template Updates**: Copier allows template updates for Git templates, a feature not available in Cookiecutter or Yeoman.

4. **Requires Programming**: Copier and Cookiecutter do not require programming knowledge, while Yeoman requires JavaScript programming.

5. **Template Package Format**: Copier supports Git repos, Git bundles, and folders, while Cookiecutter supports Git or Mercurial repos and Zip files, and Yeoman uses NPM packages.

6. **Templating Engine**: Copier and Cookiecutter both use the Jinja templating engine, while Yeoman uses EJS.

In conclusion, **Copier** stands out due to its support for migrations, template updates, and its user-friendly configuration. It offers a modern and flexible approach to project templating, making it a strong contender for developers who need a powerful code lifecycle management tool. However, depending on your specific requirements and familiarity with other programming languages, **Cookiecutter** and **Yeoman** may still be viable options to consider.

## Usage of Copier

Copier is a versatile tool for rendering project templates, making it easy to create new projects or manage existing ones. Here's a guide on how to use Copier as both a CLI app and a library:

### Installation

1. Install Python 3.7 or newer (3.8 or newer if you're on Windows).
2. Install Git 2.27 or newer.
3. To use as a CLI app: `pipx install copier`
4. To use as a library: `pip install copier` or `conda install -c conda-forge copier`
5. To use with 100% reproducibility: `nix profile install github:copier-org/copier`

### Creating a Template

To create a template, structure your project as follows:

```
📁 my_copier_template                        # your template project
├── 📄 copier.yml                            # your template configuration
├── 📁 .git/                                 # your template is a Git repository
├── 📁 {{project_name}}                      # a folder with a templated name
│   └── 📄 {{module_name}}.py.jinja          # a file with a templated name
└── 📄 {{_copier_conf.answers_file}}.jinja   # answers are recorded here
```

Define your questions in `copier.yml` and create templated files using Jinja syntax. For example:

```
print("Hello from {{module_name}}!")
```

### Generating a Project from a Template

#### Using Copier CLI

To generate a project from a template, run the following command:

```
copier path/to/project/template path/to/destination
```

#### Using Copier as a Library

You can also generate a project programmatically using Python:

```python
from copier import run_auto

# Create a project from a local path
run_auto("path/to/project/template", "path/to/destination")

# Or from a Git URL.
run_auto("https://github.com/copier-org/copier.git", "path/to/destination")

# You can also use "gh:" as a shortcut of "https://github.com/"
run_auto("gh:copier-org/copier.git", "path/to/destination")

# Or "gl:" as a shortcut of "https://gitlab.com/"
run_auto("gl:copier-org/copier.git", "path/to/destination")
```

### Exploring Public Templates

To browse public Copier templates on GitHub, visit [the `copier-template` topic](https://github.com/topics/copier-template). Use these templates as a starting point or for inspiration! To add your own template to the list, simply tag it with the `copier-template` topic.

## Hyperfast Python Template

[![license-image]][license-url]
[![version-image]][release-url]
[![release-date-image]][release-url]
[![conventional-commits-image]][conventional commits]
[![jupyter-book-image]][jupyter book]

<!-- Links: -->

[hyperfast python template]: https://github.com/entelecheia/hyperfast-python-template
[license-image]: https://img.shields.io/github/license/entelecheia/hyperfast-python-template
[license-url]: https://github.com/entelecheia/hyperfast-python-template/blob/main/LICENSE
[version-image]: https://img.shields.io/github/v/release/entelecheia/hyperfast-python-template?sort=semver
[release-date-image]: https://img.shields.io/github/release-date/entelecheia/hyperfast-python-template
[release-url]: https://github.com/entelecheia/hyperfast-python-template/releases
[conventional-commits-image]: https://img.shields.io/badge/Conventional%20Commits-1.0.0-%23FE5196?logo=conventionalcommits&logoColor=white
[jupyter-book-image]: https://jupyterbook.org/en/stable/_images/badge.svg
[repo-url]: https://github.com/entelecheia/hyperfast-python-template
[pypi-url]: https://pypi.org/project/hyperfast-python-template
[docs-url]: https://hyperfast-python.entelecheia.cc
[changelog]: https://github.com/entelecheia/hyperfast-python-template/blob/main/CHANGELOG.md
[contributing guidelines]: https://github.com/entelecheia/hyperfast-python-template/blob/main/CONTRIBUTING.md

<!-- Links: -->

A python template that helps you jump start your project

- Documentation: [https://hyperfast-python.entelecheia.cc][docs-url]
- GitHub: [https://github.com/entelecheia/hyperfast-python-template][repo-url]
- PyPI: [https://pypi.org/project/hyperfast-python-template][pypi-url]

Hyperfast Python Template is a self-contained template that helps you initialize your Python project inside the template. It is hyperfast in the sense that the template itself is converted into a Python project in the blink of an eye. It is also hyperfast in the sense that it helps you jump start your project with the best practices in the Python community.

### Quickstart

There are two ways to use this project:

- Use [Copier] to create a project to your local machine directly
- Inject [Hyperfast Python Template] into an existing project

#### I. Use Copier

1. Install Copier
   ```bash
   pipx install copier
   ```
2. Run
   ```bash
   copier gh:entelecheia/hyperfast-python-template path/to/destination
   ```
3. Do your work

#### II. Inject the template

1. Install Copier
   ```bash
   pipx install copier
   ```
2. From the root of your project, run
   ```bash
   copier gh:entelecheia/hyperfast-python-template .
   ```
3. Do your work

### Features

- [x] Automated changelog with [Conventional Commits] and [Python Semantic Release]
- [x] Automated dependency updates with [Dependabot]
- [x] Automated semantic versioning with [Python Semantic Release]
- [x] Automated uploads to [PyPI] and [TestPyPI]
- [x] Code coverage with [Pytest-Cov]
- [x] Code formatting with [Black] and [Prettier]
- [x] Continuous integration with [GitHub Actions]
- [x] Coverage reporting with [Codecov]
- [x] Documentation with [MkDocs], [Jupyter Book], and [Read the Docs]
- [x] Hyperfast rendering of the template into a new project with [Copier]
- [x] Import sorting with [isort]
- [x] Linting with [pre-commit] and [Flake8]
- [x] Managing project labels with [GitHub Labeler]
- [x] Managing projects with [Make]
- [x] Packaging and dependency management with [Poetry]
- [x] Static type-checking with [mypy]
- [x] Support for [Conventional Commits]
- [x] Support for [Semantic Versioning]
- [x] Testing with [pytest]

- [ ] Automated Python syntax upgrades with [pyupgrade]
- [ ] Automatic documentation from sources for [MkDocs] with [mkdocstrings]
- [ ] Check documentation examples with [xdoctest]
- [ ] Runtime type-checking with [Typeguard]
- [ ] Security audit with [Bandit] and [Safety]
- [ ] Test automation with [Nox]

The template supports Python 3.7, 3.8, 3.9, and 3.10.

[bandit]: https://github.com/PyCQA/bandit
[black]: https://github.com/psf/black
[click]: https://click.palletsprojects.com/
[codecov]: https://codecov.io/
[conventional commits]: https://conventionalcommits.org
[conventional release labels]: https://github.com/marketplace/actions/conventional-release-labels
[copier]: https://copier.readthedocs.io
[coverage.py]: https://coverage.readthedocs.io/
[dependabot]: https://dependabot.com/
[flake8]: http://flake8.pycqa.org
[github actions]: https://github.com/features/actions
[github labeler]: https://github.com/marketplace/actions/github-labeler
[isort]: https://pycqa.github.io/isort/
[jupyter book]: https://jupyterbook.org
[make]: https://www.gnu.org/software/make/
[mkdocs]: https://www.mkdocs.org
[mkdocstrings]: https://mkdocstrings.github.io
[mypy]: http://mypy-lang.org/
[myst]: https://myst-parser.readthedocs.io/
[nox]: https://nox.thea.codes/
[poetry]: https://python-poetry.org/
[pre-commit]: https://pre-commit.com/
[prettier]: https://prettier.io/
[pypi]: https://pypi.org/
[pytest-cov]: https://pytest-cov.readthedocs.io/
[pytest]: https://docs.pytest.org/en/latest/
[python semantic release]: https://python-semantic-release.readthedocs.io/en/latest/
[pyupgrade]: https://github.com/asottile/pyupgrade
[read the docs]: https://readthedocs.org/
[release drafter]: https://github.com/release-drafter/release-drafter
[safety]: https://github.com/pyupio/safety
[semantic versioning]: https://semver.org
[testpypi]: https://test.pypi.org/
[typeguard]: https://github.com/agronholm/typeguard
[xdoctest]: https://github.com/Erotemic/xdoctest
