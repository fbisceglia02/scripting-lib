#!/bin/bash
# Check if required tools are installed

set -euo pipefail

check_command() {
    if command -v "$1" &> /dev/null; then
        echo "✓ $1 is installed"
        return 0
    else
        echo "✗ $1 is NOT installed"
        return 1
    fi
}

echo "Checking dependencies..."
check_command "bash"
check_command "git"
check_command "docker"
check_command "kubectl"
check_command "helm"
check_command "terraform"
check_command "az"

echo ""
echo "Dependency check complete!"
