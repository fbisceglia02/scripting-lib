#!/bin/bash
# Generate repository analytics

set -euo pipefail

echo "📊 Repository Analytics"
echo "======================"
echo ""

# Total commits
TOTAL_COMMITS=$(git rev-list --all --count)
echo "Total Commits: $TOTAL_COMMITS"

# Contributors
CONTRIBUTORS=$(git shortlog -sn --all | wc -l)
echo "Contributors: $CONTRIBUTORS"

# Most active contributor
MOST_ACTIVE=$(git shortlog -sn --all | head -n1)
echo "Most Active: $MOST_ACTIVE"

# Files count
FILES_COUNT=$(git ls-files | wc -l)
echo "Total Files: $FILES_COUNT"

# Repository age
FIRST_COMMIT=$(git log --reverse --format=%ar | head -n1)
echo "Repository Age: $FIRST_COMMIT"

# Recent activity
echo ""
echo "Recent Activity (last 7 days):"
git log --since="7 days ago" --pretty=format:"  %ar: %s" | head -n10

echo ""
echo "✅ Analysis complete!"
