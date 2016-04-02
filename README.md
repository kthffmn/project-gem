# Project Generator

A gem for generating TDD projects.

## Usage

#### Install and Configure Reposit Gem

First install the [Reposit](https://github.com/loganhasson/reposit) gem.

    gem install reposit

Then visit the [token page of your GitHub account](https://github.com/settings/tokens) and click `Generate new token`. Make sure your new token has access to repos.

Then run `reposit --setup`. You will be prompted to enter your GitHub username and the token.

#### Using Project Generator

To use this gem, select a template (`ruby-method`, `ruby-class`, or `java-class`).

The `java-class` template has been generated from Gradle by running

    gradle init --type java-library

and then adding GitHub's Gradle `.gitignore` file.

Then choose the name of your new project. This name should be separated by dashes (example: `count-min-sketch`).

Then run:

    project-generator <project-type> <project-name>

If you'd like to also create a git repo, an initial commit, and push the structure up to GitHub, add the `-g` flag:

    project-generator <project-type> <project-name> -g

Be aware that this flag will lead to errors if you already have a repo with the same name as your new project.
