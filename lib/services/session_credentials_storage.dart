import 'dart:io';

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
  static const _kIsLoggedInCompat = 'is_logged_in';

  static Future<void> save(SessionCredentials session) async {
    // Use secure storage on mobile; fallback to SharedPreferences otherwise.
    if (PlatformInfos.isMobile) {
      const secure = FlutterSecureStorage();
      await secure.write(key: _kAccessToken, value: session.accessToken);
      await secure.write(key: _kUserId, value: session.userId);
      await secure.write(key: _kHomeserver, value: session.homeserver);
      if (session.deviceId != null) {
        await secure.write(key: _kDeviceId, value: session.deviceId);
      }
    } else {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_kAccessToken, session.accessToken);
      await prefs.setString(_kUserId, session.userId);
      await prefs.setString(_kHomeserver, session.homeserver);
      if (session.deviceId != null) {
        await prefs.setString(_kDeviceId, session.deviceId!);
      }
    }

    // Backward-compat flag for existing splash logic.
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kIsLoggedInCompat, true);
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

  static Future<void> clear() async {
    if (PlatformInfos.isMobile) {
      const secure = FlutterSecureStorage();
      try {
        // Some simulators may throw -34018; swallow in dev
        await secure.deleteAll();
      } catch (e) {
        debugPrint('[SecureStorage] deleteAll failed (dev): $e');
        try { await secure.delete(key: _kAccessToken); } catch (_) {}
        try { await secure.delete(key: _kUserId); } catch (_) {}
        try { await secure.delete(key: _kHomeserver); } catch (_) {}
        try { await secure.delete(key: _kDeviceId); } catch (_) {}
      }
    } else {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_kAccessToken);
      await prefs.remove(_kUserId);
      await prefs.remove(_kHomeserver);
      await prefs.remove(_kDeviceId);
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kIsLoggedInCompat, false);
  }
}
