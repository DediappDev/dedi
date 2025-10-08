# Matrix Authentication Integration Guide

## 📋 Overview

This guide provides detailed instructions for integrating Matrix SDK authentication with your OTP-based login system. It covers client initialization, session management, and security best practices.

## 🎯 Prerequisites

- Basic understanding of Matrix protocol
- Flutter development environment
- Matrix Dart SDK added to dependencies
- Backend API for OTP and token exchange

## 📦 Dependencies

Add these to your `pubspec.yaml`:

```yaml
dependencies:
  matrix: ^2.0.1                    # Matrix SDK
  shared_preferences: ^2.2.0       # Local storage
  flutter_secure_storage: ^9.2.4   # Secure storage
  provider: ^6.0.2                 # State management
  http: ^1.5.0                     # HTTP client
```

## 🏗️ Architecture Overview

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   OTP Verify    │───▶│  Backend Token   │───▶│ Matrix Client   │
│     Screen      │    │    Exchange      │    │ Initialization  │
└─────────────────┘    └──────────────────┘    └─────────────────┘
         │                       │                       │
         ▼                       ▼                       ▼
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   JWT Token     │    │ Matrix Creds     │    │   Session       │
│   Validation    │    │ (access_token)   │    │   Persistence   │
└─────────────────┘    └──────────────────┘    └─────────────────┘
```

## 🔐 Step 1: Matrix Client Manager Setup

### Create Client Manager

```dart
// lib/services/matrix_client_manager.dart
import 'package:matrix/matrix.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MatrixClientManager {
  static MatrixClientManager? _instance;
  static MatrixClientManager get instance => _instance ??= MatrixClientManager._();
  MatrixClientManager._();

  final List<Client> _clients = [];
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  List<Client> get clients => List.unmodifiable(_clients);
  Client? get activeClient => _clients.isNotEmpty ? _clients.first : null;

  /// Initialize Matrix client with credentials from backend
  Future<Client> initializeClient({
    required String userId,
    required String accessToken,
    required String deviceId,
    required String homeserverUrl,
    String? deviceName,
  }) async {
    try {
      Logs().i('[MatrixClient] Initializing client for $userId');

      // Create unique client name
      final clientName = 'DediClient-${DateTime.now().millisecondsSinceEpoch}';

      // Create Matrix client
      final client = Client(
        clientName,
        httpClient: _createHttpClient(),
        verificationMethods: {
          KeyVerificationMethod.emoji,
          KeyVerificationMethod.numbers,
        },
        databaseBuilder: _getDatabaseBuilder(clientName),
        supportedLoginTypes: {
          AuthenticationTypes.password,
          AuthenticationTypes.sso,
        },
      );

      // Initialize with credentials
      await client.init(
        newToken: accessToken,
        newUserID: userId,
        newHomeserver: Uri.parse(homeserverUrl),
        newDeviceID: deviceId,
        newDeviceName: deviceName ?? 'Dedi Mobile App',
        waitForFirstSync: false,
        waitUntilLoadCompletedLoaded: false,
      );

      // Verify initialization
      if (!client.isLogged()) {
        throw MatrixAuthException('Client initialization failed');
      }

      Logs().i('[MatrixClient] ✅ Client initialized successfully');
      Logs().i('[MatrixClient] User: ${client.userID}');
      Logs().i('[MatrixClient] Device: ${client.deviceID}');
      Logs().i('[MatrixClient] Homeserver: ${client.homeserver}');

      // Add to managed clients
      _addClient(client);

      // Store credentials securely
      await _storeClientCredentials(clientName, {
        'user_id': userId,
        'access_token': accessToken,
        'device_id': deviceId,
        'homeserver': homeserverUrl,
      });

      return client;
    } catch (e) {
      Logs().e('[MatrixClient] Initialization failed: $e');
      rethrow;
    }
  }

  /// Create HTTP client with custom configuration
  http.Client _createHttpClient() {
    // Add custom HTTP client configuration here
    // e.g., proxy settings, certificates, timeouts
    return http.Client();
  }

  /// Get database builder for client storage
  DatabaseApi Function(String)? _getDatabaseBuilder(String clientName) {
    // Use default database (SQLite with SQLCipher)
    return null;
  }

  /// Add client to managed list
  void _addClient(Client client) {
    if (!_clients.contains(client)) {
      _clients.add(client);
      _setupClientListeners(client);
    }
  }

  /// Setup event listeners for client
  void _setupClientListeners(Client client) {
    // Listen for login state changes
    client.onLoginStateChanged.stream.listen((state) {
      Logs().i('[MatrixClient] Login state changed: $state');
      if (state == LoginState.loggedOut) {
        _removeClient(client);
      }
    });

    // Listen for sync errors
    client.onSyncError.stream.listen((error) {
      Logs().w('[MatrixClient] Sync error: ${error.exception}');
      // Handle sync errors appropriately
    });

    // Listen for encryption errors
    client.onEncryptionError.stream.listen((error) {
      Logs().w('[MatrixClient] Encryption error: $error');
      // Handle encryption errors
    });
  }

  /// Store client credentials securely
  Future<void> _storeClientCredentials(
    String clientName,
    Map<String, String> credentials,
  ) async {
    try {
      final credentialsJson = jsonEncode(credentials);
      await _secureStorage.write(
        key: 'matrix_client_$clientName',
        value: credentialsJson,
      );

      // Also store in SharedPreferences for client list
      final prefs = await SharedPreferences.getInstance();
      final clientList = prefs.getStringList('matrix_clients') ?? [];
      if (!clientList.contains(clientName)) {
        clientList.add(clientName);
        await prefs.setStringList('matrix_clients', clientList);
      }
    } catch (e) {
      Logs().e('[MatrixClient] Failed to store credentials: $e');
    }
  }

  /// Remove client from managed list
  Future<void> _removeClient(Client client) async {
    try {
      _clients.remove(client);

      // Remove stored credentials
      await _secureStorage.delete(key: 'matrix_client_${client.clientName}');

      final prefs = await SharedPreferences.getInstance();
      final clientList = prefs.getStringList('matrix_clients') ?? [];
      clientList.remove(client.clientName);
      await prefs.setStringList('matrix_clients', clientList);

      Logs().i('[MatrixClient] Removed client: ${client.userID}');
    } catch (e) {
      Logs().e('[MatrixClient] Error removing client: $e');
    }
  }
}
```

## 🔄 Step 2: Authentication Flow Integration

### OTP Verification with Matrix Integration

```dart
// In your OTP verification screen
Future<void> _loginWithAuthData(Map<String, dynamic> authData) async {
  try {
    // Step 1: Extract JWT token and user info
    final userId = authData['mxid'] as String?;
    final jwtToken = authData['access_token'] as String?;

    if (userId == null || jwtToken == null) {
      throw MatrixAuthException('Missing credentials in auth response');
    }

    Logs().i('[Auth] JWT token received for user: $userId');

    // Step 2: Exchange JWT for Matrix credentials
    final matrixTokenData = await HttpHelper.getMatrixToken(
      jwtToken: jwtToken,
      phoneNumber: widget.phoneNumber,
    );

    final matrixAccessToken = matrixTokenData['access_token'] as String;
    final matrixUserId = matrixTokenData['mxid'] as String?;
    final deviceId = matrixTokenData['device_id'] as String?;
    final homeserverUrl = matrixTokenData['homeserver'] as String?;

    if (matrixUserId == null || homeserverUrl == null) {
      throw MatrixAuthException('Incomplete Matrix credentials');
    }

    Logs().i('[Auth] Matrix credentials received');
    Logs().i('[Auth] Matrix User: $matrixUserId');
    Logs().i('[Auth] Device ID: $deviceId');
    Logs().i('[Auth] Homeserver: $homeserverUrl');

    // Step 3: Initialize Matrix client
    final client = await MatrixClientManager.instance.initializeClient(
      userId: matrixUserId,
      accessToken: matrixAccessToken,
      deviceId: deviceId ?? 'DEDI_MOBILE_${DateTime.now().millisecondsSinceEpoch}',
      homeserverUrl: homeserverUrl,
      deviceName: 'Dedi Mobile App',
    );

    // Step 4: Verify client is working
    await _verifyClientConnection(client);

    // Step 5: Save authentication state
    await _saveAuthenticationState(matrixUserId, jwtToken);

    // Step 6: Navigate to chat interface
    if (mounted) {
      _showSuccessMessage();
      context.go('/rooms');
    }

  } catch (e) {
    Logs().e('[Auth] Matrix integration failed: $e');
    if (mounted) {
      _showErrorMessage(e.toString());
    }
    rethrow;
  }
}

