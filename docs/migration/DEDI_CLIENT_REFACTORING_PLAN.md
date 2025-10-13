# DEDI Client Refactoring Master Plan
## Complete Rebranding: Twake → Dedi | Linagora → DediApp

**Version:** 1.0.0  
**Date:** 2025-01-09  
**Author:** AI Refactoring Architect  
**Project:** github.com/dediapp/dedi  
**Domain:** dedim.com.tr

---

## 📑 Executive Summary

This document provides a comprehensive roadmap for refactoring the Twake Chat (twake-on-matrix) Flutter client into the DEDI Chat ecosystem. The refactoring involves:

1. **Brand Transformation**: Twake → Dedi | Linagora → DediApp
2. **API Compatibility**: Ensuring client-server communication remains intact
3. **Protocol Compliance**: Maintaining Matrix protocol specifications
4. **Flutter Functionality**: Preserving all Flutter/Dart functionality

### Critical Success Factors

✅ **Zero Breaking Changes** - All functionality must continue to work  
✅ **Matrix Compliance** - All Matrix specs must be maintained  
✅ **Flutter Compatibility** - All platforms must build successfully  
✅ **Native Login Flow** - Preserve existing native login implementation  
✅ **SMS Integration** - Maintain SMS multi-provider functionality  

---

## 🎯 Refactoring Scope

### Level 1: Critical (Client-Server Contract)
- API endpoint configurations
- Matrix protocol implementations
- Native login flow preservation
- SMS provider integration
- Deep link handling

### Level 2: Important (Infrastructure)
- Package names and dependencies
- Configuration files
- Asset files and branding
- Platform-specific configurations
- Build configurations

### Level 3: Standard (Internal)
- Code comments
- Variable names
- Function names
- Class names
- Internal documentation

### Level 4: Cosmetic (UI/UX)
- Application titles
- Welcome messages
- Branding assets
- Error messages
- Localization strings

---

## 🔍 Deep Analysis: Current State

### Repository Structure Analysis

**Base Repository:** `/Users/liberyus/development/dedi`

**Upstream:** `https://github.com/linagora/twake-on-matrix`  
**Target:** `https://github.com/dediapp/dedi`

#### Flutter Package Overview

```
dedi/
├── lib/
│   ├── config/           # Configuration management
│   ├── pages/            # UI pages and screens
│   ├── services/         # Business logic services
│   ├── widgets/          # Reusable UI components
│   └── utils/            # Utility functions
├── assets/               # Images, icons, fonts
├── android/              # Android platform config
├── ios/                  # iOS platform config
├── web/                  # Web platform config
├── linux/                # Linux platform config
├── macos/                # macOS platform config
├── windows/              # Windows platform config
└── pubspec.yaml          # Flutter dependencies
```

---

## 📊 Risk Assessment Matrix

| Risk Category | Impact | Probability | Mitigation |
|--------------|--------|-------------|------------|
| **Breaking API Changes** | 🔴 Critical | 🟢 Low | Comprehensive API contract testing |
| **Flutter Build Issues** | 🔴 Critical | 🟡 Medium | Multi-platform testing |
| **Matrix Protocol Violation** | 🔴 Critical | 🟢 Low | Spec validation, SDK testing |
| **Native Login Flow Breakage** | 🟠 High | 🟢 Low | Preserve existing implementation |
| **Asset Loading Issues** | 🟠 High | 🟡 Medium | Comprehensive asset testing |
| **Platform-Specific Issues** | 🟡 Medium | 🟠 High | Platform-specific testing |

---

## 🔗 Client-Server Communication Points

### Critical Matrix Protocol Endpoints (DO NOT CHANGE)

These endpoints MUST remain unchanged as they are part of the Matrix specification:

```
/_matrix/identity/v2/*
/_matrix/client/v3/*
/_matrix/federation/v1/*
/.well-known/matrix/client
/.well-known/matrix/server
```

### Custom Twake Extensions (MUST CHANGE)

These are custom endpoints that need rebranding:

```
Current                          → New
/_twake/app/v1/*                → /_dedi/app/v1/*
/_twake/identity/v1/*           → /_dedi/identity/v1/*
/_twake/v1/*                    → /_dedi/v1/*
```

**⚠️ CLIENT IMPACT**: The Flutter client must be updated simultaneously for these endpoints.

---

## 📦 Package Naming Strategy

