#!/bin/bash

# ============================================================================
# DevOps/Infrastructure Complete Structure Generator
# Crea l'intera struttura di folder per documentazione, scripts, templates e tools
# ============================================================================

set -euo pipefail

# Colori per output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# ============================================================================
# Funzioni di utilità
# ============================================================================

print_header() {
    echo ""
    echo -e "${CYAN}============================================================================${NC}"
    echo -e "${CYAN}  $1${NC}"
    echo -e "${CYAN}============================================================================${NC}"
    echo ""
}

print_section() {
    echo ""
    echo -e "${BLUE}▶ $1${NC}"
}

print_info() {
    echo -e "${GREEN}  ✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}  ⚠${NC} $1"
}

print_error() {
    echo -e "${RED}  ✗${NC} $1"
}

create_folder() {
    local folder_path="$1"
    if [[ ! -d "$folder_path" ]]; then
        mkdir -p "$folder_path"
    fi
}

create_readme() {
    local file_path="$1"
    local title="$2"
    local description="${3:-}"
    
    if [[ ! -f "$file_path" ]]; then
        cat > "$file_path" << EOF
# $title

$description

## Contents

This directory contains:
- Scripts and automation tools
- Documentation and guides
- Configuration files

## Usage

[Add usage instructions here]

## Notes

- Created: $(date +"%Y-%m-%d")
- Maintained by: DevOps Team
EOF
    fi
}

# ============================================================================
# Creazione struttura DOCS
# ============================================================================

create_docs_structure() {
    local base_dir="$1"
    print_section "Creating DOCS structure..."
    
    # Main docs folders
    local docs_folders=(
        "00-meta"
        "01-foundations"
        "02-git-github"
        "03-containers"
        "04-k8s-core"
        "05-k8s-advanced"
        "06-helm"
        "07-iac"
        "08-cloud-generic"
        "09-azure"
        "10-ci-cd"
        "11-observability"
        "12-security"
        "13-data-messaging"
        "14-serverless"
        "15-edge-hybrid"
        "16-dev-env"
        "17-incident-runbook"
        "18-workflows-e2e"
    )
    
    for folder in "${docs_folders[@]}"; do
        create_folder "$base_dir/docs/$folder"
        print_info "docs/$folder/"
    done
    
    # Create README files
    create_readme "$base_dir/docs/README.md" "Documentation Index" "Complete DevOps/Infrastructure documentation"
    create_readme "$base_dir/docs/00-meta/README.md" "Meta Documentation" "Project organization and standards"
    create_readme "$base_dir/docs/01-foundations/README.md" "Foundations" "Basic scripting and programming fundamentals"
    create_readme "$base_dir/docs/02-git-github/README.md" "Git & GitHub" "Version control and collaboration"
    create_readme "$base_dir/docs/03-containers/README.md" "Containers" "Docker, Podman, and container orchestration"
    create_readme "$base_dir/docs/04-k8s-core/README.md" "Kubernetes Core" "Kubernetes fundamentals and core concepts"
    create_readme "$base_dir/docs/05-k8s-advanced/README.md" "Kubernetes Advanced" "Advanced K8s topics and patterns"
    create_readme "$base_dir/docs/06-helm/README.md" "Helm" "Kubernetes package management"
    create_readme "$base_dir/docs/07-iac/README.md" "Infrastructure as Code" "Terraform, Pulumi, and IaC practices"
    create_readme "$base_dir/docs/08-cloud-generic/README.md" "Cloud Generic" "Multi-cloud concepts and patterns"
    create_readme "$base_dir/docs/09-azure/README.md" "Azure" "Azure-specific documentation"
    create_readme "$base_dir/docs/10-ci-cd/README.md" "CI/CD" "Continuous Integration and Deployment"
    create_readme "$base_dir/docs/11-observability/README.md" "Observability" "Monitoring, logging, and tracing"
    create_readme "$base_dir/docs/12-security/README.md" "Security" "Security practices and compliance"
    create_readme "$base_dir/docs/13-data-messaging/README.md" "Data & Messaging" "Databases, queues, and data platforms"
    create_readme "$base_dir/docs/14-serverless/README.md" "Serverless" "FaaS and serverless architectures"
    create_readme "$base_dir/docs/15-edge-hybrid/README.md" "Edge & Hybrid" "Edge computing and hybrid cloud"
    create_readme "$base_dir/docs/16-dev-env/README.md" "Development Environment" "Developer tooling and setup"
    create_readme "$base_dir/docs/17-incident-runbook/README.md" "Incident & Runbooks" "Incident response and operational runbooks"
    create_readme "$base_dir/docs/18-workflows-e2e/README.md" "End-to-End Workflows" "Complete workflow guides"
}

# ============================================================================
# Creazione struttura SCRIPTS
# ============================================================================

