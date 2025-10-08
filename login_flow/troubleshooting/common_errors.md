# Common Errors and Troubleshooting Guide

## 📋 Overview

This guide covers common issues you might encounter when implementing the OTP-based Matrix authentication system, along with their solutions and debugging techniques.

## 🚨 Authentication Errors

### 1. OTP Request Failures

#### Error: "Network error or CORS issue - status code 0"

**Symptoms:**
- OTP request fails on web platform
- Status code 0 in network requests
- No response from backend

**Causes:**
- CORS policy blocking the request
- Incorrect backend URL
- Backend server not running

**Solutions:**

```dart
// Fix CORS in your backend (Express.js example)
app.use(cors({
  origin: ['http://localhost:3000', 'https://yourdomain.com'],
  methods: ['POST', 'GET', 'OPTIONS'],
  allowedHeaders: ['Content-Type', 'Authorization'],
  credentials: true
}));
```

```dart
// Use text/plain content type to avoid preflight
final response = await HttpHelper.post(
  endpoint: '/otp/request',
  headers: {'Content-Type': 'text/plain'}, // Avoids OPTIONS preflight
  body: json.encode({'phone': phone}),
);
```

**Debug Steps:**
1. Check browser console for CORS errors
2. Verify backend is running and accessible
3. Test API with curl or Postman
4. Check network tab in browser developer tools

---

### 2. OTP Verification Failures

#### Error: "Invalid or expired OTP code"

**Symptoms:**
- Correct OTP code is rejected
- OTP works sometimes but not always
- Verification fails after delay

**Causes:**
- OTP expired (usually 5 minutes)
- Clock sync issues between client/server
- OTP code already used
- Rate limiting on backend

**Solutions:**

```dart
// Add better error handling in verification
try {
  final data = await HttpHelper.verifyOtp(phoneNumber, code);
  return data;
} catch (e) {
  if (e.toString().contains('expired')) {
    throw OtpException('OTP kodu süresi dolmuş. Yeni kod isteyin.');
  } else if (e.toString().contains('invalid')) {
    throw OtpException('OTP kodu hatalı. Lütfen kontrol edin.');
  } else if (e.toString().contains('rate_limit')) {
    throw OtpException('Çok fazla deneme. Lütfen bekleyin.');
  }
  rethrow;
}
```

```dart
// Add OTP expiration handling
class OtpTimer {
  static const int expirationMinutes = 5;
  late DateTime _requestTime;

  void startTimer() {
    _requestTime = DateTime.now();
  }

  bool isExpired() {
    final now = DateTime.now();
    final difference = now.difference(_requestTime);
    return difference.inMinutes >= expirationMinutes;
  }

  int getRemainingSeconds() {
    final now = DateTime.now();
    final elapsed = now.difference(_requestTime);
    final remaining = (expirationMinutes * 60) - elapsed.inSeconds;
    return remaining > 0 ? remaining : 0;
  }
}
```

**Debug Steps:**
1. Check server logs for OTP validation attempts
2. Verify system time is correct
3. Test with development OTP codes
4. Check rate limiting settings

---

### 3. JWT Token Issues

#### Error: "Invalid or expired JWT token"

**Symptoms:**
- OTP verification succeeds but Matrix token exchange fails
- Token appears valid but is rejected
- Intermittent authentication failures

**Causes:**
- JWT token expired
- Invalid token signature
- Missing or incorrect claims
- Backend JWT configuration issues

**Solutions:**

```dart
// Add JWT validation before Matrix token exchange
bool isJwtValid(String token) {
  try {
    final parts = token.split('.');
    if (parts.length != 3) return false;

    // Decode payload (base64url)
    final payload = base64Url.decode(base64Url.normalize(parts[1]));
    final claims = json.decode(utf8.decode(payload));

    // Check expiration
    final exp = claims['exp'];
    if (exp != null) {
      final expiration = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
      if (DateTime.now().isAfter(expiration)) {
        return false;
      }
    }

    return true;
  } catch (e) {
    return false;
  }
}
```

```dart
// Add token refresh mechanism
Future<String> refreshJwtToken(String expiredToken) async {
  try {
    final response = await HttpHelper.post(
      endpoint: '/auth/refresh',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $expiredToken',
      },
      body: json.encode({'refresh_token': refreshToken}),
    );

    final data = json.decode(response.body);
    return data['access_token'];
  } catch (e) {
    throw AuthenticationException('Token refresh failed: $e');
  }
}
```

