# Offline Migration - Quick Reference Card

## 🚀 Quick Start

```bash
# Interactive mode (recommended)
bash scripts/migration/run_migration.sh

# Or manual step-by-step
bash scripts/migration/analyze_dependencies.sh
bash scripts/migration/mirror_git_repos.sh
export DOCKER_REGISTRY_URL="registry.liberyus.com"
bash scripts/migration/mirror_docker_images.sh
bash scripts/migration/setup_package_registries.sh
bash scripts/migration/update_git_urls.sh
bash scripts/migration/update_dockerfile.sh
```

## 📋 Migration Checklist

- [ ] 1. Analyze dependencies
- [ ] 2. Mirror git repos to git.liberyus.com
- [ ] 3. Mirror Docker images to private registry
- [ ] 4. Setup package registries (npm, pub, maven, cocoapods)
- [ ] 5. Update project configs
- [ ] 6. Test offline builds
- [ ] 7. Update CI/CD
- [ ] 8. Document & train team

## 🔧 Key Commands

### Prerequisites Check
```bash
# GitLab access
ssh -T git@git.liberyus.com

# Docker login
docker login ${DOCKER_REGISTRY_URL}

# Flutter version
flutter --version
```

### Git Mirroring
```bash
# Mirror all repos
bash scripts/migration/mirror_git_repos.sh

# Verify single repo
git ls-remote git@git.liberyus.com:dedi/deps/matrix-dart-sdk.git
```

### Docker Mirroring
```bash
# Set registry
export DOCKER_REGISTRY_URL="registry.liberyus.com"

# Mirror images
bash scripts/migration/mirror_docker_images.sh

# Test pull
docker pull ${DOCKER_REGISTRY_URL}/nginx:alpine
```

### Configuration Updates
```bash
# Update git URLs
bash scripts/migration/update_git_urls.sh

# Update Dockerfile
bash scripts/migration/update_dockerfile.sh

# Test dependencies
flutter pub get
```

### Offline Testing
```bash
# Disable network
networksetup -setairportpower en0 off  # macOS
# or
sudo iptables -A OUTPUT -j DROP  # Linux

# Test builds
flutter build web --release
flutter build apk --release
flutter build ios --release --no-codesign  # macOS only

# Re-enable network
networksetup -setairportpower en0 on  # macOS
# or
sudo iptables -D OUTPUT -j DROP  # Linux
```

## 📦 Infrastructure URLs

### Git Repositories
- **Host**: git.liberyus.com
- **Group**: dedi/deps
- **iOS Packages**: dedi/deps/ios
- **Format**: `git@git.liberyus.com:dedi/deps/REPO_NAME.git`

### Docker Registry
- **URL**: `REGISTRY_URL_PLACEHOLDER` (pending devops)
- **Format**: `${REGISTRY_URL}/IMAGE:TAG`

### Package Registries
- **NPM**: `https://git.liberyus.com/api/v4/packages/npm/`
- **Pub**: `https://pub.liberyus.com` (when available)
- **Maven**: `https://git.liberyus.com/api/v4/projects/PROJECT_ID/packages/maven`
- **CocoaPods**: `git@git.liberyus.com:dedi/cocoapods-specs.git`

## 🔑 Environment Variables

```bash
# Docker registry
export DOCKER_REGISTRY_URL="registry.liberyus.com"

# Package registries
export NPM_TOKEN="your_npm_token"
export GITLAB_MAVEN_TOKEN="your_maven_token"
export PUB_HOSTED_URL="https://pub.liberyus.com"
```

## 📊 Dependency Count

| Type | Count | Status |
|------|-------|--------|
| Git Repos (Flutter/Dart) | 12 | ⏳ |
| Git Repos (3rd party) | 8 | ⏳ |
| Git Repos (iOS Swift) | 9 | ⏳ |
| Docker Images | 4 | ⏳ |
| Pub Packages | 100+ | ⏳ |
| NPM Packages | 4 | ⏳ |

## 🚨 Troubleshooting

### Git Mirror Fails
```bash
# Check SSH
ssh -T git@git.liberyus.com

# Check group exists
# Navigate to git.liberyus.com/dedi/deps

# Check permissions
# Ensure you have Developer/Maintainer role
```

### Docker Push Fails
```bash
# Re-login
docker logout ${DOCKER_REGISTRY_URL}
docker login ${DOCKER_REGISTRY_URL}

# Check permissions
# Verify registry access in GitLab/Harbor
```

