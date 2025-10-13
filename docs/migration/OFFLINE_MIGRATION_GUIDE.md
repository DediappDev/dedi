# Complete Offline Dependency Migration Guide

This guide provides step-by-step instructions for migrating all project dependencies to self-hosted infrastructure for 100% offline operation.

## Overview

**Goal**: Enable the Dedi project to build and run completely offline by mirroring all external dependencies to:
- Git repositories: `git.liberyus.com`
- Docker images: `REGISTRY_URL_PLACEHOLDER` (to be configured)
- Package registries: Private registries on GitLab

**Timeline**: Refactoring of twake/linagora references will occur AFTER migration to ensure stability.

## Prerequisites

### Infrastructure Requirements
- ✅ GitLab instance accessible at `git.liberyus.com`
- ✅ SSH access to GitLab configured
- ⏳ Private Docker registry (URL pending from devops)
- ⏳ Package registry infrastructure (GitLab Package Registry or standalone)

### Local Requirements
- Git with SSH keys configured for git.liberyus.com
- Docker with registry authentication
- Flutter SDK 3.24.x+
- Node.js and NPM (for npm dependencies)
- CocoaPods (for iOS, macOS only)
- Gradle (for Android)

## Migration Phases

### Phase 1: Dependency Discovery & Analysis

1. **Run dependency analysis**:
   ```bash
   bash scripts/migration/analyze_dependencies.sh
   ```

2. **Review analysis results**:
   ```bash
   cat docs/migration/ANALYSIS_SUMMARY.md
   ```

3. **Identify all dependencies**:
   - Git repositories: See plan document section 1.1
   - Docker images: See plan document section 1.2
   - Pub packages: See plan document section 1.5
   - NPM packages: See plan document section 1.4
   - Maven/Gradle: See plan document section 1.6
   - CocoaPods: See plan document section 1.7

### Phase 2: Mirror Git Repositories

1. **Ensure git.liberyus.com access**:
   ```bash
   ssh -T git@git.liberyus.com
   # Should return: Welcome to GitLab, @username!
   ```

2. **Create GitLab group structure**:
   - Navigate to git.liberyus.com
   - Create group: `dedi/deps`
   - Create subgroup: `dedi/deps/ios`

3. **Run git mirroring script**:
   ```bash
   bash scripts/migration/mirror_git_repos.sh
   ```

4. **Verify mirrors**:
   ```bash
   git ls-remote git@git.liberyus.com:dedi/deps/matrix-dart-sdk.git
   ```

### Phase 3: Mirror Docker Images

1. **Get Docker registry URL from devops**:
   ```bash
   # Example values (replace with actual):
   # registry.liberyus.com
   # registry.gitlab.liberyus.com
   # harbor.liberyus.com
   ```

2. **Set registry URL**:
   ```bash
   export DOCKER_REGISTRY_URL="registry.liberyus.com"
   ```

3. **Login to private registry**:
   ```bash
   docker login ${DOCKER_REGISTRY_URL}
   ```

4. **Run Docker mirroring**:
   ```bash
   bash scripts/migration/mirror_docker_images.sh
   ```

5. **Verify images**:
   ```bash
   docker pull ${DOCKER_REGISTRY_URL}/nginx:alpine
   ```

### Phase 4: Setup Package Registries

1. **Run package registry setup**:
   ```bash
   bash scripts/migration/setup_package_registries.sh
   ```

2. **Configure each registry** (see `docs/migration/REGISTRY_SETUP.md`):
   - NPM: Verdaccio or GitLab NPM registry
   - Pub/Dart: pub_server or GitLab Dart registry
   - Maven: GitLab Maven registry
   - CocoaPods: Private spec repository

3. **Test registry access**:
   ```bash
   # NPM
   npm ping --registry https://npm.liberyus.com
   
   # Pub (if configured)
   curl https://pub.liberyus.com
   
   # Maven (gradle test)
   cd android && ./gradlew help
   
   # CocoaPods
   pod repo list
   ```

### Phase 5: Update Project Configuration

1. **Update Git URLs in project**:
   ```bash
   bash scripts/migration/update_git_urls.sh
   ```

2. **Verify changes**:
   ```bash
   git diff pubspec.yaml
   git diff ios/Runner.xcodeproj/project.pbxproj
   git diff devenv.nix
   ```

3. **Test Flutter dependencies**:
   ```bash
   flutter pub get
   ```

4. **Update Dockerfile** (when registry URL is known):
   ```bash
   export DOCKER_REGISTRY_URL="registry.liberyus.com"
   bash scripts/migration/update_dockerfile.sh
   ```

5. **Verify Docker build**:
   ```bash
   docker build -t dedi-test .
   ```

### Phase 6: Offline Build Testing

1. **Disable internet** (or use network isolation):
   ```bash
   # Option 1: Airplane mode
   # Option 2: Firewall rules
   # Option 3: Docker network isolation
   ```

2. **Test Flutter web build**:
   ```bash
   flutter build web --release
   ```

3. **Test Android build**:
   ```bash
   flutter build apk --release
   ```

4. **Test iOS build** (macOS only):
   ```bash
   flutter build ios --release --no-codesign
   ```

