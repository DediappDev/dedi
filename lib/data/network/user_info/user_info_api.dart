import 'package:fluffychat/data/network/tom_endpoint.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/di/global/network_di.dart';
import 'package:fluffychat/domain/model/user_info/user_info.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfoApi {
  const UserInfoApi();
  static const _unsupportedCacheKey = 'tom.user_info.unsupported';
  static bool _isUnsupported = false;

  Future<UserInfo> getUserInfo(String userId) async {
    if (!_isUnsupported) {
      final prefs = await SharedPreferences.getInstance();
      _isUnsupported = prefs.getBool(_unsupportedCacheKey) ?? false;
    }
    if (_isUnsupported) {
      return _buildFallbackUserInfo(userId);
    }

    final dio = getIt.get<Dio>(instanceName: NetworkDI.tomServerDioName);

    try {
      final response = await dio.get(
        TomEndpoint.userInfoServicePath.generateTomUserInfoEndpoint(userId),
        options: Options(validateStatus: (_) => true),
      );

      final statusCode = response.statusCode ?? 0;
      if (statusCode >= 400) {
        // Cache unsupported state to avoid noisy repeated calls/logs.
        if (statusCode == 404 ||
            statusCode == 405 ||
            statusCode == 500 ||
            statusCode == 501) {
          await _markUnsupported();
        }
        return _buildFallbackUserInfo(userId);
      }

      final data = response.data;
      if (data is Map<String, dynamic>) {
        return UserInfo.fromJson(data);
      }
      return _buildFallbackUserInfo(userId);
    } on DioException catch (e) {
      // If user-info endpoint is unavailable, return a stub instead of failing auth flow.
      final statusCode = e.response?.statusCode ?? 0;
      if (statusCode >= 400 || e.type == DioExceptionType.badResponse) {
        if (statusCode == 404 ||
            statusCode == 405 ||
            statusCode == 500 ||
            statusCode == 501) {
          await _markUnsupported();
        }
        return _buildFallbackUserInfo(userId);
      }
      rethrow;
    }
  }

  Future<void> _markUnsupported() async {
    _isUnsupported = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_unsupportedCacheKey, true);
  }

  UserInfo _buildFallbackUserInfo(String userId) {
    return UserInfo.fromJson({
      'user_id': userId,
      'displayname': null,
      'avatar_url': null,
      'language': null,
    });
  }
}
