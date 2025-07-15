#!/bin/bash

# Batch Lighthouse Audit Script
# Usage: ./batch-lighthouse-audit.sh

# Configuration
DOMAIN="awsventures.com"
BASE_URL="https://${DOMAIN}"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
REPORT_DIR="report/batch-${TIMESTAMP}"
PRESET="desktop"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Create report directory
mkdir -p "${REPORT_DIR}"

# Function to log messages
log() {
    echo -e "${BLUE}[$(date '+%H:%M:%S')]${NC} $1"
}

# Function to run lighthouse on a single URL
audit_url() {
    local url=$1
    local name=$2
    
    log "Auditing: ${url}"
    
    # Generate filename from URL
    local filename="${name:-$(echo $url | sed 's|https://||' | sed 's|/|_|g' | sed 's|_$||')}"
    
    # Run lighthouse
    lighthouse "$url" \
        --output json --output html \
        --output-path "${REPORT_DIR}/${filename}" \
        --preset="$PRESET" \
        --quiet \
        --chrome-flags="--headless" 2>/dev/null
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Success: ${url}${NC}"
    else
        echo -e "${RED}❌ Failed: ${url}${NC}"
    fi
}

# Function to discover pages by checking common paths
discover_pages() {
    local common_paths=(
        "/"
        "/about"
        "/about-us"
        "/services"
        "/products"
        "/contact"
        "/blog"
        "/portfolio"
        "/team"
        "/careers"
        "/privacy"
        "/terms"
        "/support"
        "/help"
        "/faq"
        "/pricing"
        "/solutions"
        "/case-studies"
        "/testimonials"
        "/news"
    )
    
    local valid_urls=()
    
    log "Discovering pages on ${BASE_URL}..."
    
    for path in "${common_paths[@]}"; do
        local url="${BASE_URL}${path}"
        # Check if URL returns 200 status
        if curl -s --head "$url" | head -n 1 | grep -q "200 OK"; then
            valid_urls+=("$url")
            echo -e "${GREEN}✅ Found: ${url}${NC}"
        else
            echo -e "${YELLOW}⚠️  Not found: ${url}${NC}"
        fi
    done
    
    echo "${valid_urls[@]}"
}

# Function to create summary report
create_summary() {
    local report_files=($(find "${REPORT_DIR}" -name "*.report.json"))
    local summary_file="${REPORT_DIR}/summary.md"
    
    cat > "$summary_file" << EOF
# Lighthouse Audit Summary

**Date**: $(date)
**Domain**: ${DOMAIN}
**Preset**: ${PRESET}
**Total Pages**: ${#report_files[@]}

## Results

| Page | Performance | Accessibility | Best Practices | SEO |
|------|-------------|---------------|----------------|-----|
EOF

    for file in "${report_files[@]}"; do
        if [ -f "$file" ]; then
            local url=$(jq -r '.finalUrl' "$file" 2>/dev/null)
            local perf=$(jq -r '.categories.performance.score * 100' "$file" 2>/dev/null)
            local a11y=$(jq -r '.categories.accessibility.score * 100' "$file" 2>/dev/null)
            local bp=$(jq -r '.categories["best-practices"].score * 100' "$file" 2>/dev/null)
            local seo=$(jq -r '.categories.seo.score * 100' "$file" 2>/dev/null)
            
            if [ "$url" != "null" ]; then
                echo "| [$url]($url) | ${perf}% | ${a11y}% | ${bp}% | ${seo}% |" >> "$summary_file"
            fi
        fi
    done
    
    log "Summary created: ${summary_file}"
}

# Main execution
main() {
    echo -e "${BLUE}🚀 Starting Batch Lighthouse Audit${NC}"
    echo -e "${BLUE}Domain: ${DOMAIN}${NC}"
    echo -e "${BLUE}Report Directory: ${REPORT_DIR}${NC}"
    echo ""
    
    # Option 1: Use predefined URLs
    read -p "Do you want to (1) auto-discover pages or (2) specify URLs manually? [1/2]: " choice
    
    case $choice in
        1)
            log "Auto-discovering pages..."
            urls=($(discover_pages))
            ;;
        2)
            log "Manual URL input mode"
            echo "Enter URLs one per line (press Enter twice to finish):"
            urls=()
            while IFS= read -r line; do
                [[ -z "$line" ]] && break
                urls+=("$line")
            done
            ;;
        *)
            log "Invalid choice. Using auto-discovery..."
            urls=($(discover_pages))
            ;;
    esac
    
    if [ ${#urls[@]} -eq 0 ]; then
        echo -e "${RED}❌ No URLs found to audit${NC}"
        exit 1
    fi
    
    echo ""
    log "Found ${#urls[@]} URLs to audit"
    
    # Audit each URL
    for url in "${urls[@]}"; do
        audit_url "$url"
        sleep 2  # Brief pause between audits
    done
    
    # Create summary if jq is available
    if command -v jq &> /dev/null; then
        create_summary
    else
        log "Install 'jq' to generate summary reports"
    fi
    
    echo ""
    echo -e "${GREEN}🎉 Batch audit complete!${NC}"
    echo -e "${GREEN}Reports saved to: ${REPORT_DIR}${NC}"
    echo -e "${GREEN}Open HTML reports in browser to view results${NC}"
}

# Run main function
main "$@" 