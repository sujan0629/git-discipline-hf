# Git Discipline Template Playbook

This repository should be used as a **GitHub Template Repository** for new projects.
It provides universal Git policy plus reusable automation that teams adapt per stack.

## Template URL (single source of truth)

Replace this once and keep it permanent:

```text
https://github.com/your-org/git-discipline-template
```

Share this exact URL with your team:

```text
When starting any new project, create it from this template repository.
```

## How this template works

### Developer flow (every new project)

1. Open template repository URL
2. Click **Use this template** → **Create a new repository**
3. Set repository name and visibility
4. Create repository
5. Clone and run one-time local hook setup for the project stack
6. Update stack-specific CI/deploy scripts in `.ci/`

## Automation layers in this template

### Layer 1 — CI workflows (stack-agnostic)

These workflows are copied as-is into every new repository from template:

- `.github/workflows/ci.yml`
- `.github/workflows/commitlint.yml`
- `.github/workflows/branch-name.yml`
- `.github/workflows/cd-demo.yml`

Notes:

- `commitlint` and `branch-name` enforce universal Git policy.
- `ci` and `cd-demo` call project-owned scripts:
  - `.ci/commands.sh`
  - `.ci/deploy.sh`

This keeps workflows universal while letting each stack plug in its own commands.

### Layer 2 — Local hooks (cross-stack)

This template uses **Lefthook** for local enforcement across stacks:

- `lefthook.yml`
- `scripts/hooks/validate-commit-msg.sh`
- `scripts/hooks/validate-branch-name.sh`

Lefthook is runtime-agnostic and works for Node, Python/Django, Go, and others.

## What this template contains

- `CONTRIBUTING.md`: universal branch, PR, release, and commit policy
- `SETUP-PLAYBOOK.md`: team onboarding and template usage guide
- `git-disclipine.md`: short architecture/context note for presentations
- `lefthook.yml`: local hook orchestration
- `scripts/hooks/*.sh`: local validation scripts
- `.github/workflows/*.yml`: server-side CI policy and pipeline scaffolding
- `.ci/commands.sh`: stack-specific CI commands placeholder
- `.ci/deploy.sh`: stack-specific deploy commands placeholder
- `commitlint.config.cjs`: commitlint policy for CI workflow

## How teams should apply this to any stack

Each project keeps the same Git policy and fills in stack-specific commands.

### Required policy (same everywhere)

- branch naming:
  - `feature/<short-name>`
  - `fix/<short-name>`
  - `hotfix/<short-name>`
  - `chore/<short-name>`
- Conventional Commit messages
- PR-first workflow
- protected `main` and `develop`
- required checks before merge

## Practical setup per stack

| Stack | Hook tool | One-time setup command |
|---|---|---|
| Node / Next / React | Lefthook | `lefthook install` |
| Python / Django | Lefthook (or pre-commit if team standard) | `lefthook install` |
| Go / Others | Lefthook | `lefthook install` |

After hook install, edit `.ci/commands.sh` and `.ci/deploy.sh` for that project.

Examples:

- Node: run `npm ci`, `npm run lint`, `npm run test`, `npm run build`
- Django: run `pip install -r requirements.txt`, `ruff check .`, `pytest`
- Go: run `go fmt ./...`, `go vet ./...`, `go test ./...`

## New project bootstrap checklist

When a team creates a new project from template, do this immediately:

1. Create `develop` from `main`
2. Configure branch protections for `main` and `develop`
3. Run `lefthook install`
4. Update `.ci/commands.sh` and `.ci/deploy.sh`
5. Add required status checks in branch protection
6. Open first PR to verify end-to-end workflow

## GitHub branch protection baseline

Apply this in every new repository:

- protect `main` and `develop`
- require pull request before merge
- require at least one approval
- require required status checks
- restrict direct pushes
- enable auto-delete head branches (optional but recommended)

## Copy/paste templates

### Branch names

```text
feature/<short-name>
fix/<short-name>
hotfix/<short-name>
chore/<short-name>
```

### Commit messages

```text
type(scope): description
type: description
```

Examples:

- `feat(auth): add login route guard`
- `fix(api): handle timeout response`
- `chore: update contributing policy`

### PR title

```text
type(scope): short summary
```

### PR checklist

```markdown
- [ ] Branch name follows policy
- [ ] Commit messages follow Conventional Commits
- [ ] Stack-specific CI checks pass
- [ ] PR title follows Conventional Commits
- [ ] At least one approval received
```

## Maintenance model

- Update this template repository when policy changes
- New projects use the latest template at creation time
- Existing projects are not auto-modified; update them intentionally as needed

## FAQ

### Does changing template update existing repositories automatically?

No. Existing repositories keep their own files. Update them manually when needed.

### Can teams use different tooling?

Yes. Tooling may differ by stack. Policy should remain consistent.

### Why Lefthook in this template?

Because it is cross-stack and avoids package-manager lock-in while still providing local automation.