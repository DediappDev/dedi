# Best Practices for Matrix Authentication Implementation

## 📋 Overview

This guide provides best practices, performance optimizations, and security recommendations for implementing Matrix-based authentication with OTP verification.

## 🔐 Security Best Practices

### 1. Token Management

#### JWT Token Security

```dart
class JwtSecurityManager {
  // Use secure algorithms only
  static const List<String> allowedAlgorithms = ['RS256', 'ES256'];

  // Validate JWT tokens thoroughly
  static bool validateJwtToken(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return false;

      // Decode header
      final header = json.decode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[0])))
      );

      // Check algorithm
      if (!allowedAlgorithms.contains(header['alg'])) {
        throw SecurityException('Unsupported JWT algorithm: ${header['alg']}');
      }

      // Decode payload
      final payload = json.decode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1])))
      );

      // Validate expiration
      final exp = payload['exp'];
      if (exp != null) {
        final expiration = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
        if (DateTime.now().isAfter(expiration)) {
          return false;
        }
      }

      // Validate issuer and audience
      final iss = payload['iss'];
      final aud = payload['aud'];
      if (iss == null || aud == null) {
        throw SecurityException('Missing required JWT claims');
      }

      return true;
    } catch (e) {
      Logs().w('JWT validation failed: $e');
      return false;
    }
  }
}
```

#### Secure Storage Implementation

```dart
class SecureStorageManager {
  static const FlutterSecureStorage _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
      sharedPreferencesName: 'SecureAppPrefs',
      preferencesKeyPrefix: 'secure_',
    ),
    iOptions: IOSOptions(
      accessibility: IOSAccessibility.first_unlock_this_device,
      synchronizable: false,
    ),
    lOptions: LinuxOptions(
      useSessionKeyring: true,
    ),
    wOptions: WindowsOptions(
      useBackwardCompatibility: false,
    ),
  );

  // Implement key rotation
  static Future<void> rotateEncryptionKeys() async {
    try {
      final allKeys = await _storage.readAll();

      // Re-encrypt all stored data with new keys
      for (final entry in allKeys.entries) {
        final reEncryptedValue = await _reEncryptValue(entry.value);
        await _storage.write(key: entry.key, value: reEncryptedValue);
      }

      Logs().i('Encryption key rotation completed');
    } catch (e) {
      Logs().e('Key rotation failed: $e');
      throw SecurityException('Failed to rotate encryption keys');
    }
  }

  static Future<String> _reEncryptValue(String value) async {
    // Implement your re-encryption logic here
    // This is a placeholder implementation
    return value;
  }
}
```

### 2. OTP Security

#### Rate Limiting Implementation

```dart
class OtpRateLimiter {
  static final Map<String, List<DateTime>> _attempts = {};
  static const int maxAttemptsPerHour = 5;
  static const int maxAttemptsPerDay = 20;

  static bool canRequestOtp(String phoneNumber) {
    final now = DateTime.now();
    final attempts = _attempts[phoneNumber] ?? [];

    // Clean old attempts
    attempts.removeWhere(
      (attempt) => now.difference(attempt).inHours > 24
    );

    // Check hourly limit
    final recentAttempts = attempts.where(
      (attempt) => now.difference(attempt).inHours < 1
    ).length;

    if (recentAttempts >= maxAttemptsPerHour) {
      return false;
    }

    // Check daily limit
    if (attempts.length >= maxAttemptsPerDay) {
      return false;
    }

    return true;
  }

  static void recordAttempt(String phoneNumber) {
    _attempts[phoneNumber] ??= [];
    _attempts[phoneNumber]!.add(DateTime.now());
  }

  static Duration getNextAllowedTime(String phoneNumber) {
    final now = DateTime.now();
    final attempts = _attempts[phoneNumber] ?? [];

    if (attempts.isEmpty) return Duration.zero;

    final lastAttempt = attempts.last;
    final timeSinceLastAttempt = now.difference(lastAttempt);

    if (timeSinceLastAttempt.inMinutes < 1) {
      return Duration(minutes: 1) - timeSinceLastAttempt;
    }

    return Duration.zero;
  }
}
```

#### OTP Generation Best Practices