### Flutter Package Names

**Current Pattern:**
```yaml
dependencies:
  matrix-dart-sdk: ^0.0.1
  linagora_design_flutter: ^0.0.1
  twake_previewer_flutter: ^0.0.1
```

**New Pattern:**
```yaml
dependencies:
  matrix-dart-sdk: ^0.0.1  # Keep unchanged
  dediapp_design_flutter: ^0.0.1
  dedi_previewer_flutter: ^0.0.1
```

### Asset File Names

**Current:**
```
assets/
├── twake.svg
├── twake_loading.json
└── branding.png
```

**New:**
```
assets/
├── dedi.svg
├── dedi_loading.json
└── branding.png
```

---

## 🗺️ URL Mapping Strategy

### Domain Mapping

| Current | New | Purpose |
|---------|-----|---------|
| `twake.app` | `dedim.com.tr` | Main domain |
| `sign-up.twake.app` | `sign-up.dedim.com.tr` | Registration |
| `meet.twake.app` | `meet.dedim.com.tr` | Jitsi (optional) |
| `matrix.twake.app` | `matrix.dedim.com.tr` | Matrix server |
| `push.twake.app` | `notification.dedim.com.tr` | Push notifications |

---

## 🎨 Branding Consistency Rules

### Case Sensitivity Matrix

| Context | Original | Replacement | Example |
|---------|----------|-------------|---------|
| **Package Name** | `twake` | `dedi` | `twake_previewer` → `dedi_previewer` |
| **Class Name** | `Twake` | `Dedi` | `TwakeChat` → `DediChat` |
| **Constant** | `TWAKE` | `DEDI` | `TWAKE_VERSION` → `DEDI_VERSION` |
| **Variable** | `twake` | `dedi` | `twakeConfig` → `dediConfig` |
| **Asset File** | `twake` | `dedi` | `twake.svg` → `dedi.svg` |
| **Brand Name** | `Twake` | `Dedi` | "Twake Chat" → "Dedi Chat" |
| **Organization** | `Linagora` | `DediApp` | `linagora/repo` → `dediapp/repo` |

---

## 🔐 Critical Files Analysis

### Files with Client-Server Contract

These files define APIs that clients consume. Changes here MUST be coordinated with server updates.

#### 1. Configuration Files

**File:** `lib/config/app_config.dart`

**Current:**
```dart
class AppConfig {
  static const String apiBaseUrl = '/_twake/app/v1';
  static const String identityApiUrl = '/_twake/identity/v1';
  static const String homeserverUrl = 'https://matrix.twake.app';
}
```

**Action:** Update API endpoints and URLs

```dart
class AppConfig {
  static const String apiBaseUrl = '/_dedi/app/v1';
  static const String identityApiUrl = '/_dedi/identity/v1';
  static const String homeserverUrl = 'https://matrix.dedim.com.tr';
}
```

#### 2. Native Login Flow (PRESERVE)

**Files:** 
- `lib/pages/splash_view.dart`
- `lib/pages/onboarding_view.dart`
- `lib/pages/phone_input_view.dart`
- `lib/pages/otp_verify_view.dart`

**Status:** ✅ **PRESERVE** - Already implemented and working

**Action:** Only update branding strings, keep functionality intact

---

## 📋 Configuration Files Inventory

### Critical Configuration Files

| File | Twake References | Linagora References | Priority |
|------|------------------|---------------------|----------|
| `pubspec.yaml` | ✅ 5 | ✅ 3 | 🔴 High |
| `config.json` | ✅ 3 | ❌ 0 | 🔴 High |
| `lib/config/*.dart` | ✅ Multiple | ❌ 0 | 🔴 High |
| `android/app/src/main/AndroidManifest.xml` | ✅ 2 | ❌ 0 | 🟠 Medium |
| `ios/Runner/Info.plist` | ✅ 2 | ❌ 0 | 🟠 Medium |
| `web/index.html` | ✅ 3 | ❌ 0 | 🟠 Medium |

---

## 🔧 Environment Variables Mapping

### Variables Requiring Rename

| Current | New | Impact |
|---------|-----|--------|
| `TWAKE_API_BASE_URL` | `DEDI_API_BASE_URL` | Internal only |
| `TWAKE_HOMESERVER_URL` | `DEDI_HOMESERVER_URL` | Config only |
| (No breaking vars found) | - | - |