---

## 🔧 Matrix Integration Errors

### 4. Matrix Client Initialization Failures

#### Error: "Client initialization succeeded but isLogged() returns false"

**Symptoms:**
- Client appears to initialize successfully
- `isLogged()` returns false after initialization
- Unable to perform Matrix operations

**Causes:**
- Invalid Matrix access token
- Homeserver connection issues
- Incorrect user ID format
- Database initialization problems

**Solutions:**

```dart
// Add comprehensive client validation
Future<void> validateMatrixClient(Client client) async {
  // Check basic properties
  if (client.userID == null || client.userID!.isEmpty) {
    throw MatrixException('User ID is null or empty');
  }

  if (client.accessToken == null || client.accessToken!.isEmpty) {
    throw MatrixException('Access token is null or empty');
  }

  if (client.homeserver == null) {
    throw MatrixException('Homeserver is null');
  }

  // Test homeserver connection
  try {
    final versions = await client.getVersions();
    print('Homeserver versions: ${versions.versions}');
  } catch (e) {
    throw MatrixException('Cannot connect to homeserver: $e');
  }

  // Test authentication with a simple API call
  try {
    await client.getProfile(client.userID!);
    print('✅ Matrix authentication verified');
  } catch (e) {
    throw MatrixException('Authentication test failed: $e');
  }
}
```

```dart
// Add retry mechanism for client initialization
Future<Client> initializeClientWithRetry({
  required String userId,
  required String accessToken,
  required String deviceId,
  required String homeserverUrl,
  int maxRetries = 3,
}) async {
  Exception? lastError;

  for (int attempt = 1; attempt <= maxRetries; attempt++) {
    try {
      print('Matrix initialization attempt $attempt/$maxRetries');

      final client = await MatrixClientManager.instance.initializeClient(
        userId: userId,
        accessToken: accessToken,
        deviceId: deviceId,
        homeserverUrl: homeserverUrl,
      );

      await validateMatrixClient(client);
      return client;

    } catch (e) {
      lastError = e as Exception;
      print('Attempt $attempt failed: $e');

      if (attempt < maxRetries) {
        await Future.delayed(Duration(seconds: attempt * 2));
      }
    }
  }

  throw lastError!;
}
```

---

### 5. Homeserver Connection Issues

#### Error: "Cannot connect to homeserver"

**Symptoms:**
- Homeserver appears unreachable
- Timeout errors during Matrix operations
- SSL/TLS certificate errors

**Causes:**
- Homeserver down or unreachable
- Network connectivity issues
- DNS resolution problems
- SSL certificate issues
- Firewall blocking connections

**Solutions:**

```dart
// Add homeserver health check
Future<bool> checkHomeserverHealth(String homeserverUrl) async {
  try {
    final response = await http.get(
      Uri.parse('$homeserverUrl/_matrix/client/versions'),
      headers: {'Accept': 'application/json'},
    ).timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Homeserver versions: ${data['versions']}');
      return true;
    }
    return false;
  } catch (e) {
    print('Homeserver health check failed: $e');
    return false;
  }
}
```

```dart
// Add fallback homeserver mechanism
class HomeserverManager {
  static const List<String> fallbackServers = [
    'https://matrix.org',
    'https://matrix.example.com',
    // Add your fallback servers
  ];

  static Future<String> findWorkingHomeserver(String primaryServer) async {
    // Try primary server first
    if (await checkHomeserverHealth(primaryServer)) {
      return primaryServer;
    }

    // Try fallback servers
    for (final server in fallbackServers) {
      if (await checkHomeserverHealth(server)) {
        print('Using fallback homeserver: $server');
        return server;
      }
    }

    throw Exception('No working homeserver found');
  }
}
```

---

## 📱 Platform-Specific Issues

### 6. iOS Specific Issues

#### Error: "Keychain access denied"

**Symptoms:**
- Secure storage operations fail on iOS
- Authentication state not persisting
- App crashes when accessing keychain

**Causes:**
- Missing keychain access entitlements
- iOS simulator keychain issues
- App sandbox restrictions

**Solutions:**

