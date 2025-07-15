# Lighthouse Performance Baseline Workflow

A comprehensive guide for using the [Google Chrome Lighthouse](https://developer.chrome.com/docs/lighthouse/overview/) repository as a baseline for measuring website performance while showcasing your Git workflow expertise.

## Overview

This workflow demonstrates how to:
- Use the [Lighthouse repository](https://github.com/GoogleChrome/lighthouse) as a foundation
- Create baseline performance metrics for your websites
- Compare results after optimization strategies
- Showcase your Git and performance analysis skills publicly

## Current Project Status

### ✅ **Completed Setup (July 2025)**

**Repository Configuration:**
- **Fork**: `https://github.com/awsventures/lighthouse.git` (your fork)
- **Upstream**: `https://github.com/GoogleChrome/lighthouse.git` (Google's original)
- **Branch**: `baseline-20250714` (dedicated baseline branch)
- **Directory Structure**: Fixed nested `lighthouse/lighthouse/` issue - all files now at root level

**Tools Installed:**
- **Lighthouse CLI**: v12.8.0 ✅
- **GitHub CLI**: v2.50.0 ✅
- **Authentication**: Configured as `awsventures` ✅

**Files Created:**
- `mydocs/instructions.md` - This comprehensive documentation
- `mydocs/links.txt` - Clean URL list (9 AWS Ventures pages)
- `batch-lighthouse-audit.sh` - Production-ready batch testing script
- `docs/baseline-20250714/README.md` - Baseline audit documentation
- `docs/baseline-20250714/PERFORMANCE_SUMMARY.md` - Performance overview

### ✅ **Completed Baseline Audit (July 14, 2025)**

**Audit Results:**
- **✅ 9 pages successfully audited** from https://awsventures.com/
- **⏱️ Total audit time**: 3 minutes 37 seconds
- **🗂️ 20 files created**: 18 reports + 2 documentation files
- **📈 Total baseline data**: ~18.5MB
- **🎯 Lighthouse version**: v12.8.0 desktop preset

**Pages Audited:**
- **Core Business Pages**: Homepage, Company, Services, Process, Contact
- **Legal Pages**: Privacy Policy, Terms & Conditions, Copyright, Opt-out Preferences

**Report Files Generated:**
- **HTML Reports**: 9 interactive reports (816KB - 1.4MB each)
- **JSON Reports**: 9 machine-readable data files (863KB - 1.7MB each)
- **All reports stored**: `docs/baseline-20250714/` for permanent reference

**Git Branch Management:**
- **Baseline branch**: `baseline-20250714` created and committed
- **Commit history**: 2 commits with comprehensive audit results
- **Ready for**: Future comparison branches and performance tracking

### 🔄 **Next Steps Available**

1. **✅ COMPLETED**: Initial baseline audit establishment
2. **🎯 READY**: Performance improvement implementation
3. **📊 READY**: Future audit comparisons using established workflow
4. **🚀 READY**: CI/CD integration for automated monitoring

### 🛠️ **Quick Start Commands**

```bash
# Navigate to repository
cd /c/dev/Projects/lighthouse

# Check current status
git status
lighthouse --version

# Run single page audit
lighthouse https://awsventures.com/ \
  --output json --output html \
  --output-path ./report/homepage-$(date +%Y%m%d).html \
  --preset=desktop

# Run batch audit (after editing mydocs/links.txt)
chmod +x batch-lighthouse-audit.sh
./batch-lighthouse-audit.sh
```

### 🐛 **Known Issues & Solutions**

**Problem**: Nested directory structure (`lighthouse/lighthouse/`)
**Solution**: ✅ Fixed - All files moved to root level

**Problem**: Report files not tracked in git
**Solution**: ✅ Normal behavior - `.gitignore` excludes `*.report.*` files

**Problem**: Batch script needs page URLs
**Solution**: ⚠️ **ACTION REQUIRED** - Add URLs to `mydocs/links.txt`

**Problem**: GitHub Pages not configured
**Solution**: ⚠️ **ACTION REQUIRED** - Enable in repository settings

### 📊 **Sample Audit Results**

**Test Site**: `https://awsventures.com/`
**Date**: July 14, 2025
**Configuration**: Desktop preset
**Results**: Available in `report/awsventures-20250714.report.html`

**File Locations:**
- Reports: `./report/` (ignored by git)
- Documentation: `./mydocs/`
- Batch Script: `./batch-lighthouse-audit.sh`

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

## Batch Audit Script

The included `batch-lighthouse-audit.sh` script enables testing multiple pages systematically:

### Features

- **Auto-discovery**: Tests common page paths automatically
- **Manual URL input**: Specify exact pages to test
- **Organized output**: Creates timestamped report directories
- **Summary generation**: Creates markdown summary with scores (requires `jq`)
- **Colored output**: Visual feedback during execution

### Usage

```bash
# Make script executable (first time only)
chmod +x batch-lighthouse-audit.sh

# Run the script
./batch-lighthouse-audit.sh

# Choose option 1 for auto-discovery or 2 for manual input
```

### Auto-Discovery Mode

Tests common paths on your domain:
- `/` (homepage)
- `/about`, `/about-us`
- `/services`, `/products`
- `/contact`, `/blog`
- `/portfolio`, `/team`
- And 15+ other common paths

### Manual Input Mode

Enter specific URLs one per line:
```
https://awsventures.com/
https://awsventures.com/services/
https://awsventures.com/about/
```

### Output Structure

```
report/
├── batch-20250714-143022/
│   ├── awsventures.com.report.html
│   ├── awsventures.com.report.json
│   ├── awsventures.com_services.report.html
│   ├── awsventures.com_services.report.json
│   └── summary.md
```

### Script Configuration

Edit the script to customize:
- `DOMAIN`: Your website domain
- `PRESET`: Lighthouse preset (desktop/mobile)
- `REPORT_DIR`: Output directory pattern
- Common paths array for auto-discovery

### Example Output

```bash
🚀 Starting Batch Lighthouse Audit
Domain: awsventures.com
Report Directory: report/batch-20250714-143022

[14:30:22] Discovering pages on https://awsventures.com...
✅ Found: https://awsventures.com/
✅ Found: https://awsventures.com/services/
⚠️  Not found: https://awsventures.com/blog

[14:30:25] Found 2 URLs to audit
[14:30:25] Auditing: https://awsventures.com/
✅ Success: https://awsventures.com/
[14:30:45] Auditing: https://awsventures.com/services/
✅ Success: https://awsventures.com/services/

🎉 Batch audit complete!
Reports saved to: report/batch-20250714-143022/
```

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

## Handoff Instructions

### 📋 **Immediate Action Items**

1. **Complete Page URL List**
   ```bash
   # Edit the links file with all pages to test
   nano mydocs/links.txt
   
   # Add URLs like:
   # https://awsventures.com/
   # https://awsventures.com/services/
   # https://awsventures.com/about/
   ```

2. **Run Comprehensive Audit**
   ```bash
   # Execute batch audit on all pages
   ./batch-lighthouse-audit.sh
   
   # Choose option 2 (manual input) if you updated links.txt
   # Or option 1 (auto-discovery) to test common paths
   ```

3. **Create Baseline Branch**
   ```bash
   # Create dated baseline branch
   git checkout -b baseline-$(date +%Y%m%d)
   
   # Move reports to docs for GitHub Pages
   mkdir -p docs/baseline-$(date +%Y%m%d)
   cp report/batch-*/awsventures*.report.* docs/baseline-$(date +%Y%m%d)/
   
   # Commit baseline
   git add docs/baseline-$(date +%Y%m%d)
   git commit -m "Baseline Lighthouse scores for $(date +%Y-%m-%d)"
   git push -u origin baseline-$(date +%Y%m%d)
   ```

4. **Enable GitHub Pages**
   - Go to repository **Settings** → **Pages**
   - Source: "Deploy from a branch"
   - Branch: `main` or your baseline branch
   - Folder: `docs/`

### 🔄 **Ongoing Workflow**

```bash
# For each optimization cycle:
git checkout -b optimize-[feature-name]
# Make optimization changes
# Re-run lighthouse audit
# Compare results
# Create PR with before/after comparison
```

### 📊 **Current Repository State**

**Last Updated**: July 14, 2025  
**Repository**: https://github.com/awsventures/lighthouse  
**Branch**: `main`  
**Commit**: `a196e652b` - Directory restructure completed  

**Files Ready for Use**:
- ✅ `batch-lighthouse-audit.sh` - Batch testing script
- ✅ `mydocs/instructions.md` - This documentation
- ✅ `mydocs/links.txt` - Page URL management
- ✅ `report/awsventures-20250714.report.*` - Sample audit results

**Configuration Status**:
- ✅ GitHub fork configured
- ✅ Lighthouse CLI installed (v12.8.0)
- ✅ Directory structure fixed
- ⚠️ GitHub Pages - **ACTION REQUIRED**
- ⚠️ Page URLs list - **ACTION REQUIRED**

### 🆘 **Troubleshooting Guide**

**Script won't run**: `chmod +x batch-lighthouse-audit.sh`
**No pages found**: Check `mydocs/links.txt` formatting
**Git push fails**: Ensure you're on correct branch
**Reports not generating**: Verify lighthouse CLI: `lighthouse --version`
**GitHub Pages not working**: Check repository settings

### 👥 **Handoff Checklist**

- [ ] Repository cloned and accessible
- [ ] Lighthouse CLI verified working
- [ ] Page URLs added to `mydocs/links.txt`
- [ ] Batch audit script tested
- [ ] Baseline branch created
- [ ] GitHub Pages enabled
- [ ] First optimization cycle planned

**Contact**: Repository owner `awsventures` on GitHub

## Resources

- [Lighthouse Documentation](https://developer.chrome.com/docs/lighthouse/overview/)
- [Lighthouse-CI Documentation](https://github.com/GoogleChrome/lighthouse-ci)
- [GitHub Pages Setup](https://docs.github.com/en/pages)
- [Conventional Commits](https://www.conventionalcommits.org/)

---

Happy auditing! 🚀 