5. **Test Docker build**:
   ```bash
   docker build -t dedi-offline-test .
   ```

6. **Document any failures**:
   - Missing packages
   - External API calls
   - Network timeouts

### Phase 7: Runtime API Proxying (Optional)

For runtime dependencies (matrix.org, etc.), set up local proxies:

1. **Create proxy configuration**:
   ```nginx
   # /etc/nginx/sites-available/matrix-proxy
   server {
       listen 443 ssl;
       server_name matrix-proxy.liberyus.com;
       
       location /_matrix/ {
           proxy_pass https://matrix.dedim.com.tr;
       }
   }
   ```

2. **Update application configs**:
   - Point matrix.org references to matrix-proxy.liberyus.com
   - Update DNS or /etc/hosts for local testing

## Verification Checklist

- [ ] All git repositories accessible from git.liberyus.com
- [ ] All Docker images in private registry
- [ ] NPM packages resolved from private registry
- [ ] Pub packages resolved from private registry  
- [ ] Maven dependencies resolved from private registry
- [ ] CocoaPods resolved from private specs
- [ ] `flutter build web` works offline
- [ ] `flutter build apk` works offline
- [ ] `flutter build ios` works offline
- [ ] Docker build works offline
- [ ] All tests pass offline

## Rollback Procedures

### Rollback Git URLs
```bash
# Restore from backup
cp backups/pre-migration-TIMESTAMP/pubspec.yaml .
cp backups/pre-migration-TIMESTAMP/Dockerfile .
flutter pub get
```

### Rollback Docker Configuration
```bash
# Restore original Dockerfile
git checkout HEAD -- Dockerfile
```

### Rollback Package Registries
```bash
# Remove private registry configs
rm scripts/copy-nse/.npmrc
rm pubspec_overrides.yaml
rm android/gradle/private-registry.gradle
git checkout HEAD -- ios/Podfile
```

## Troubleshooting

### Git Mirror Failures

**Problem**: `git push --mirror` fails
- **Solution**: Ensure GitLab project exists and you have write access
- **Check**: `git remote -v` shows correct URL
- **Verify**: SSH key is added to GitLab account

### Docker Mirror Failures

**Problem**: `docker push` fails with authentication error
- **Solution**: Login again: `docker login ${DOCKER_REGISTRY_URL}`
- **Check**: Registry URL is correct
- **Verify**: User has push permissions

### Flutter Pub Get Fails

**Problem**: Package resolution fails
- **Solution**: Check PUB_HOSTED_URL environment variable
- **Verify**: Private pub server is running
- **Fallback**: Remove pubspec_overrides.yaml temporarily

### Android Build Fails

**Problem**: Gradle dependency resolution fails
- **Solution**: Check GITLAB_MAVEN_TOKEN environment variable
- **Verify**: Maven registry URL and project ID are correct
- **Fallback**: Use public repositories in build.gradle

### iOS Build Fails

**Problem**: Swift package resolution fails
- **Solution**: Verify git URLs in Xcode project settings
- **Check**: SSH access to git.liberyus.com
- **Verify**: All Swift packages are mirrored

## Post-Migration Tasks

### 1. Update CI/CD Pipelines
- Update GitLab CI/CD to use private registries
- Add registry authentication to CI environment
- Test pipelines work offline

### 2. Documentation
- Document all registry URLs and access credentials
- Create runbook for registry maintenance
- Update developer onboarding docs

### 3. Monitoring
- Set up registry health monitoring
- Track package mirror freshness
- Alert on registry failures

### 4. Regular Sync
Create cron jobs to keep mirrors updated:

```bash
# Update git mirrors weekly
0 2 * * 0 /path/to/scripts/migration/mirror_git_repos.sh

# Update Docker images weekly  
0 3 * * 0 /path/to/scripts/migration/mirror_docker_images.sh
```

## Future: Twake/Linagora Refactoring

After successful migration and offline testing:

1. Create feature branch: `feature/dedi-rebrand`
2. Refactor codebase (twake→dedi, linagora→dediapp)
3. Test extensively
4. Consider forking and refactoring dependency repositories
5. Merge to main after validation

## Support

### Internal Contacts
- **DevOps**: For registry infrastructure questions
- **GitLab Admin**: For access and permissions
- **Team Lead**: For migration strategy decisions

### External Resources
- [GitLab Package Registry Docs](https://docs.gitlab.com/ee/user/packages/)
- [Verdaccio Documentation](https://verdaccio.org/docs/what-is-verdaccio)
- [Dart pub_server](https://pub.dev/packages/pub_server)
- [Docker Registry](https://docs.docker.com/registry/)

## Migration Status Tracking

Track progress in: `docs/migration/MIGRATION_STATUS.md`

| Phase | Status | Date | Notes |
|-------|--------|------|-------|
| Dependency Analysis | ⏳ Not Started | - | - |
| Git Mirroring | ⏳ Not Started | - | - |
| Docker Mirroring | ⏳ Pending Registry URL | - | - |
| Package Registries | ⏳ Not Started | - | - |
| Config Updates | ⏳ Not Started | - | - |
| Offline Testing | ⏳ Not Started | - | - |
| Documentation | ⏳ In Progress | - | This guide |