/// Verify Matrix client connection
Future<void> _verifyClientConnection(Client client) async {
  try {
    // Test basic functionality
    if (!client.isLogged()) {
      throw MatrixAuthException('Client not logged in after initialization');
    }

    // Verify access token is valid
    if (client.accessToken == null || client.accessToken!.isEmpty) {
      throw MatrixAuthException('Invalid access token');
    }

    // Test homeserver connection
    try {
      await client.getVersions();
      Logs().i('[Auth] ✅ Homeserver connection verified');
    } catch (e) {
      throw MatrixAuthException('Cannot connect to homeserver: $e');
    }

    // Start initial sync in background
    if (client.prevBatch == null) {
      Logs().i('[Auth] Starting initial sync...');
      // Don't await this - let it run in background
      client.oneShotSync();
    }

    Logs().i('[Auth] ✅ Matrix client verification complete');
  } catch (e) {
    Logs().e('[Auth] Client verification failed: $e');
    rethrow;
  }
}
```

## 🔒 Step 3: Session Management

### Authentication State Persistence

```dart
// lib/services/auth_service.dart
class AuthService {
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _userIdKey = 'user_id';
  static const String _jwtTokenKey = 'jwt_token';

  /// Save authentication state
  static Future<void> saveAuthenticationState(
    String matrixUserId,
    String jwtToken,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_isLoggedInKey, true);
      await prefs.setString(_userIdKey, matrixUserId);

