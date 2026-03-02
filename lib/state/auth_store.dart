import 'package:flutter/foundation.dart';
import 'package:matrix/matrix.dart';

import 'package:fluffychat/services/session_credentials_storage.dart';
import 'package:fluffychat/utils/matrix_session_hydrator.dart';
import 'package:fluffychat/utils/onboarding_prefs.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/data/network/interceptor/authorization_interceptor.dart';

enum AuthState { unknown, hydrating, authenticated, unauthenticated }

class AuthStore extends ChangeNotifier {
  AuthState state = AuthState.unknown;
  Client? _client;
  String? _userId;
  bool onboardingDone = false;

  Client? get client => _client;
  String? get userId => _userId;

  Future<void> bootstrap({Client? client}) async {
    state = AuthState.hydrating;
    notifyListeners();

    onboardingDone = await OnboardingPrefs.isDone();

    final saved = await SessionCredentialsStorage.load();
    if (saved == null) {
      Logs().i('[AUTH] No saved credentials found');
      if (_tryUseExistingLoggedClient(client)) {
        notifyListeners();
        return;
      }
      _client = null;
      _userId = null;
      state = AuthState.unauthenticated;
      notifyListeners();
      return;
    }
    if (saved.accessToken.isEmpty ||
        saved.userId.isEmpty ||
        saved.homeserver.isEmpty) {
      Logs().w('[AUTH] Saved credentials are incomplete, clearing storage');
      await SessionCredentialsStorage.clear(preserveClientSessions: true);
      if (_tryUseExistingLoggedClient(client)) {
        notifyListeners();
        return;
      }
      _client = null;
      _userId = null;
      state = AuthState.unauthenticated;
      notifyListeners();
      return;
    }

    try {
      MatrixSessionHydrator.normalizeHomeserverUri(saved.homeserver);
    } catch (e) {
      Logs().w(
        '[AUTH] Saved homeserver is invalid (${saved.homeserver}), clearing storage: $e',
      );
      await SessionCredentialsStorage.clear(preserveClientSessions: true);
      if (_tryUseExistingLoggedClient(client)) {
        notifyListeners();
        return;
      }
      _client = null;
      _userId = null;
      state = AuthState.unauthenticated;
      notifyListeners();
      return;
    }

    final hydratedClient = client ?? Client('Dedi Client');

    try {
      Logs()
          .i('[AUTH] Attempting to hydrate session for user: ${saved.userId}');

      await MatrixSessionHydrator.fromAccessToken(
        client: hydratedClient,
        homeserverBaseUrl: saved.homeserver,
        userId: saved.userId,
        accessToken: saved.accessToken,
        deviceId: saved.deviceId,
        verifyHomeserver: false,
        startSync: false,
      );

      // CRITICAL: Validate token before setting authenticated
      Logs().i('[AUTH] Validating access token with /whoami...');
      final ok =
          await MatrixSessionHydrator.validateAccessToken(hydratedClient);

      if (ok) {
        if (!_isClientReadyForSync(hydratedClient)) {
          Logs().w(
            '[AUTH] Hydrated client is not ready for sync (homeserver/accessToken missing). Clearing credentials.',
          );
          await SessionCredentialsStorage.clear(preserveClientSessions: true);
          _client = null;
          _userId = null;
          state = AuthState.unauthenticated;
          notifyListeners();
          return;
        }
        _client = hydratedClient;
        _userId = saved.userId;
        _primeAuthorization(hydratedClient);
        _startSync(hydratedClient);
        state = AuthState.authenticated;
        Logs().i('[AUTH] Bootstrap succeeded - user authenticated');
      } else {
        Logs()
            .w('[AUTH] Token validation returned false - clearing credentials');
        await SessionCredentialsStorage.clear(preserveClientSessions: true);
        if (_tryUseExistingLoggedClient(client)) {
          notifyListeners();
          return;
        }
        _client = null;
        _userId = null;
        state = AuthState.unauthenticated;
      }
    } catch (e, stack) {
      Logs().e('[AUTH] Bootstrap exception: $e');
      Logs().e('[AUTH] Stack trace: $stack');
      await SessionCredentialsStorage.clear(preserveClientSessions: true);
      if (_tryUseExistingLoggedClient(client)) {
        notifyListeners();
        return;
      }
      _client = null;
      _userId = null;
      state = AuthState.unauthenticated;
    }
    notifyListeners();
  }

  Future<void> setAuthenticated(
    Client client, {
    bool startSync = true,
    String? userId,
  }) async {
    if (!_isClientReadyForSync(client)) {
      Logs().w(
        '[AUTH] setAuthenticated skipped: client is not ready for sync/authenticated state',
      );
      state = AuthState.unauthenticated;
      notifyListeners();
      return;
    }
    _client = client;
    _userId = userId ?? _userId ?? client.userID;
    _primeAuthorization(client);
    if (startSync) {
      _startSync(client);
    }
    state = AuthState.authenticated;
    notifyListeners();
  }

  Future<void> setOnboardingDone() async {
    onboardingDone = true;
    await OnboardingPrefs.setDone();
    notifyListeners();
  }

  Future<void> logout() async {
    try {
      await _client?.logout();
    } catch (_) {}
    await SessionCredentialsStorage.clear();
    _client = null;
    _userId = null;
    state = AuthState.unauthenticated;
    notifyListeners();
  }

  void _startSync(Client client) {
    if (!_isClientReadyForSync(client)) {
      Logs().w(
        '[AUTH] _startSync skipped: homeserver/accessToken is invalid',
      );
      return;
    }
    client.backgroundSync = true;
    client.syncPresence = null;
    client.requestHistoryOnLimitedTimeline = true;
    client.sync();
  }

  bool _isClientReadyForSync(Client client) {
    final homeserver = client.homeserver;
    return homeserver != null &&
        homeserver.scheme.isNotEmpty &&
        homeserver.host.isNotEmpty &&
        (client.accessToken?.isNotEmpty ?? false);
  }

  bool _tryUseExistingLoggedClient(Client? client) {
    if (client == null ||
        !client.isLogged() ||
        !_isClientReadyForSync(client)) {
      return false;
    }
    _client = client;
    _userId = client.userID;
    _primeAuthorization(client);
    _startSync(client);
    state = AuthState.authenticated;
    Logs().i('[AUTH] Fallback authenticated using existing logged client');
    return true;
  }

  void _primeAuthorization(Client client) {
    try {
      final authz = getIt.get<AuthorizationInterceptor>();
      authz.accessToken = client.accessToken;
    } catch (_) {
      // ignore if interceptor not registered
    }
  }
}