create_scripts_structure() {
    local base_dir="$1"
    print_section "Creating SCRIPTS structure..."
    
    # Meta
    create_folder "$base_dir/scripts/meta"
    print_info "scripts/meta/"
    
    # Foundations
    create_folder "$base_dir/scripts/foundations/bash"
    create_folder "$base_dir/scripts/foundations/powershell"
    create_folder "$base_dir/scripts/foundations/python"
    print_info "scripts/foundations/{bash,powershell,python}/"
    
    # Git & GitHub
    create_folder "$base_dir/scripts/git-github/git"
    create_folder "$base_dir/scripts/git-github/github-cli"
    print_info "scripts/git-github/{git,github-cli}/"
    
    # Containers
    create_folder "$base_dir/scripts/containers/docker"
    create_folder "$base_dir/scripts/containers/registry"
    print_info "scripts/containers/{docker,registry}/"
    
    # Kubernetes
    create_folder "$base_dir/scripts/k8s/core-ops"
    create_folder "$base_dir/scripts/k8s/advanced"
    create_folder "$base_dir/scripts/k8s/ingress-network"
    create_folder "$base_dir/scripts/k8s/storage-backup"
    create_folder "$base_dir/scripts/k8s/multicluster"
    print_info "scripts/k8s/{core-ops,advanced,ingress-network,storage-backup,multicluster}/"
    
    # Helm
    create_folder "$base_dir/scripts/helm/operations"
    create_folder "$base_dir/scripts/helm/chart-authoring"
    print_info "scripts/helm/{operations,chart-authoring}/"
    
    # Infrastructure as Code
    create_folder "$base_dir/scripts/iac/terraform"
    create_folder "$base_dir/scripts/iac/pulumi"
    create_folder "$base_dir/scripts/iac/policy-as-code"
    print_info "scripts/iac/{terraform,pulumi,policy-as-code}/"
    
    # Cloud - Generic
    create_folder "$base_dir/scripts/cloud/generic/accounts-identity"
    create_folder "$base_dir/scripts/cloud/generic/resource-management"
    create_folder "$base_dir/scripts/cloud/generic/backup-dr"
    create_folder "$base_dir/scripts/cloud/generic/cost-management"
    print_info "scripts/cloud/generic/{accounts-identity,resource-management,backup-dr,cost-management}/"
    
    # Cloud - Azure
    create_folder "$base_dir/scripts/cloud/azure/identity-security"
    create_folder "$base_dir/scripts/cloud/azure/networking"
    create_folder "$base_dir/scripts/cloud/azure/compute"
    create_folder "$base_dir/scripts/cloud/azure/storage-data"
    create_folder "$base_dir/scripts/cloud/azure/aks"
    print_info "scripts/cloud/azure/{identity-security,networking,compute,storage-data,aks}/"
    
    # CI/CD
    create_folder "$base_dir/scripts/ci-cd/pipelines"
    create_folder "$base_dir/scripts/ci-cd/executions"
    create_folder "$base_dir/scripts/ci-cd/release-management"
    print_info "scripts/ci-cd/{pipelines,executions,release-management}/"
    
    # Observability
    create_folder "$base_dir/scripts/observability/metrics"
    create_folder "$base_dir/scripts/observability/logs"
    create_folder "$base_dir/scripts/observability/tracing"
    print_info "scripts/observability/{metrics,logs,tracing}/"
    
    # Security
    create_folder "$base_dir/scripts/security/scans"
    create_folder "$base_dir/scripts/security/hardening"
    create_folder "$base_dir/scripts/security/identity-access"
    print_info "scripts/security/{scans,hardening,identity-access}/"
    
    # Data & Messaging
    create_folder "$base_dir/scripts/data-messaging/databases"
    create_folder "$base_dir/scripts/data-messaging/queues"
    create_folder "$base_dir/scripts/data-messaging/object-storage"
    print_info "scripts/data-messaging/{databases,queues,object-storage}/"
    
    # Serverless
    create_folder "$base_dir/scripts/serverless/deployment"
    create_folder "$base_dir/scripts/serverless/testing"
    print_info "scripts/serverless/{deployment,testing}/"
    
    # Edge & Hybrid
    create_folder "$base_dir/scripts/edge-hybrid/edge-nodes"
    create_folder "$base_dir/scripts/edge-hybrid/iot"
    create_folder "$base_dir/scripts/edge-hybrid/hybrid-connectivity"
    print_info "scripts/edge-hybrid/{edge-nodes,iot,hybrid-connectivity}/"
    
    # Dev Environment
    create_folder "$base_dir/scripts/dev-env/bootstrap"
    create_folder "$base_dir/scripts/dev-env/templates"
    create_folder "$base_dir/scripts/dev-env/productivity"
    print_info "scripts/dev-env/{bootstrap,templates,productivity}/"
    
    # Incident & Runbooks
    create_folder "$base_dir/scripts/incident-runbook/service-down"
    create_folder "$base_dir/scripts/incident-runbook/failed-deployment"
    create_folder "$base_dir/scripts/incident-runbook/reporting"
    print_info "scripts/incident-runbook/{service-down,failed-deployment,reporting}/"
    
    # Workflows E2E
    create_folder "$base_dir/scripts/workflows-e2e/new-service"
    create_folder "$base_dir/scripts/workflows-e2e/clone-environment"
    create_folder "$base_dir/scripts/workflows-e2e/decommission"
    print_info "scripts/workflows-e2e/{new-service,clone-environment,decommission}/"
    
    # Create main README
    create_readme "$base_dir/scripts/README.md" "Scripts Collection" "Automation scripts organized by category"
}