      // Store JWT token securely
      const secureStorage = FlutterSecureStorage();
      await secureStorage.write(key: _jwtTokenKey, value: jwtToken);

      Logs().i('[Auth] Authentication state saved');
    } catch (e) {
      Logs().e('[Auth] Failed to save auth state: $e');
    }
  }

  /// Check if user is authenticated
  static Future<bool> isAuthenticated() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isLoggedIn = prefs.getBool(_isLoggedInKey) ?? false;

      if (!isLoggedIn) return false;

      // Check if we have valid Matrix clients
      final clients = MatrixClientManager.instance.clients;
      return clients.any((client) => client.isLogged());
    } catch (e) {
      Logs().e('[Auth] Error checking authentication: $e');
      return false;
    }
  }

  /// Get current user ID
  static Future<String?> getCurrentUserId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_userIdKey);
    } catch (e) {
      Logs().e('[Auth] Error getting user ID: $e');
      return null;
    }
  }

  /// Get stored JWT token
  static Future<String?> getJwtToken() async {
    try {
      const secureStorage = FlutterSecureStorage();
      return await secureStorage.read(key: _jwtTokenKey);
    } catch (e) {
      Logs().e('[Auth] Error getting JWT token: $e');
      return null;
    }
  }

  /// Clear authentication state
  static Future<void> logout() async {
    try {
      // Logout all Matrix clients
      final clients = MatrixClientManager.instance.clients;
      for (final client in clients) {
        try {
          await client.logout();
        } catch (e) {
          Logs().w('[Auth] Error logging out client: $e');
        }
      }

      // Clear stored data
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_isLoggedInKey);
      await prefs.remove(_userIdKey);
      await prefs.remove('matrix_clients');

      const secureStorage = FlutterSecureStorage();
      await secureStorage.delete(key: _jwtTokenKey);

      Logs().i('[Auth] Logout complete');
    } catch (e) {
      Logs().e('[Auth] Error during logout: $e');
    }
  }
}
```

## 🔄 Step 4: Client Restoration

### Restore Clients on App Start

```dart
// lib/services/matrix_restoration_service.dart
class MatrixRestorationService {
  /// Restore all Matrix clients on app startup
  static Future<List<Client>> restoreClients() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final clientNames = prefs.getStringList('matrix_clients') ?? [];

