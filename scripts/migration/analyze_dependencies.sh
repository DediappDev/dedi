#!/bin/bash
# Dependency Analysis Script
# Analyzes all transitive dependencies across all package managers

set -e

OUTPUT_DIR="docs/migration"
mkdir -p "$OUTPUT_DIR"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}Starting Comprehensive Dependency Analysis${NC}"
echo "=================================================="
echo "Output directory: $OUTPUT_DIR"
echo ""

# 1. Flutter/Dart pub dependencies
echo -e "${YELLOW}Analyzing Flutter/Dart dependencies...${NC}"
if command -v flutter &> /dev/null; then
    flutter pub deps --style=compact > "$OUTPUT_DIR/flutter_dependencies.txt" 2>&1 || true
    flutter pub deps --style=tree > "$OUTPUT_DIR/flutter_dependencies_tree.txt" 2>&1 || true
    flutter pub deps --json > "$OUTPUT_DIR/flutter_dependencies.json" 2>&1 || true
    echo -e "${GREEN}  ✓ Flutter dependencies analyzed${NC}"
else
    echo -e "${RED}  ✗ Flutter not found${NC}"
fi

# 2. NPM dependencies
echo -e "${YELLOW}Analyzing NPM dependencies...${NC}"
if [ -f "scripts/copy-nse/package.json" ]; then
    cd scripts/copy-nse
    if command -v npm &> /dev/null; then
        npm list --all > "../../$OUTPUT_DIR/npm_dependencies.txt" 2>&1 || true
        npm list --json > "../../$OUTPUT_DIR/npm_dependencies.json" 2>&1 || true
        echo -e "${GREEN}  ✓ NPM dependencies analyzed${NC}"
    else
        echo -e "${RED}  ✗ NPM not found${NC}"
    fi
    cd - > /dev/null
else
    echo -e "${YELLOW}  - No package.json found${NC}"
fi

# 3. Android/Gradle dependencies
echo -e "${YELLOW}Analyzing Android/Gradle dependencies...${NC}"
if [ -f "android/build.gradle" ]; then
    cd android
    if command -v ./gradlew &> /dev/null; then
        ./gradlew dependencies > "../$OUTPUT_DIR/gradle_dependencies.txt" 2>&1 || true
        echo -e "${GREEN}  ✓ Gradle dependencies analyzed${NC}"
    elif command -v gradle &> /dev/null; then
        gradle dependencies > "../$OUTPUT_DIR/gradle_dependencies.txt" 2>&1 || true
        echo -e "${GREEN}  ✓ Gradle dependencies analyzed${NC}"
    else
        echo -e "${RED}  ✗ Gradle not found${NC}"
    fi
    cd - > /dev/null
else
    echo -e "${YELLOW}  - No build.gradle found${NC}"
fi

# 4. iOS CocoaPods dependencies
echo -e "${YELLOW}Analyzing iOS CocoaPods dependencies...${NC}"
if [ -f "ios/Podfile" ]; then
    cd ios
    if command -v pod &> /dev/null; then
        pod install --verbose 2>&1 | tee "../$OUTPUT_DIR/cocoapods_install.log" || true
        pod list > "../$OUTPUT_DIR/cocoapods_dependencies.txt" 2>&1 || true
        echo -e "${GREEN}  ✓ CocoaPods dependencies analyzed${NC}"
    else
        echo -e "${RED}  ✗ CocoaPods not found${NC}"
    fi
    cd - > /dev/null
else
    echo -e "${YELLOW}  - No Podfile found${NC}"
fi

# 5. Extract unique package registries
echo -e "${YELLOW}Extracting package registry sources...${NC}"
{
    echo "# Package Registry Sources"
    echo ""
    echo "## Pub/Dart Packages"
    grep -r "pub.dev\|pub.dartlang.org" pubspec.yaml pubspec.lock 2>/dev/null || echo "None found directly"
    echo ""
    echo "## NPM Packages"
    grep -r "npmjs.org\|registry.npmjs.org" scripts/ 2>/dev/null || echo "None found directly"
    echo ""
    echo "## Maven/Gradle Repositories"
    grep -r "mavenCentral\|google()\|jcenter" android/ 2>/dev/null || echo "None found"
    echo ""
    echo "## CocoaPods Sources"
    grep -r "cdn.cocoapods.org\|trunk.cocoapods.org" ios/ 2>/dev/null || echo "None found"
} > "$OUTPUT_DIR/registry_sources.txt"
echo -e "${GREEN}  ✓ Registry sources extracted${NC}"

# 6. Create summary report
echo -e "${YELLOW}Creating summary report...${NC}"
{
    echo "# Dependency Analysis Summary"
    echo "Generated: $(date)"
    echo ""
    
    echo "## Flutter/Dart Dependencies"
    if [ -f "$OUTPUT_DIR/flutter_dependencies.txt" ]; then
        echo "Total packages: $(wc -l < "$OUTPUT_DIR/flutter_dependencies.txt")"
        echo "Details: See flutter_dependencies_tree.txt"
    else
        echo "Not analyzed"
    fi
    echo ""
    
    echo "## NPM Dependencies"
    if [ -f "$OUTPUT_DIR/npm_dependencies.txt" ]; then
        echo "Details: See npm_dependencies.txt"
    else
        echo "Not analyzed"
    fi
    echo ""
    
    echo "## Android/Gradle Dependencies"
    if [ -f "$OUTPUT_DIR/gradle_dependencies.txt" ]; then
        echo "Details: See gradle_dependencies.txt"
    else
        echo "Not analyzed"
    fi
    echo ""
    
    echo "## iOS CocoaPods Dependencies"
    if [ -f "$OUTPUT_DIR/cocoapods_dependencies.txt" ]; then
        echo "Total pods: $(wc -l < "$OUTPUT_DIR/cocoapods_dependencies.txt")"
        echo "Details: See cocoapods_dependencies.txt"
    else
        echo "Not analyzed"
    fi
    echo ""
    
    echo "## Required Actions"
    echo "1. Review all *_dependencies.txt files"
    echo "2. Identify packages that need mirroring"
    echo "3. Set up private registries for each package type"
    echo "4. Configure projects to use private registries"
    
} > "$OUTPUT_DIR/ANALYSIS_SUMMARY.md"
echo -e "${GREEN}  ✓ Summary report created${NC}"

echo ""
echo -e "${GREEN}=================================================="
echo "Dependency analysis complete!"
echo "==================================================${NC}"
echo ""
echo "Results saved to: $OUTPUT_DIR/"
echo ""
echo "Key files:"
echo "  - ANALYSIS_SUMMARY.md       (Overview)"
echo "  - flutter_dependencies.txt  (All Dart/Flutter packages)"
echo "  - npm_dependencies.txt      (NPM packages)"
echo "  - gradle_dependencies.txt   (Android dependencies)"
echo "  - cocoapods_dependencies.txt (iOS dependencies)"
echo "  - registry_sources.txt      (Package registry URLs)"
echo ""
echo "Next steps:"
echo "1. Review ANALYSIS_SUMMARY.md"
echo "2. Set up private registries based on findings"
echo "3. Run mirror scripts for each package type"

