# GitHub Workflow

This lecture note provides an in-depth look at the GitHub workflow, with example usages to help you understand how to effectively manage projects on GitHub. By the end of this lecture, you should have a clear understanding of the GitHub workflow and be able to implement it in your own projects.

## 1. Introduction to GitHub Workflow

GitHub Workflow is a set of best practices that allows developers to collaborate on projects effectively. The core components of the workflow are:

- Forking a repository
- Cloning the repository to your local machine
- Creating branches for new features or bug fixes
- Committing changes
- Pushing changes to GitHub
- Creating pull requests
- Merging pull requests
- Syncing your fork with the upstream repository

## 2. Forking a Repository

Forking a repository creates a copy of the project under your GitHub account. This allows you to make changes without affecting the original project.

To fork a repository:

1. Navigate to the repository you want to fork.
2. Click the "Fork" button in the upper-right corner.

Example:

```
Original Repository: https://github.com/owner/project.git
Forked Repository: https://github.com/yourusername/project.git
```

## 3. Cloning a Repository

After forking a repository, you need to clone it to your local machine to start working on it.

To clone a repository:

```bash
git clone https://github.com/yourusername/project.git
cd project
```

## 4. Creating a New Branch

Create a new branch to work on a specific feature or bug fix without affecting the main branch.

To create a new branch and switch to it:

```bash
git checkout -b my-feature
```

## 5. Making Changes and Committing

Make changes to the code and commit them. It's recommended to make small, focused commits with clear messages.

To commit changes:

```bash
git add .
git commit -m "Add a meaningful message describing the changes"
```

## 6. Pushing Changes to GitHub

Push your changes to the remote repository on GitHub.

To push your branch:

```bash
git push origin my-feature
```

## 7. Creating a Pull Request

To merge your changes into the original repository, you need to create a pull request.

1. Navigate to your forked repository on GitHub.
2. Click the "New pull request" button.
3. Choose the original repository as the base and your fork as the head.
4. Click "Create pull request".
5. Add a descriptive title and explain the changes in the description.

## 8. Merging a Pull Request

Once the pull request is reviewed and approved, it can be merged into the original repository.

1. Navigate to the pull request in the original repository.
2. If there are no conflicts, click "Merge pull request".
3. Click "Confirm merge" to finalize the merge.

**Note**: Only users with write access to the original repository can merge pull requests.

## 9. Syncing Your Fork

After the pull request is merged, you need to sync your fork with the upstream repository to keep it up-to-date.

To sync your fork:

```bash
# Add the upstream repository as a remote
git remote add upstream https://github.com/owner/project.git

# Fetch changes from the upstream repository
git fetch upstream

# Switch to the main branch
git checkout main

# Merge changes from upstream/main into your local main branch
git merge upstream/main

# Push the updated main branch to your fork on GitHub
git push origin main
```

## 10. Example Usage

Here's an example of how to use the GitHub Workflow for contributing to a project:

1. Fork the repository: https://github.com/owner/project.git
2. Clone the forked repository: `git clone https://github.com/yourusername/project.git`
3. Create a new branch: `git checkout -b my-feature`
4. Make changes and commit: `git add . && git commit -m "Add new feature"`
5. Push the changes to GitHub: `git push origin my-feature`
6. Create a pull request on GitHub.
7. After the pull request is merged, sync your fork:
   ```
   git remote add upstream https://github.com/owner/project.git
   git fetch upstream
   git checkout main
   git merge upstream/main
   git push origin main
   ```

By following the GitHub Workflow, you can effectively contribute to open-source projects or collaborate with other developers in a structured and organized manner.

## Next

```{tableofcontents}

```
