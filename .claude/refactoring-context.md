# DEDI Client Refactoring Context

## Project Overview
- **Original**: Twake Chat (twake-on-matrix) fork from linagora
- **Target**: DEDI Chat for dedim.com.tr
- **Repository**: github.com/dediapp/dedi
- **Domain**: dedim.com.tr
- **Organization**: DediApp (formerly Linagora)
- **Platform**: Flutter/Dart multi-platform client

## Refactoring Goals
1. **Rebrand Twake → Dedi** (all instances)
2. **Rebrand Linagora → DediApp** (organization)
3. **Maintain Matrix protocol compliance** (critical)
4. **Preserve client-server compatibility** (critical)
5. **Update all URLs**: twake.app → dedim.com.tr
6. **Preserve SMS multi-provider features** (DEDI custom)
7. **Maintain Flutter/Dart functionality** (critical)

## Critical Rules - NEVER BREAK
- **DO NOT change Matrix protocol implementations** (matrix-dart-sdk)
- **DO NOT change core Flutter functionality**
- **MAINTAIN backwards compatibility** for API endpoints
- **PRESERVE all Matrix protocol specifications**
- **TEST thoroughly after each change**
- **PRESERVE SMS multi-provider functionality** (DEDI custom feature)
- **MAINTAIN native login flow** (already implemented)

## Package Mapping (Flutter Dependencies)
```
# Core Matrix packages (keep unchanged)
matrix-dart-sdk → matrix-dart-sdk (no change)
flutter_openssl_crypto → flutter_openssl_crypto (no change)

# UI/UX packages (rebrand)
linagora-design-flutter → dediapp-design-flutter
twake-previewer-flutter → dedi-previewer-flutter

# Custom packages (rebrand)
twake_* → dedi_* (all custom packages)
```

## URL Mapping
```
twake.app → dedim.com.tr
sign-up.twake.app → sign-up.dedim.com.tr
meet.twake.app → meet.dedim.com.tr
matrix.twake.app → matrix.dedim.com.tr
push.twake.app → notification.dedim.com.tr
linagora/* → dediapp/*
```

## API Endpoints
**OLD (deprecated)**: /_twake/app/v1/*
**NEW**: /_dedi/app/v1/*
**Note**: Support both with deprecation headers until 2025-06-01

## DEDI Custom Features to Preserve
- **Native Login Flow**: SplashView, OnboardingView, PhoneInputView, OTPVerifyView
- **SMS Multi-Provider Support**: Backend integration
- **Turkish SMS Support**: Local providers prioritized
- **Deep Link Support**: dedi://login
- **Matrix Protocol**: Full compliance maintained

## Configuration Already Updated
- **Domain URLs**: All dedim.com.tr ✅
- **Native Login**: Implemented ✅
- **SMS Integration**: Working ✅
- **Deep Links**: dedi://login ✅

## Flutter-Specific Considerations
- **pubspec.yaml**: Update package names and descriptions
- **config.json**: Update branding and URLs
- **Assets**: Update logos, icons, branding images
- **Localization**: Update Turkish translations
- **Platform-specific**: Update Android/iOS app names
- **Web**: Update web app branding

## Risk Levels
- **Critical**: Matrix protocol, API endpoints, native login flow
- **High**: Package names, app branding, deep links
- **Medium**: UI strings, assets, configuration
- **Low**: Comments, documentation, internal names

## Testing Requirements
- All Flutter tests must pass
- Integration tests must pass
- Platform builds must succeed (Android, iOS, Web, Desktop)
- No twake.app references should remain
- API backwards compatibility must work
- SMS functionality must be preserved
- Native login flow must work

## Rollback Strategy
- Full backup before starting: `.refactor-backup/`
- Git commits after each phase
- Flutter build rollback capability
- Configuration file backups
- Asset rollback capability

## Client-Server Coordination
- Flutter client must coordinate with server API changes
- API endpoint migration requires coordination
- 6-month deprecation period for old endpoints
- Backwards compatibility layer required

## Success Criteria
- Zero breaking changes for existing functionality
- All Matrix protocol compliance maintained
- SMS multi-provider functionality preserved
- All Flutter tests passing
- All platform builds successful
- Documentation updated
- Server team coordinated

## Flutter Build Commands
```bash
# Test all platforms
flutter test
flutter test integration_test/

# Build all platforms
flutter build apk
flutter build ios
flutter build web
flutter build linux
flutter build macos
flutter build windows

# Check for remaining references
grep -r "twake" lib/
grep -r "twake.app" lib/
```

## Asset Updates Required
- **Icons**: Update app icons for all platforms
- **Logos**: Replace Twake logos with Dedi logos
- **Branding**: Update all visual branding elements
- **Splash Screen**: Update splash screen branding
- **Loading Animations**: Update loading animations

## Platform-Specific Updates
- **Android**: Update app name, package name, icons
- **iOS**: Update app name, bundle identifier, icons
- **Web**: Update web app title, favicon, manifest
- **Desktop**: Update app names and icons
