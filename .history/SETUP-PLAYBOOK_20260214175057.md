# Git Discipline Setup Playbook

This document explains what was implemented in this repository, why it exists, and how any developer can recreate the same setup in a new repository.

## 1) What was set up in this repo

- Workflow model: `develop` (integration) + `main` (production)
- Pull-request-first development with squash merges
- Conventional Commits enforcement (local hook + CI)
- Branch naming enforcement (local hook + CI)
- CI checks (`lint`, `test`, `typecheck`, `build`)
- Demo CD workflow on pushes to `main`

## 2) Files created and what each does

### Root files

- `README.md` — quick-start and high-level policy summary
- `CONTRIBUTING.md` — source-of-truth workflow rules for the team
- `git-disclipine.md` — compact architecture snapshot for presentation/demo
- `package.json` — scripts, dev dependencies, `lint-staged` config
- `package-lock.json` — dependency lock for reproducible installs
- `.gitignore` — excludes build/dependency artifacts
- `commitlint.config.cjs` — Conventional Commit rule config
- `eslint.config.mjs` — lint rules used by CI and local checks

### Hook files (`.husky/`)

- `.husky/commit-msg` — blocks invalid commit messages and shows message format help
- `.husky/pre-commit` — runs `lint-staged` before commit finalization
- `.husky/pre-push` — validates branch naming before push

### CI/CD files (`.github/workflows/`)

- `.github/workflows/ci.yml` — runs lint/test/typecheck/build
- `.github/workflows/commitlint.yml` — validates commit messages on PRs
- `.github/workflows/branch-name.yml` — validates branch naming on push/PR
- `.github/workflows/cd-demo.yml` — demo deploy simulation on `main`

### Script files (`scripts/`)

- `scripts/validate-branch-name.mjs` — enforces branch patterns:
  - `feature/<short-name>`
  - `fix/<short-name>`
  - `hotfix/<short-name>`
  - `chore/<short-name>`
- `scripts/typecheck-check.mjs` — demo typecheck placeholder used in CI
- `scripts/build-check.mjs` — demo build placeholder used in CI

### Demo code

- `src/index.js` — sample module
- `tests/smoke.test.js` — sample Node test for CI demo

## 3) Step-by-step setup in a new repo

Use these steps when another developer wants the same setup from scratch.

1. Create repository and initialize Node project

```bash
git init
npm init -y
```

2. Install required dev dependencies

```bash
npm i -D husky lint-staged @commitlint/cli @commitlint/config-conventional eslint
```

3. Add base files

- Add `CONTRIBUTING.md`, `README.md`, `.gitignore`
- Add `commitlint.config.cjs` and `eslint.config.mjs`
- Add `scripts/` + `.github/workflows/` + `.husky/` files

4. Configure scripts in `package.json`

```json
{
  "type": "module",
  "scripts": {
    "prepare": "husky install",
    "lint": "eslint . --max-warnings=0",
    "test": "node --test",
    "typecheck": "node scripts/typecheck-check.mjs",
    "build": "node scripts/build-check.mjs",
    "validate:branch": "node scripts/validate-branch-name.mjs"
  }
}
```

5. Install and enable hooks

```bash
npm run prepare
```

6. Create long-lived branches

```bash
git checkout -b main
git checkout -b develop
```

7. Set GitHub branch protections manually

- Protect `main` and `develop`
- Require PR before merge
- Require status checks: `ci`, `commitlint`, `branch-name`
- Require at least 1 approval
- Restrict direct push

8. Validate locally

```bash
npm run lint
npm run test
npm run typecheck
npm run build
```

## 4) Team templates (copy/paste)

### Branch name template

```text
feature/<short-name>
fix/<short-name>
hotfix/<short-name>
chore/<short-name>
```

Examples:

- `feature/auth-navigation`
- `fix/login-crash`
- `hotfix/prod-timeout`
- `chore/update-eslint`

### Commit message template

```text
type(scope): description
```

Scope is optional:

```text
type: description
```

Examples:

- `feat(auth): add route guard`
- `fix(api): handle null token`
- `chore: update readme`

### PR title template

Use the same format as Conventional Commits:

```text
feat(auth): add login route guard
```

### PR checklist template

```markdown
- [ ] Branch name follows policy (`feature/...`, `fix/...`, `hotfix/...`, `chore/...`)
- [ ] Commit messages follow Conventional Commits
- [ ] `npm run lint` passes
- [ ] `npm run test` passes
- [ ] `npm run typecheck` passes
- [ ] `npm run build` passes
- [ ] PR title follows Conventional Commits
```

## 5) Common gotchas

- If bad commit messages are not blocked, ensure `.husky/commit-msg` exists and `npm run prepare` was run.
- If branch checks fail on push, rename branch to short-name format (no ticket ID).
- If CI is not required at merge time, branch protection rules are missing in GitHub settings.

## 6) Minimal command cheat sheet

```bash
git checkout develop
git pull origin develop
git checkout -b feature/your-short-name
git add .
git commit -m "feat(scope): short description"
git push -u origin feature/your-short-name
```