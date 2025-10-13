#!/bin/bash
# Docker Image Mirror Script for Offline Migration
# Mirrors all external Docker images to private registry

set -e

# PLACEHOLDER: Replace with actual registry URL when known
REGISTRY_URL="${DOCKER_REGISTRY_URL:-REGISTRY_URL_PLACEHOLDER}"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}Starting Docker Image Mirroring${NC}"
echo "=================================================="
echo "Target Registry: ${REGISTRY_URL}"
echo ""

if [ "$REGISTRY_URL" = "REGISTRY_URL_PLACEHOLDER" ]; then
    echo -e "${RED}ERROR: DOCKER_REGISTRY_URL environment variable not set!${NC}"
    echo "Please set it to your private registry URL, e.g.:"
    echo "  export DOCKER_REGISTRY_URL=registry.liberyus.com"
    echo "  or"
    echo "  export DOCKER_REGISTRY_URL=registry.gitlab.liberyus.com"
    echo ""
    exit 1
fi

# Function to mirror an image
mirror_image() {
    local source_image=$1
    local target_path=$2
    
    echo -e "${YELLOW}Mirroring: ${source_image}${NC}"
    echo "  Target: ${REGISTRY_URL}/${target_path}"
    
    # Pull source image
    if docker pull "$source_image"; then
        # Tag for private registry
        docker tag "$source_image" "${REGISTRY_URL}/${target_path}"
        
        # Push to private registry
        if docker push "${REGISTRY_URL}/${target_path}"; then
            echo -e "  ${GREEN}✓ Success${NC}"
        else
            echo -e "  ${RED}✗ Failed to push${NC}"
        fi
    else
        echo -e "  ${RED}✗ Failed to pull${NC}"
    fi
    
    echo ""
}

# Mirror base images
echo -e "${GREEN}=== Base Images ===${NC}"
mirror_image "nixos/nix:2.22.1" "nixos/nix:2.22.1"
mirror_image "ghcr.io/instrumentisto/flutter:3.27.4" "instrumentisto/flutter:3.27.4"
mirror_image "nginx:alpine" "nginx:alpine"

# Mirror test images
echo -e "${GREEN}=== Integration Test Images ===${NC}"
mirror_image "matrixdotorg/synapse:latest" "matrixdotorg/synapse:latest"

# Also pull and tag specific versions
echo -e "${GREEN}=== Additional Flutter Versions (Optional) ===${NC}"
read -p "Do you want to mirror additional Flutter versions? (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    mirror_image "ghcr.io/instrumentisto/flutter:3.24.0" "instrumentisto/flutter:3.24.0"
    mirror_image "ghcr.io/instrumentisto/flutter:3.27.0" "instrumentisto/flutter:3.27.0"
fi

echo ""
echo -e "${GREEN}=================================================="
echo "Docker image mirroring complete!"
echo "==================================================${NC}"
echo ""
echo "Mirrored images:"
echo "  - ${REGISTRY_URL}/nixos/nix:2.22.1"
echo "  - ${REGISTRY_URL}/instrumentisto/flutter:3.27.4"
echo "  - ${REGISTRY_URL}/nginx:alpine"
echo "  - ${REGISTRY_URL}/matrixdotorg/synapse:latest"
echo ""
echo "Next steps:"
echo "1. Verify images are accessible: docker pull ${REGISTRY_URL}/nginx:alpine"
echo "2. Update Dockerfile to use private registry"
echo "3. Update integration test scripts to use private registry"

