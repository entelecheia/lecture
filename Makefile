# To do stuff with make, you type `make` in a directory that has a file called
# "Makefile".  You can also type `make -f <makefile>` to use a different filename.
#
# A Makefile is a collection of rules. Each rule is a recipe to do a specific
# thing, sort of like a grunt task or an npm package.json script.
#
# A rule looks like this:
#
# <target>: <prerequisites...>
# 	<commands>
#
# The "target" is required. The prerequisites are optional, and the commands
# are also optional, but you have to have one or the other.
#
# Type `make` to show the available targets and a description of each.
#
.DEFAULT_GOAL := help
.PHONY: help
help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-25s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)


##@ Clean-up

clean-cov: ## remove coverage reports
	@rm -rf .coverage tests/htmlcov tests/pytest.xml tests/pytest-coverage.txt

clean-pycache: ## remove __pycache__ directories
	@find . -type d -name __pycache__ -exec rm -rf {} + || true

clean-build: ## remove build/python artifacts
	@rm -rf build dist *.egg-info

clean-docs: ## remove documentation artifacts
	@rm -rf book/_build docs/_build _site

clean: clean-cov clean-pycache clean-build clean-docs ## run all clean commands

##@ Formatting

format-black: ## format code with black
	@black .

format-isort: ## sort imports with isort
	@isort .

format: format-black format-isort ## format code with black and isort

##@ Linting

lint-black: ## check code formatting with black
	@black --check --diff .

lint-flake8: ## check code style with flake8
	@flake8 .

lint-isort: ## check import sorting with isort
	@isort --check-only --diff .

lint-mypy: ## check types with mypy
	@mypy --config-file pyproject.toml .

lint-mypy-reports: ## generate an HTML report of the type (mypy) checker
	@mypy --config-file pyproject.toml . --html-report ./tests/mypy-report

lint: lint-black lint-flake8 lint-isort ## check code style with flake8, black, and isort

##@ Testing

tests: ## run tests with pytest
	@pytest --doctest-modules

tests-cov: ## run tests with pytest and generate a coverage report
	@pytest --doctest-modules --cov=src --cov-report term-missing --cov-report=html

tests-cov-fail: ## run tests with pytest and generate a coverage report, fail if coverage is below 80%
	@pytest --doctest-modules --cov=src --cov-report term-missing --cov-report=html --cov-fail-under=80 --junitxml=tests/pytest.xml | tee tests/pytest-coverage.txt

##@ Git Branches

show-branches: ## show all branches
	@git show-branch --list

show-tags: ## show tags
	@git tag --list

show-remotes: ## show remotes
	@git remote --verbose

show-refs: ## show refs
	@git show-ref

branch-checkout: ## checkout a branch (usage: make branch-checkout branch=name)
	@git checkout $(branch)

branch-checkout-upstream: ## create a new branch and push it to origin (usage: make branch-checkout-upstream branch=name)
	@git checkout -B $(branch) && \
	git push --set-upstream origin $(branch)

dev-checkout: ## checkout the dev branch
	@branch=$(shell echo $${branch:-"dev"}) && \
	    git show-branch --list | grep -q $${branch} && \
		git checkout $${branch}

dev-checkout-upstream: ## create and checkout the dev branch, and set the upstream
	@branch=$(shell echo $${branch:-"dev"}) && \
		git checkout -B $${branch} && \
		git push --set-upstream origin $${branch} || true

main-checkout: ## checkout the main branch
	@git checkout main

##@ Git LFS

git-lfs-install: ## git lfs install
	@git lfs install

git-lfs-track: ## git lfs track (usage: make git-lfs-track patterns="*.pdf")
	@git lfs track $(patterns)

git-lfs-migrate: ## git lfs migrate (usage: make git-lfs-migrate patterns="*.pdf")
	@git lfs migrate import --everything --include=$(patterns)

##@ Git Submodules

git-add-submodule: ## git submodule add (usage: make git-add-submodule url=... path=...)
	@git submodule add $(url) $(path)

