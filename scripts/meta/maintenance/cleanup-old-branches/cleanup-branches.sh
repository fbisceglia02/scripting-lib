#!/bin/bash
# Clean up old merged branches

set -euo pipefail

DAYS_OLD="${1:-30}"

echo "🧹 Cleaning branches older than $DAYS_OLD days..."

# Get default branch
DEFAULT_BRANCH=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')

# Find and delete old merged branches
git branch --merged "$DEFAULT_BRANCH" | \
    grep -v "^\*" | \
    grep -v "$DEFAULT_BRANCH" | \
    while read -r branch; do
        LAST_COMMIT=$(git log -1 --format=%ct "$branch")
        CURRENT_TIME=$(date +%s)
        DAYS_DIFF=$(( (CURRENT_TIME - LAST_COMMIT) / 86400 ))
        
        if [ "$DAYS_DIFF" -gt "$DAYS_OLD" ]; then
            echo "  Deleting: $branch (${DAYS_DIFF} days old)"
            git branch -d "$branch"
        fi
    done

echo "✅ Cleanup complete!"
