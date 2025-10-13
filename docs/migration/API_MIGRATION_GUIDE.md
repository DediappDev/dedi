# DEDI Client API Migration Guide

## Overview
This guide helps client developers migrate from Twake API endpoints to DEDI API endpoints.

## API Endpoint Changes

### Old Endpoints (Deprecated)
```
/_twake/app/v1/*
/_twake/identity/v1/*
/_twake/v1/*
```

### New Endpoints (Current)
```
/_dedi/app/v1/*
/_dedi/identity/v1/*
/_dedi/v1/*
```

## Migration Timeline

- **2025-01-15**: New endpoints available, old endpoints deprecated
- **2025-06-01**: Old endpoints will be removed

## Client Configuration Updates

### Flutter Client Configuration

**File:** `lib/config/app_config.dart`

**Before:**
```dart
class AppConfig {
  static const String apiBaseUrl = '/_twake/app/v1';
  static const String identityApiUrl = '/_twake/identity/v1';
}
```

**After:**
```dart
class AppConfig {
  static const String apiBaseUrl = '/_dedi/app/v1';
  static const String identityApiUrl = '/_dedi/identity/v1';
}
```

### Configuration File Updates

**File:** `config.json`

**Before:**
```json
{
  "api_base_url": "/_twake/app/v1",
  "identity_api_url": "/_twake/identity/v1"
}
```

**After:**
```json
{
  "api_base_url": "/_dedi/app/v1",
  "identity_api_url": "/_dedi/identity/v1"
}
```

## Backwards Compatibility

Both old and new endpoints will be supported until **2025-06-01**.

Old endpoints will return these headers:
- `X-Deprecated: Use /_dedi/ endpoints instead`
- `X-Deprecation-Date: 2025-06-01`
- `X-New-Endpoint: <new_endpoint_path>`

## Testing

### Flutter Testing
```bash
# Test with new endpoints
fvm flutter test

# Test API connectivity
fvm flutter test integration_test/
```

### Manual Testing
1. Update configuration to use new endpoints
2. Test all functionality (login, messaging, etc.)
3. Verify no errors in logs
4. Test on all platforms (Android, iOS, Web)

## Rollback Plan

If issues occur:
```bash
# Revert to old endpoints
git checkout HEAD~1 lib/config/app_config.dart
git checkout HEAD~1 config.json

# Rebuild and test
fvm flutter clean
fvm flutter pub get
fvm flutter test
```

## Questions?

Contact: support@dedim.com.tr