### Flutter Pub Get Fails
```bash
# Verbose mode
flutter pub get --verbose

# Check specific repo
git ls-remote git@git.liberyus.com:dedi/deps/matrix-dart-sdk.git

# Verify SSH
ssh -T git@git.liberyus.com
```

### Build Fails Offline
```bash
# Check missing dependency
flutter build web --verbose 2>&1 | grep -i "http\|https\|git"

# Verify registry configs
cat pubspec_overrides.yaml
cat scripts/copy-nse/.npmrc
cat android/gradle/private-registry.gradle
```

## 🔄 Rollback

```bash
# Find backup
ls -la backups/pre-migration-*/

# Restore files
cp backups/pre-migration-TIMESTAMP/* .

# Restore dependencies
flutter pub get

# Or use interactive rollback
bash scripts/migration/run_migration.sh
# Select option 9
```

## 📝 File Locations

### Scripts
- `scripts/migration/run_migration.sh` - Master script
- `scripts/migration/analyze_dependencies.sh` - Analysis
- `scripts/migration/mirror_git_repos.sh` - Git mirroring
- `scripts/migration/mirror_docker_images.sh` - Docker mirroring
- `scripts/migration/setup_package_registries.sh` - Registry setup
- `scripts/migration/update_git_urls.sh` - Update git URLs
- `scripts/migration/update_dockerfile.sh` - Update Dockerfile

### Documentation
- `docs/migration/OFFLINE_MIGRATION_GUIDE.md` - Full guide
- `docs/migration/REGISTRY_SETUP.md` - Registry details
- `docs/migration/MIGRATION_STATUS.md` - Progress tracking
- `docs/migration/ANALYSIS_SUMMARY.md` - Dependency report

### Configuration
- `pubspec.yaml` - Flutter dependencies
- `pubspec_overrides.yaml` - Pub registry override
- `Dockerfile` - Docker build config
- `scripts/copy-nse/.npmrc` - NPM config
- `android/gradle/private-registry.gradle` - Maven config
- `ios/Podfile` - CocoaPods config

### Backups
- `backups/pre-migration-*/` - Config backups

## 🎯 Success Criteria

✅ All 29 git repos mirrored  
✅ All 4 Docker images mirrored  
✅ All 4 registries configured  
✅ Web build works offline  
✅ Android build works offline  
✅ iOS build works offline  
✅ Docker build works offline  
✅ Tests pass offline  
✅ CI/CD updated  
✅ Team trained  

## 📞 Support

- **Full Guide**: `docs/migration/OFFLINE_MIGRATION_GUIDE.md`
- **Registry Setup**: `docs/migration/REGISTRY_SETUP.md`
- **Status**: `docs/migration/MIGRATION_STATUS.md`
- **Scripts README**: `scripts/migration/README.md`

## 🔗 Key Git Repos to Verify

```bash
# Critical dependencies
git ls-remote git@git.liberyus.com:dedi/deps/matrix-dart-sdk.git
git ls-remote git@git.liberyus.com:dedi/deps/linagora-design-flutter.git
git ls-remote git@git.liberyus.com:dedi/deps/flutter_matrix_html.git
git ls-remote git@git.liberyus.com:dedi/deps/olm.git

# iOS packages
git ls-remote git@git.liberyus.com:dedi/deps/ios/Version.git
git ls-remote git@git.liberyus.com:dedi/deps/ios/swift-collections.git
```

## 🐳 Docker Images to Verify

```bash
docker pull ${DOCKER_REGISTRY_URL}/nixos/nix:2.22.1
docker pull ${DOCKER_REGISTRY_URL}/instrumentisto/flutter:3.27.4
docker pull ${DOCKER_REGISTRY_URL}/nginx:alpine
docker pull ${DOCKER_REGISTRY_URL}/matrixdotorg/synapse:latest
```

## ⏱️ Estimated Timeline

| Phase | Duration | Dependencies |
|-------|----------|--------------|
| Analysis | 1-2 hours | None |
| Git Mirroring | 2-4 hours | GitLab setup |
| Docker Mirroring | 1-2 hours | Registry access |
| Registry Setup | 4-8 hours | Infrastructure |
| Config Updates | 1-2 hours | Mirrors complete |
| Testing | 4-8 hours | Configs updated |
| **Total** | **1-3 days** | - |

---

**Print this page for quick reference during migration!**

Last updated: Auto-generated  
Version: 1.0

