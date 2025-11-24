#!/bin/bash
# Initialize a new repository with best practices

set -euo pipefail

PROJECT_NAME="${1:-my-project}"

echo "🚀 Initializing repository: $PROJECT_NAME"

# Initialize git
git init
git branch -M main

# Create basic structure
mkdir -p .github/workflows
mkdir -p docs
mkdir -p scripts
mkdir -p tests

# Create README
cat > README.md << EOF
# $PROJECT_NAME

## Overview
[Add project description]

## Getting Started
[Add instructions]

## Contributing
See [CONTRIBUTING.md](CONTRIBUTING.md)
EOF

# Create .gitignore
cat > .gitignore << EOF
# OS
.DS_Store
Thumbs.db
*.swp

# IDE
.vscode/
.idea/

# Logs
*.log
EOF

# Create CONTRIBUTING.md
cat > CONTRIBUTING.md << EOF
# Contributing to $PROJECT_NAME

## Pull Request Process
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request
EOF

git add .
git commit -m "Initial commit: Project structure"

echo "✅ Repository initialized successfully!"