```dart
class SecureOtpGenerator {
  static const int otpLength = 6;
  static const int expirationMinutes = 5;

  // Use cryptographically secure random number generation
  static String generateOtp() {
    final random = Random.secure();
    final digits = List.generate(otpLength, (_) => random.nextInt(10));
    return digits.join();
  }

  // Store OTP with metadata
  static Future<void> storeOtp(String phoneNumber, String otp) async {
    final otpData = {
      'otp': otp,
      'created_at': DateTime.now().toIso8601String(),
      'expires_at': DateTime.now()
          .add(Duration(minutes: expirationMinutes))
          .toIso8601String(),
      'attempts': 0,
    };

    await SecureStorageManager.write(
      'otp_$phoneNumber',
      json.encode(otpData),
    );
  }

  // Validate OTP with comprehensive checks
  static Future<bool> validateOtp(String phoneNumber, String providedOtp) async {
    try {
      final storedData = await SecureStorageManager.read('otp_$phoneNumber');
      if (storedData == null) return false;

      final otpData = json.decode(storedData);
      final storedOtp = otpData['otp'];
      final expiresAt = DateTime.parse(otpData['expires_at']);
      final attempts = otpData['attempts'] ?? 0;

      // Check if expired
      if (DateTime.now().isAfter(expiresAt)) {
        await SecureStorageManager.delete('otp_$phoneNumber');
        return false;
      }

      // Check attempt limit
      if (attempts >= 3) {
        await SecureStorageManager.delete('otp_$phoneNumber');
        return false;
      }

      // Validate OTP
      final isValid = storedOtp == providedOtp;

      if (isValid) {
        // Clear OTP after successful validation
        await SecureStorageManager.delete('otp_$phoneNumber');
      } else {
        // Increment attempt counter
        otpData['attempts'] = attempts + 1;
        await SecureStorageManager.write(
          'otp_$phoneNumber',
          json.encode(otpData),
        );
      }

      return isValid;
    } catch (e) {
      Logs().e('OTP validation error: $e');
      return false;
    }
  }
}
```

## ⚡ Performance Optimization

### 1. Matrix Client Initialization

#### Lazy Loading and Caching

```dart
class OptimizedMatrixManager {
  static final Map<String, Client> _clientCache = {};
  static final Map<String, Future<Client>> _initializationFutures = {};

  // Implement client pooling
  static Future<Client> getOrCreateClient(String userId) async {
    // Return cached client if available
    if (_clientCache.containsKey(userId)) {
      final client = _clientCache[userId]!;
      if (client.isLogged()) {
        return client;
      } else {
        _clientCache.remove(userId);
      }
    }

    // Return ongoing initialization if in progress
    if (_initializationFutures.containsKey(userId)) {
      return _initializationFutures[userId]!;
    }

    // Start new initialization
    final future = _initializeClientOptimized(userId);
    _initializationFutures[userId] = future;

    try {
      final client = await future;
      _clientCache[userId] = client;
      return client;
    } finally {
      _initializationFutures.remove(userId);
    }
  }

  static Future<Client> _initializeClientOptimized(String userId) async {
    // Load credentials from cache
    final credentials = await _loadCachedCredentials(userId);
    if (credentials == null) {
      throw Exception('No cached credentials found');
    }

    // Create client with optimized settings
    final client = Client(
      'OptimizedClient-$userId',
      httpClient: _getOptimizedHttpClient(),
      verificationMethods: {KeyVerificationMethod.emoji},
      databaseBuilder: _getOptimizedDatabaseBuilder(),
    );

    // Initialize without waiting for sync
    await client.init(
      newToken: credentials['access_token'],
      newUserID: credentials['user_id'],
      newHomeserver: Uri.parse(credentials['homeserver']),
      newDeviceID: credentials['device_id'],
      waitForFirstSync: false,
      waitUntilLoadCompletedLoaded: false,
    );

    // Start background sync
    _startBackgroundSync(client);

    return client;
  }

  static void _startBackgroundSync(Client client) {
    // Start sync in background without blocking
    Timer.run(() async {
      try {
        await client.oneShotSync();
      } catch (e) {
        Logs().w('Background sync failed: $e');
      }
    });
  }
}
```

#### HTTP Client Optimization

```dart
class OptimizedHttpClient {
  static http.Client? _sharedClient;

  static http.Client getOptimizedClient() {
    _sharedClient ??= http.Client();
    return _sharedClient!;
  }

  // Connection pooling and reuse
  static void configureHttpClient() {
    // Configure connection pooling
    HttpOverrides.global = OptimizedHttpOverrides();
  }
}

class OptimizedHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final client = super.createHttpClient(context);

    // Optimize connection settings
    client.connectionTimeout = const Duration(seconds: 10);
    client.idleTimeout = const Duration(seconds: 30);
    client.maxConnectionsPerHost = 5;

    return client;
  }
}
```

