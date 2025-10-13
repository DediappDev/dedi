#!/bin/bash
# Update Dockerfile Script
# Updates Dockerfile to use private Docker registry

set -e

# PLACEHOLDER: Replace with actual registry URL when known
REGISTRY_URL="${DOCKER_REGISTRY_URL:-REGISTRY_URL_PLACEHOLDER}"
BACKUP_DIR="backups/pre-migration-$(date +%Y%m%d_%H%M%S)"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}Updating Dockerfile for Private Registry${NC}"
echo "=================================================="
echo "Registry URL: $REGISTRY_URL"
echo ""

if [ "$REGISTRY_URL" = "REGISTRY_URL_PLACEHOLDER" ]; then
    echo -e "${RED}ERROR: DOCKER_REGISTRY_URL environment variable not set!${NC}"
    echo "Please set it to your private registry URL, e.g.:"
    echo "  export DOCKER_REGISTRY_URL=registry.liberyus.com"
    echo ""
    exit 1
fi

# Create backup
echo -e "${YELLOW}Creating backup...${NC}"
mkdir -p "$BACKUP_DIR"
cp Dockerfile "$BACKUP_DIR/"
cp scripts/integration-server-synapse.sh "$BACKUP_DIR/" 2>/dev/null || true
echo -e "${GREEN}  ✓ Backup created${NC}"
echo ""

# Update Dockerfile
echo -e "${YELLOW}Updating Dockerfile...${NC}"

sed -i.bak "s|nixos/nix:\${NIX_VERSION}|${REGISTRY_URL}/nixos/nix:\${NIX_VERSION}|g" Dockerfile
sed -i.bak "s|ghcr.io/instrumentisto/flutter:\${FLUTTER_VERSION}|${REGISTRY_URL}/instrumentisto/flutter:\${FLUTTER_VERSION}|g" Dockerfile
sed -i.bak "s|nginx:alpine|${REGISTRY_URL}/nginx:alpine|g" Dockerfile

# Also update OLM build to use private git
sed -i.bak 's|gitlab:matrix-org/olm/\${OLM_VERSION}?host=gitlab.matrix.org#javascript|git@git.liberyus.com:dedi/deps/olm.git|g' Dockerfile

rm -f Dockerfile.bak

echo -e "${GREEN}  ✓ Dockerfile updated${NC}"

# Update integration test script
if [ -f "scripts/integration-server-synapse.sh" ]; then
    echo -e "${YELLOW}Updating integration test script...${NC}"
    
    sed -i.bak "s|matrixdotorg/synapse:latest|${REGISTRY_URL}/matrixdotorg/synapse:latest|g" scripts/integration-server-synapse.sh
    
    rm -f scripts/integration-server-synapse.sh.bak
    
    echo -e "${GREEN}  ✓ Integration script updated${NC}"
fi

echo ""
echo -e "${GREEN}=================================================="
echo "Dockerfile update complete!"
echo "==================================================${NC}"
echo ""
echo "Updated files:"
echo "  - Dockerfile"
echo "  - scripts/integration-server-synapse.sh"
echo ""
echo "Backup location: $BACKUP_DIR/"
echo ""
echo "Next steps:"
echo "1. Verify registry access: docker pull ${REGISTRY_URL}/nginx:alpine"
echo "2. Test Docker build: docker build -t dedi-test ."
echo "3. Commit changes if successful"
echo ""
echo "To rollback:"
echo "  cp $BACKUP_DIR/Dockerfile ."

