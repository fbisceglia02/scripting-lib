# Meta Scripts

Scripts for repository management, automation, and standardization.

## Categories

### 🏗️ Project Setup
Initialize and configure new repositories with best practices.
- **init-repository**: Bootstrap new projects
- **setup-git-hooks**: Configure pre-commit, pre-push hooks
- **configure-branching**: Set up branching strategies (GitFlow, trunk-based)
- **setup-ci-cd-basics**: Initial CI/CD pipeline configuration

### 📚 Documentation
Automate documentation generation and maintenance.
- **generate-docs**: Auto-generate API docs, code docs
- **update-readme**: Keep README files updated
- **create-changelog**: Generate CHANGELOG.md from commits
- **wiki-automation**: Sync docs to wiki platforms
- **doc-validation**: Validate documentation completeness

### 🔧 Maintenance
Keep repositories clean and healthy.
- **dependency-updates**: Automated dependency bumps
- **cleanup-old-branches**: Remove stale branches
- **archive-projects**: Archive deprecated repositories
- **repo-health-check**: Repository health scoring
- **license-compliance**: Ensure license compliance

### 📏 Standards
Enforce coding and commit standards.
- **code-style-enforcement**: Apply code formatters (prettier, black)
- **naming-conventions**: Validate file/function naming
- **commit-message-validation**: Conventional commits validation
- **pr-template-generation**: Generate PR templates
- **quality-gates**: Define quality thresholds

### 🤖 Automation
Bulk operations and workflow automation.
- **bulk-operations**: Multi-repository operations
- **batch-updates**: Apply changes across repos
- **multi-repo-sync**: Keep multiple repos synchronized
- **automated-tagging**: Semantic versioning tags
- **release-automation**: Automated release workflows

### 📊 Analytics
Repository and team metrics.
- **repo-metrics**: Lines of code, commits, etc.
- **contributor-stats**: Developer contributions
- **velocity-tracking**: Sprint/iteration velocity
- **technical-debt**: Identify tech debt
- **code-coverage**: Track test coverage trends

### 👥 Onboarding
New team member setup automation.
- **new-team-member**: Onboarding checklist automation
- **environment-bootstrap**: Developer environment setup
- **access-provisioning**: Grant necessary permissions
- **training-automation**: Generate training materials
- **documentation-generation**: Create onboarding docs

### 🛠️ Utilities
Helper tools and generators.
- **version-management**: Semantic versioning helpers
- **license-headers**: Add/update license headers
- **file-templates**: Code file templates
- **scaffold-generator**: Project scaffolding
- **migration-tools**: Migrate between systems

## Usage Examples

### Initialize a new project
```bash
./project-setup/init-repository/init-repo.sh my-new-project
```

### Clean old branches
```bash
./maintenance/cleanup-old-branches/cleanup-branches.sh 30
```

### Analyze repository
```bash
./analytics/repo-metrics/analyze-repo.sh
```

### Validate commit message
```bash
./standards/commit-message-validation/validate-commit.sh
```
