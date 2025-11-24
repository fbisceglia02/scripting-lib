# Analytics Scripts

Generate insights and metrics about repositories and development practices.

## Metrics Tracked

### Repository Metrics
- Total commits
- Files count
- Lines of code
- Repository age
- Commit frequency

### Contributor Statistics
- Active contributors
- Commit distribution
- Code ownership
- Contribution trends

### Velocity Tracking
- Sprint velocity
- Lead time for changes
- Deployment frequency
- Change failure rate

### Technical Debt
- Code complexity
- Duplication percentage
- TODO/FIXME tracking
- Outdated dependencies

### Code Coverage
- Test coverage trends
- Uncovered files
- Coverage by module
- Historical tracking

## Usage

### Generate full report
```bash
./repo-metrics/analyze-repo.sh > report.txt
```

### Contributor stats
```bash
./contributor-stats/generate-stats.sh --format json
```

### Track velocity
```bash
./velocity-tracking/calculate-velocity.sh --weeks 4
```
