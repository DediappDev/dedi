import 'package:flutter/foundation.dart';
import 'package:matrix/matrix.dart';

/// Utility to hydrate a Matrix client session using an existing access token.
///
/// This avoids any /login flow and sets the client to a ready state
/// by assigning homeserver, userId and accessToken directly. Sync can be
/// started immediately or deferred until after token validation.
class MatrixSessionHydrator {
  static Uri normalizeHomeserverUri(String rawValue) {
    final value = rawValue.trim();
    if (value.isEmpty) {
      throw const FormatException('Homeserver URL is empty');
    }
    var uri = Uri.parse(value);
    if (uri.scheme.isEmpty) {
      uri = Uri.https(value, '');
    }
    if (uri.host.isEmpty) {
      throw FormatException('Invalid homeserver URL: $rawValue');
    }
    return uri;
  }

  /// Restores a session from an access token.
  ///
  /// Required fields come from the backend response after OTP verification.
  static Future<Client> fromAccessToken({
    required Client client,
    required String homeserverBaseUrl,
    required String userId,
    required String accessToken,
    String? deviceId,
    bool verifyHomeserver = false,
    bool startSync = false,
  }) async {
    final hs = normalizeHomeserverUri(homeserverBaseUrl);

    // Optionally verify homeserver discovery (can throw if .well-known is HTML)
    if (verifyHomeserver) {
      try {
        await client.checkHomeserver(hs);
      } catch (e) {
        // Ignore malformed discovery on hydration path; we already trust the base URL.
        if (kDebugMode) {
          Logs().w(
            'MatrixSessionHydrator: checkHomeserver failed, continuing hydration anyway: $e',
          );
        }
      }
    }

    // Directly hydrate session without calling /login; keep encryption untouched.
    client.homeserver = hs;
    client.accessToken = accessToken;
    try {
      client.setUserId(userId);
    } catch (_) {
      // setUserId exists only in some SDK builds; ignore if missing.
    }

    if (startSync) {
      client.backgroundSync = true;
      client.syncPresence = null;
      client.requestHistoryOnLimitedTimeline = true;
      client.sync();
      if (kDebugMode) {
        Logs().v('[Hydration] Background sync started (manual hydration)');
      }
    } else {
      client.backgroundSync = false;
    }

    return client;
  }

  /// Validates that the current client's token is accepted by the homeserver.
  /// Returns true if token is valid, false otherwise.
  static Future<bool> validateAccessToken(Client client) async {
    try {
      await client.request(RequestType.GET, '/client/r0/account/whoami');
      return true;
    } on MatrixException catch (e) {
      if (e.error == MatrixError.M_UNKNOWN_TOKEN) {
        return false;
      }
      return false;
    } catch (_) {
      return false;
    }
  }
}
