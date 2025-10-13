#!/bin/bash
# Update Git URLs Script
# Updates all git repository URLs to use private GitLab instance

set -e

GITLAB_HOST="git.liberyus.com"
GITLAB_GROUP="dedi/deps"
BACKUP_DIR="backups/pre-migration-$(date +%Y%m%d_%H%M%S)"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}Updating Git URLs to Private GitLab${NC}"
echo "=================================================="
echo "GitLab Host: $GITLAB_HOST"
echo "GitLab Group: $GITLAB_GROUP"
echo ""

# Create backup
echo -e "${YELLOW}Creating backup of original files...${NC}"
mkdir -p "$BACKUP_DIR"
cp pubspec.yaml "$BACKUP_DIR/"
cp ios/Runner.xcodeproj/project.pbxproj "$BACKUP_DIR/" 2>/dev/null || true
cp devenv.nix "$BACKUP_DIR/" 2>/dev/null || true
echo -e "${GREEN}  ✓ Backup created at: $BACKUP_DIR${NC}"
echo ""

# Update pubspec.yaml
echo -e "${YELLOW}Updating pubspec.yaml...${NC}"

# Linagora dependencies
sed -i.bak 's|git@github.com:linagora/matrix-dart-sdk.git|git@'"$GITLAB_HOST"':'"$GITLAB_GROUP"'/matrix-dart-sdk.git|g' pubspec.yaml
sed -i.bak 's|https://github.com/linagora/receive_sharing_intent.git|git@'"$GITLAB_HOST"':'"$GITLAB_GROUP"'/receive_sharing_intent.git|g' pubspec.yaml
sed -i.bak 's|git@github.com:linagora/linagora-design-flutter.git|git@'"$GITLAB_HOST"':'"$GITLAB_GROUP"'/linagora-design-flutter.git|g' pubspec.yaml
sed -i.bak 's|https://github.com/linagora/flutter_matrix_html.git|git@'"$GITLAB_HOST"':'"$GITLAB_GROUP"'/flutter_matrix_html.git|g' pubspec.yaml
sed -i.bak 's|git@github.com:linagora/flutter_contacts.git|git@'"$GITLAB_HOST"':'"$GITLAB_GROUP"'/flutter_contacts.git|g' pubspec.yaml
sed -i.bak 's|git@github.com:linagora/inview_notifier_list.git|git@'"$GITLAB_HOST"':'"$GITLAB_GROUP"'/inview_notifier_list.git|g' pubspec.yaml
sed -i.bak 's|git@github.com:linagora/future-loading-dialog.git|git@'"$GITLAB_HOST"':'"$GITLAB_GROUP"'/future-loading-dialog.git|g' pubspec.yaml
sed -i.bak 's|git@github.com:linagora/linkfy_text.git|git@'"$GITLAB_HOST"':'"$GITLAB_GROUP"'/linkfy_text.git|g' pubspec.yaml
sed -i.bak 's|git@github.com:linagora/emoji_mart.git|git@'"$GITLAB_HOST"':'"$GITLAB_GROUP"'/emoji_mart.git|g' pubspec.yaml
sed -i.bak 's|git@github.com:linagora/social_media_recorder.git|git@'"$GITLAB_HOST"':'"$GITLAB_GROUP"'/social_media_recorder.git|g' pubspec.yaml
sed -i.bak 's|https://github.com/linagora/matrix_link_text.git|git@'"$GITLAB_HOST"':'"$GITLAB_GROUP"'/matrix_link_text.git|g' pubspec.yaml
sed -i.bak 's|https://github.com/linagora/dart_matrix_api_lite.git|git@'"$GITLAB_HOST"':'"$GITLAB_GROUP"'/dart_matrix_api_lite.git|g' pubspec.yaml

# Third-party dependencies
sed -i.bak 's|git@github.com:SpectoraSoftware/VideoCompress.git|git@'"$GITLAB_HOST"':'"$GITLAB_GROUP"'/VideoCompress.git|g' pubspec.yaml
sed -i.bak 's|https://github.com/maRci002/video_thumbnail.git|git@'"$GITLAB_HOST"':'"$GITLAB_GROUP"'/video_thumbnail.git|g' pubspec.yaml
sed -i.bak 's|https://github.com/famedly/fcm_shared_isolate.git|git@'"$GITLAB_HOST"':'"$GITLAB_GROUP"'/fcm_shared_isolate.git|g' pubspec.yaml
sed -i.bak 's|https://github.com/bitsydarel/flutter_app_badger.git|git@'"$GITLAB_HOST"':'"$GITLAB_GROUP"'/flutter_app_badger.git|g' pubspec.yaml
sed -i.bak 's|https://github.com/alirezat66/skeletons.git|git@'"$GITLAB_HOST"':'"$GITLAB_GROUP"'/skeletons.git|g' pubspec.yaml
sed -i.bak 's|https://github.com/FlutterStudioIst/image_gallery_saver.git|git@'"$GITLAB_HOST"':'"$GITLAB_GROUP"'/image_gallery_saver.git|g' pubspec.yaml
sed -i.bak 's|https://github.com/famedly/dart_native_imaging|git@'"$GITLAB_HOST"':'"$GITLAB_GROUP"'/dart_native_imaging.git|g' pubspec.yaml
sed -i.bak 's|git@github.com:zhouzhuo810/keyboard_shortcuts.git|git@'"$GITLAB_HOST"':'"$GITLAB_GROUP"'/keyboard_shortcuts.git|g' pubspec.yaml

