#!/usr/bin/env bash
set -euo pipefail

BRANCH_NAME="${1:-$(git rev-parse --abbrev-ref HEAD)}"

if [[ "$BRANCH_NAME" == "main" || "$BRANCH_NAME" == "develop" ]]; then
  echo "Direct pushes to $BRANCH_NAME are blocked. Use a short-lived branch + PR."
  exit 1
fi

REGEX='^(feature|fix|hotfix|chore)\/[a-z0-9]+(-[a-z0-9]+)*$'

if [[ ! "$BRANCH_NAME" =~ $REGEX ]]; then
  echo "Invalid branch name: $BRANCH_NAME"
  echo "Allowed formats:"
  echo "- feature/auth-navigation"
  echo "- fix/session-timeout"
  echo "- hotfix/payment-failure"
  echo "- chore/update-docs"
  exit 1
fi

echo "Branch name valid: $BRANCH_NAME"
