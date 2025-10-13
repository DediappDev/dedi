#!/bin/bash
# Setup Package Registries Script
# Configures private package registries for all package managers

set -e

GITLAB_HOST="git.liberyus.com"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${GREEN}Setting Up Private Package Registries${NC}"
echo "=================================================="
echo "GitLab Host: $GITLAB_HOST"
echo ""

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# 1. Setup NPM Registry
echo -e "${BLUE}=== NPM Registry Setup ===${NC}"
if [ -f "scripts/copy-nse/package.json" ]; then
    echo -e "${YELLOW}Configuring NPM to use private registry...${NC}"
    
    cat > scripts/copy-nse/.npmrc << EOF
# Private NPM Registry Configuration
# registry=https://${GITLAB_HOST}/api/v4/packages/npm/
# //$(echo $GITLAB_HOST | sed 's/https:\/\///')/api/v4/packages/npm/:_authToken=\${NPM_TOKEN}

# Fallback to public registry (comment out for full offline mode)
registry=https://registry.npmjs.org/
EOF
    
    echo -e "${GREEN}  ✓ Created scripts/copy-nse/.npmrc${NC}"
    echo -e "${YELLOW}  ⚠ Update NPM_TOKEN in .npmrc when GitLab registry is ready${NC}"
else
    echo -e "${YELLOW}  - No NPM project found${NC}"
fi
echo ""

# 2. Setup Pub/Dart Registry
echo -e "${BLUE}=== Pub/Dart Registry Setup ===${NC}"
echo -e "${YELLOW}Configuring Dart/Flutter pub registry...${NC}"

cat > pubspec_overrides.yaml << EOF
# Private Pub Repository Configuration
# This file can be used to override package sources when private registry is ready

# Uncomment and configure when private pub server is available:
# dependency_overrides:
#   # Example:
#   # http:
#   #   hosted:
#   #     name: http
#   #     url: https://pub.${GITLAB_HOST}/api/packages/
EOF

echo -e "${GREEN}  ✓ Created pubspec_overrides.yaml template${NC}"
echo -e "${YELLOW}  ⚠ Set PUB_HOSTED_URL environment variable when registry is ready:${NC}"
echo -e "     export PUB_HOSTED_URL=https://pub.${GITLAB_HOST}"
echo ""

# 3. Setup Maven/Gradle Registry
echo -e "${BLUE}=== Maven/Gradle Registry Setup ===${NC}"
echo -e "${YELLOW}Creating Gradle init script for private Maven...${NC}"

mkdir -p android/gradle
cat > android/gradle/private-registry.gradle << EOF
// Private Maven Registry Configuration for Android

allprojects {
    buildscript {
        repositories {
            // Uncomment when private Maven registry is available
            // maven {
            //     url 'https://${GITLAB_HOST}/api/v4/projects/MAVEN_PROJECT_ID/packages/maven'
            //     credentials(HttpHeaderCredentials) {
            //         name = 'Private-Token'
            //         value = System.getenv('GITLAB_MAVEN_TOKEN')
            //     }
            //     authentication {
            //         header(HttpHeaderAuthentication)
            //     }
            // }
            
            // Temporary: Use public repositories
            google()
            mavenCentral()
        }
    }
    
    repositories {
        // Uncomment when private Maven registry is available
        // maven {
        //     url 'https://${GITLAB_HOST}/api/v4/projects/MAVEN_PROJECT_ID/packages/maven'
        //     credentials(HttpHeaderCredentials) {
        //         name = 'Private-Token'
        //         value = System.getenv('GITLAB_MAVEN_TOKEN')
        //     }
        //     authentication {
        //         header(HttpHeaderAuthentication)
        //     }
        // }
        
        // Temporary: Use public repositories
        google()
        mavenCentral()
    }
}
EOF

echo -e "${GREEN}  ✓ Created android/gradle/private-registry.gradle${NC}"
echo -e "${YELLOW}  ⚠ Apply this script in android/build.gradle when ready:${NC}"
echo -e "     apply from: 'gradle/private-registry.gradle'"
echo ""

# 4. Setup CocoaPods Registry
echo -e "${BLUE}=== CocoaPods Registry Setup ===${NC}"
if [ -f "ios/Podfile" ]; then
    echo -e "${YELLOW}Creating CocoaPods private spec repository configuration...${NC}"
    
    # Create backup
    cp ios/Podfile ios/Podfile.backup
    
    # Add private source at the beginning (commented out)
    cat > ios/Podfile.new << EOF
# Uncomment this line to define a global platform for your project
platform :ios, '13.0'

# CocoaPods analytics sends network stats synchronously affecting flutter build latency.
ENV['COCOAPODS_DISABLE_STATS'] = 'true'

# Private CocoaPods Spec Repository (uncomment when ready)
# source 'git@${GITLAB_HOST}:dedi/cocoapods-specs.git'

# Public CocoaPods repository (comment out for full offline mode)
# source 'https://cdn.cocoapods.org/'

EOF
    
    # Append rest of original Podfile (skip first 5 lines)
    tail -n +6 ios/Podfile >> ios/Podfile.new
    mv ios/Podfile.new ios/Podfile
    
    echo -e "${GREEN}  ✓ Updated ios/Podfile with private source template${NC}"
    echo -e "${YELLOW}  ⚠ Original Podfile backed up to ios/Podfile.backup${NC}"
else
    echo -e "${YELLOW}  - No Podfile found${NC}"
fi
echo ""

# 5. Create registry setup documentation
echo -e "${BLUE}=== Creating Documentation ===${NC}"
mkdir -p docs/migration

cat > docs/migration/REGISTRY_SETUP.md << 'EOF'
# Private Package Registry Setup Guide

This document describes how to set up and configure private package registries for complete offline operation.

## Prerequisites