# Clean up .bak files
rm -f pubspec.yaml.bak

echo -e "${GREEN}  ✓ pubspec.yaml updated${NC}"

# Update iOS Swift Package URLs
if [ -f "ios/Runner.xcodeproj/project.pbxproj" ]; then
    echo -e "${YELLOW}Updating iOS Swift Package URLs...${NC}"
    
    sed -i.bak 's|https://github.com/mxcl/Version|git@'"$GITLAB_HOST"':'"$GITLAB_GROUP"'/ios/Version.git|g' ios/Runner.xcodeproj/project.pbxproj
    sed -i.bak 's|https://github.com/apple/swift-collections|git@'"$GITLAB_HOST"':'"$GITLAB_GROUP"'/ios/swift-collections.git|g' ios/Runner.xcodeproj/project.pbxproj
    sed -i.bak 's|https://github.com/BarredEwe/Prefire|git@'"$GITLAB_HOST"':'"$GITLAB_GROUP"'/ios/Prefire.git|g' ios/Runner.xcodeproj/project.pbxproj
    sed -i.bak 's|https://github.com/Cocoanetics/DTCoreText|git@'"$GITLAB_HOST"':'"$GITLAB_GROUP"'/ios/DTCoreText.git|g' ios/Runner.xcodeproj/project.pbxproj
    sed -i.bak 's|https://github.com/devicekit/DeviceKit.git|git@'"$GITLAB_HOST"':'"$GITLAB_GROUP"'/ios/DeviceKit.git|g' ios/Runner.xcodeproj/project.pbxproj
    sed -i.bak 's|https://github.com/matrix-org/matrix-rust-components-swift|git@'"$GITLAB_HOST"':'"$GITLAB_GROUP"'/ios/matrix-rust-components-swift.git|g' ios/Runner.xcodeproj/project.pbxproj
    sed -i.bak 's|https://github.com/nicklockwood/LRUCache|git@'"$GITLAB_HOST"':'"$GITLAB_GROUP"'/ios/LRUCache.git|g' ios/Runner.xcodeproj/project.pbxproj
    sed -i.bak 's|https://github.com/kishikawakatsumi/KeychainAccess|git@'"$GITLAB_HOST"':'"$GITLAB_GROUP"'/ios/KeychainAccess.git|g' ios/Runner.xcodeproj/project.pbxproj
    sed -i.bak 's|https://github.com/onevcat/Kingfisher|git@'"$GITLAB_HOST"':'"$GITLAB_GROUP"'/ios/Kingfisher.git|g' ios/Runner.xcodeproj/project.pbxproj
    
    rm -f ios/Runner.xcodeproj/project.pbxproj.bak
    
    echo -e "${GREEN}  ✓ iOS project updated${NC}"
fi

# Update devenv.nix OLM build
if [ -f "devenv.nix" ]; then
    echo -e "${YELLOW}Updating devenv.nix for OLM build...${NC}"
    
    # Replace gitlab.matrix.org with private GitLab
    sed -i.bak 's|gitlab:matrix-org/olm/3.2.16?host=gitlab.matrix.org#javascript|git@'"$GITLAB_HOST"':'"$GITLAB_GROUP"'/olm.git|g' devenv.nix
    
    rm -f devenv.nix.bak
    
    echo -e "${GREEN}  ✓ devenv.nix updated${NC}"
fi

echo ""
echo -e "${GREEN}=================================================="
echo "Git URL update complete!"
echo "==================================================${NC}"
echo ""
echo "Updated files:"
echo "  - pubspec.yaml"
echo "  - ios/Runner.xcodeproj/project.pbxproj"
echo "  - devenv.nix"
echo ""
echo "Backup location: $BACKUP_DIR/"
echo ""
echo "Next steps:"
echo "1. Verify changes: git diff"
echo "2. Test flutter pub get"
echo "3. Test iOS build if on macOS"
echo "4. Commit changes: git add . && git commit -m 'chore: migrate to private GitLab repositories'"
echo ""
echo "To rollback:"
echo "  cp $BACKUP_DIR/* ."

