#!/bin/bash
# Master Migration Script
# Orchestrates the complete offline dependency migration process

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Configuration
GITLAB_HOST="git.liberyus.com"
DOCKER_REGISTRY_URL="${DOCKER_REGISTRY_URL:-}"

echo -e "${CYAN}"
echo "╔════════════════════════════════════════════════════════════╗"
echo "║     Dedi Project - Offline Dependency Migration           ║"
echo "║     Complete Migration to Self-Hosted Infrastructure      ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo -e "${NC}"
echo ""

# Check prerequisites
echo -e "${BLUE}Checking prerequisites...${NC}"

# Check GitLab SSH access
echo -n "  Checking GitLab SSH access... "
if ssh -T git@${GITLAB_HOST} 2>&1 | grep -q "Welcome to GitLab"; then
    echo -e "${GREEN}✓${NC}"
else
    echo -e "${RED}✗${NC}"
    echo -e "${RED}ERROR: Cannot access GitLab at ${GITLAB_HOST}${NC}"
    echo "Please ensure:"
    echo "  1. GitLab instance is running"
    echo "  2. SSH keys are configured"
    echo "  3. Host is reachable"
    exit 1
fi

# Check if Docker is available
echo -n "  Checking Docker... "
if command -v docker &> /dev/null; then
    echo -e "${GREEN}✓${NC}"
else
    echo -e "${YELLOW}⚠ Not found (Docker tasks will be skipped)${NC}"
fi

# Check Flutter
echo -n "  Checking Flutter... "
if command -v flutter &> /dev/null; then
    echo -e "${GREEN}✓${NC}"
else
    echo -e "${YELLOW}⚠ Not found (Flutter tasks will be skipped)${NC}"
fi

echo ""

# Main menu
show_menu() {
    echo -e "${CYAN}=== Migration Steps ===${NC}"
    echo ""
    echo "  1) Analyze Dependencies (Recommended first step)"
    echo "  2) Mirror Git Repositories"
    echo "  3) Mirror Docker Images (Requires registry URL)"
    echo "  4) Setup Package Registries"
    echo "  5) Update Project Configuration"
    echo "  6) Run Full Migration (Steps 1-5)"
    echo ""
    echo "  7) Test Offline Builds"
    echo "  8) View Migration Status"
    echo "  9) Rollback Changes"
    echo ""
    echo "  0) Exit"
    echo ""
}

# Step 1: Analyze Dependencies
run_analysis() {
    echo -e "${BLUE}=== Step 1: Analyzing Dependencies ===${NC}"
    bash "${SCRIPT_DIR}/analyze_dependencies.sh"
    echo ""
    read -p "Press Enter to continue..."
}

# Step 2: Mirror Git Repositories
run_git_mirror() {
    echo -e "${BLUE}=== Step 2: Mirroring Git Repositories ===${NC}"
    echo ""
    echo "This will mirror all git dependencies to: git.liberyus.com/dedi/deps/"
    echo ""
    read -p "Continue? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        bash "${SCRIPT_DIR}/mirror_git_repos.sh"
    fi
    echo ""
    read -p "Press Enter to continue..."
}

# Step 3: Mirror Docker Images
run_docker_mirror() {
    echo -e "${BLUE}=== Step 3: Mirroring Docker Images ===${NC}"
    echo ""
    
    if [ -z "$DOCKER_REGISTRY_URL" ]; then
        echo -e "${YELLOW}Docker registry URL not set.${NC}"
        echo ""
        read -p "Enter Docker registry URL (e.g., registry.liberyus.com): " DOCKER_REGISTRY_URL
        export DOCKER_REGISTRY_URL
    fi
    
    echo "Target registry: ${DOCKER_REGISTRY_URL}"
    echo ""
    read -p "Continue? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        bash "${SCRIPT_DIR}/mirror_docker_images.sh"
    fi
    echo ""
    read -p "Press Enter to continue..."
}

# Step 4: Setup Package Registries
run_registry_setup() {
    echo -e "${BLUE}=== Step 4: Setting Up Package Registries ===${NC}"
    bash "${SCRIPT_DIR}/setup_package_registries.sh"
    echo ""
    read -p "Press Enter to continue..."
}

# Step 5: Update Configuration
run_config_update() {
    echo -e "${BLUE}=== Step 5: Updating Project Configuration ===${NC}"
    echo ""
    echo "This will update:"
    echo "  - pubspec.yaml (Git URLs)"
    echo "  - iOS project files (Swift package URLs)"
    echo "  - devenv.nix (OLM build)"
    echo "  - Dockerfile (Docker registry)"
    echo ""
    read -p "Continue? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        bash "${SCRIPT_DIR}/update_git_urls.sh"
        
        if [ -n "$DOCKER_REGISTRY_URL" ]; then
            bash "${SCRIPT_DIR}/update_dockerfile.sh"
        else
            echo -e "${YELLOW}Skipping Dockerfile update (registry URL not set)${NC}"
        fi
    fi
    echo ""
    read -p "Press Enter to continue..."
}

