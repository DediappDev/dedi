import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fluffychat/utils/platform_infos.dart';

class SessionCredentials {
  final String accessToken;
  final String userId;
  final String homeserver;
  final String? deviceId;

  const SessionCredentials({
    required this.accessToken,
    required this.userId,
    required this.homeserver,
    this.deviceId,
  });
}

class SessionCredentialsStorage {
  static const _kAccessToken = 'session.access_token';
  static const _kUserId = 'session.user_id';
  static const _kHomeserver = 'session.homeserver';
  static const _kDeviceId = 'session.device_id';
  static const _kSessionsByClient = 'session.by_client';
  static const _kSignedOutClientNames = 'session.signed_out_client_names';
  static const _kIsLoggedInCompat = 'is_logged_in';

  static Future<void> save(
    SessionCredentials session, {
    String? clientName,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    // Use secure storage on mobile; fallback to SharedPreferences otherwise.
    if (PlatformInfos.isMobile) {
      const secure = FlutterSecureStorage();
      await secure.write(key: _kAccessToken, value: session.accessToken);
      await secure.write(key: _kUserId, value: session.userId);
      await secure.write(key: _kHomeserver, value: session.homeserver);
      if (session.deviceId != null) {
        await secure.write(key: _kDeviceId, value: session.deviceId);
      }
      // Keep a mirrored copy in SharedPreferences for resilience against
      // transient keychain read issues in iOS simulators/dev environments.
      await prefs.setString(_kAccessToken, session.accessToken);
      await prefs.setString(_kUserId, session.userId);
      await prefs.setString(_kHomeserver, session.homeserver);
      if (session.deviceId != null) {
        await prefs.setString(_kDeviceId, session.deviceId!);
      } else {
        await prefs.remove(_kDeviceId);
      }
    } else {
      await prefs.setString(_kAccessToken, session.accessToken);
      await prefs.setString(_kUserId, session.userId);
      await prefs.setString(_kHomeserver, session.homeserver);
      if (session.deviceId != null) {
        await prefs.setString(_kDeviceId, session.deviceId!);
      } else {
        await prefs.remove(_kDeviceId);
      }
    }

    // Backward-compat flag for existing splash logic.
    await prefs.setBool(_kIsLoggedInCompat, true);

    if (clientName != null && clientName.isNotEmpty) {
      final sessions = await loadAllByClientName();
      sessions[clientName] = session;
      await _storeAllByClientName(sessions);
      await _removeSignedOutClientName(clientName);
    }
  }

  static Future<SessionCredentials?> load() async {
    String? accessToken;
    String? userId;
    String? homeserver;
    String? deviceId;

    if (PlatformInfos.isMobile) {
      const secure = FlutterSecureStorage();
      accessToken = await secure.read(key: _kAccessToken);
      userId = await secure.read(key: _kUserId);
      homeserver = await secure.read(key: _kHomeserver);
      deviceId = await secure.read(key: _kDeviceId);

      // Fallback to SharedPreferences mirror if keychain read returns empty.
      if (accessToken == null || userId == null || homeserver == null) {
        final prefs = await SharedPreferences.getInstance();
        accessToken ??= prefs.getString(_kAccessToken);
        userId ??= prefs.getString(_kUserId);
        homeserver ??= prefs.getString(_kHomeserver);
        deviceId ??= prefs.getString(_kDeviceId);
      }
    } else {
      final prefs = await SharedPreferences.getInstance();
      accessToken = prefs.getString(_kAccessToken);
      userId = prefs.getString(_kUserId);
      homeserver = prefs.getString(_kHomeserver);
      deviceId = prefs.getString(_kDeviceId);
    }

    if (accessToken == null || userId == null || homeserver == null) {
      return null;
    }
    return SessionCredentials(
      accessToken: accessToken,
      userId: userId,
      homeserver: homeserver,
      deviceId: deviceId,
    );
  }

  static Future<void> clear({
    bool preserveClientSessions = false,
  }) async {
    if (PlatformInfos.isMobile) {
      const secure = FlutterSecureStorage();
      if (preserveClientSessions) {
        await _safeDelete(secure, _kAccessToken);
        await _safeDelete(secure, _kUserId);
        await _safeDelete(secure, _kHomeserver);
        await _safeDelete(secure, _kDeviceId);
      } else {
        try {
          // Some simulators may throw -34018; swallow in dev
          await secure.deleteAll();
        } catch (e) {
          debugPrint('[SecureStorage] deleteAll failed (dev): $e');
          await _safeDelete(secure, _kAccessToken);
          await _safeDelete(secure, _kUserId);
          await _safeDelete(secure, _kHomeserver);
          await _safeDelete(secure, _kDeviceId);
          await _safeDelete(secure, _kSessionsByClient);
        }
      }
    } else {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_kAccessToken);
      await prefs.remove(_kUserId);
      await prefs.remove(_kHomeserver);
      await prefs.remove(_kDeviceId);
      if (!preserveClientSessions) {
        await prefs.remove(_kSessionsByClient);
      }
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kAccessToken);
    await prefs.remove(_kUserId);
    await prefs.remove(_kHomeserver);
    await prefs.remove(_kDeviceId);
    await prefs.setBool(_kIsLoggedInCompat, false);
    if (!preserveClientSessions) {
      await prefs.remove(_kSignedOutClientNames);
    }
  }

