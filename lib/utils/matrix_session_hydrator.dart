import 'package:flutter/foundation.dart';
import 'package:matrix/matrix.dart';

/// Utility to hydrate a Matrix client session using an existing access token.
///
/// This avoids any /login flow and sets the client to a ready state
/// by assigning homeserver, userId and accessToken directly, then
/// triggering background sync.
class MatrixSessionHydrator {
  /// Restores a session from an access token and starts background sync.
  ///
  /// Required fields come from the backend response after OTP verification.
  static Future<Client> fromAccessToken({
    required Client client,
    required String homeserverBaseUrl,
    required String userId,
    required String accessToken,
    String? deviceId,
    bool verifyHomeserver = false,
    bool startSync = true,
  }) async {
    final hs = Uri.parse(homeserverBaseUrl);
    if (hs.scheme.isEmpty || hs.host.isEmpty) {
      throw ArgumentError(
        'homeserverBaseUrl must be absolute (scheme + host): $homeserverBaseUrl',
      );
    }

    // Optionally verify homeserver discovery (can throw if .well-known is HTML)
    if (verifyHomeserver) {
      try {
        await client.checkHomeserver(hs);
      } catch (e) {
        // Ignore malformed discovery on hydration path; we already trust the base URL.
        if (kDebugMode) {
          Logs().w(
              'MatrixSessionHydrator: checkHomeserver failed, continuing hydration anyway: $e');
        }
      }
    }

    // Assign session fields directly; no /login calls.
    client.homeserver = hs;
    // Keep userId available before first sync events arrive.
    client.setUserId(userId);
    client.accessToken = accessToken;
    // deviceId is not publicly settable; SDK will populate it from responses.

    if (startSync) {
      // Kick off background sync so timelines begin to populate.
      client.backgroundSync = true;
      client.syncPresence = null;
      client.requestHistoryOnLimitedTimeline = true;
      client.sync();
    }

    if (kDebugMode) {
      Logs().v(
        '[Hydration] ${startSync ? 'Background sync started' : 'Hydration completed without sync'}',
      );
    }

    return client;
  }

  /// Validates that the current client's token is accepted by the homeserver.
  /// Returns true if token is valid, false if M_UNKNOWN_TOKEN, rethrows on other errors.
  static Future<bool> validateAccessToken(Client client) async {
    try {
      await client.request(RequestType.GET, '/client/r0/account/whoami');
      return true;
    } on MatrixException catch (e) {
      if (e.error == MatrixError.M_UNKNOWN_TOKEN) {
        return false;
      }
      rethrow;
    }
  }
}
