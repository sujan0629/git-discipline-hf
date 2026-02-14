# Contributing

This is a process template repository. It is intentionally stack-agnostic so teams can use it for Node, Django, Go, Java, .NET, or any other technology.

## Workflow model

- `main`: production branch, always deployable
- `develop`: integration branch, always green
- all work: short-lived branches + pull requests + required checks

## Branching policy

### Long-lived branches

- `main`
- `develop`

### Short-lived branches

Create from `develop`:

- `feature/<short-name>`
- `fix/<short-name>`
- `chore/<short-name>`

Examples:

- `feature/auth-navigation`
- `fix/session-timeout`
- `chore/update-docs`

### Hotfix branches

For urgent production fixes, create from `main`:

- `hotfix/<short-name>`

Then merge into `main` and back into `develop`.

## Day-to-day development flow

1. Sync `develop`

```bash
git checkout develop
git pull origin develop
```

2. Create a short-lived branch

```bash
git checkout -b feature/your-short-name
```

3. Commit with Conventional Commits

```bash
git commit -m "feat(scope): short description"
```

4. Push and open a pull request

```bash
git push -u origin feature/your-short-name
```

## Pull request requirements

A PR may merge only when all are true:

- required CI checks are green
- at least one approval is present
- no unresolved review comments remain
- PR title follows Conventional Commits
- branch is up to date with target branch

## Merge strategy

- squash merge only
- delete source branch after merge

## Release flow (sprint cadence)

At sprint end:

1. Open PR `develop -> main`
2. Verify required checks are green
3. Merge and deploy
4. Tag release if your team uses tags

## Hotfix flow

1. Branch from `main`: `hotfix/<short-name>`
2. Fix and open PR into `main`
3. Deploy
4. Merge `main -> develop`

## Commit message standard

Format:

```text
type(scope): description
```

Scope is optional:

```text
type: description
```

Allowed types:

- `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`, `perf`, `ci`, `build`, `revert`

Examples:

- `feat(auth): add route guard`
- `fix(api): handle empty token`
- `chore: update contributing guide`

## Stack-specific checks (team-owned)

This template does not prescribe package managers or language tools.
Each project team must define required checks in their own stack, then enforce them in CI.

Examples by stack:

- Node: lint + test + build
- Python/Django: ruff/flake8 + pytest + migrations check
- Go: `go vet` + `go test ./...`
- Java: `mvn test` / `gradle test`

## Governance rule

No direct pushes to `main` or `develop`.
All changes go through PR review and required checks.

## Automation model (template default)

This template uses a two-layer enforcement approach.

### Layer 1: CI workflows (stack-agnostic)

The following files are copied as-is into every project created from template:

- `.github/workflows/branch-name.yml`
- `.github/workflows/commitlint.yml`
- `.github/workflows/ci.yml`
- `.github/workflows/cd-demo.yml`

`branch-name` and `commitlint` are universal policy checks.
`ci` and `cd-demo` call project-owned scripts (`.ci/commands.sh`, `.ci/deploy.sh`) so each stack can plug in its own commands.

### Layer 2: Local hooks (cross-stack)

Local hook enforcement is provided with **Lefthook**:

- `lefthook.yml`
- `scripts/hooks/validate-commit-msg.sh`
- `scripts/hooks/validate-branch-name.sh`

This avoids Node-only hook tooling and works for mixed stacks.

One-time setup in each generated project:

```bash
lefthook install
```

If a team chooses a different local hook framework, they must keep the same branch and commit policy.