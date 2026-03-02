# DEDI Authentication Flow Documentation

**Last Updated:** 2025-11-29
**Status:** Implementation Complete - Ready for Testing

---

## 📋 Table of Contents

1. [Overview](#overview)
2. [Problem Statement](#problem-statement)
3. [Implementation Summary](#implementation-summary)
4. [Authentication Flow](#authentication-flow)
5. [File Changes](#file-changes)
6. [Router Guard Logic](#router-guard-logic)
7. [AuthStore State Machine](#authstore-state-machine)
8. [Testing Guide](#testing-guide)
9. [Debugging](#debugging)
10. [Troubleshooting](#troubleshooting)

---

## 📖 Overview

This document describes the **complete authentication flow** for the DEDI app, including:
- Phone-based OTP authentication via https://tom.dedim.com.tr
- First-run onboarding experience
- Token validation and session management
- Router guards and navigation flow

The implementation fixes critical issues where the app was jumping to `/rooms` without proper authentication, causing null reference crashes.

---

## 🚨 Problem Statement

### Original Broken Behavior

```
Client.init() fails with "type 'Null' is not a subtype of type 'String'"
↓
AuthStore.state = AuthState.authenticated  ← WRONG!
↓
Router redirect: /splash → /rooms  ← PREMATURE!
↓
App crashes: "Null check operator used on a null value"
```

### Root Causes

1. **Corrupted client data** - ClientManager loaded broken client from storage
2. **No error handling** - AuthStore.bootstrap() didn't handle client init failures
3. **No first-run detection** - Missing onboarding preference check
4. **Router guards broken** - Checked AuthState but not actual client validity
5. **No data cleanup** - Corrupted data persisted across app restarts

---

## ✅ Implementation Summary

### What Was Fixed

#### Phase 1: Emergency Fix in main.dart
- ✅ Wrapped `ClientManager.getClients()` in try-catch
- ✅ Clear corrupted data (SecureStorage + Hive) on client init failure
- ✅ Set `authStore.state = unauthenticated` on failure
- ✅ Comprehensive error logging

#### Phase 2: Fix AuthStore.bootstrap()
- ✅ Added null checks for `client.userID` and `client.accessToken`
- ✅ Wrapped token validation in try-catch
- ✅ Clear credentials if validation fails
- ✅ Comprehensive logging at each step

#### Phase 3: Add Onboarding System
- ✅ Created `OnboardingPrefs` utility (SharedPreferences wrapper)
- ✅ Added `onboardingDone` field to AuthStore
- ✅ Check onboarding status in bootstrap()

#### Phase 4: Fix Router Guards
- ✅ Added client validity double-check in authenticated state
- ✅ Call `auth.logout()` if client is null despite authenticated state
- ✅ Added onboarding flow logic (first-run detection)
- ✅ Enhanced debug logging with onboarding status

#### Phase 5: Create Onboarding Screen
- ✅ Created `OnboardingView` welcome screen
- ✅ Turkish UI ("DEDI'ye Hoşgeldiniz")
- ✅ "Başlayalım" button to proceed to phone input

#### Phase 6: Add Onboarding Route
- ✅ Added `/onboarding` route to router
- ✅ Imported OnboardingView

#### Phase 7: Mark Onboarding Done After Auth
- ✅ Updated OTPVerifyController to mark onboarding done
- ✅ Set `authStore.onboardingDone = true` after successful auth
- ✅ Updated documentation to reflect 7-step auth flow

---

## 🔄 Authentication Flow

### Expected Flow (Now Implemented)

```
┌─────────────────────────────────────────────────────────────────┐
│ App Start                                                        │
│  ↓                                                               │
│ main() - Initialize Flutter, Hive, GetIt, Matrix clients        │
│  ↓                                                               │
│ Try: ClientManager.getClients()                                 │
│  ├─ Success: firstClient exists                                 │
│  │   ↓                                                           │
│  │  AuthStore.bootstrap(client: firstClient)                    │
│  │   ├─ Check: client.userID != null && client.accessToken != null? │
│  │   │   ├─ No: state = unauthenticated, clear storage         │
│  │   │   └─ Yes: Continue                                       │
│  │   ├─ Check: OnboardingPrefs.isDone()                         │
│  │   │   └─ Set: authStore.onboardingDone = result             │
│  │   ├─ Load: SessionCredentialsStorage.load()                 │
│  │   │   ├─ null: state = unauthenticated                      │
│  │   │   └─ exists: Continue                                    │
│  │   ├─ Hydrate: MatrixSessionHydrator.fromAccessToken()       │
│  │   ├─ Validate: MatrixSessionHydrator.validateAccessToken()  │
│  │   │   ├─ true: state = authenticated                         │
│  │   │   └─ false: state = unauthenticated, clear storage      │
│  │   └─ End                                                      │
│  │                                                               │
│  └─ Catch: Clear all storage, state = unauthenticated          │
│                                                                  │
│ Start GUI with AuthStore                                        │
│  ↓                                                               │
│ Router Redirect Logic:                                          │
│  ├─ AuthState.unknown/hydrating → /splash                      │
│  ├─ AuthState.authenticated                                     │
│  │   ├─ Check: client != null && client.userID != null?        │
│  │   │   ├─ No: logout(), → /phone-input                       │
│  │   │   └─ Yes: → /rooms                                       │
│  │   └─ End                                                      │
│  └─ AuthState.unauthenticated                                   │
│      ├─ Check: onboardingDone?                                  │
│      │   ├─ No: → /onboarding                                  │
│      │   └─ Yes: → /phone-input                                 │
│      └─ End                                                      │
└─────────────────────────────────────────────────────────────────┘
```

### First-Time User Flow

```
/splash
→ /onboarding (user clicks "Başlayalım")
→ /phone-input (user enters phone)
→ /otp-verify (user enters OTP)
→ Auth Success (7-step process in OTPVerifyController)
→ /rooms
```

### Returning Authenticated User Flow

```
/splash
→ AuthStore.bootstrap() validates saved token
→ state = authenticated
→ /rooms
```

### Returning Unauthenticated User Flow

```
/splash
→ AuthStore.bootstrap() finds no saved credentials
→ state = unauthenticated
→ /phone-input (skip onboarding)
→ /otp-verify
→ Auth Success
→ /rooms
```

---

## 📁 File Changes

### Modified Files

#### 1. `/lib/main.dart`
**Lines 77-101:** Added try-catch for ClientManager.getClients()
```dart
List<Client> clients = [];
try {
  clients = await ClientManager.getClients();
} catch (e, stack) {
  Logs().e('[MAIN] ClientManager.getClients() failed: $e');
  // Clear all corrupted data
  await const FlutterSecureStorage().deleteAll();
  await Hive.deleteFromDisk();
}
```

**Lines 144-155:** Added try-catch for AuthStore.bootstrap()
```dart
if (firstClient != null) {
  try {
    await authStore.bootstrap(client: firstClient);
  } catch (e, stack) {
    Logs().e('[MAIN] AuthStore.bootstrap() failed: $e');
    authStore.state = AuthState.unauthenticated;
  }
} else {
  authStore.state = AuthState.unauthenticated;
}
```

#### 2. `/lib/state/auth_store.dart`
**Complete rewrite of bootstrap() method:**
- Added `onboardingDone` field
- Added null checks for `client.userID` and `client.accessToken`
- Added comprehensive logging
- Wrapped token validation in try-catch
- Clear credentials on validation failure

#### 3. `/lib/widgets/twake_app.dart`
**Lines 75-125:** Updated router redirect logic
- Added client validity double-check
- Added onboarding flow logic
- Enhanced debug logging

#### 4. `/lib/pages/phone_auth/otp_verify/otp_verify_controller.dart`
**Lines 12, 286-299:** Mark onboarding done after successful auth
- Import OnboardingPrefs
- Added Step 7 to mark onboarding as done
- Update authStore.onboardingDone field

#### 5. `/lib/config/go_routes/go_router.dart`
**Lines 25, 103-109:** Add onboarding route
- Import OnboardingView
- Add /onboarding route

### New Files Created

#### 1. `/lib/utils/onboarding_prefs.dart`
**Purpose:** Manage onboarding completion preference
**Methods:**
- `isDone()` - Check if onboarding completed
- `setDone()` - Mark onboarding completed
- `reset()` - Reset for testing

#### 2. `/lib/pages/phone_auth/onboarding/onboarding_view.dart`
**Purpose:** First-run onboarding screen
**Features:**
- DEDI logo
- Welcome message in Turkish
- "Başlayalım" button to proceed

---

## 🛡️ Router Guard Logic

### Redirect Decision Tree

```
┌─────────────────────────────────────────────────────────────┐
│ redirect(ctx, state)                                        │
│  ↓                                                          │
│ Get: authState, currentLocation, onboardingDone            │
│  ↓                                                          │
│ Log: [REDIRECT] authState=$s from=$loc onboardingDone=...  │
│  ↓                                                          │
│ Check: AuthState?                                           │
│  ├─ unknown/hydrating                                      │
│  │   └─ Return: /splash                                    │
│  │                                                          │
│  ├─ authenticated                                           │
│  │   ├─ Check: client != null && client.userID != null?   │
│  │   │   ├─ No:                                            │
│  │   │   │   ├─ Log: ERROR - client is null!              │
│  │   │   │   ├─ Call: auth.logout()                       │
│  │   │   │   └─ Return: /phone-input                      │
│  │   │   └─ Yes:                                           │
│  │   │       ├─ If: currentLocation is auth flow          │
│  │   │       │   └─ Return: /rooms                        │
│  │   │       └─ Else: Return: null (allow)                │
│  │   └─ End                                                 │
│  │                                                          │
│  └─ unauthenticated                                         │
│      ├─ Check: onboardingDone?                             │
│      │   ├─ No (first run):                                │
│      │   │   ├─ If: loc is /onboarding or auth flow       │
│      │   │   │   └─ Return: null (allow)                  │
│      │   │   └─ Else: Return: /onboarding                 │
│      │   │                                                  │
│      │   └─ Yes (returning user):                          │
│      │       ├─ If: loc is /phone-input or /otp-verify    │
│      │       │   └─ Return: null (allow)                  │
│      │       └─ Else: Return: /phone-input                │
│      └─ End                                                 │
└─────────────────────────────────────────────────────────────┘
```

---

## 🔄 AuthStore State Machine

### States

```
AuthState.unknown
   ↓ (app start)
AuthState.hydrating
   ↓
   ├─ (success) → AuthState.authenticated
   └─ (failure) → AuthState.unauthenticated
```

### State Transitions

| From State        | Event                 | To State           | Action                          |
|-------------------|----------------------|--------------------|---------------------------------|
| `unknown`         | bootstrap() called   | `hydrating`        | Check onboarding, load credentials |
| `hydrating`       | Valid token          | `authenticated`    | Set client, notify listeners   |
| `hydrating`       | Invalid/null token   | `unauthenticated`  | Clear credentials              |
| `authenticated`   | logout() called      | `unauthenticated`  | Clear client and credentials   |
| `unauthenticated` | OTP verify success   | `authenticated`    | Set client, save credentials   |

---

## 🧪 Testing Guide

### Manual Testing Scenarios

#### Test 1: Fresh Install (First Run)
**Steps:**
1. Uninstall app completely
2. Reinstall and launch
3. Expected flow: `/splash` → `/onboarding`
4. Click "Başlayalım"
5. Expected: Navigate to `/phone-input`
6. Enter valid phone number
7. Expected: Navigate to `/otp-verify`
8. Enter valid OTP
9. Expected: 7-step auth flow completes, navigate to `/rooms`

**Success Criteria:**
- ✅ Onboarding screen shows on first run
- ✅ Phone input works
- ✅ OTP verification succeeds
- ✅ Logs show all 7 steps completing
- ✅ App navigates to `/rooms`
- ✅ OnboardingPrefs.isDone() returns true

#### Test 2: Returning User (Onboarding Already Done, No Auth)
**Steps:**
1. Complete Test 1
2. Close app
3. Clear app data (but not uninstall)
4. Relaunch app
5. Expected flow: `/splash` → `/phone-input` (skip onboarding)

**Success Criteria:**
- ✅ Onboarding screen does NOT show
- ✅ App goes directly to `/phone-input`

#### Test 3: Authenticated User Restart
**Steps:**
1. Complete Test 1 (user is authenticated)
2. Close app
3. Relaunch app (with saved credentials)
4. Expected flow: `/splash` → `/rooms`

**Success Criteria:**
- ✅ AuthStore.bootstrap() succeeds
- ✅ Token validation passes
- ✅ App navigates directly to `/rooms`
- ✅ No auth screens shown

#### Test 4: Corrupted Data Recovery
**Steps:**
1. Manually corrupt Hive database or SecureStorage
2. Launch app
3. Expected: App detects error, clears all data, sets unauthenticated
4. Expected flow: `/splash` → `/onboarding` (if onboarding not done) or `/phone-input`

**Success Criteria:**
- ✅ App doesn't crash
- ✅ Logs show: `[MAIN] ClientManager.getClients() failed`
- ✅ Logs show: `[MAIN] Clearing all storage`
- ✅ App recovers and shows auth screens

#### Test 5: Invalid Token on Restart
**Steps:**
1. Complete Test 1 (authenticated)
2. Manually invalidate the Matrix access token on the server
3. Restart app
4. Expected: Token validation fails, credentials cleared, redirect to `/phone-input`

**Success Criteria:**
- ✅ Logs show: `[AUTH] Token validation returned false`
- ✅ Credentials are cleared
- ✅ state = unauthenticated
- ✅ App navigates to `/phone-input`

---

## 🐛 Debugging

### Key Debug Logs to Watch

#### Main.dart Logs
```
[MAIN] ClientManager.getClients() failed: ...  ← Client init error
[MAIN] Clearing all storage due to client init failure...
[MAIN] SecureStorage cleared successfully
[MAIN] Hive database cleared successfully
[MAIN] AuthStore.bootstrap() failed: ...
[MAIN] No client available, setting unauthenticated state
```

#### AuthStore Logs
```
[AUTH] Client has null userID or accessToken - cannot proceed
[AUTH]   userID: ...
[AUTH]   hasAccessToken: ...
[AUTH] No saved credentials found
[AUTH] Attempting to hydrate session for user: ...
[AUTH] Validating access token with /whoami...
[AUTH] Token validation failed: ...
[AUTH] Token validation returned false - clearing credentials
[AUTH] Bootstrap succeeded - user authenticated
[AUTH] Bootstrap exception: ...
```

#### Router Logs
```
[REDIRECT] authState=... from=... onboardingDone=...
[REDIRECT] AuthState is authenticated but client is null!
```

#### OTPVerifyController Logs
```
🔐 Step 1: Verifying OTP code...
✅ Step 1 complete: JWT token received
🔑 Step 2: Exchanging JWT for Matrix token...
✅ Step 2 complete: Matrix token received
💧 Step 3: Hydrating Matrix session...
✅ Step 3 complete: Matrix session hydrated
🔍 Step 4: Validating token with /whoami...
✅ Step 4 complete: Token is valid!
💾 Step 5: Saving credentials to secure storage...
✅ Step 5 complete: Credentials saved
🔄 Step 6: Updating AuthStore...
✅ Step 6 complete: AuthStore updated
🎯 Step 7: Marking onboarding as done...
✅ Step 7 complete: Onboarding marked as done
🎉 AUTHENTICATION COMPLETE!
```

### How to Enable Debug Logging

1. **Enable debug toasts:**
   ```bash
   flutter run --dart-define=ENABLE_DEBUG_TOASTS=true
   ```

2. **Check logs in real-time:**
   ```bash
   flutter logs | grep -E '\[MAIN\]|\[AUTH\]|\[REDIRECT\]'
   ```

3. **Filter OTP flow logs:**
   ```bash
   flutter logs | grep -E '🔐|✅|❌|🎉'
   ```

---

## 🔧 Troubleshooting

### Issue: App Still Jumps to /rooms Without Auth

**Possible Causes:**
1. Old code still running in hot-reload
2. Corrupted data not cleared
3. Router guards not being called

**Solutions:**
1. Do a **full restart** (not hot-reload):
   ```bash
   flutter run --dart-define=ENABLE_DEBUG_TOASTS=true
   ```
2. Clear app data manually:
   ```bash
   # iOS Simulator
   xcrun simctl erase all

   # Android
   adb shell pm clear app.twake.android.chat
   ```
3. Check router logs for redirect decisions

### Issue: Onboarding Shows Every Time

**Possible Causes:**
1. OnboardingPrefs.setDone() not being called
2. SharedPreferences not persisting

**Solutions:**
1. Check logs for: `🎯 Step 7: Marking onboarding as done...`
2. Verify OTPVerifyController completes successfully
3. Check SharedPreferences:
   ```dart
   final prefs = await SharedPreferences.getInstance();
   print(prefs.getBool('onboarding_done')); // Should be true
   ```

### Issue: Token Validation Always Fails

**Possible Causes:**
1. Backend not generating valid Matrix tokens
2. Homeserver URL incorrect
3. Matrix server down

**Solutions:**
1. Check logs for Step 4: `🔍 Step 4: Validating token with /whoami...`
2. Verify backend response contains valid `access_token`
3. Check Matrix homeserver is reachable:
   ```bash
   curl https://tom.dedim.com.tr/_matrix/client/versions
   ```
4. Temporarily disable validation (NOT RECOMMENDED) by commenting out Step 4 in OTPVerifyController

### Issue: App Crashes on Startup

**Possible Causes:**
1. Client init failures not caught
2. Null client passed to bootstrap
3. Router trying to access null client

**Solutions:**
1. Check main.dart try-catch is working
2. Verify `authStore.state = unauthenticated` is set on errors
3. Check router guards double-check client validity
4. Clear all app data and restart

---

## 📝 Summary

### What's Fixed
- ✅ Client initialization error handling
- ✅ Corrupted data recovery
- ✅ Token validation re-enabled
- ✅ Router guards enforce proper flow
- ✅ Onboarding system for first-run users
- ✅ Comprehensive debug logging

### What's NEW
- ✅ OnboardingPrefs utility
- ✅ OnboardingView screen
- ✅ Client validity double-checking
- ✅ 7-step authentication flow
- ✅ First-run detection

### Testing Checklist
- [ ] Fresh install → onboarding → phone → OTP → rooms
- [ ] Returning user → phone (skip onboarding)
- [ ] Authenticated restart → rooms (skip auth)
- [ ] Corrupted data recovery
- [ ] Invalid token handling

### Next Steps
1. Complete manual testing (all 5 scenarios)
2. Verify logs show correct flow
3. Test on both iOS and Android
4. Consider adding automated tests for router guards
5. Consider adding "Reset Onboarding" option in settings

---

**Document End**
For questions or issues, check the debug logs and follow the troubleshooting guide above.
