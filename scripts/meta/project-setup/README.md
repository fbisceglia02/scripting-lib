# Project Setup Scripts

Bootstrap new repositories with standardized structure and configurations.

## Scripts

### init-repo.sh
Initialize a new Git repository with:
- Standard directory structure
- README, CONTRIBUTING, LICENSE templates
- .gitignore configuration
- Initial commit

**Usage:**
```bash
./init-repo.sh [project-name]
```

### setup-git-hooks.sh
Configure Git hooks for automation:
- pre-commit: Run linters and tests
- pre-push: Validate commits
- commit-msg: Validate commit messages

### configure-branching.sh
Set up branching strategies:
- GitFlow (main, develop, feature/*, hotfix/*)
- Trunk-based development
- GitHub Flow

### setup-ci-cd-basics.sh
Initialize CI/CD pipelines:
- GitHub Actions workflows
- Azure Pipelines templates
- GitLab CI configurations
