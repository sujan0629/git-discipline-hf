# Git Discipline Template Architecture

This repository is a universal process template for new projects.

## Purpose

- Provide one shared Git workflow standard for all teams
- Keep policy consistent across different tech stacks
- Avoid hard-coding Node/Python/Go-specific tooling into the template

## Core files

- `CONTRIBUTING.md`: rules for branches, PRs, commits, releases, and hotfixes
- `SETUP-PLAYBOOK.md`: how to use this as a GitHub template repository
- `git-disclipine.md`: quick architecture summary for internal demos
- `.github/workflows/*.yml`: universal CI/CD policy workflows
- `lefthook.yml`: cross-stack local hook orchestration
- `scripts/hooks/*.sh`: local commit and branch validators
- `.ci/*.sh`: project-owned CI and deploy command entrypoints

## What each generated project customizes

- language/toolchain dependencies
- command content inside `.ci/commands.sh`
- deploy content inside `.ci/deploy.sh`

Policy and workflow layout remain consistent; only project commands change.

## Template usage model

1. Mark this repository as **Template repository** in GitHub Settings
2. Share one permanent URL with the team
3. Each new project is created via **Use this template**
4. Each project updates `.ci/commands.sh` and `.ci/deploy.sh` for its stack

## Policy baseline applied to all projects

- Branch names:
	- `feature/<short-name>`
	- `fix/<short-name>`
	- `hotfix/<short-name>`
	- `chore/<short-name>`
- Conventional Commits for commits and PR titles
- PR-first workflow with required checks
- Protected `main` and `develop`
