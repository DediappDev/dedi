# DEDI Client Refactoring - Quick Start Guide - TESTFLIGHT EDITION

## 🚀 Ready to Start TESTFLIGHT Refactoring?

All necessary files have been created! Here's your quick start guide for TESTFLIGHT deployment:

---

## 📁 **Files Created/Updated**

### ✅ **New Files Created:**
- `.claude/refactoring-context.md` - DEDI client refactoring context
- `.cursorrules` - DEDI client cursor rules  
- `docs/refactoring/DEDI_CLIENT_REFACTORING_PLAN.md` - Comprehensive refactoring plan
- `TESTFLIGHT_BRANDING_PLAN.md` - Simple testflight branding plan
- `API_MIGRATION_GUIDE.md` - API migration guide
- `DEPLOYMENT_CHECKLIST.md` - Deployment checklist
- `ENVIRONMENT_SETUP.md` - Environment setup guide

### ✅ **Files Updated:**
- `.taskmaster/templates/example_prd.txt` - Refactoring context added
- `.taskmaster/tasks/tasks.json` - Testflight tasks added
- `docs/UNIFIED_IMPLEMENTATION_GUIDE.md` - Next phase info added

---

## 🎯 **TESTFLIGHT BRANDING PLAN - QUICK START**

### **Goal**: Show "Dedi Chat" instead of "Twake Chat" in testflight

### **What Changes (Minimal)**:
1. **pubspec.yaml** - App name and description
2. **config.json** - App name
3. **Platform configs** - Android, iOS, Web app names
4. **Asset files** - Rename twake.svg → dedi.svg

### **What Stays (For Later)**:
- ❌ Package names (`twake_*`)
- ❌ Class names (`TwakeChat`)
- ❌ API endpoint URLs (`/_twake/*`)
- ❌ Import statements
- ❌ Code comments
- ❌ Native login flow (preserve)

---

## 🚀 **Quick Start Commands**

### 1. **Check Current Status**
```bash
cd /Users/liberyus/development/dedi

# Check current branding
grep -r "Twake" pubspec.yaml
grep -r "twake" config.json
grep -r "twake" android/app/src/main/res/values/strings.xml
grep -r "twake" ios/Runner/Info.plist
grep -r "twake" web/index.html
```

### 2. **Start TESTFLIGHT Branding**
```bash
# Task 11.1: Update pubspec.yaml
# Task 11.2: Update config.json
# Task 11.3: Update platform configs
# Task 11.4: Update asset files
# Task 11.5: Build and test
```

### 3. **Build All Platforms**
```bash
# Clean and build
fvm flutter clean
fvm flutter pub get

# Build all platforms
fvm flutter build apk
fvm flutter build ios
fvm flutter build web
fvm flutter build linux
fvm flutter build macos
fvm flutter build windows
```

### 4. **Test Functionality**
```bash
# Run tests
fvm flutter test

# Run integration tests
fvm flutter test integration_test/

# Test on devices
fvm flutter run
```

---

## 📋 **TaskMaster Commands**

### **View Tasks**
```bash
# List all tasks
tm list

# Show testflight task
tm show 11

# Show future task
tm show 12
```

### **Start Testflight Task**
```bash
# Start testflight branding
tm set-status 11 in-progress

# Complete subtasks
tm set-status 11.1 done
tm set-status 11.2 done
tm set-status 11.3 done
tm set-status 11.4 done
tm set-status 11.5 done

# Complete main task
tm set-status 11 done
```

---

## 🔍 **Validation Commands**

### **Check for Remaining References**
```bash
# Check for twake references
grep -r "twake" lib/
grep -r "twake.app" lib/
grep -r "Twake" lib/

# Check for new dedi references
grep -r "dedi" lib/
grep -r "dedim.com.tr" lib/
```

### **Build Validation**
```bash
# Validate Flutter build
fvm flutter test
fvm flutter build apk
fvm flutter build web

# Check for errors
fvm flutter analyze
```

---

## 🚨 **Emergency Rollback**

If anything goes wrong:
```bash
# Quick rollback
git reset --hard HEAD~1

# Clean and rebuild
fvm flutter clean
fvm flutter pub get
fvm flutter test
```

---

## 📊 **Success Criteria**

- [ ] User sees "Dedi Chat" in app
- [ ] App starts without errors on all platforms
- [ ] Native login flow works
- [ ] Matrix functionality works
- [ ] All existing features work
- [ ] No breaking changes

---

## 🎯 **Next Steps After Testflight**

Once testflight branding is successful:
1. **Plan detailed refactoring** (Task 12)
2. **Create comprehensive migration plan**
3. **Coordinate with server team**
4. **Execute full refactoring**

---

## 📞 **Support**

- **Development Team**: dev@dedim.com.tr
- **Server Team**: server@dedim.com.tr
- **Support**: support@dedim.com.tr

---

**This is a MINIMAL branding change for testflight validation only. Full refactoring will follow after testflight success!**
