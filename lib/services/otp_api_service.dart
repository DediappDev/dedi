import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../config/app_config.dart';

class OTPApiService {
  static Uri _buildUri(String endpoint) {
    final uri = Uri.parse('${AppConfig.otpApiBaseUrl}$endpoint');
    if (kDebugMode) {
      debugPrint('OTPApiService: Building URI: $uri');
    }
    return uri;
  }

  static Future<Map<String, dynamic>> requestOTP(String phoneNumber) async {
    try {
      if (kDebugMode) {
        debugPrint('OTPApiService: Requesting OTP for phone: $phoneNumber');
      }
      
      final response = await http.post(
        _buildUri(AppConfig.otpRequestEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phone': phoneNumber}),
      ).timeout(
        const Duration(seconds: 15),
        onTimeout: () => throw Exception('Request timeout'),
      );

      if (kDebugMode) {
        debugPrint('OTPApiService: Request OTP response status: ${response.statusCode}');
        debugPrint('OTPApiService: Request OTP response body: ${response.body}');
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return data;
      }

      // Parse error response
      String errorMessage = 'Failed to request OTP';
      try {
        final errorData = jsonDecode(response.body) as Map<String, dynamic>;
        errorMessage = errorData['message'] as String? ?? 
                      errorData['error'] as String? ?? 
                      'Failed to request OTP (${response.statusCode})';
      } catch (_) {
        errorMessage = 'Failed to request OTP (${response.statusCode})';
      }

      throw Exception(errorMessage);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('OTPApiService: Request OTP error: $e');
      }
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> verifyOTP(
    String phoneNumber,
    String code,
  ) async {
    try {
      if (kDebugMode) {
        debugPrint('OTPApiService: Verifying OTP for phone: $phoneNumber, code: $code');
      }
      
      final response = await http.post(
        _buildUri(AppConfig.otpVerifyEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'phone': phoneNumber,
          'code': code,
        }),
      ).timeout(
        const Duration(seconds: 15),
        onTimeout: () => throw Exception('Request timeout'),
      );

      if (kDebugMode) {
        debugPrint('OTPApiService: Verify OTP response status: ${response.statusCode}');
        debugPrint('OTPApiService: Verify OTP response body: ${response.body}');
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return data;
      }

      // Parse error response
      String errorMessage = 'INVALID_OTP';
      try {
        final errorData = jsonDecode(response.body) as Map<String, dynamic>;
        errorMessage = errorData['message'] as String? ?? 
                      errorData['error'] as String? ?? 
                      'Invalid OTP (${response.statusCode})';
      } catch (_) {
        errorMessage = 'Invalid OTP (${response.statusCode})';
      }

      throw Exception(errorMessage);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('OTPApiService: Verify OTP error: $e');
      }
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> getMatrixToken(
    String jwtToken,
    String phoneNumber,
  ) async {
    try {
      if (kDebugMode) {
        debugPrint('OTPApiService: Getting Matrix token for phone: $phoneNumber');
      }
      
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
      ).timeout(
        const Duration(seconds: 15),
        onTimeout: () => throw Exception('Request timeout'),
      );

      if (kDebugMode) {
        debugPrint('OTPApiService: Matrix token response status: ${response.statusCode}');
        debugPrint('OTPApiService: Matrix token response body: ${response.body}');
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return data;
      }

      // Parse error response
      String errorMessage = 'Failed to get Matrix token';
      try {
        final errorData = jsonDecode(response.body) as Map<String, dynamic>;
        errorMessage = errorData['message'] as String? ?? 
                      errorData['error'] as String? ?? 
                      'Failed to get Matrix token (${response.statusCode})';
      } catch (_) {
        errorMessage = 'Failed to get Matrix token (${response.statusCode})';
      }

      throw Exception(errorMessage);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('OTPApiService: Get Matrix token error: $e');
      }
      rethrow;
    }
  }
}
