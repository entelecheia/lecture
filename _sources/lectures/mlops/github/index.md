# Github's Fork & Pull Workflow

## Introduction

We will explore the Fork & Pull workflow, which is a popular collaboration model for open-source projects on Github. By the end of this lecture, you will understand the basic concepts of the Fork & Pull workflow and learn how to contribute to open-source projects using this approach.

## 1. Understanding Fork & Pull Workflow

The Fork & Pull workflow involves two primary steps: forking a repository and creating a pull request. Forking is the process of creating a personal copy of another user's repository. You can make changes to your forked repository without affecting the original project. Once you have made your changes, you can submit a pull request to the original repository, requesting that the project maintainer merge your changes.

## 2. Forking a Repository

To fork a repository, follow these steps:

- a) Go to the Github repository you wish to contribute to.
- b) Click on the "Fork" button located in the top right corner of the page.
- c) Select your account as the destination for the forked repository.
- d) Wait for Github to create your fork. Once completed, you will have a personal copy of the repository under your Github account.

Example: Let's assume you want to contribute to the "example-project" repository. After forking, you will have a copy of "example-project" in your account, like "your_username/example-project".

## 3. Cloning the Forked Repository

Now, you need to clone the forked repository to your local machine:

```bash
git clone https://github.com/your_username/example-project.git
```

## 4. Creating a New Branch

It's a good practice to create a new branch for your changes, so you can keep your master branch in sync with the original repository:

```bash
git checkout -b new-feature
```

## 5. Making Changes and Committing

Make your changes in the new branch, and then commit them:

```bash
git add .
git commit -m "Add new feature"

```

## 6. Pushing Changes to Your Fork

Now, push your changes to your forked repository on Github:

```bash
git push origin new-feature
```

## 7. Creating a Pull Request

To create a pull request, follow these steps:

- a) Go to your forked repository on Github.
- b) Switch to the branch containing your changes (in this case, "new-feature").
- c) Click on the "New Pull Request" button.
- d) Ensure that the base repository is the original repository and the base branch is the branch you want your changes to be merged into (usually "master" or "main").
- e) Confirm that the head repository is your forked repository and the compare branch is the branch containing your changes.
- f) Add a descriptive title and a detailed explanation of your changes in the pull request description.
- g) Click "Create Pull Request".

## 8. Collaborating and Merging

The project maintainer will review your pull request and may request changes or clarifications. Collaborate with the maintainer by addressing their comments and pushing new commits to your branch. Once your changes are approved, the maintainer will merge your pull request into the original repository.

## Conclusion

In this lecture, we have learned about Github's Fork & Pull workflow and how it facilitates collaboration on open-source projects. By understanding this workflow and following the steps outlined above, you can start contributing to open-source projects and enhance your Git skills.

## References

- [GitHub Standard Fork & Pull Request Workflow](https://gist.github.com/Chaser324/ce0505fbed06b947d962#file-github-forking-md)
- [Introducing code owners](https://github.blog/2017-07-06-introducing-code-owners/)
- [How to Create a Good Pull Request Template](https://dev.to/opensauced/how-to-create-a-good-pull-request-template-and-why-you-should-add-gifs-4i0l)

## Next

```{tableofcontents}

```
