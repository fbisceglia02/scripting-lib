#!/bin/bash
# Update README with automatic sections

set -euo pipefail

README="README.md"

echo "📝 Updating README.md..."

# Backup existing README
if [ -f "$README" ]; then
    cp "$README" "${README}.bak"
    echo "  Backup created: ${README}.bak"
fi

# Add Table of Contents marker if not exists
if ! grep -q "<!-- TOC -->" "$README"; then
    sed -i '1a\<!-- TOC -->\n<!-- /TOC -->\n' "$README"
fi

# Generate file tree
echo "  Generating project structure..."
TREE_OUTPUT=$(tree -L 2 -I 'node_modules|.git|dist|build' || echo "Install 'tree' for structure visualization")

# Update last modified date
echo "  Updating last modified date..."
sed -i "s/Last Updated:.*/Last Updated: $(date '+%Y-%m-%d')/" "$README" || \
    echo "**Last Updated:** $(date '+%Y-%m-%d')" >> "$README"

echo "✅ README updated successfully!"