- GitLab instance at git.liberyus.com
- Admin access to GitLab
- Docker registry (integrated with GitLab or standalone)

## 1. NPM Registry

### Option A: GitLab NPM Registry

1. Enable NPM package registry in GitLab project settings
2. Get your personal access token from GitLab
3. Update `scripts/copy-nse/.npmrc`:
   ```
   registry=https://git.liberyus.com/api/v4/packages/npm/
   //git.liberyus.com/api/v4/packages/npm/:_authToken=${NPM_TOKEN}
   ```
4. Publish packages:
   ```bash
   cd scripts/copy-nse
   npm publish
   ```

### Option B: Verdaccio (Recommended)

1. Install Verdaccio:
   ```bash
   npm install -g verdaccio
   ```

2. Configure Verdaccio to proxy npmjs.org:
   ```yaml
   # ~/.config/verdaccio/config.yaml
   uplinks:
     npmjs:
       url: https://registry.npmjs.org/
   
   packages:
     '@*/*':
       access: $all
       publish: $authenticated
       proxy: npmjs
   ```

3. Run Verdaccio:
   ```bash
   verdaccio --listen 4873
   ```

4. Configure NPM:
   ```bash
   npm config set registry http://localhost:4873
   ```

## 2. Pub/Dart Registry

### Option A: Pub Server

1. Install pub_server:
   ```bash
   dart pub global activate pub_server
   ```

2. Run server:
   ```bash
   pub_server -d /path/to/package-db --host 0.0.0.0 --port 8080
   ```

3. Configure environment:
   ```bash
   export PUB_HOSTED_URL=https://pub.liberyus.com
   ```

### Option B: GitLab Pub Registry (if available)

Check if your GitLab version supports Dart packages and configure accordingly.

## 3. Maven/Gradle Registry

### GitLab Maven Registry

1. Create GitLab project for Maven packages
2. Note the project ID
3. Update `android/gradle/private-registry.gradle`:
   ```gradle
   maven {
       url 'https://git.liberyus.com/api/v4/projects/PROJECT_ID/packages/maven'
       credentials(HttpHeaderCredentials) {
           name = 'Private-Token'
           value = System.getenv('GITLAB_MAVEN_TOKEN')
       }
       authentication {
           header(HttpHeaderAuthentication)
       }
   }
   ```

4. Apply in `android/build.gradle`:
   ```gradle
   apply from: 'gradle/private-registry.gradle'
   ```

5. Set environment variable:
   ```bash
   export GITLAB_MAVEN_TOKEN=your_token_here
   ```

## 4. CocoaPods Registry

### Private Spec Repository

1. Create GitLab repository for specs:
   ```bash
   git clone git@git.liberyus.com:dedi/cocoapods-specs.git
   ```

2. Add to CocoaPods:
   ```bash
   pod repo add dedi-specs git@git.liberyus.com:dedi/cocoapods-specs.git
   ```

3. Update ios/Podfile:
   ```ruby
   source 'git@git.liberyus.com:dedi/cocoapods-specs.git'
   ```

4. Mirror existing pods:
   ```bash
   pod repo push dedi-specs YourPodspec.podspec
   ```

## 5. Docker Registry

### GitLab Container Registry

1. Enable container registry in GitLab
2. Login:
   ```bash
   docker login registry.gitlab.liberyus.com
   ```

3. Tag and push:
   ```bash
   docker tag source:tag registry.gitlab.liberyus.com/group/image:tag
   docker push registry.gitlab.liberyus.com/group/image:tag
   ```

### Standalone Registry

1. Run Docker registry:
   ```bash
   docker run -d -p 5000:5000 --name registry registry:2
   ```

2. Configure insecure registry if needed (for testing):
   ```json
   {
     "insecure-registries": ["registry.liberyus.com:5000"]
   }
   ```

## Verification

After setup, test each registry:

```bash
# NPM
npm install --loglevel verbose

# Pub/Dart
flutter pub get --verbose

# Maven/Gradle
cd android && ./gradlew dependencies

# CocoaPods
cd ios && pod install --verbose

# Docker
docker pull registry.liberyus.com/nginx:alpine
```

## Troubleshooting

### NPM authentication fails
- Verify token in .npmrc
- Check GitLab registry is enabled
- Ensure token has package:read scope

### Pub packages not found
- Verify PUB_HOSTED_URL environment variable
- Check pub_server is running
- Ensure packages are published to private registry

### Gradle sync fails
- Verify GITLAB_MAVEN_TOKEN environment variable
- Check project ID in Maven URL
- Ensure token has api scope

### Pod install fails
- Verify private spec repo is added: `pod repo list`
- Check SSH access to GitLab
- Ensure Podfile source is correct

## Full Offline Mode

To enable complete offline operation:

1. Remove all public registry fallbacks
2. Ensure all packages are mirrored
3. Test builds without internet connection
4. Document any remaining external dependencies
EOF

echo -e "${GREEN}  ✓ Created docs/migration/REGISTRY_SETUP.md${NC}"
echo ""

echo -e "${GREEN}=================================================="
echo "Package registry setup complete!"
echo "==================================================${NC}"
echo ""
echo "Created files:"
echo "  - scripts/copy-nse/.npmrc          (NPM config)"
echo "  - pubspec_overrides.yaml           (Pub config template)"
echo "  - android/gradle/private-registry.gradle (Maven config)"
echo "  - ios/Podfile                      (Updated with private source)"
echo "  - docs/migration/REGISTRY_SETUP.md (Setup documentation)"
echo ""
echo "Next steps:"
echo "1. Read docs/migration/REGISTRY_SETUP.md for detailed setup"
echo "2. Configure each registry based on your infrastructure"
echo "3. Test each package manager with private registries"
echo "4. Run full offline build tests"