### 2. Memory Management

#### Client Lifecycle Management

```dart
class ClientLifecycleManager {
  static final Map<String, Timer> _clientTimers = {};
  static const Duration clientIdleTimeout = Duration(minutes: 30);

  static void trackClientActivity(Client client) {
    final userId = client.userID!;

    // Cancel existing timer
    _clientTimers[userId]?.cancel();

    // Start new idle timer
    _clientTimers[userId] = Timer(clientIdleTimeout, () {
      _disposeIdleClient(client);
    });
  }

  static void _disposeIdleClient(Client client) {
    try {
      if (!client.isLogged()) return;

      // Save important state before disposal
      _saveClientState(client);

      // Dispose client resources
      client.dispose();

      // Remove from cache
      OptimizedMatrixManager._clientCache.remove(client.userID);

      Logs().i('Disposed idle client: ${client.userID}');
    } catch (e) {
      Logs().e('Error disposing client: $e');
    }
  }

  static Future<void> _saveClientState(Client client) async {
    // Save minimal state needed for restoration
    final state = {
      'last_sync': client.prevBatch,
      'device_keys': client.userDeviceKeys.isNotEmpty,
      'room_count': client.rooms.length,
    };

    await SecureStorageManager.write(
      'client_state_${client.userID}',
      json.encode(state),
    );
  }
}
```

## 🏗️ Architecture Best Practices

### 1. Separation of Concerns

#### Service Layer Architecture

```dart
// Authentication Service
abstract class IAuthenticationService {
  Future<void> sendOtpRequest(String phoneNumber);
  Future<AuthResult> verifyOtp(String phoneNumber, String code);
  Future<void> logout();
  Stream<AuthState> get authStateStream;
}

// Matrix Service
abstract class IMatrixService {
  Future<Client> initializeClient(MatrixCredentials credentials);
  Future<void> startSync(Client client);
  Future<void> disposeClient(Client client);
  Stream<MatrixState> get matrixStateStream;
}

// Storage Service
abstract class IStorageService {
  Future<void> storeSecurely(String key, String value);
  Future<String?> readSecurely(String key);
  Future<void> clearAll();
}

// Implementation
class AuthenticationService implements IAuthenticationService {
  final IHttpService _httpService;
  final IStorageService _storageService;
  final StreamController<AuthState> _authStateController;

  AuthenticationService({
    required IHttpService httpService,
    required IStorageService storageService,
  }) : _httpService = httpService,
       _storageService = storageService,
       _authStateController = StreamController.broadcast();

  @override
  Stream<AuthState> get authStateStream => _authStateController.stream;

  @override
  Future<AuthResult> verifyOtp(String phoneNumber, String code) async {
    try {
      final response = await _httpService.post('/otp/verify', {
        'phone': phoneNumber,
        'code': code,
      });

      final authResult = AuthResult.fromJson(response);

      // Store authentication state
      await _storageService.storeSecurely('auth_token', authResult.token);

      // Emit new state
      _authStateController.add(AuthState.authenticated(authResult));

      return authResult;
    } catch (e) {
      _authStateController.add(AuthState.error(e.toString()));
      rethrow;
    }
  }
}
```

### 2. Dependency Injection

#### Service Locator Pattern

```dart
class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();
  factory ServiceLocator() => _instance;
  ServiceLocator._internal();

  final Map<Type, dynamic> _services = {};

  void registerSingleton<T>(T service) {
    _services[T] = service;
  }

  void registerFactory<T>(T Function() factory) {
    _services[T] = factory;
  }

  T get<T>() {
    final service = _services[T];
    if (service == null) {
      throw Exception('Service of type $T not registered');
    }

    if (service is Function) {
      return service() as T;
    }

    return service as T;
  }
}

// Registration
void setupServices() {
  final serviceLocator = ServiceLocator();

  // Register storage service
  serviceLocator.registerSingleton<IStorageService>(
    SecureStorageService(),
  );

  // Register HTTP service
  serviceLocator.registerSingleton<IHttpService>(
    HttpService(),
  );

  // Register authentication service
  serviceLocator.registerSingleton<IAuthenticationService>(
    AuthenticationService(
      httpService: serviceLocator.get<IHttpService>(),
      storageService: serviceLocator.get<IStorageService>(),
    ),
  );
}
```