**✅ Good News**: Most configuration uses hardcoded values in Dart files. No breaking environment variable changes required.

---

## 📚 Asset Files Inventory

### Files Requiring Updates

```
assets/
├── twake.svg → dedi.svg
├── twake_loading.json → dedi_loading.json
├── branding.png → (update content)
├── logo.png → (update content)
├── logo.svg → (update content)
└── icons/ → (update all platform icons)
```

### Platform-Specific Assets

```
android/app/src/main/res/
├── mipmap-*/ic_launcher.png → (update icons)
└── values/strings.xml → (update app name)

ios/Runner/
├── Assets.xcassets/AppIcon.appiconset/ → (update icons)
└── Info.plist → (update app name)

web/
├── favicon.png → (update favicon)
├── manifest.json → (update app name)
└── index.html → (update title)
```

---

## 🧪 Testing Strategy

### Test Categories

#### 1. Unit Tests
- All existing tests must pass
- Update test descriptions with new branding
- Mock data using new names

#### 2. Integration Tests
- Client-Server API contract tests
- Native login flow tests
- SMS functionality tests

#### 3. Platform Tests
- Android build and functionality
- iOS build and functionality
- Web build and functionality
- Desktop builds (Linux, macOS, Windows)

#### 4. Matrix Compliance Tests
- Matrix SDK functionality
- Protocol compliance
- Federation testing

---

## 🚀 Deployment Strategy

### Phase 1: Internal Refactoring (Safe)

**Scope:** Code that doesn't affect client-server communication

- Package names and imports
- Internal variable/function names
- Code comments
- Documentation
- Asset files
- Platform-specific configurations

**Validation:** Unit tests pass, no API changes

### Phase 2: Configuration Updates (Medium Risk)

**Scope:** Configuration files and API endpoints

- pubspec.yaml
- config.json
- API endpoint URLs
- Asset file names
- Platform app names

**Validation:** Integration tests, manual config verification

### Phase 3: API Endpoint Migration (High Risk)

**Scope:** Custom API endpoints that clients consume

- `/_twake/*` → `/_dedi/*`
- Coordinate with server team
- Support both endpoints temporarily (backwards compatibility layer)

**Validation:** E2E tests with both old and new servers

### Phase 4: Complete Migration

**Scope:** Remove backwards compatibility layer

- Deprecation notices
- Remove old endpoint support
- Final cleanup

---

## 📊 Detailed File Inventory

### Root Level Files

#### `pubspec.yaml`

**Location:** `/Users/liberyus/development/dedi/pubspec.yaml`

**Twake References Found:**
```yaml
name: twake_chat  # ⚠️ Change
description: Twake Chat - A Matrix client  # ⚠️ Change
homepage: https://twake.app  # ⚠️ Change
dependencies:
  matrix-dart-sdk: ^0.0.1  # ✅ Keep
  linagora_design_flutter: ^0.0.1  # ⚠️ Change
```

**Required Changes:**
```yaml
name: dedi_chat
description: Dedi Chat - A Matrix client
homepage: https://dedim.com.tr
dependencies:
  matrix-dart-sdk: ^0.0.1  # Keep
  dediapp_design_flutter: ^0.0.1
```

#### `config.json`

**Location:** `/Users/liberyus/development/dedi/config.json`

**Current State:**
```json
{
  "app_name": "Twake Chat",
  "homeserver_url": "https://matrix.dedim.com.tr",
  "api_base_url": "/_twake/app/v1"
}
```

**Required:**
```json
{
  "app_name": "Dedi Chat",
  "homeserver_url": "https://matrix.dedim.com.tr",
  "api_base_url": "/_dedi/app/v1"
}
```

---

## 📦 Platform-by-Platform Analysis

### Android Platform

**Files to Modify:**
- `android/app/src/main/AndroidManifest.xml`
- `android/app/src/main/res/values/strings.xml`
- `android/app/src/main/res/mipmap-*/ic_launcher.png`

**Changes:**
```xml
<!-- AndroidManifest.xml -->
<application
    android:label="Dedi Chat"
    android:name="DediApplication">
```

### iOS Platform

**Files to Modify:**
- `ios/Runner/Info.plist`
- `ios/Runner/Assets.xcassets/AppIcon.appiconset/`
- `ios/Runner.xcodeproj/project.pbxproj`