```dart
// Configure iOS secure storage properly
const FlutterSecureStorage secureStorage = FlutterSecureStorage(
  iOptions: IOSOptions(
    accessibility: IOSAccessibility.first_unlock_this_device,
    accountName: 'YourAppName',
  ),
);
```

```xml
<!-- Add to ios/Runner/Runner.entitlements -->
<key>keychain-access-groups</key>
<array>
  <string>$(AppIdentifierPrefix)com.yourcompany.yourapp</string>
</array>
```

---

### 7. Android Specific Issues

#### Error: "EncryptedSharedPreferences initialization failed"

**Symptoms:**
- Secure storage fails on some Android devices
- App crashes on older Android versions
- Data not persisting between app restarts

**Causes:**
- Android version compatibility issues
- Device-specific encryption problems
- Insufficient storage space

**Solutions:**

```dart
// Add fallback for Android secure storage
class SecureStorageManager {
  static FlutterSecureStorage? _secureStorage;

  static FlutterSecureStorage get instance {
    _secureStorage ??= const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
        sharedPreferencesName: 'YourAppSecurePrefs',
        preferencesKeyPrefix: 'secure_',
      ),
    );
    return _secureStorage!;
  }

  static Future<void> writeSecure(String key, String value) async {
    try {
      await instance.write(key: key, value: value);
    } catch (e) {
      // Fallback to regular SharedPreferences with warning
      print('Warning: Using non-secure storage due to error: $e');
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('fallback_$key', value);
    }
  }

  static Future<String?> readSecure(String key) async {
    try {
      return await instance.read(key: key);
    } catch (e) {
      print('Warning: Reading from non-secure storage due to error: $e');
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('fallback_$key');
    }
  }
}
```

---

## 🌐 Web Specific Issues

### 8. Web CORS and Security Issues

#### Error: "Mixed content blocked"

**Symptoms:**
- HTTPS web app cannot connect to HTTP backend
- Browser blocks non-secure requests
- Network requests fail silently

**Causes:**
- Mixed content security policy
- HTTP backend used from HTTPS frontend
- Insecure WebSocket connections

**Solutions:**

```dart
// Use HTTPS for all backend communications
class ApiConfig {
  static String get baseUrl {
    if (kIsWeb && html.window.location.protocol == 'https:') {
      return 'https://api.yourapp.com'; // Always use HTTPS for web
    }
    return const String.fromEnvironment('API_BASE_URL',
                                        defaultValue: 'http://localhost:3000');
  }
}
```

```dart
// Add proper error handling for web
Future<http.Response> webSafePost({
  required String url,
  required Map<String, String> headers,
  required String body,
}) async {
  if (kIsWeb) {
    try {
      final request = html.HttpRequest();
      request.open('POST', url);

      // Set headers
      headers.forEach((key, value) {
        request.setRequestHeader(key, value);
      });

      // Send request with timeout
      request.send(body);

      await Future.any([
        request.onLoad.first,
        request.onError.first,
        request.onTimeout.first,
      ]);

      if (request.status == 0) {
        throw Exception('Network error: Check CORS configuration');
      }

      return http.Response(request.responseText ?? '', request.status ?? 0);
    } catch (e) {
      throw Exception('Web request failed: $e');
    }
  } else {
    return http.post(Uri.parse(url), headers: headers, body: body);
  }
}
```

---

## 🐛 Debugging Tools and Techniques

### Debug Logging Configuration

```dart
// lib/utils/debug_logger.dart
class DebugLogger {
  static const bool enableLogging = bool.fromEnvironment('DEBUG_LOGGING', defaultValue: true);

  static void log(String message, {String? tag}) {
    if (enableLogging) {
      final timestamp = DateTime.now().toIso8601String();
      final logMessage = tag != null ? '[$tag] $message' : message;
      print('[$timestamp] $logMessage');
    }
  }

  static void error(String message, dynamic error, {String? tag, StackTrace? stackTrace}) {
    if (enableLogging) {
      final timestamp = DateTime.now().toIso8601String();
      final logMessage = tag != null ? '[$tag] ERROR: $message' : 'ERROR: $message';
      print('[$timestamp] $logMessage');
      print('Error details: $error');
      if (stackTrace != null) {
        print('Stack trace: $stackTrace');
      }
    }
  }
}
```

### Network Request Debugging

