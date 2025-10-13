# Offline Dependency Migration Scripts

This directory contains scripts for migrating all project dependencies to self-hosted infrastructure for complete offline operation.

## Quick Start

### Interactive Mode (Recommended)

```bash
bash scripts/migration/run_migration.sh
```

This launches an interactive menu that guides you through each migration step.

### Manual Execution

Run scripts in this order:

```bash
# 1. Analyze all dependencies
bash scripts/migration/analyze_dependencies.sh

# 2. Mirror git repositories
bash scripts/migration/mirror_git_repos.sh

# 3. Mirror Docker images (after setting registry URL)
export DOCKER_REGISTRY_URL="registry.liberyus.com"
bash scripts/migration/mirror_docker_images.sh

# 4. Setup package registries
bash scripts/migration/setup_package_registries.sh

# 5. Update project configurations
bash scripts/migration/update_git_urls.sh
bash scripts/migration/update_dockerfile.sh
```

## Scripts Overview

### `run_migration.sh`
**Master orchestration script** with interactive menu for all migration steps.

**Usage**:
```bash
bash scripts/migration/run_migration.sh
```

**Features**:
- Interactive step-by-step execution
- Prerequisites checking
- Status monitoring
- Rollback capability

---

### `analyze_dependencies.sh`
**Analyzes all project dependencies** across all package managers.

**Usage**:
```bash
bash scripts/migration/analyze_dependencies.sh
```

**Output**: `docs/migration/`
- `ANALYSIS_SUMMARY.md` - Overview report
- `flutter_dependencies.txt` - Dart/Flutter packages
- `npm_dependencies.txt` - NPM packages
- `gradle_dependencies.txt` - Android dependencies
- `cocoapods_dependencies.txt` - iOS dependencies
- `registry_sources.txt` - Package registry URLs

**What it does**:
- Runs `flutter pub deps` for Flutter dependencies
- Runs `npm list` for NPM dependencies
- Runs `gradle dependencies` for Android
- Runs `pod list` for iOS (macOS only)
- Extracts all package registry sources

---

### `mirror_git_repos.sh`
**Mirrors all git repository dependencies** to git.liberyus.com.

**Usage**:
```bash
bash scripts/migration/mirror_git_repos.sh
```

**Prerequisites**:
- SSH access to git.liberyus.com configured
- GitLab group `dedi/deps` created
- GitLab group `dedi/deps/ios` created

**What it mirrors**:
- 12 Linagora Flutter/Dart repositories
- 8 Third-party Flutter repositories
- 9 iOS Swift package repositories
- Matrix OLM library

**Target structure**:
```
git.liberyus.com/dedi/deps/
├── matrix-dart-sdk.git
├── receive_sharing_intent.git
├── linagora-design-flutter.git
├── ...
└── ios/
    ├── Version.git
    ├── swift-collections.git
    └── ...
```

---

### `mirror_docker_images.sh`
**Mirrors all Docker images** to private registry.

**Usage**:
```bash
export DOCKER_REGISTRY_URL="registry.liberyus.com"
bash scripts/migration/mirror_docker_images.sh
```

**Prerequisites**:
- Docker installed and running
- Logged in to private registry: `docker login ${DOCKER_REGISTRY_URL}`
- DOCKER_REGISTRY_URL environment variable set

**What it mirrors**:
- `nixos/nix:2.22.1` (for OLM build)
- `ghcr.io/instrumentisto/flutter:3.27.4` (web builder)
- `nginx:alpine` (final image)
- `matrixdotorg/synapse:latest` (integration tests)

---

### `setup_package_registries.sh`
**Configures private package registries** for all package managers.

**Usage**:
```bash
bash scripts/migration/setup_package_registries.sh
```

**What it creates**:
- `scripts/copy-nse/.npmrc` - NPM registry config
- `pubspec_overrides.yaml` - Pub/Dart registry template
- `android/gradle/private-registry.gradle` - Maven config
- `ios/Podfile` - Updated with private CocoaPods source
- `docs/migration/REGISTRY_SETUP.md` - Detailed setup guide

**Supported registries**:
- **NPM**: GitLab NPM Registry or Verdaccio
- **Pub/Dart**: pub_server or GitLab Dart Registry
- **Maven**: GitLab Maven Registry
- **CocoaPods**: Private spec repository

---

### `update_git_urls.sh`
**Updates all git repository URLs** in project files to use private GitLab.

**Usage**:
```bash
bash scripts/migration/update_git_urls.sh
```

**What it updates**:
- `pubspec.yaml` - All git dependencies
- `ios/Runner.xcodeproj/project.pbxproj` - Swift package URLs
- `devenv.nix` - OLM library reference

**Backup**: Creates backup in `backups/pre-migration-<timestamp>/`

**Changes**:
- `git@github.com:linagora/*` → `git@git.liberyus.com:dedi/deps/*`
- `https://github.com/*` → `git@git.liberyus.com:dedi/deps/*`

---

### `update_dockerfile.sh`
**Updates Dockerfile** to use private Docker registry.

**Usage**:
```bash
export DOCKER_REGISTRY_URL="registry.liberyus.com"
bash scripts/migration/update_dockerfile.sh
```