### 3. Error Handling Strategy

#### Comprehensive Error Management

```dart
// Custom exception hierarchy
abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;

  AppException(this.message, {this.code, this.originalError});

  @override
  String toString() => 'AppException: $message${code != null ? ' ($code)' : ''}';
}

class AuthenticationException extends AppException {
  AuthenticationException(String message, {String? code, dynamic originalError})
      : super(message, code: code, originalError: originalError);
}

class NetworkException extends AppException {
  NetworkException(String message, {String? code, dynamic originalError})
      : super(message, code: code, originalError: originalError);
}

class MatrixException extends AppException {
  MatrixException(String message, {String? code, dynamic originalError})
      : super(message, code: code, originalError: originalError);
}

// Error handler
class ErrorHandler {
  static String getLocalizedMessage(AppException error) {
    switch (error.runtimeType) {
      case AuthenticationException:
        return _getAuthErrorMessage(error as AuthenticationException);
      case NetworkException:
        return _getNetworkErrorMessage(error as NetworkException);
      case MatrixException:
        return _getMatrixErrorMessage(error as MatrixException);
      default:
        return 'Bilinmeyen bir hata oluştu.';
    }
  }

  static String _getAuthErrorMessage(AuthenticationException error) {
    switch (error.code) {
      case 'INVALID_OTP':
        return 'Doğrulama kodu hatalı.';
      case 'OTP_EXPIRED':
        return 'Doğrulama kodu süresi dolmuş.';
      case 'RATE_LIMITED':
        return 'Çok fazla deneme. Lütfen bekleyin.';
      default:
        return 'Kimlik doğrulama hatası: ${error.message}';
    }
  }

  static bool isRetryable(AppException error) {
    final retryableCodes = ['NETWORK_ERROR', 'TIMEOUT', 'SERVER_ERROR'];
    return retryableCodes.contains(error.code);
  }
}
```

## 🧪 Testing Best Practices

### 1. Unit Testing

#### Comprehensive Test Coverage

```dart
// Test for authentication service
class MockHttpService extends Mock implements IHttpService {}
class MockStorageService extends Mock implements IStorageService {}

void main() {
  group('AuthenticationService', () {
    late AuthenticationService authService;
    late MockHttpService mockHttpService;
    late MockStorageService mockStorageService;

    setUp(() {
      mockHttpService = MockHttpService();
      mockStorageService = MockStorageService();
      authService = AuthenticationService(
        httpService: mockHttpService,
        storageService: mockStorageService,
      );
    });

    group('sendOtpRequest', () {
      test('should send OTP request successfully', () async {
        // Arrange
        const phoneNumber = '+905551234567';
        when(mockHttpService.post('/otp/request', any))
            .thenAnswer((_) async => {'status': 'sent'});

        // Act
        await authService.sendOtpRequest(phoneNumber);

        // Assert
        verify(mockHttpService.post('/otp/request', {
          'phone': phoneNumber,
        })).called(1);
      });

      test('should handle network errors', () async {
        // Arrange
        const phoneNumber = '+905551234567';
        when(mockHttpService.post('/otp/request', any))
            .thenThrow(NetworkException('Connection failed'));

        // Act & Assert
        expect(
          () => authService.sendOtpRequest(phoneNumber),
          throwsA(isA<NetworkException>()),
        );
      });
    });

    group('verifyOtp', () {
      test('should verify OTP successfully', () async {
        // Arrange
        const phoneNumber = '+905551234567';
        const code = '123456';
        final expectedResponse = {
          'access_token': 'test_token',
          'user_id': '@test:example.com',
        };

        when(mockHttpService.post('/otp/verify', any))
            .thenAnswer((_) async => expectedResponse);
        when(mockStorageService.storeSecurely(any, any))
            .thenAnswer((_) async {});

        // Act
        final result = await authService.verifyOtp(phoneNumber, code);

        // Assert
        expect(result.token, equals('test_token'));
        expect(result.userId, equals('@test:example.com'));
        verify(mockStorageService.storeSecurely('auth_token', 'test_token'));
      });
    });
  });
}
```

### 2. Integration Testing

#### End-to-End Test Scenarios

