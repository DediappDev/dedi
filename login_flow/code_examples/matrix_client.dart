/// Matrix Client Integration
/// Based on: lib/widgets/matrix.dart and lib/utils/client_manager.dart
///
/// This file provides:
/// - Matrix client initialization and management
/// - Authentication state handling
/// - Session persistence and restoration
/// - Multi-client support for multiple accounts

import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Matrix Client Manager - Singleton for managing Matrix clients
class MatrixClientManager {
  static MatrixClientManager? _instance;
  static MatrixClientManager get instance => _instance ??= MatrixClientManager._();
  MatrixClientManager._();

  final List<Client> _clients = [];
  Client? _activeClient;
  final StreamController<List<Client>> _clientsController = StreamController.broadcast();

  List<Client> get clients => List.unmodifiable(_clients);
  Client? get activeClient => _activeClient;
  Stream<List<Client>> get clientsStream => _clientsController.stream;

  /// Initialize Matrix client with credentials from backend
  static Future<Client> initializeClient({
    required String userId,
    required String accessToken,
    required String deviceId,
    required String homeserverUrl,
    String? deviceName,
  }) async {
    try {
      print('[MatrixClient] Initializing Matrix client...');
      print('[MatrixClient] User ID: $userId');
      print('[MatrixClient] Homeserver: $homeserverUrl');
      print('[MatrixClient] Device ID: $deviceId');

      // Create client name based on current timestamp
      final clientName = 'DediClient-${DateTime.now().millisecondsSinceEpoch}';

      // Get shared preferences for storage
      final store = await SharedPreferences.getInstance();

      // Create Matrix client
      final client = Client(
        clientName,
        httpClient: _createHttpClient(),
        verificationMethods: {
          KeyVerificationMethod.emoji,
          KeyVerificationMethod.numbers,
        },
        importantStateEvents: {
          'im.ponies.room_emotes', // Room emotes support
        },
        databaseBuilder: _getDatabaseBuilder(clientName),
        legacyDatabaseBuilder: _getLegacyDatabaseBuilder(clientName),
        supportedLoginTypes: {
          AuthenticationTypes.password,
          AuthenticationTypes.sso,
        },
      );

      // Initialize client with credentials
      await client.init(
        newToken: accessToken,
        newUserID: userId,
        newHomeserver: Uri.parse(homeserverUrl),
        newDeviceID: deviceId,
        newDeviceName: deviceName ?? 'Dedi Mobile App',
        waitForFirstSync: false,
        waitUntilLoadCompletedLoaded: false,
      );

      // Verify client initialization
      if (!client.isLogged()) {
        throw Exception('Client initialization succeeded but isLogged() returns false');
      }

      print('[MatrixClient] ✅ Matrix client successfully initialized!');
      print('[MatrixClient] User ID: ${client.userID}');
      print('[MatrixClient] Device ID: ${client.deviceID}');
      print('[MatrixClient] Access token set: ${client.accessToken != null}');
      print('[MatrixClient] Homeserver: ${client.homeserver}');

      // Add to client manager
      instance._addClient(client);

      // Store client name for persistence
      await _storeClientName(clientName, store);

      return client;
    } catch (e) {
      print('[MatrixClient] Client initialization error: $e');
      rethrow;
    }
  }

  /// Create a new client for login process
  static Future<Client> createLoginClient() async {
    final clientName = 'LoginClient-${DateTime.now().millisecondsSinceEpoch}';
    final store = await SharedPreferences.getInstance();

    final client = Client(
      clientName,
      httpClient: _createHttpClient(),
      verificationMethods: {
        KeyVerificationMethod.emoji,
        KeyVerificationMethod.numbers,
      },
      databaseBuilder: _getDatabaseBuilder(clientName),
      legacyDatabaseBuilder: _getLegacyDatabaseBuilder(clientName),
      supportedLoginTypes: {
        AuthenticationTypes.password,
        AuthenticationTypes.sso,
      },
    );

    return client;
  }

