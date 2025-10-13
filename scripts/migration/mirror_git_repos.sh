#!/bin/bash
# Git Repository Mirror Script for Offline Migration
# Mirrors all external git dependencies to git.liberyus.com

set -e

GITLAB_HOST="git.liberyus.com"
GITLAB_GROUP="dedi/deps"
TEMP_DIR="/tmp/dedi-git-mirrors"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Create temp directory
mkdir -p "$TEMP_DIR"

echo -e "${GREEN}Starting Git Repository Mirroring to ${GITLAB_HOST}${NC}"
echo "=================================================="
echo ""

# Function to mirror a repository
mirror_repo() {
    local source_url=$1
    local target_path=$2
    local repo_name=$(basename "$target_path" .git)
    
    echo -e "${YELLOW}Mirroring: ${source_url}${NC}"
    echo "  Target: git@${GITLAB_HOST}:${GITLAB_GROUP}/${target_path}"
    
    # Clone mirror
    if git clone --mirror "$source_url" "${TEMP_DIR}/${repo_name}.git" 2>/dev/null; then
        cd "${TEMP_DIR}/${repo_name}.git"
        
        # Set push URL to GitLab
        git remote set-url --push origin "git@${GITLAB_HOST}:${GITLAB_GROUP}/${target_path}"
        
        # Push mirror
        if git push --mirror; then
            echo -e "  ${GREEN}✓ Success${NC}"
        else
            echo -e "  ${RED}✗ Failed to push${NC}"
        fi
        
        cd - > /dev/null
    else
        echo -e "  ${RED}✗ Failed to clone${NC}"
    fi
    
    echo ""
}

# Linagora dependencies
echo -e "${GREEN}=== Linagora Dependencies ===${NC}"
mirror_repo "git@github.com:linagora/matrix-dart-sdk.git" "matrix-dart-sdk.git"
mirror_repo "https://github.com/linagora/receive_sharing_intent.git" "receive_sharing_intent.git"
mirror_repo "git@github.com:linagora/linagora-design-flutter.git" "linagora-design-flutter.git"
mirror_repo "https://github.com/linagora/flutter_matrix_html.git" "flutter_matrix_html.git"
mirror_repo "git@github.com:linagora/flutter_contacts.git" "flutter_contacts.git"
mirror_repo "git@github.com:linagora/inview_notifier_list.git" "inview_notifier_list.git"
mirror_repo "git@github.com:linagora/future-loading-dialog.git" "future-loading-dialog.git"
mirror_repo "git@github.com:linagora/linkfy_text.git" "linkfy_text.git"
mirror_repo "git@github.com:linagora/emoji_mart.git" "emoji_mart.git"
mirror_repo "git@github.com:linagora/social_media_recorder.git" "social_media_recorder.git"
mirror_repo "https://github.com/linagora/matrix_link_text.git" "matrix_link_text.git"
mirror_repo "https://github.com/linagora/dart_matrix_api_lite.git" "dart_matrix_api_lite.git"

# Third-party dependencies
echo -e "${GREEN}=== Third-Party Dependencies ===${NC}"
mirror_repo "git@github.com:SpectoraSoftware/VideoCompress.git" "VideoCompress.git"
mirror_repo "https://github.com/maRci002/video_thumbnail.git" "video_thumbnail.git"
mirror_repo "https://github.com/famedly/fcm_shared_isolate.git" "fcm_shared_isolate.git"
mirror_repo "https://github.com/bitsydarel/flutter_app_badger.git" "flutter_app_badger.git"
mirror_repo "https://github.com/alirezat66/skeletons.git" "skeletons.git"
mirror_repo "https://github.com/FlutterStudioIst/image_gallery_saver.git" "image_gallery_saver.git"
mirror_repo "https://github.com/famedly/dart_native_imaging" "dart_native_imaging.git"
mirror_repo "git@github.com:zhouzhuo810/keyboard_shortcuts.git" "keyboard_shortcuts.git"

# iOS Swift packages
echo -e "${GREEN}=== iOS Swift Package Dependencies ===${NC}"
mirror_repo "https://github.com/mxcl/Version" "ios/Version.git"
mirror_repo "https://github.com/apple/swift-collections" "ios/swift-collections.git"
mirror_repo "https://github.com/BarredEwe/Prefire" "ios/Prefire.git"
mirror_repo "https://github.com/Cocoanetics/DTCoreText" "ios/DTCoreText.git"
mirror_repo "https://github.com/devicekit/DeviceKit.git" "ios/DeviceKit.git"
mirror_repo "https://github.com/matrix-org/matrix-rust-components-swift" "ios/matrix-rust-components-swift.git"
mirror_repo "https://github.com/nicklockwood/LRUCache" "ios/LRUCache.git"
mirror_repo "https://github.com/kishikawakatsumi/KeychainAccess" "ios/KeychainAccess.git"
mirror_repo "https://github.com/onevcat/Kingfisher" "ios/Kingfisher.git"

# Special: Clone OLM library
echo -e "${GREEN}=== Matrix OLM Library ===${NC}"
echo -e "${YELLOW}Cloning matrix-org/olm from GitLab...${NC}"
if git clone https://gitlab.matrix.org/matrix-org/olm.git "${TEMP_DIR}/olm.git"; then
    cd "${TEMP_DIR}/olm.git"
    git remote set-url --push origin "git@${GITLAB_HOST}:${GITLAB_GROUP}/olm.git"
    if git push --mirror; then
        echo -e "  ${GREEN}✓ Success${NC}"
    else
        echo -e "  ${RED}✗ Failed to push${NC}"
    fi
    cd - > /dev/null
else
    echo -e "  ${RED}✗ Failed to clone${NC}"
fi

echo ""
echo -e "${GREEN}=================================================="
echo "Git mirroring complete!"
echo "==================================================${NC}"
echo ""
echo "Next steps:"
echo "1. Verify all repositories are accessible at git.liberyus.com"
echo "2. Run 'bash scripts/migration/update_git_urls.sh' to update project configs"
echo "3. Test builds work with new URLs"