```dart
// Integration test for complete auth flow
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Authentication Flow Integration', () {
    testWidgets('complete OTP authentication flow', (tester) async {
      // Start app
      await tester.pumpWidget(MyApp());
      await tester.pumpAndSettle();

      // Should show phone input screen
      expect(find.byType(PhoneInputPage), findsOneWidget);

      // Enter phone number
      await tester.enterText(
        find.byType(TextField),
        '5551234567',
      );

      // Tap continue button
      await tester.tap(find.text('Doğrulama Kodu Al'));
      await tester.pumpAndSettle();

      // Should navigate to OTP verification
      expect(find.byType(OtpVerifyPage), findsOneWidget);

      // Enter OTP code
      final otpFields = find.byType(OtpDigitField);
      expect(otpFields, findsNWidgets(6));

      // Fill OTP fields
      for (int i = 0; i < 6; i++) {
        await tester.enterText(otpFields.at(i), '${i + 1}');
      }

      // Should auto-verify and navigate to chat list
      await tester.pumpAndSettle(const Duration(seconds: 5));
      expect(find.byType(ChatListPage), findsOneWidget);
    });

    testWidgets('handles invalid OTP gracefully', (tester) async {
      // Setup and navigate to OTP screen
      await tester.pumpWidget(MyApp());
      await _navigateToOtpScreen(tester);

      // Enter invalid OTP
      await _enterOtp(tester, '000000');

      // Should show error message
      expect(find.text('Doğrulama kodu hatalı'), findsOneWidget);

      // Should remain on OTP screen
      expect(find.byType(OtpVerifyPage), findsOneWidget);
    });
  });
}
```

## 📊 Monitoring and Analytics

### 1. Performance Monitoring

```dart
class PerformanceMonitor {
  static final Map<String, Stopwatch> _timers = {};

  static void startTimer(String operation) {
    _timers[operation] = Stopwatch()..start();
  }

  static void endTimer(String operation) {
    final timer = _timers[operation];
    if (timer != null) {
      timer.stop();
      final duration = timer.elapsedMilliseconds;

      // Log performance metric
      Logs().i('Performance: $operation took ${duration}ms');

      // Send to analytics (implement your analytics service)
      AnalyticsService.recordPerformance(operation, duration);

      _timers.remove(operation);
    }
  }
}

// Usage
Future<void> authenticateUser() async {
  PerformanceMonitor.startTimer('user_authentication');

  try {
    // Authentication logic
    await performAuthentication();
  } finally {
    PerformanceMonitor.endTimer('user_authentication');
  }
}
```

### 2. Error Tracking

```dart
class ErrorTracker {
  static void recordError(
    dynamic error,
    StackTrace? stackTrace, {
    Map<String, dynamic>? context,
  }) {
    final errorData = {
      'error': error.toString(),
      'stack_trace': stackTrace?.toString(),
      'timestamp': DateTime.now().toIso8601String(),
      'context': context,
    };

    // Log locally
    Logs().e('Error recorded: $errorData');

    // Send to crash reporting service
    CrashReportingService.recordError(errorData);
  }
}
```

## 📋 Implementation Checklist

### Security Checklist
- [ ] JWT tokens validated properly
- [ ] Secure storage implemented correctly
- [ ] OTP rate limiting in place
- [ ] HTTPS enforced in production
- [ ] Input validation on all endpoints
- [ ] Error messages don't leak sensitive info
- [ ] Authentication state cleared on logout

### Performance Checklist
- [ ] Client initialization optimized
- [ ] HTTP connection pooling configured
- [ ] Memory management implemented
- [ ] Background sync optimized
- [ ] Unnecessary network requests eliminated
- [ ] Caching strategy implemented

### Architecture Checklist
- [ ] Services properly separated
- [ ] Dependency injection configured
- [ ] Error handling comprehensive
- [ ] Code is testable and modular
- [ ] Configuration externalized
- [ ] Logging properly implemented

### Testing Checklist
- [ ] Unit tests cover critical paths
- [ ] Integration tests verify flows
- [ ] Error scenarios tested
- [ ] Performance tests included
- [ ] Security tests implemented
- [ ] Platform-specific tests added

### Monitoring Checklist
- [ ] Performance metrics collected
- [ ] Error tracking configured
- [ ] User analytics implemented
- [ ] Health checks in place
- [ ] Alerting configured
- [ ] Logging structured and searchable

This comprehensive guide provides the foundation for building a secure, performant, and maintainable Matrix authentication system.