# Performance Comparison Plan

**Created**: July 14, 2025  
**Baseline Branch**: `baseline-20250714`  
**Baseline Data**: `docs/baseline-20250714/`

## Overview

This plan outlines the complete workflow for running future performance audits and comparing them against the established baseline to measure performance improvements.

## ✅ Established Baseline

### Baseline Audit Summary
- **Date**: July 14, 2025
- **Pages Audited**: 9 AWS Ventures pages
- **Lighthouse Version**: v12.8.0
- **Preset**: Desktop
- **Branch**: `baseline-20250714`
- **Location**: `docs/baseline-20250714/`

### Baseline Results Structure
```
docs/baseline-20250714/
├── README.md                                      # Complete documentation
├── PERFORMANCE_SUMMARY.md                         # Quick overview
├── awsventures.report.html                       # Homepage HTML report
├── awsventures.report.json                       # Homepage JSON data
├── awsventures.com_company.report.html           # Company page HTML
├── awsventures.com_company.report.json           # Company page JSON
└── ... (additional report files for all 9 pages)
```

## 🎯 Future Audit Workflow

### Step 1: Prepare for New Audit
```bash
# Navigate to project directory
cd /c/dev/Projects/lighthouse

# Create new audit branch
git checkout -b audit-$(date +%Y%m%d)

# Ensure you're using the same Lighthouse version for consistency
lighthouse --version  # Should be v12.8.0 or note version differences
```

### Step 2: Run Comparison Audit
```bash
# Run the same batch audit script
./batch-lighthouse-audit.sh

# Select option 2 (manual input) and paste the same URLs:
# https://awsventures.com/
# https://awsventures.com/company/
# https://awsventures.com/services/
# https://awsventures.com/process/
# https://awsventures.com/contact/
# https://awsventures.com/privacy-policy/
# https://awsventures.com/term_conditions/
# https://awsventures.com/copyright/
# https://awsventures.com/opt-out-preferences/
```

### Step 3: Organize Results
```bash
# Move results to comparison directory
AUDIT_DATE=$(date +%Y%m%d)
mkdir -p docs/comparison-${AUDIT_DATE}
cp -r report/batch-*/* docs/comparison-${AUDIT_DATE}/
```

### Step 4: Generate Comparison Report
```bash
# Create comparison analysis (manual analysis template provided below)
# Compare key metrics between baseline and new audit
```

## 📊 Performance Comparison Analysis

### Key Metrics to Track

For each page, compare these scores (0-100):
1. **Performance Score** - Loading speed, Core Web Vitals
2. **Accessibility Score** - WCAG compliance
3. **Best Practices Score** - Security, modern standards
4. **SEO Score** - Search optimization

### Comparison Template

Create `docs/comparison-YYYYMMDD/COMPARISON_ANALYSIS.md`:

```markdown
# Performance Comparison Analysis

**Baseline**: July 14, 2025  
**Comparison**: [NEW_DATE]  
**Lighthouse Version**: [VERSION]

## Summary

| Metric | Baseline Avg | New Avg | Change | Status |
|--------|--------------|---------|--------|--------|
| Performance | [X]% | [Y]% | [+/-Z]% | [↑/↓] |
| Accessibility | [X]% | [Y]% | [+/-Z]% | [↑/↓] |
| Best Practices | [X]% | [Y]% | [+/-Z]% | [↑/↓] |
| SEO | [X]% | [Y]% | [+/-Z]% | [↑/↓] |

## Page-by-Page Analysis

### Homepage (https://awsventures.com/)
- **Performance**: [baseline]% → [new]% ([change])
- **Accessibility**: [baseline]% → [new]% ([change])
- **Best Practices**: [baseline]% → [new]% ([change])
- **SEO**: [baseline]% → [new]% ([change])

[Repeat for all 9 pages]

## Performance Improvements Made

1. **[Improvement 1]**: [Description and expected impact]
2. **[Improvement 2]**: [Description and expected impact]
3. **[Improvement 3]**: [Description and expected impact]

## Recommendations for Next Optimization

1. **[Recommendation 1]**: [Priority and rationale]
2. **[Recommendation 2]**: [Priority and rationale]
3. **[Recommendation 3]**: [Priority and rationale]
```

## 🚀 Automated Analysis Scripts

### Extract Performance Scores
```bash
# Extract performance scores from JSON reports
for file in docs/comparison-*/awsventures*.json; do
    url=$(grep -o '"finalUrl":"[^"]*' "$file" | cut -d'"' -f4)
    perf=$(grep -o '"performance":{"score":[0-9.]*' "$file" | cut -d':' -f3)
    echo "$url: $(echo "$perf * 100" | bc -l)%"
done
```

### Compare Baseline vs New Audit
```bash
# Simple comparison script (requires jq if available)
echo "Performance Score Comparison:"
echo "Baseline vs New Audit"
echo "========================"

# Compare homepage scores
baseline_perf=$(grep -o '"performance":{"score":[0-9.]*' docs/baseline-20250714/awsventures.report.json | cut -d':' -f3)
new_perf=$(grep -o '"performance":{"score":[0-9.]*' docs/comparison-*/awsventures.report.json | cut -d':' -f3)

echo "Homepage Performance: $(echo "$baseline_perf * 100" | bc -l)% → $(echo "$new_perf * 100" | bc -l)%"
```

## 📈 Performance Tracking Over Time

### Branch Strategy
```
main
├── baseline-20250714      # Initial baseline
├── audit-20250721        # Week 1 comparison
├── audit-20250728        # Week 2 comparison
└── audit-20250804        # Week 3 comparison
```

### Documentation Structure
```
docs/
├── baseline-20250714/     # Original baseline
├── comparison-20250721/   # First comparison
├── comparison-20250728/   # Second comparison
├── comparison-20250804/   # Third comparison
└── trends/
    ├── performance-trends.md
    └── optimization-log.md
```

## 🔄 Regular Audit Schedule

### Recommended Frequency
- **During Active Optimization**: Weekly audits
- **Maintenance Phase**: Monthly audits
- **Post-Major Changes**: Immediate audit

### Audit Checklist
- [ ] Same URLs tested (use mydocs/links.txt)
- [ ] Same Lighthouse version (or note differences)
- [ ] Same preset (desktop)
- [ ] Results saved to `docs/comparison-YYYYMMDD/`
- [ ] Comparison analysis created
- [ ] Changes committed to audit branch
- [ ] Improvements documented

## 🎯 Performance Goals

### Target Improvements
- **Performance**: Increase by 10+ points per page
- **Accessibility**: Maintain 90%+ scores
- **Best Practices**: Achieve 95%+ scores
- **SEO**: Maintain 90%+ scores

### Success Metrics
- **Overall site speed**: 20%+ improvement
- **Core Web Vitals**: All pages pass
- **Accessibility**: WCAG 2.1 AA compliance
- **SEO**: All pages optimized

## 🛠️ Integration Options

### GitHub Actions (Future)
```yaml
# .github/workflows/lighthouse-audit.yml
name: Lighthouse Audit Comparison
on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  lighthouse:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Run Lighthouse
        uses: treosh/lighthouse-ci-action@v7
        with:
          configPath: './lighthouserc.js'
```

### Continuous Monitoring
- **Lighthouse CI**: Automated audits on every PR
- **Performance Budgets**: Fail builds if scores regress
- **Trend Analysis**: Track performance over time

This plan provides a complete framework for ongoing performance monitoring and comparison analysis. 