git-init-submodule: ## git submodule update --init --recursive
	@git submodule update --init --recursive

git-update-submodule: ## git submodule update --recursive --remote
	@git submodule update --recursive --remote

##@ Version & Release

version: ## print the current version
	@semantic-release print-version --current

next-version: ## print the next version
	@semantic-release print-version --next

changelog: ## print the changelog for the current version
	@semantic-release changelog --released

next-changelog: ## print the changelog for the next version
	@semantic-release changelog --unreleased

release-noop: ## run a dry-run of the release process
	@semantic-release publish --noop -v DEBUG

release-ci: ## run the release process in CI
	@semantic-release publish -v DEBUG -D commit_author='github-actions <action@github.com>'

prerelease-noop: ## run a dry-run of the prerelease process
	@semantic-release publish --noop -v DEBUG --prerelease

##@ Utilities

generate-slide-numbering: ## generate slide numbering
	@sh scripts/generate-slide-numbering.sh

large-files: ## show the 20 largest files in the repo
	@find . -printf '%s %p\n'| sort -nr | head -20

disk-usage: ## show the disk usage of the repo
	@du -h -d 2 .

git-sizer: ## run git-sizer
	@git-sizer --verbose

gc-prune: ## garbage collect and prune
	@git gc --prune=now

##@ Installation

install: ## install dependencies
	@uv sync --no-dev

install-dev: ## install dev dependencies
	@uv sync --extra dev

update: ## update dependencies
	@uv sync --upgrade

lock: ## lock dependencies
	@uv lock

##@ Book

install-jupyter-book: ## install jupyter-book
	@pip install -r book/requirements.txt

book-build: ## build the book
	@jupyter-book build book

book-build-all: ## build the book with all outputs
	@jupyter-book build book --all

book-publish: ## publish the book
	@ghp-import -n -p -f book/_build/html

##@ Setup

install-node: ## install node
	@export NVM_DIR="$${HOME}/.nvm"; \
	[ -s "$${NVM_DIR}/nvm.sh" ] && . "$${NVM_DIR}/nvm.sh"; \
	nvm install --lts

nvm-ls: ## list node versions
	@export NVM_DIR="$${HOME}/.nvm"; \
	[ -s "$${NVM_DIR}/nvm.sh" ] && . "$${NVM_DIR}/nvm.sh"; \
	nvm ls

set-default-node: ## set default node
	@export NVM_DIR="$${HOME}/.nvm"; \
	[ -s "$${NVM_DIR}/nvm.sh" ] && . "$${NVM_DIR}/nvm.sh"; \
	nvm alias default node

install-pipx: ## install pipx (pre-requisite for external tools)
	@command -v pipx &> /dev/null || pip install --user pipx || true

install-uv: install-pipx ## install uv (pre-requisite for install)
	@command -v uv &> /dev/null || pipx install uv || true

install-copier: install-pipx ## install copier (pre-requisite for init-project)
	@command -v copier &> /dev/null || pipx install copier || true

install-commitzen: install-pipx ## install commitzen (pre-requisite for commit)
	@command -v cz &> /dev/null || pipx install commitizen || true

install-precommit: install-pipx ## install pre-commit
	@command -v pre-commit &> /dev/null || pipx install pre-commit || true

install-precommit-hooks: install-precommit ## install pre-commit hooks
	@pre-commit install

initialize: install-pipx ## initialize the project environment
	@pipx install copier
	@pipx install uv
	@pipx install commitizen
	@pipx install pre-commit
	@pre-commit install

init-project: initialize remove-template ## initialize the project (Warning: do this only once!)
	@copier --answers-file .copier-config.yaml gh:entelecheia/hyperfast-python-template .

reinit-project: install-copier ## reinitialize the project (Warning: this may overwrite existing files!)
	@bash -c 'args=(); while IFS= read -r file; do args+=("--skip" "$$file"); done < .copierignore; copier "$${args[@]}" --answers-file .copier-config.yaml gh:entelecheia/hyperfast-python-template .'
