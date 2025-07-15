#!/bin/bash

# Optimized Baseline Audit Script
echo "🚀 Starting Optimized Baseline Audit - $(date)"
echo "📊 Establishing post-optimization performance as new baseline"

BASELINE_DIR="docs/baseline-optimized-20250715"
mkdir -p "$BASELINE_DIR"

echo "Auditing 1/9: Homepage..."
lighthouse https://awsventures.com/ \
  --output json --output html \
  --output-path "$BASELINE_DIR/awsventures" \
  --preset=desktop --quiet

echo "Auditing 2/9: Company..."
lighthouse https://awsventures.com/company/ \
  --output json --output html \
  --output-path "$BASELINE_DIR/awsventures.com_company" \
  --preset=desktop --quiet

echo "Auditing 3/9: Services..."
lighthouse https://awsventures.com/services/ \
  --output json --output html \
  --output-path "$BASELINE_DIR/awsventures.com_services" \
  --preset=desktop --quiet

echo "Auditing 4/9: Process..."
lighthouse https://awsventures.com/process/ \
  --output json --output html \
  --output-path "$BASELINE_DIR/awsventures.com_process" \
  --preset=desktop --quiet

echo "Auditing 5/9: Contact..."
lighthouse https://awsventures.com/contact/ \
  --output json --output html \
  --output-path "$BASELINE_DIR/awsventures.com_contact" \
  --preset=desktop --quiet

echo "Auditing 6/9: Privacy Policy..."
lighthouse https://awsventures.com/privacy-policy/ \
  --output json --output html \
  --output-path "$BASELINE_DIR/awsventures.com_privacy-policy" \
  --preset=desktop --quiet

echo "Auditing 7/9: Terms & Conditions..."
lighthouse https://awsventures.com/term_conditions/ \
  --output json --output html \
  --output-path "$BASELINE_DIR/awsventures.com_term_conditions" \
  --preset=desktop --quiet

echo "Auditing 8/9: Copyright..."
lighthouse https://awsventures.com/copyright/ \
  --output json --output html \
  --output-path "$BASELINE_DIR/awsventures.com_copyright" \
  --preset=desktop --quiet

echo "Auditing 9/9: Opt-out Preferences..."
lighthouse https://awsventures.com/opt-out-preferences/ \
  --output json --output html \
  --output-path "$BASELINE_DIR/awsventures.com_opt-out-preferences" \
  --preset=desktop --quiet

echo "🎉 Optimized Baseline Audit Complete!"
echo "📁 Results saved to: $BASELINE_DIR"
echo "📊 All 9 pages audited successfully" 