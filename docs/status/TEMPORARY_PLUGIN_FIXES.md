# TEMPORARY PLUGIN FIXES - MUST BE RESTORED

## receive_sharing_intent Plugin Issue

**Problem:** Swift compiler cannot find 'Flutter/Flutter.h' headers, causing build failures on iOS.

**Temporarily Disabled Files & Code:**
1. `pubspec.yaml:17-21` - Commented out receive_sharing_intent dependency
2. `lib/pages/chat_list/receive_sharing_intent_mixin.dart:17` - Commented out plugin import
3. `lib/pages/chat_list/receive_sharing_intent_mixin.dart:36-148` - Disabled plugin-dependent code
4. `lib/presentation/extensions/shared_media_file_extension.dart:1-47` - Entire file commented out
5. `ios/Runner/AppDelegate.swift:3,57-59` - Plugin import and usage still active (needs fixing)
6. `ios/TwakeShareExtension/ShareViewController.swift:1,3` - **CRITICAL:** Commented out plugin import and changed inheritance to SLComposeServiceViewController

**Error Details:**
```
Swift Compiler Error (Xcode): 'Flutter/Flutter.h' file not found
receive_sharing_intent-f08a4c0c.input:1:1: fatal error: could not build module 'receive_sharing_intent'
```

**Attempted Fixes (Failed):**
- Added comprehensive header search paths in `ios/Podfile:54-68`
- Multiple Flutter clean and pod install cycles
- Header paths for Flutter framework locations

**NEXT STEPS TO PROPERLY FIX:**
1. Update receive_sharing_intent plugin fork to be compatible with current Flutter/Xcode
2. Or find alternative sharing plugin (share_plus already available)
3. Restore all commented code
4. Test sharing functionality

**Files to Restore:**
- Uncomment `pubspec.yaml:17-21`
- Uncomment `lib/pages/chat_list/receive_sharing_intent_mixin.dart:17`
- Uncomment `lib/pages/chat_list/receive_sharing_intent_mixin.dart:36-148`
- Uncomment `lib/presentation/extensions/shared_media_file_extension.dart:1-47`
- Fix AppDelegate.swift properly

**Priority:** HIGH - Sharing functionality is core feature