# ============================================================================
# Creazione struttura TEMPLATES
# ============================================================================

create_templates_structure() {
    local base_dir="$1"
    print_section "Creating TEMPLATES structure..."
    
    create_folder "$base_dir/templates/README-templates"
    create_folder "$base_dir/templates/wiki-page-templates"
    create_folder "$base_dir/templates/script-headers"
    create_folder "$base_dir/templates/pipeline-templates"
    
    print_info "templates/README-templates/"
    print_info "templates/wiki-page-templates/"
    print_info "templates/script-headers/"
    print_info "templates/pipeline-templates/"
    
    # Create sample templates
    cat > "$base_dir/templates/script-headers/bash-header.sh" << 'EOF'
#!/bin/bash
# ============================================================================
# Script Name: [SCRIPT_NAME]
# Description: [DESCRIPTION]
# Author: [AUTHOR]
# Date: [DATE]
# Version: 1.0.0
# ============================================================================

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Functions
print_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
print_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
print_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Main
main() {
    print_info "Starting script..."
    # Your code here
    print_success "Script completed successfully!"
}

main "$@"
EOF

    cat > "$base_dir/templates/README-templates/project-readme.md" << 'EOF'
# [Project Name]

## Overview

[Brief description of the project]

## Prerequisites

- Requirement 1
- Requirement 2
- Requirement 3

## Installation

```bash
# Installation steps
```

## Usage

```bash
# Usage examples
```

## Configuration

Configuration options and environment variables.

## Contributing

Guidelines for contributing to this project.

## License

[License information]

## Contact

- Team: [Team Name]
- Email: [Email]
- Slack: [Slack Channel]
EOF

    create_readme "$base_dir/templates/README.md" "Templates" "Reusable templates for documentation and automation"
}

# ============================================================================
# Creazione struttura TOOLS
# ============================================================================

create_tools_structure() {
    local base_dir="$1"
    print_section "Creating TOOLS structure..."
    
    create_folder "$base_dir/tools/linters"
    create_folder "$base_dir/tools/helpers"
    create_folder "$base_dir/tools/ci-support"
    
    print_info "tools/linters/"
    print_info "tools/helpers/"
    print_info "tools/ci-support/"
    
    # Create a sample helper script
    cat > "$base_dir/tools/helpers/check-dependencies.sh" << 'EOF'
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
EOF
    chmod +x "$base_dir/tools/helpers/check-dependencies.sh"
    
    create_readme "$base_dir/tools/README.md" "Tools" "Helper tools and utilities"
}

# ============================================================================
# Creazione file principali
# ============================================================================