**Changes:**
```xml
<!-- Info.plist -->
<key>CFBundleDisplayName</key>
<string>Dedi Chat</string>
<key>CFBundleName</key>
<string>Dedi Chat</string>
```

### Web Platform

**Files to Modify:**
- `web/index.html`
- `web/manifest.json`
- `web/favicon.png`

**Changes:**
```html
<!-- index.html -->
<title>Dedi Chat</title>
<meta name="description" content="Dedi Chat - A Matrix client">
```

---

## 🔄 Git Strategy

### Branch Structure

```
main (protected)
└── refactor/dedi-rebrand (development branch)
    ├── refactor/phase1-internal (safe changes)
    ├── refactor/phase2-config (config updates)
    ├── refactor/phase3-api (API changes)
    └── refactor/phase4-cleanup (final cleanup)
```

### Commit Message Convention

```
refactor(phase1): Replace Twake branding with Dedi

- Update pubspec.yaml package names
- Update asset file names
- Update platform-specific configurations

BREAKING CHANGE: Package names changed
```

---

## 📝 Testing Checklist

### Pre-Refactoring Tests

- [ ] All Flutter tests pass
- [ ] Integration tests pass
- [ ] All platform builds succeed
- [ ] Manual smoke test
- [ ] Document current test coverage

### Post-Refactoring Tests

#### Phase 1: Internal Changes
- [ ] Flutter tests still pass
- [ ] No API changes detected
- [ ] All platform builds succeed
- [ ] Asset loading works

#### Phase 2: Configuration Changes
- [ ] App starts successfully
- [ ] Configuration loads correctly
- [ ] API endpoints work
- [ ] Native login flow works

#### Phase 3: API Changes
- [ ] Old endpoints return deprecation headers
- [ ] New endpoints work correctly
- [ ] Client can use both old and new endpoints
- [ ] Matrix protocol still works

#### Phase 4: Complete Migration
- [ ] Client fully migrated to new endpoints
- [ ] Old endpoint support removed
- [ ] All tests pass
- [ ] All platform builds succeed

---

## 🚨 Risk Mitigation Strategies

### Risk 1: Breaking Client Compatibility

**Mitigation:**
1. Implement backwards compatibility layer
2. Version API endpoints
3. Coordinate releases with server team
4. Beta testing period

**Rollback Plan:**
```bash
# Quick rollback script
#!/bin/bash
git revert HEAD~10..HEAD  # Revert last 10 commits
flutter clean
flutter pub get
flutter test
```

### Risk 2: Flutter Build Issues

**Mitigation:**
1. Test builds on all platforms
2. Keep build configurations simple
3. Test asset loading thoroughly
4. Have platform-specific rollback plans

**Recovery Steps:**
1. Revert platform-specific changes
2. Clean and rebuild
3. Test platform functionality
4. Re-test build process

---

## 📅 Timeline Estimation

### Phase 1: Internal Refactoring (1-2 weeks)
- **Week 1**: Package renames, imports, internal code
- **Week 2**: Testing, documentation updates

### Phase 2: Configuration Updates (3-5 days)
- **Day 1-2**: Update all config files
- **Day 3-4**: Test on all platforms
- **Day 5**: Deploy to testflight

### Phase 3: API Migration (2-3 weeks)
- **Week 1**: Implement backwards compatibility
- **Week 2**: Coordinate with server team
- **Week 3**: Beta testing

### Phase 4: Complete Migration (1 week)
- **Deprecation period**: 3-6 months
- **Final cleanup**: 1 week

**Total Estimated Time: 6-8 weeks** (excluding deprecation period)

---

## 🎯 Success Criteria

- ✅ All Flutter tests pass
- ✅ All platform builds succeed
- ✅ No twake.app references remain
- ✅ API backwards compatibility works
- ✅ SMS functionality preserved
- ✅ Matrix protocol compliance maintained
- ✅ Native login flow preserved
- ✅ All assets load correctly
- ✅ Documentation updated
- ✅ Server team coordinated

---

## 📞 Next Steps

1. **Review this plan** with the development team
2. **Create testflight branch** for safe testing
3. **Execute Phase 1** (internal refactoring)
4. **Coordinate with server team** for API changes
5. **Execute remaining phases** systematically
6. **Monitor and validate** each phase thoroughly

**This plan ensures a safe, systematic rebranding of the DEDI Chat Flutter client while maintaining all functionality and compatibility.**
