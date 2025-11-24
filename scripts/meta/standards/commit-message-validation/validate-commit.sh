#!/bin/bash
# Validate commit messages according to conventional commits

set -euo pipefail

COMMIT_MSG_FILE="${1:-.git/COMMIT_EDITMSG}"

if [ ! -f "$COMMIT_MSG_FILE" ]; then
    echo "❌ Commit message file not found"
    exit 1
fi

COMMIT_MSG=$(cat "$COMMIT_MSG_FILE")

# Conventional commit pattern: type(scope): subject
PATTERN="^(feat|fix|docs|style|refactor|test|chore|perf|ci|build|revert)(\([a-z0-9-]+\))?: .{1,100}$"

if echo "$COMMIT_MSG" | grep -qE "$PATTERN"; then
    echo "✅ Commit message is valid"
    exit 0
else
    echo "❌ Invalid commit message format!"
    echo ""
    echo "Expected format:"
    echo "  type(scope): subject"
    echo ""
    echo "Valid types: feat, fix, docs, style, refactor, test, chore, perf, ci, build, revert"
    echo ""
    echo "Example:"
    echo "  feat(auth): add OAuth2 login support"
    exit 1
fi
