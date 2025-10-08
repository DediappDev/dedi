import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/app_config.dart';

class OTPApiService {
  static Uri _buildUri(String endpoint) {
    return Uri.parse('${AppConfig.otpApiBaseUrl}$endpoint');
  }

  static Future<Map<String, dynamic>> requestOTP(String phoneNumber) async {
    final response = await http.post(
      _buildUri(AppConfig.otpRequestEndpoint),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'phone': phoneNumber}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }

    throw Exception('Failed to request OTP: ${response.body}');
  }

  static Future<Map<String, dynamic>> verifyOTP(
    String phoneNumber,
    String code,
  ) async {
    final response = await http.post(
      _buildUri(AppConfig.otpVerifyEndpoint),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'phone': phoneNumber,
        'code': code,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }

    throw Exception('Failed to verify OTP: ${response.body}');
  }

  static Future<Map<String, dynamic>> getMatrixToken(
    String jwtToken,
    String phoneNumber,
  ) async {
    final response = await http.post(
      _buildUri(AppConfig.otpMatrixTokenEndpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      },
      body: jsonEncode({
        'jwt_token': jwtToken,
        'phone': phoneNumber,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }

    throw Exception('Failed to get Matrix token: ${response.body}');
  }
}
