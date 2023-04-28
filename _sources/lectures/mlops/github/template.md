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
