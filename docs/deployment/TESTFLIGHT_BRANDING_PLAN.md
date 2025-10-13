# DEDI Client Testflight Branding Plan

## Project Overview
**Project Name**: DEDI Client Testflight Branding  
**Version**: 1.0.0  
**Date**: 2025-01-09  
**Owner**: DediApp Development Team  
**Repository**: github.com/dediapp/dedi  
**Domain**: dedim.com.tr  

## Executive Summary
**SIMPLE GOAL**: Create a testflight build that shows "Dedi Chat" instead of "Twake Chat" while keeping the Flutter app fully functional. This is a minimal branding change for testflight validation before detailed refactoring.

## Business Objectives
1. **Brand Visibility**: Show "Dedi Chat" instead of "Twake Chat" in testflight
2. **App Functionality**: Ensure Flutter app still works perfectly on all platforms
3. **Native Login Preservation**: Keep native login flow intact
4. **Matrix Compliance**: Maintain all Matrix protocol standards
5. **Zero Breaking Changes**: No impact on existing functionality

## Success Metrics - TESTFLIGHT ONLY
- **Branding Visible**: User sees "Dedi Chat" instead of "Twake Chat"
- **App Running**: All platforms start and work normally
- **Native Login Working**: Native login flow preserved and functional
- **Matrix Working**: All Matrix protocol endpoints functional
- **No Errors**: No breaking changes or errors on any platform

## Technical Requirements - MINIMAL CHANGES

### Phase 1: App Branding Only (1-2 days)
1. **pubspec.yaml**: Update app name and description
   - `name: dedi_chat`
   - `description: Dedi Chat - A Matrix client`

2. **config.json**: Update app branding
   - `"app_name": "Dedi Chat"`

3. **Platform-Specific Configs**: Update app names
   - Android: Update app name in strings.xml
   - iOS: Update app name in Info.plist
   - Web: Update title in index.html

4. **Asset Files**: Update branding assets
   - Rename `twake.svg` → `dedi.svg`
   - Update branding images content

### Phase 2: Build and Test (1 day)
1. **Flutter Build**: Create testflight builds for all platforms
2. **Platform Testing**: Test on Android, iOS, Web
3. **Functionality Test**: Verify all features work

## What We DON'T Change (Keep for Later)
- ❌ Package names in pubspec.yaml - Later
- ❌ Class names in Dart code - Later  
- ❌ API endpoint URLs - Later
- ❌ Import statements - Later
- ❌ Code comments - Later
- ❌ Documentation files - Later

## Implementation Steps

### Day 1: App Branding
```bash
# 1. Update pubspec.yaml
# Change name: twake_chat → dedi_chat
# Change description: "Twake Chat" → "Dedi Chat"

# 2. Update config.json
# Change app_name: "Twake Chat" → "Dedi Chat"

# 3. Update platform configs
# Android: android/app/src/main/res/values/strings.xml
# iOS: ios/Runner/Info.plist
# Web: web/index.html
```

### Day 2: Assets & Build
```bash
# 1. Update asset files
# Rename assets/twake.svg → assets/dedi.svg
# Update branding images

# 2. Build all platforms
fvm flutter build apk
fvm flutter build ios
fvm flutter build web

# 3. Test functionality
fvm flutter test
```

### Day 3: Testflight Deployment
```bash
# 1. Deploy to testflight environment
# 2. Test all functionality
# 3. Validate branding changes
```

## Risk Assessment - MINIMAL RISK
- **Risk Level**: Very Low
- **Breaking Changes**: None
- **Client Impact**: None (UI only)
- **Rollback**: Simple (revert config files)

## Rollback Plan
If anything goes wrong:
```bash
# 1. Revert config files
git checkout HEAD~1 pubspec.yaml
git checkout HEAD~1 config.json
git checkout HEAD~1 android/app/src/main/res/values/strings.xml
git checkout HEAD~1 ios/Runner/Info.plist
git checkout HEAD~1 web/index.html

# 2. Rebuild and redeploy
fvm flutter clean
fvm flutter pub get
fvm flutter build apk
fvm flutter build web
```

## Success Criteria
- [ ] User sees "Dedi Chat" in app
- [ ] App starts without errors on all platforms
- [ ] Native login flow works
- [ ] Matrix functionality works
- [ ] All existing features work
- [ ] No breaking changes

## Timeline
- **Total Duration**: 3 days
- **Risk Level**: Very Low
- **Team Required**: 1 developer
- **Downtime**: None (testflight only)

## Next Steps After Testflight
Once testflight branding is successful:
1. Plan detailed refactoring (packages, classes, APIs)
2. Create comprehensive migration plan
3. Coordinate with server team
4. Execute full refactoring

---

**This is a MINIMAL branding change for testflight validation only.**