  /// Restore clients from stored preferences
  static Future<List<Client>> restoreClients() async {
    try {
      final store = await SharedPreferences.getInstance();
      final clientNames = store.getStringList('matrix_clients') ?? [];

      print('[MatrixClient] Restoring ${clientNames.length} clients...');

      final clients = <Client>[];
      for (final clientName in clientNames) {
        try {
          final client = await _restoreClient(clientName, store);
          if (client != null) {
            clients.add(client);
            instance._addClient(client);
          }
        } catch (e) {
          print('[MatrixClient] Failed to restore client $clientName: $e');
          // Remove invalid client name
          clientNames.remove(clientName);
          await store.setStringList('matrix_clients', clientNames);
        }
      }

      print('[MatrixClient] Successfully restored ${clients.length} clients');
      return clients;
    } catch (e) {
      print('[MatrixClient] Error restoring clients: $e');
      return [];
    }
  }

  /// Restore a single client from storage
  static Future<Client?> _restoreClient(String clientName, SharedPreferences store) async {
    try {
      final client = Client(
        clientName,
        httpClient: _createHttpClient(),
        verificationMethods: {
          KeyVerificationMethod.emoji,
          KeyVerificationMethod.numbers,
        },
        databaseBuilder: _getDatabaseBuilder(clientName),
        legacyDatabaseBuilder: _getLegacyDatabaseBuilder(clientName),
        supportedLoginTypes: {
          AuthenticationTypes.password,
          AuthenticationTypes.sso,
        },
      );

      // Check if client has valid session data
      await client.init();

      if (client.isLogged()) {
        print('[MatrixClient] ✅ Restored client: ${client.userID}');
        return client;
      } else {
        print('[MatrixClient] ❌ Client $clientName not logged in, removing...');
        return null;
      }
    } catch (e) {
      print('[MatrixClient] Error restoring client $clientName: $e');
      return null;
    }
  }

  /// Add client to manager
  void _addClient(Client client) {
    if (!_clients.contains(client)) {
      _clients.add(client);
      _activeClient ??= client;
      _clientsController.add(_clients);

      // Setup client listeners
      _setupClientListeners(client);
    }
  }

  /// Remove client from manager
  Future<void> removeClient(Client client) async {
    try {
      await client.logout();
      _clients.remove(client);

      if (_activeClient == client) {
        _activeClient = _clients.isNotEmpty ? _clients.first : null;
      }

      _clientsController.add(_clients);

      // Remove from stored preferences
      final store = await SharedPreferences.getInstance();
      final clientNames = store.getStringList('matrix_clients') ?? [];
      clientNames.remove(client.clientName);
      await store.setStringList('matrix_clients', clientNames);

      print('[MatrixClient] Removed client: ${client.userID}');
    } catch (e) {
      print('[MatrixClient] Error removing client: $e');
    }
  }

  /// Set active client
  void setActiveClient(Client client) {
    if (_clients.contains(client)) {
      _activeClient = client;
      print('[MatrixClient] Active client set to: ${client.userID}');
    }
  }

  /// Setup client event listeners
  void _setupClientListeners(Client client) {
    // Listen for login state changes
    client.onLoginStateChanged.stream.listen((state) {
      print('[MatrixClient] Login state changed for ${client.userID}: $state');

      if (state == LoginState.loggedOut) {
        removeClient(client);
      }
    });

    // Listen for sync errors
    client.onSyncError.stream.listen((SyncError error) {
      print('[MatrixClient] Sync error for ${client.userID}: ${error.exception}');
      // Handle sync errors (e.g., show user notification)
    });
  }

  /// Store client name for persistence
  static Future<void> _storeClientName(String clientName, SharedPreferences store) async {
    final clientNames = store.getStringList('matrix_clients') ?? [];
    if (!clientNames.contains(clientName)) {
      clientNames.add(clientName);
      await store.setStringList('matrix_clients', clientNames);
    }
  }

  /// Create HTTP client with custom settings
  static http.Client _createHttpClient() {
    // You can customize HTTP client here for proxy, certificates, etc.
    return http.Client();
  }

  /// Get database builder for client storage
  static DatabaseApi Function(String)? _getDatabaseBuilder(String clientName) {
    // Return null to use default database (Hive/Isar)
    // You can implement custom database here if needed
    return null;
  }

  /// Get legacy database builder
  static DatabaseApi Function(String)? _getLegacyDatabaseBuilder(String clientName) {
    // Return null to use default legacy database handling
    return null;
  }

  /// Dispose all resources
  void dispose() {
    for (final client in _clients) {
      client.dispose();
    }
    _clients.clear();
    _clientsController.close();
  }
}

/// Matrix Provider Widget for state management
class MatrixProvider extends StatefulWidget {
  final Widget child;
  final List<Client> clients;
  final SharedPreferences store;

