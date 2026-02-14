#!/usr/bin/env bash
set -euo pipefail

MSG_FILE="${1:-}"

if [[ -z "$MSG_FILE" || ! -f "$MSG_FILE" ]]; then
  echo "[hook] commit message file not found"
  exit 1
fi

COMMIT_MSG="$(head -n 1 "$MSG_FILE" | tr -d '\r')"
REGEX='^(feat|fix|docs|style|refactor|test|chore|perf|ci|build|revert)(\([a-z0-9._/-]+\))?: .{1,}$'

if [[ ! "$COMMIT_MSG" =~ $REGEX ]]; then
  echo "Invalid commit message: $COMMIT_MSG"
  echo ""
  echo "Use Conventional Commits format:"
  echo "  type(scope): description"
  echo "  type: description"
  echo ""
  echo "Examples:"
  echo "  feat(auth): add route guard"
  echo "  fix(api): handle timeout response"
  echo "  chore: update docs"
  exit 1
fi

echo "Commit message valid"