**Prerequisites**:
- DOCKER_REGISTRY_URL environment variable set

**What it updates**:
- `Dockerfile` - All base image references
- `scripts/integration-server-synapse.sh` - Test image reference

**Changes**:
- `nixos/nix:*` → `${REGISTRY_URL}/nixos/nix:*`
- `ghcr.io/instrumentisto/flutter:*` → `${REGISTRY_URL}/instrumentisto/flutter:*`
- `nginx:alpine` → `${REGISTRY_URL}/nginx:alpine`
- `matrixdotorg/synapse:*` → `${REGISTRY_URL}/matrixdotorg/synapse:*`

---

## Environment Variables

### Required

- `DOCKER_REGISTRY_URL` - Private Docker registry URL
  ```bash
  export DOCKER_REGISTRY_URL="registry.liberyus.com"
  ```

### Optional

- `NPM_TOKEN` - GitLab NPM registry token (for package publishing)
- `GITLAB_MAVEN_TOKEN` - GitLab Maven registry token
- `PUB_HOSTED_URL` - Private Pub server URL
  ```bash
  export PUB_HOSTED_URL="https://pub.liberyus.com"
  ```

## Testing Offline Builds

After migration, test all builds offline:

### Disable Network

```bash
# Option 1: Airplane mode (macOS)
networksetup -setairportpower en0 off

# Option 2: Firewall rules (Linux)
sudo iptables -A OUTPUT -j DROP

# Option 3: Docker network isolation
docker network create --internal isolated
```

### Run Builds

```bash
# Flutter web
flutter build web --release

# Android APK
flutter build apk --release

# iOS (macOS only)
flutter build ios --release --no-codesign

# Docker
docker build -t dedi-offline .
```

### Re-enable Network

```bash
# macOS
networksetup -setairportpower en0 on

# Linux
sudo iptables -D OUTPUT -j DROP
```

## Rollback

If migration fails, restore from backup:

```bash
# Find latest backup
ls -la backups/pre-migration-*/

# Restore specific backup
cp backups/pre-migration-TIMESTAMP/* .

# Restore dependencies
flutter pub get
```

Or use the rollback option in `run_migration.sh` menu.

## Directory Structure

```
scripts/migration/
├── README.md                        # This file
├── run_migration.sh                 # Master orchestration script
├── analyze_dependencies.sh          # Dependency analysis
├── mirror_git_repos.sh             # Git repository mirroring
├── mirror_docker_images.sh         # Docker image mirroring
├── setup_package_registries.sh     # Package registry setup
├── update_git_urls.sh              # Update git URLs in configs
└── update_dockerfile.sh            # Update Dockerfile

docs/migration/
├── OFFLINE_MIGRATION_GUIDE.md      # Complete migration guide
├── REGISTRY_SETUP.md               # Registry setup documentation
├── ANALYSIS_SUMMARY.md             # Dependency analysis report
├── flutter_dependencies.txt        # Flutter dependency tree
├── npm_dependencies.txt            # NPM dependency tree
├── gradle_dependencies.txt         # Gradle dependency tree
└── cocoapods_dependencies.txt      # CocoaPods dependency list

backups/pre-migration-*/            # Configuration backups
```

## Support

### Documentation
- **Migration Guide**: `docs/migration/OFFLINE_MIGRATION_GUIDE.md`
- **Registry Setup**: `docs/migration/REGISTRY_SETUP.md`
- **Main Plan**: `offline-dependency-migration.plan.md`

### Troubleshooting

**Git mirror fails**:
- Verify SSH access: `ssh -T git@git.liberyus.com`
- Check GitLab groups exist
- Ensure write permissions

**Docker push fails**:
- Login to registry: `docker login ${DOCKER_REGISTRY_URL}`
- Verify registry URL is correct
- Check push permissions

**Flutter pub get fails**:
- Check if git repositories are accessible
- Verify SSH keys are configured
- Try with verbose flag: `flutter pub get --verbose`

**Build fails offline**:
- Check which dependency is missing
- Verify all registries are configured
- Review error logs for external URLs

### Getting Help

1. Check migration guide: `docs/migration/OFFLINE_MIGRATION_GUIDE.md`
2. Review registry setup: `docs/migration/REGISTRY_SETUP.md`
3. Check dependency analysis: `docs/migration/ANALYSIS_SUMMARY.md`
4. Contact DevOps team for infrastructure issues
5. Contact team lead for strategy questions

## Success Criteria

- [ ] All git repos accessible from git.liberyus.com
- [ ] All Docker images in private registry
- [ ] All package registries configured
- [ ] `flutter build web` works offline
- [ ] `flutter build apk` works offline
- [ ] `flutter build ios` works offline
- [ ] Docker build works offline
- [ ] All tests pass offline
- [ ] CI/CD updated for private registries
- [ ] Documentation complete

## Next Steps After Migration

1. **Update CI/CD pipelines** to use private registries
2. **Document registry access** for team members
3. **Set up registry monitoring** and health checks
4. **Create sync jobs** to keep mirrors updated
5. **Plan refactoring** (twake→dedi) for post-migration phase