  static Future<void> _safeDelete(
    FlutterSecureStorage secure,
    String key,
  ) async {
    try {
      await secure.delete(key: key);
    } catch (_) {}
  }

  static Future<Map<String, SessionCredentials>> loadAllByClientName() async {
    String? raw;
    try {
      if (PlatformInfos.isMobile) {
        const secure = FlutterSecureStorage();
        raw = await secure.read(key: _kSessionsByClient);
        if (raw == null || raw.isEmpty) {
          final prefs = await SharedPreferences.getInstance();
          raw = prefs.getString(_kSessionsByClient);
        }
      } else {
        final prefs = await SharedPreferences.getInstance();
        raw = prefs.getString(_kSessionsByClient);
      }
    } catch (e) {
      debugPrint(
        'SessionCredentialsStorage::loadAllByClientName secure read failed: $e',
      );
      final prefs = await SharedPreferences.getInstance();
      raw = prefs.getString(_kSessionsByClient);
    }
    if (raw == null || raw.isEmpty) return {};

    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) return {};
      final sessions = <String, SessionCredentials>{};
      decoded.forEach((clientName, value) {
        if (value is! Map<String, dynamic>) return;
        final accessToken = value['access_token'] as String?;
        final userId = value['user_id'] as String?;
        final homeserver = value['homeserver'] as String?;
        if (accessToken == null || userId == null || homeserver == null) {
          return;
        }
        sessions[clientName] = SessionCredentials(
          accessToken: accessToken,
          userId: userId,
          homeserver: homeserver,
          deviceId: value['device_id'] as String?,
        );
      });
      return sessions;
    } catch (_) {
      return {};
    }
  }

  static Future<void> removeClientSession(String clientName) async {
    if (clientName.isEmpty) return;
    await _addSignedOutClientName(clientName);
    try {
      final sessions = await loadAllByClientName();
      sessions.remove(clientName);
      await _storeAllByClientName(sessions);
    } catch (e) {
      debugPrint(
        'SessionCredentialsStorage::removeClientSession() failed for $clientName: $e',
      );
    }
  }

  static Future<Set<String>> loadSignedOutClientNames() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_kSignedOutClientNames) ?? const [];
    return list.toSet();
  }

  static Future<void> _addSignedOutClientName(String clientName) async {
    final prefs = await SharedPreferences.getInstance();
    final signedOut = prefs.getStringList(_kSignedOutClientNames) ?? <String>[];
    if (!signedOut.contains(clientName)) {
      signedOut.add(clientName);
      await prefs.setStringList(_kSignedOutClientNames, signedOut);
    }
  }

  static Future<void> _removeSignedOutClientName(String clientName) async {
    final prefs = await SharedPreferences.getInstance();
    final signedOut = prefs.getStringList(_kSignedOutClientNames) ?? <String>[];
    if (signedOut.remove(clientName)) {
      await prefs.setStringList(_kSignedOutClientNames, signedOut);
    }
  }

  static Future<void> _storeAllByClientName(
    Map<String, SessionCredentials> sessions,
  ) async {
    final map = <String, dynamic>{
      for (final entry in sessions.entries)
        entry.key: {
          'access_token': entry.value.accessToken,
          'user_id': entry.value.userId,
          'homeserver': entry.value.homeserver,
          if (entry.value.deviceId != null) 'device_id': entry.value.deviceId,
        },
    };
    final serialized = jsonEncode(map);
    final prefs = await SharedPreferences.getInstance();
    if (PlatformInfos.isMobile) {
      const secure = FlutterSecureStorage();
      try {
        await secure.write(key: _kSessionsByClient, value: serialized);
      } catch (e) {
        debugPrint(
          'SessionCredentialsStorage::_storeAllByClientName secure write failed: $e',
        );
        await prefs.setString(_kSessionsByClient, serialized);
      }
    } else {
      await prefs.setString(_kSessionsByClient, serialized);
    }
    // Keep a mirrored copy in SharedPreferences for resilience against
    // transient keychain read issues on iOS simulators/dev environments.
    await prefs.setString(_kSessionsByClient, serialized);
  }
}
