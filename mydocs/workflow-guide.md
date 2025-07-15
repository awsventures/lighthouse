# AWS Ventures Performance Optimization Workflow

**Quick Reference Guide for Ongoing Performance Monitoring**

## 📊 Summary of Completed Work

### ✅ Baseline Established (July 14, 2025)
- **9 pages audited** across AWS Ventures website
- **Lighthouse v12.8.0** desktop preset used
- **18 report files** generated (HTML + JSON)
- **Complete documentation** created
- **Git branch**: `baseline-20250714` with 2 commits

### 🗂️ File Organization
```
lighthouse/
├── mydocs/
│   ├── instructions.md              # Complete project documentation
│   ├── links.txt                    # Clean URL list (9 pages)
│   ├── performance-comparison-plan.md  # Future audit workflow
│   └── workflow-guide.md            # This quick reference
├── docs/
│   └── baseline-20250714/
│       ├── README.md                # Baseline documentation
│       ├── PERFORMANCE_SUMMARY.md   # Performance overview
│       └── *.report.* files         # 18 audit reports
├── batch-lighthouse-audit.sh        # Production-ready script
└── report/                          # Temporary audit outputs
```

## 🚀 Quick Start: Run New Audit

### 1. Prepare New Audit
```bash
cd /c/dev/Projects/lighthouse
git checkout -b audit-$(date +%Y%m%d)
lighthouse --version  # Verify version consistency
```

### 2. Execute Batch Audit
```bash
./batch-lighthouse-audit.sh
# Select option 2 (manual input)
# Paste URLs from mydocs/links.txt
```

### 3. Organize Results
```bash
AUDIT_DATE=$(date +%Y%m%d)
mkdir -p docs/comparison-${AUDIT_DATE}
cp -r report/batch-*/* docs/comparison-${AUDIT_DATE}/
```

### 4. Create Comparison Analysis
```bash
# Copy template from mydocs/performance-comparison-plan.md
# Fill in actual metrics comparison
# Document improvements made
```

## 📈 Performance Tracking Commands

### Extract Performance Scores
```bash
# Get performance scores from all pages
for file in docs/baseline-20250714/*.json; do
    url=$(grep -o '"finalUrl":"[^"]*' "$file" | cut -d'"' -f4)
    perf=$(grep -o '"performance":{"score":[0-9.]*' "$file" | cut -d':' -f3)
    echo "$url: $(echo "$perf * 100" | bc -l)%"
done
```

### Compare Before/After
```bash
# Simple comparison script
echo "Performance Score Comparison:"
baseline_perf=$(grep -o '"performance":{"score":[0-9.]*' docs/baseline-20250714/awsventures.report.json | cut -d':' -f3)
new_perf=$(grep -o '"performance":{"score":[0-9.]*' docs/comparison-*/awsventures.report.json | cut -d':' -f3)
echo "Homepage: $(echo "$baseline_perf * 100" | bc -l)% → $(echo "$new_perf * 100" | bc -l)%"
```

## 🎯 Optimization Checklist

### Before Each Audit
- [ ] Same URLs tested (use mydocs/links.txt)
- [ ] Same Lighthouse version (or note differences)
- [ ] Same preset (desktop)
- [ ] Clean branch created

### After Each Audit
- [ ] Results saved to `docs/comparison-YYYYMMDD/`
- [ ] Comparison analysis created
- [ ] Performance improvements documented
- [ ] Changes committed to audit branch
- [ ] Next steps identified

## 🔄 Regular Schedule

### Recommended Frequency
- **During active optimization**: Weekly audits
- **Maintenance phase**: Monthly audits  
- **Post-major changes**: Immediate audit

### Performance Goals
- **Performance**: +10 points per page
- **Accessibility**: Maintain 90%+
- **Best Practices**: Achieve 95%+
- **SEO**: Maintain 90%+

## 📚 Documentation References

- **Complete Instructions**: `mydocs/instructions.md`
- **Comparison Plan**: `mydocs/performance-comparison-plan.md`
- **Baseline Results**: `docs/baseline-20250714/README.md`
- **URL List**: `mydocs/links.txt`

## 🛠️ Troubleshooting

### Common Issues
- **Script permissions**: Run `chmod +x batch-lighthouse-audit.sh`
- **Node version**: Ensure Node.js LTS is installed
- **Chrome issues**: Run with `--chrome-flags="--headless"`
- **Network timeouts**: Retry audit if pages fail

### Getting Help
1. Check `mydocs/instructions.md` for detailed setup
2. Review `mydocs/performance-comparison-plan.md` for analysis
3. Examine baseline results in `docs/baseline-20250714/`

---

*This workflow guide provides everything needed for ongoing performance monitoring and optimization of the AWS Ventures website.* 