      if (clientNames.isEmpty) {
        Logs().i('[Restore] No clients to restore');
        return [];
      }

      Logs().i('[Restore] Restoring ${clientNames.length} clients...');

      final restoredClients = <Client>[];
      const secureStorage = FlutterSecureStorage();

      for (final clientName in clientNames) {
        try {
          // Read stored credentials
          final credentialsJson = await secureStorage.read(
            key: 'matrix_client_$clientName',
          );

          if (credentialsJson == null) {
            Logs().w('[Restore] No credentials for client: $clientName');
            continue;
          }

          final credentials = jsonDecode(credentialsJson) as Map<String, dynamic>;

          // Create and restore client
          final client = await _restoreClient(clientName, credentials);
          if (client != null) {
            restoredClients.add(client);
            MatrixClientManager.instance._addClient(client);
          }
        } catch (e) {
          Logs().e('[Restore] Failed to restore client $clientName: $e');
          // Remove invalid client
          clientNames.remove(clientName);
          await prefs.setStringList('matrix_clients', clientNames);
        }
      }

      Logs().i('[Restore] Successfully restored ${restoredClients.length} clients');
      return restoredClients;
    } catch (e) {
      Logs().e('[Restore] Error restoring clients: $e');
      return [];
    }
  }

  /// Restore individual client
  static Future<Client?> _restoreClient(
    String clientName,
    Map<String, dynamic> credentials,
  ) async {
    try {
      final client = Client(
        clientName,
        httpClient: http.Client(),
        verificationMethods: {
          KeyVerificationMethod.emoji,
          KeyVerificationMethod.numbers,
        },
        supportedLoginTypes: {
          AuthenticationTypes.password,
          AuthenticationTypes.sso,
        },
      );

      // Initialize client
      await client.init();

      // Check if client has valid session
      if (client.isLogged()) {
        Logs().i('[Restore] ✅ Restored client: ${client.userID}');
        return client;
      } else {
        Logs().w('[Restore] Client $clientName not logged in');
        return null;
      }
    } catch (e) {
      Logs().e('[Restore] Error restoring client $clientName: $e');
      return null;
    }
  }
}
```

## 🛡️ Step 5: Security Best Practices

### Secure Token Management

```dart
// lib/services/secure_token_manager.dart
class SecureTokenManager {
  static const FlutterSecureStorage _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: IOSAccessibility.first_unlock_this_device,
    ),
  );

  /// Store Matrix access token securely
  static Future<void> storeMatrixToken(String userId, String accessToken) async {
    try {
      await _storage.write(
        key: 'matrix_token_$userId',
        value: accessToken,
      );
    } catch (e) {
      Logs().e('[Security] Failed to store Matrix token: $e');
      rethrow;
    }
  }

  /// Retrieve Matrix access token
  static Future<String?> getMatrixToken(String userId) async {
    try {
      return await _storage.read(key: 'matrix_token_$userId');
    } catch (e) {
      Logs().e('[Security] Failed to retrieve Matrix token: $e');
      return null;
    }
  }

  /// Delete Matrix access token
  static Future<void> deleteMatrixToken(String userId) async {
    try {
      await _storage.delete(key: 'matrix_token_$userId');
    } catch (e) {
      Logs().e('[Security] Failed to delete Matrix token: $e');
    }
  }

  /// Clear all stored tokens
  static Future<void> clearAllTokens() async {
    try {
      await _storage.deleteAll();
    } catch (e) {
      Logs().e('[Security] Failed to clear all tokens: $e');
    }
  }
}
```

## 🔧 Step 6: Error Handling

### Matrix-Specific Error Handling

```dart
// lib/utils/matrix_error_handler.dart
class MatrixErrorHandler {
  /// Handle Matrix exceptions with user-friendly messages
  static String getLocalizedError(dynamic error) {
    if (error is MatrixException) {
      switch (error.errcode) {
        case 'M_FORBIDDEN':
          return 'Bu işlem için yetkiniz bulunmuyor.';
        case 'M_NOT_FOUND':
          return 'İstenen kaynak bulunamadı.';
        case 'M_LIMIT_EXCEEDED':
          return 'Çok fazla deneme. Lütfen bekleyin.';
        case 'M_UNKNOWN_TOKEN':
          return 'Oturum süresi dolmuş. Lütfen tekrar giriş yapın.';
        case 'M_USER_IN_USE':
          return 'Bu kullanıcı zaten mevcut.';
        default:
          return 'Sunucu hatası: ${error.errcode}';
      }
    }

    if (error is MatrixConnectionException) {
      return 'Bağlantı hatası. İnternet bağlantınızı kontrol edin.';
    }

    if (error is TimeoutException) {
      return 'İstek zaman aşımına uğradı. Lütfen tekrar deneyin.';
    }

    return 'Bilinmeyen hata oluştu.';
  }

