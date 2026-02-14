# Contributing

This repository follows a **develop + main** workflow with **CI-first discipline**.

- `develop` is the integration branch and must stay green.
- `main` is production and must stay deployable.
- All work lands through pull requests with passing checks.

## Branching strategy

### Long-lived branches

- `main`: production-ready code
- `develop`: integration branch for completed work

### Short-lived branches

Create from `develop`:

- `feature/<TICKET>-<short-name>`
- `fix/<TICKET>-<short-name>`
- `chore/<short-name>`

Examples:

- `feature/CLIK-142-auth-navigation`
- `fix/CLIK-201-crash-on-start`
- `chore/update-deps`

### Hotfix branches

For urgent production fixes, create from `main`:

- `hotfix/<TICKET>-<short-name>`

Then merge into `main` and back into `develop`.

## Development workflow

1. Sync `develop`

```bash
git checkout develop
git pull origin develop
```

2. Create branch

```bash
git checkout -b feature/CLIK-142-auth-navigation
```

3. Commit using Conventional Commits

```bash
git commit -m "feat(auth): add login route guard"
```

4. Push and open PR

```bash
git push -u origin feature/CLIK-142-auth-navigation
```

## Pull request rules

A PR can merge only when:

- CI checks pass (`lint`, `test`, `typecheck`, `build`)
- At least one approval is present
- No unresolved review comments remain
- PR title follows Conventional Commits
- Branch is up to date with target branch

## Merge method

- Squash merge only
- Delete source branch after merge

## Release workflow

At sprint end:

1. Open PR `develop -> main`
2. Verify CI is green
3. Merge and deploy
4. Create release tag if needed

## Hotfix workflow

1. Branch from `main`
2. Fix and PR into `main`
3. Deploy
4. Merge `main -> develop`

## Conventional Commit format

```text
type(scope): description
```

Allowed types:

- `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`, `perf`, `ci`, `build`, `revert`

Examples:

- `feat(auth): add JWT token validation`
- `fix(ui): resolve mobile layout overflow`
- `ci: add commitlint workflow`

## Local quality checks

Run before pushing:

- `npm run lint`
- `npm run test`
- `npm run typecheck`
- `npm run build`
