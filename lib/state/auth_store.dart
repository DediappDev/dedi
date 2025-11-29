import 'package:flutter/foundation.dart';
import 'package:matrix/matrix.dart';

import 'package:fluffychat/services/session_credentials_storage.dart';
import 'package:fluffychat/utils/matrix_session_hydrator.dart';

enum AuthState { unknown, hydrating, authenticated, unauthenticated }

class AuthStore extends ChangeNotifier {
  AuthState state = AuthState.unknown;
  Client? _client;

  Client? get client => _client;

  Future<void> bootstrap({required Client client}) async {
    state = AuthState.hydrating;
    notifyListeners();
    final saved = await SessionCredentialsStorage.load();
    if (saved == null) {
      state = AuthState.unauthenticated;
      notifyListeners();
      return;
    }
    try {
      await MatrixSessionHydrator.fromAccessToken(
        client: client,
        homeserverBaseUrl: saved.homeserver,
        userId: saved.userId,
        accessToken: saved.accessToken,
        deviceId: saved.deviceId,
        verifyHomeserver: false,
      );
      final ok = await MatrixSessionHydrator.validateAccessToken(client);
      if (ok) {
        _client = client;
        state = AuthState.authenticated;
      } else {
        await SessionCredentialsStorage.clear();
        state = AuthState.unauthenticated;
      }
    } catch (_) {
      await SessionCredentialsStorage.clear();
      state = AuthState.unauthenticated;
    }
    notifyListeners();
  }

  Future<void> setAuthenticated(Client client) async {
    _client = client;
    state = AuthState.authenticated;
    notifyListeners();
  }

  Future<void> logout() async {
    try {
      await _client?.logout();
    } catch (_) {}
    await SessionCredentialsStorage.clear();
    _client = null;
    state = AuthState.unauthenticated;
    notifyListeners();
  }
}

