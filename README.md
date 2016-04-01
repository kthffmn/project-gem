# Project Generator

A gem for generating projects.

## Usage

`project-generator <project-name>`

### With Git

Use the command above but add the flag `-g` to create a project with an initialized git repository.

`project-generator <project-name> -g`

## Project Name

The project-name refers to the name of the project (example: `count-min-sketch`).

## Reposit

If Reposit is installed on your machine, after creating the project, run `reposit <project-name>` followed by `git remote add origin < command + V >`.

## Handy Steps

1. `project-generator <project-name> -g`
2. `reposit <project-name>`
3. `git remote add origin < command + V >`
4. `git push origin master`