# Step 6: Full Migration
run_full_migration() {
    echo -e "${CYAN}=== Full Migration Process ===${NC}"
    echo ""
    echo "This will run all migration steps in sequence:"
    echo "  1. Analyze dependencies"
    echo "  2. Mirror git repositories"
    echo "  3. Mirror Docker images"
    echo "  4. Setup package registries"
    echo "  5. Update configurations"
    echo ""
    read -p "Continue with full migration? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        run_analysis
        run_git_mirror
        run_docker_mirror
        run_registry_setup
        run_config_update
        
        echo -e "${GREEN}"
        echo "╔════════════════════════════════════════════════════════════╗"
        echo "║         Migration Complete!                                ║"
        echo "╚════════════════════════════════════════════════════════════╝"
        echo -e "${NC}"
    fi
    echo ""
    read -p "Press Enter to continue..."
}

# Step 7: Test Offline Builds
run_offline_tests() {
    echo -e "${BLUE}=== Testing Offline Builds ===${NC}"
    echo ""
    echo "This will test builds with current configuration."
    echo ""
    echo -e "${YELLOW}Note: For true offline testing, disable network access${NC}"
    echo ""
    
    read -p "Test Flutter web build? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "Running: flutter build web --release"
        flutter build web --release || echo -e "${RED}Build failed${NC}"
    fi
    
    read -p "Test Android APK build? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "Running: flutter build apk --release"
        flutter build apk --release || echo -e "${RED}Build failed${NC}"
    fi
    
    if [[ "$OSTYPE" == "darwin"* ]]; then
        read -p "Test iOS build? (y/N) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            echo "Running: flutter build ios --release --no-codesign"
            flutter build ios --release --no-codesign || echo -e "${RED}Build failed${NC}"
        fi
    fi
    
    echo ""
    read -p "Press Enter to continue..."
}

# Step 8: View Status
view_status() {
    echo -e "${BLUE}=== Migration Status ===${NC}"
    echo ""
    
    if [ -f "docs/migration/ANALYSIS_SUMMARY.md" ]; then
        echo -e "${GREEN}✓ Dependency analysis complete${NC}"
    else
        echo -e "${YELLOW}⏳ Dependency analysis not run${NC}"
    fi
    
    echo ""
    echo "Git Mirrors (checking a few samples):"
    for repo in matrix-dart-sdk receive_sharing_intent flutter_matrix_html; do
        if git ls-remote "git@${GITLAB_HOST}:dedi/deps/${repo}.git" &>/dev/null; then
            echo -e "  ${GREEN}✓${NC} ${repo}"
        else
            echo -e "  ${RED}✗${NC} ${repo}"
        fi
    done
    
    echo ""
    if [ -n "$DOCKER_REGISTRY_URL" ]; then
        echo "Docker Registry: ${DOCKER_REGISTRY_URL}"
    else
        echo -e "${YELLOW}Docker registry URL not configured${NC}"
    fi
    
    echo ""
    echo "Configuration files:"
    if grep -q "git.liberyus.com" pubspec.yaml 2>/dev/null; then
        echo -e "  ${GREEN}✓${NC} pubspec.yaml updated"
    else
        echo -e "  ${YELLOW}⏳${NC} pubspec.yaml not updated"
    fi
    
    if [ -f "pubspec_overrides.yaml" ]; then
        echo -e "  ${GREEN}✓${NC} pubspec_overrides.yaml created"
    else
        echo -e "  ${YELLOW}⏳${NC} pubspec_overrides.yaml not created"
    fi
    
    if [ -f "android/gradle/private-registry.gradle" ]; then
        echo -e "  ${GREEN}✓${NC} Gradle private registry configured"
    else
        echo -e "  ${YELLOW}⏳${NC} Gradle private registry not configured"
    fi
    
    echo ""
    echo "For detailed migration guide, see:"
    echo "  docs/migration/OFFLINE_MIGRATION_GUIDE.md"
    echo ""
    read -p "Press Enter to continue..."
}

# Step 9: Rollback
run_rollback() {
    echo -e "${RED}=== Rollback Changes ===${NC}"
    echo ""
    echo "This will restore files from the most recent backup."
    echo ""
    
    LATEST_BACKUP=$(ls -td backups/pre-migration-* 2>/dev/null | head -1)
    
    if [ -z "$LATEST_BACKUP" ]; then
        echo -e "${YELLOW}No backup found. Nothing to rollback.${NC}"
    else
        echo "Latest backup: ${LATEST_BACKUP}"
        echo ""
        echo "Files to restore:"
        ls -la "${LATEST_BACKUP}"
        echo ""
        read -p "Continue with rollback? (y/N) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            cp "${LATEST_BACKUP}"/* . 2>/dev/null || true
            echo -e "${GREEN}Rollback complete${NC}"
            echo "Run 'flutter pub get' to restore dependencies"
        fi
    fi
    
    echo ""
    read -p "Press Enter to continue..."
}

# Main loop
while true; do
    clear
    echo -e "${CYAN}"
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║     Dedi Project - Offline Dependency Migration           ║"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    echo ""
    
    show_menu
    
    read -p "Select option: " choice
    
    case $choice in
        1) run_analysis ;;
        2) run_git_mirror ;;
        3) run_docker_mirror ;;
        4) run_registry_setup ;;
        5) run_config_update ;;
        6) run_full_migration ;;
        7) run_offline_tests ;;
        8) view_status ;;
        9) run_rollback ;;
        0) 
            echo ""
            echo -e "${GREEN}Migration script exited.${NC}"
            echo "See docs/migration/OFFLINE_MIGRATION_GUIDE.md for detailed documentation"
            echo ""
            exit 0
            ;;
        *) 
            echo -e "${RED}Invalid option${NC}"
            sleep 1
            ;;
    esac
done