create_root_files() {
    local base_dir="$1"
    print_section "Creating root files..."
    
    # Main README
    cat > "$base_dir/README.md" << 'EOF'
# DevOps & Infrastructure Repository

## 📚 Overview

This repository contains a comprehensive collection of DevOps and Infrastructure automation tools, scripts, documentation, and templates.

## 📁 Structure

```
.
├── docs/               # Documentation organized by topic
├── scripts/            # Automation scripts
├── templates/          # Reusable templates
└── tools/              # Helper tools and utilities
```

## 🚀 Quick Start

1. Clone this repository
2. Review the documentation in `docs/`
3. Explore scripts in `scripts/`
4. Use templates from `templates/`

## 📖 Documentation Index

- [00 - Meta](docs/00-meta/) - Project organization
- [01 - Foundations](docs/01-foundations/) - Basic concepts
- [02 - Git & GitHub](docs/02-git-github/) - Version control
- [03 - Containers](docs/03-containers/) - Docker & containers
- [04 - Kubernetes Core](docs/04-k8s-core/) - K8s fundamentals
- [05 - Kubernetes Advanced](docs/05-k8s-advanced/) - Advanced K8s
- [06 - Helm](docs/06-helm/) - Package management
- [07 - IaC](docs/07-iac/) - Infrastructure as Code
- [08 - Cloud Generic](docs/08-cloud-generic/) - Multi-cloud
- [09 - Azure](docs/09-azure/) - Azure specific
- [10 - CI/CD](docs/10-ci-cd/) - Pipelines & automation
- [11 - Observability](docs/11-observability/) - Monitoring & logging
- [12 - Security](docs/12-security/) - Security practices
- [13 - Data & Messaging](docs/13-data-messaging/) - Databases & queues
- [14 - Serverless](docs/14-serverless/) - FaaS & serverless
- [15 - Edge & Hybrid](docs/15-edge-hybrid/) - Edge computing
- [16 - Dev Environment](docs/16-dev-env/) - Developer tools
- [17 - Incident & Runbooks](docs/17-incident-runbook/) - Operations
- [18 - E2E Workflows](docs/18-workflows-e2e/) - Complete workflows

## 🛠️ Tools

Check available tools in the `tools/` directory:
- Linters for code quality
- Helper scripts
- CI/CD support tools

## 📝 Templates

Reusable templates available in `templates/`:
- README templates
- Wiki page templates
- Script headers
- Pipeline templates

## 🤝 Contributing

Contributions are welcome! Please follow the guidelines in each section.

## 📞 Support

For questions or support, contact the DevOps team.

---

**Last Updated:** $(date +"%Y-%m-%d")
EOF

    # .gitignore
    cat > "$base_dir/.gitignore" << 'EOF'
# OS
.DS_Store
Thumbs.db
*.swp
*.swo
*~

# IDE
.vscode/
.idea/
*.iml

# Logs
*.log
logs/

# Temporary files
tmp/
temp/
*.tmp

# Secrets (NEVER commit secrets!)
*.key
*.pem
*.pfx
*.p12
secrets/
.env.local
.env.*.local

# Terraform
.terraform/
*.tfstate
*.tfstate.*
*.tfvars
.terraform.lock.hcl

# Python
__pycache__/
*.py[cod]
*.egg-info/
.venv/
venv/

# Node
node_modules/
npm-debug.log*

# Build artifacts
dist/
build/
EOF

    # .editorconfig
    cat > "$base_dir/.editorconfig" << 'EOF'
root = true

[*]
charset = utf-8
end_of_line = lf
insert_final_newline = true
trim_trailing_whitespace = true

[*.{sh,bash}]
indent_style = space
indent_size = 4

[*.{yml,yaml}]
indent_style = space
indent_size = 2

[*.{tf,hcl}]
indent_style = space
indent_size = 2

[*.py]
indent_style = space
indent_size = 4

[*.ps1]
indent_style = space
indent_size = 4

[Makefile]
indent_style = tab
EOF

    print_info "README.md"
    print_info ".gitignore"
    print_info ".editorconfig"
}

# ============================================================================
# Main execution
# ============================================================================

main() {
    print_header "DevOps/Infrastructure Structure Generator"
    
    # Get project name
    read -p "Nome del progetto/directory [devops-repo]: " project_name
    project_name="${project_name:-devops-repo}"
    
    base_dir="$(pwd)/$project_name"
    
    # Check if directory exists
    if [[ -d "$base_dir" ]]; then
        echo ""
        print_warning "Directory '$project_name' già esistente!"
        read -p "Vuoi continuare e sovrascrivere? (y/n): " confirm
        if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
            print_info "Operazione annullata."
            exit 0
        fi
    fi
    
    echo ""
    print_info "Creazione struttura in: $base_dir"
    echo ""
    
    # Create base directory
    create_folder "$base_dir"
    
    # Create all structures
    create_docs_structure "$base_dir"
    create_scripts_structure "$base_dir"
    create_templates_structure "$base_dir"
    create_tools_structure "$base_dir"
    create_root_files "$base_dir"
    
    # Summary
    print_header "Struttura Creata con Successo!"
    
    echo -e "${GREEN}✓ Documentazione:${NC} 18 categorie"
    echo -e "${GREEN}✓ Scripts:${NC} 30+ categorie organizzate"
    echo -e "${GREEN}✓ Templates:${NC} 4 tipologie"
    echo -e "${GREEN}✓ Tools:${NC} 3 categorie"
    echo ""
    echo -e "${CYAN}📂 Location:${NC} $base_dir"
    echo ""
    echo -e "${YELLOW}Next steps:${NC}"
    echo "  1. cd $project_name"
    echo "  2. git init"
    echo "  3. git add ."
    echo "  4. git commit -m 'Initial DevOps repository structure'"
    echo ""
    
    # Tree view
    if command -v tree &> /dev/null; then
        echo -e "${CYAN}Tree view (first 3 levels):${NC}"
        echo ""
        tree -L 3 -d "$base_dir" 2>/dev/null || true
    fi
    
    echo ""
    print_header "Fatto! 🚀"
}

# Execute main
main "$@"