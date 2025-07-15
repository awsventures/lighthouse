# Lighthouse Performance Baseline Workflow

A comprehensive guide for using the [Google Chrome Lighthouse](https://developer.chrome.com/docs/lighthouse/overview/) repository as a baseline for measuring website performance while showcasing your Git workflow expertise.

## Overview

This workflow demonstrates how to:
- Use the [Lighthouse repository](https://github.com/GoogleChrome/lighthouse) as a foundation
- Create baseline performance metrics for your websites
- Compare results after optimization strategies
- Showcase your Git and performance analysis skills publicly

## Getting Started

### 1. Fork and Clone the Lighthouse Repository

| Step | Command | Purpose |
|------|---------|---------|
| 1 | `gh repo fork GoogleChrome/lighthouse --clone` | Creates your own public copy for pushing branches and PRs |
| 2 | `cd lighthouse` | Enter the working directory |
| 3 | `git remote add upstream https://github.com/GoogleChrome/lighthouse.git` | Enables pulling future updates from Google |

> **Note**: If you don't use GitHub CLI, use the Fork button in the GitHub UI instead.

### 2. Create a Dedicated Baseline Branch

```bash
git checkout -b baseline-20250713
```

Naming the branch after the date keeps your history organized and clearly indicates when metrics were captured.

### 3. Install and Run Lighthouse CLI

Lighthouse is a Node package that provides repeatable, script-friendly audits—perfect for baseline measurements.

#### Prerequisites

```bash
# Install Node.js LTS
nvm install --lts

# Install Lighthouse CLI globally
npm install -g lighthouse
```

#### Running Performance Audits

```bash
# Example: audit your homepage
lighthouse https://awsventures.com/ \
          --output json --output html \
          --output-path ./report/awsventures-20250713.html \
          --preset=desktop
```

**What this command does:**
- Runs Chrome headless to capture performance, accessibility, SEO & best-practice scores
- Outputs both HTML (human-readable) and JSON (machine-readable) formats
- Saves reports to `./report/` for easy comparison later

> **Tip**: Test multiple pages by creating a bash wrapper or using [Lighthouse-CI](https://github.com/GoogleChrome/lighthouse-ci) to loop through URL lists.

### 4. Commit Baseline Reports

```bash
mkdir -p docs/baseline-20250713
mv report/* docs/baseline-20250713/
git add docs/baseline-20250713
git commit -m "Baseline Lighthouse scores for 2025-07-13"
git push -u origin baseline-20250713
```

**Benefits of this structure:**
- Placing HTML files in `docs/` enables automatic GitHub Pages rendering
- Each branch acts as a performance snapshot
- Reviewers can browse raw reports directly in the GitHub UI

## Automation with Lighthouse-CI

For automated performance testing on every optimization PR:

### Installation

```bash
npm install -g @lhci/cli
```

### Configuration

Create `lighthouserc.js` in your repository root:

```javascript
module.exports = {
  ci: {
    collect: {
      url: [
        'https://awsventures.com/',
        'https://awsventures.com/services/'
      ],
      numberOfRuns: 3
    },
    upload: { target: 'temporary-public-storage' }
  }
};
```

### GitHub Actions Integration

The CI workflow will:
- Spin up Chrome automatically
- Run performance audits
- Comment on pull requests with comparison tables
- Fail builds if scores regress past your thresholds

## Optimization Workflow

### 1. Create Optimization Branch

```bash
git checkout -b optimize-images
```

### 2. Apply Your Optimization

Example: Enable EWWW image compression or implement lazy loading.

### 3. Re-run Lighthouse

Either manually or let the CI job handle it automatically.

### 4. Commit New Reports

```bash
mkdir -p docs/after-optimize-images-20250714
# Move new report files to this folder
git add docs/after-optimize-images-20250714
git commit -m "perf: optimize images with EWWW compression"
git push -u origin optimize-images
```

### 5. Create Pull Request

GitHub will display side-by-side diffs via Lighthouse-CI comments or by browsing the report folders.

## Professional Showcase Features

### GitHub Pages Setup

1. Go to **Settings** → **Pages**
2. Select `docs/` folder as source
3. Access reports at: `https://<your-user>.github.io/lighthouse/baseline-20250713/awsventures-20250713.html`

### README Enhancements

- Add badges linking to latest HTML reports
- Include performance score trends
- Document optimization strategies used

### Commit Hygiene

Use [conventional commits](https://www.conventionalcommits.org/) for clean history:

```bash
git commit -m "perf: enable Redis caching for 40% speed improvement"
git commit -m "feat: implement lazy loading for images"
git commit -m "chore: update Lighthouse to v11.0.0"
```

## Safety and Rollback Strategy

### Backup Strategy

```bash
# Tag baseline before optimizing
git tag v0.0-baseline

# Small, incremental changes
git commit -m "perf: enable Redis cache"
# Test and measure before next change
```

### Rollback Process

```bash
# If optimization degrades performance
git revert <commit-hash>
# Redeploy and re-run Lighthouse to confirm recovery
```

## Benefits of This Approach

✅ **Public Portfolio**: Demonstrates Git expertise and performance analysis skills  
✅ **Repeatable Process**: Scientific approach to optimization tracking  
✅ **Professional Documentation**: Clean commit history and structured reporting  
✅ **Automated Testing**: CI integration prevents performance regressions  
✅ **Historical Tracking**: Complete audit trail of optimization efforts  

## Resources

- [Lighthouse Documentation](https://developer.chrome.com/docs/lighthouse/overview/)
- [Lighthouse-CI Documentation](https://github.com/GoogleChrome/lighthouse-ci)
- [GitHub Pages Setup](https://docs.github.com/en/pages)
- [Conventional Commits](https://www.conventionalcommits.org/)

---

Happy auditing! 🚀 