  const MatrixProvider({
    super.key,
    required this.child,
    required this.clients,
    required this.store,
  });

  @override
  MatrixProviderState createState() => MatrixProviderState();

  /// Get MatrixProviderState from context
  static MatrixProviderState of(BuildContext context) =>
      Provider.of<MatrixProviderState>(context, listen: false);
}

class MatrixProviderState extends State<MatrixProvider> with WidgetsBindingObserver {
  late final MatrixClientManager _clientManager;
  SharedPreferences get store => widget.store;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _clientManager = MatrixClientManager.instance;
    _initializeMatrix();
  }

  /// Initialize Matrix clients
  Future<void> _initializeMatrix() async {
    try {
      // Restore existing clients
      final restoredClients = await MatrixClientManager.restoreClients();
      print('[MatrixProvider] Restored ${restoredClients.length} clients');

      // Add any additional clients passed to widget
      for (final client in widget.clients) {
        if (!restoredClients.contains(client)) {
          _clientManager._addClient(client);
        }
      }

      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      print('[MatrixProvider] Error initializing Matrix: $e');
    }
  }

  /// Get current active client
  Client? get client => _clientManager.activeClient;

  /// Get all clients
  List<Client> get clients => _clientManager.clients;

  /// Check if any client is logged in
  bool get isLoggedIn => clients.any((client) => client.isLogged());

  /// Get login client for authentication
  Future<Client> getLoginClient() async {
    return MatrixClientManager.createLoginClient();
  }

  /// Set active client
  void setActiveClient(Client client) {
    _clientManager.setActiveClient(client);
    setState(() {});
  }

  /// Handle app lifecycle changes
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final foreground = state != AppLifecycleState.inactive &&
        state != AppLifecycleState.paused;

    for (final client in clients) {
      client.syncPresence = state == AppLifecycleState.resumed
          ? null
          : PresenceType.unavailable;

      if (kIsWeb) {
        // Web-specific handling
        client.backgroundSync = foreground;
        client.requestHistoryOnLimitedTimeline = !foreground;
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _clientManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<MatrixProviderState>(
      create: (_) => this,
      child: StreamBuilder<List<Client>>(
        stream: _clientManager.clientsStream,
        builder: (context, snapshot) {
          return widget.child;
        },
      ),
    );
  }
}

/// Authentication Helper Class
class MatrixAuthHelper {
  /// Check if user is authenticated
  static Future<bool> isAuthenticated() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isLoggedIn = prefs.getBool('is_logged_in') ?? false;

      if (!isLoggedIn) return false;

      // Check if we have valid Matrix clients
      final clients = await MatrixClientManager.restoreClients();
      return clients.any((client) => client.isLogged());
    } catch (e) {
      print('[AuthHelper] Error checking authentication: $e');
      return false;
    }
  }

  /// Clear authentication state
  static Future<void> clearAuthState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('is_logged_in');
      await prefs.remove('user_id');
      await prefs.remove('matrix_clients');

      // Logout all clients
      final manager = MatrixClientManager.instance;
      for (final client in manager.clients) {
        await manager.removeClient(client);
      }

      print('[AuthHelper] Authentication state cleared');
    } catch (e) {
      print('[AuthHelper] Error clearing auth state: $e');
    }
  }

  /// Get current user ID
  static Future<String?> getCurrentUserId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('user_id');
    } catch (e) {
      print('[AuthHelper] Error getting user ID: $e');
      return null;
    }
  }
}

/// Extension for Matrix Client utilities
extension MatrixClientExtensions on Client {
  /// Check if client has valid session
  bool get hasValidSession {
    return isLogged() && accessToken != null && userID != null;
  }

  /// Get user display name safely
  String get displayName {
    return profile?.displayName ?? userID?.localpart ?? 'Unknown User';
  }

  /// Get formatted homeserver name
  String get homeserverName {
    return homeserver?.host ?? 'Unknown Server';
  }
}

/// Custom exceptions for Matrix operations
class MatrixException implements Exception {
  final String message;
  final String? code;

  MatrixException(this.message, [this.code]);

  @override
  String toString() => 'MatrixException: $message${code != null ? ' ($code)' : ''}';
}

class MatrixAuthException extends MatrixException {
  MatrixAuthException(String message) : super(message, 'AUTH_ERROR');
}

class MatrixNetworkException extends MatrixException {
  MatrixNetworkException(String message) : super(message, 'NETWORK_ERROR');
}