```dart
// lib/utils/network_debugger.dart
class NetworkDebugger {
  static void logRequest(String method, String url, Map<String, String>? headers, String? body) {
    DebugLogger.log('=== HTTP REQUEST ===', tag: 'NETWORK');
    DebugLogger.log('$method $url', tag: 'NETWORK');
    if (headers != null) {
      DebugLogger.log('Headers: $headers', tag: 'NETWORK');
    }
    if (body != null) {
      DebugLogger.log('Body: $body', tag: 'NETWORK');
    }
  }

  static void logResponse(int statusCode, String? body) {
    DebugLogger.log('=== HTTP RESPONSE ===', tag: 'NETWORK');
    DebugLogger.log('Status: $statusCode', tag: 'NETWORK');
    if (body != null) {
      DebugLogger.log('Body: $body', tag: 'NETWORK');
    }
  }
}
```

### Matrix Debug Information

```dart
// lib/utils/matrix_debugger.dart
class MatrixDebugger {
  static void logClientState(Client client) {
    DebugLogger.log('=== MATRIX CLIENT STATE ===', tag: 'MATRIX');
    DebugLogger.log('User ID: ${client.userID}', tag: 'MATRIX');
    DebugLogger.log('Device ID: ${client.deviceID}', tag: 'MATRIX');
    DebugLogger.log('Homeserver: ${client.homeserver}', tag: 'MATRIX');
    DebugLogger.log('Is logged in: ${client.isLogged()}', tag: 'MATRIX');
    DebugLogger.log('Has access token: ${client.accessToken != null}', tag: 'MATRIX');
    DebugLogger.log('Sync status: ${client.syncPresence}', tag: 'MATRIX');
    DebugLogger.log('Room count: ${client.rooms.length}', tag: 'MATRIX');
  }

  static void logSyncError(SyncError error) {
    DebugLogger.error('Sync error occurred', error.exception, tag: 'MATRIX');
  }

  static void logEncryptionError(Object error) {
    DebugLogger.error('Encryption error occurred', error, tag: 'MATRIX');
  }
}
```

## 🔍 Common Debug Commands

### Flutter Debug Commands

```bash
# Run with debug logging
flutter run --dart-define=DEBUG_LOGGING=true

# Run with specific environment
flutter run --dart-define=ENVIRONMENT=development

# Run with network debugging
flutter run --dart-define=DEBUG_NETWORK=true

# Clear app data (Android)
flutter clean
cd android && ./gradlew clean && cd ..

# Reset iOS simulator
flutter clean
cd ios && rm -rf Pods Podfile.lock && pod install && cd ..
```

### Backend Debug Commands

```bash
# Test OTP request
curl -X POST http://localhost:3000/otp/request \
  -H "Content-Type: application/json" \
  -d '{"phone": "+905551234567"}' \
  -v

# Test OTP verification
curl -X POST http://localhost:3000/otp/verify \
  -H "Content-Type: application/json" \
  -d '{"phone": "+905551234567", "code": "123456"}' \
  -v

# Test Matrix token exchange
curl -X POST http://localhost:3000/otp/matrix-token \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer <jwt_token>" \
  -d '{"jwt_token": "<jwt_token>", "phone": "+905551234567"}' \
  -v
```

## 📋 Troubleshooting Checklist

### Before Asking for Help

- [ ] Check error logs and console output
- [ ] Verify all dependencies are properly installed
- [ ] Test with development/mock data
- [ ] Check network connectivity
- [ ] Verify backend API is running and accessible
- [ ] Test on different platforms (if applicable)
- [ ] Check for CORS issues (web)
- [ ] Verify SSL certificates (if using HTTPS)
- [ ] Test with minimal reproduction case
- [ ] Check Matrix homeserver status

### Information to Include in Bug Reports

1. **Environment Information:**
   - Flutter version
   - Dart version
   - Platform (Android/iOS/Web/Desktop)
   - Device/OS version

2. **Error Details:**
   - Complete error message
   - Stack trace
   - Steps to reproduce
   - Expected vs actual behavior

3. **Code Context:**
   - Relevant code snippets
   - Configuration files
   - API responses (sanitized)

4. **Debug Information:**
   - Network request/response logs
   - Matrix client state
   - Authentication flow step where error occurs

This troubleshooting guide should help you resolve most common issues encountered during implementation. For additional help, check the project documentation or community forums.