  /// Check if error is recoverable
  static bool isRecoverableError(dynamic error) {
    if (error is MatrixException) {
      return ![
        'M_FORBIDDEN',
        'M_UNKNOWN_TOKEN',
        'M_USER_DEACTIVATED',
      ].contains(error.errcode);
    }

    if (error is MatrixConnectionException || error is TimeoutException) {
      return true;
    }

    return false;
  }
}
```

## 🧪 Step 7: Testing

### Unit Tests for Authentication

```dart
// test/services/matrix_client_manager_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  group('MatrixClientManager', () {
    late MatrixClientManager manager;

    setUp(() {
      manager = MatrixClientManager.instance;
    });

    test('should initialize client with valid credentials', () async {
      // Test implementation
      final client = await manager.initializeClient(
        userId: '@test:example.com',
        accessToken: 'test_token',
        deviceId: 'test_device',
        homeserverUrl: 'https://example.com',
      );

      expect(client.isLogged(), isTrue);
      expect(client.userID, equals('@test:example.com'));
    });

    test('should handle initialization failure', () async {
      // Test error handling
      expect(
        () => manager.initializeClient(
          userId: 'invalid_user_id',
          accessToken: '',
          deviceId: 'test_device',
          homeserverUrl: 'invalid_url',
        ),
        throwsA(isA<MatrixAuthException>()),
      );
    });
  });
}
```

## ✅ Integration Checklist

- [ ] Matrix SDK dependency added
- [ ] Client manager implemented
- [ ] Authentication flow integrated
- [ ] Session persistence working
- [ ] Client restoration implemented
- [ ] Secure token storage configured
- [ ] Error handling implemented
- [ ] Unit tests written
- [ ] Integration tests passing
- [ ] Security review completed

## 🔗 Next Steps

After completing Matrix authentication integration:

1. **Implement Chat Features**: Set up chat rooms, messaging, and real-time sync
2. **Add Encryption**: Configure end-to-end encryption and key management
3. **Set up Push Notifications**: Integrate UnifiedPush or Firebase
4. **Add Voice/Video Calls**: Implement WebRTC calling features
5. **Create Settings UI**: Build user settings and preferences screens

## 📚 Additional Resources

- [Matrix Dart SDK Documentation](https://pub.dev/packages/matrix)
- [Matrix Specification](https://spec.matrix.org/)
- [Flutter Secure Storage](https://pub.dev/packages/flutter_secure_storage)
- [Matrix Authentication Flow](https://spec.matrix.org/v1.1/client-server-api/#authentication-types)