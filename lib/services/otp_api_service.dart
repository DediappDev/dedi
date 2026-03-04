import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../config/app_config.dart';
import '../config/environment.dart';
import '../utils/debug_toast_service.dart';

class OTPApiService {
  static Uri _buildUri(String endpoint) {
    final uri = Uri.parse('${AppConfig.otpApiBaseUrl}$endpoint');

    // ✅ Enhanced debug logging for URL construction
    if (kDebugMode && Environment.enableDebugLogging) {
      debugPrint('🌐 OTPApiService: Building URI for DEDI Server:');
      debugPrint('   - Base URL: ${AppConfig.otpApiBaseUrl}');
      debugPrint('   - Endpoint: $endpoint');
      debugPrint('   - Full URI: $uri');
      debugPrint('   - Scheme: ${uri.scheme}');
      debugPrint('   - Host: ${uri.host}');
      debugPrint('   - Path: ${uri.path}');
    }

    return uri;
  }

  static Future<Map<String, dynamic>> requestOTP(String phoneNumber) async {
    try {
      // ✅ Enhanced debug logging for OTP request
      if (kDebugMode && Environment.enableDebugLogging) {
        debugPrint('📤 OTPApiService: Starting OTP request to DEDI Server');
        debugPrint('   - Operation: Request OTP');
        debugPrint(
            '   - Phone (masked): ${phoneNumber.substring(0, 4)}****${phoneNumber.substring(phoneNumber.length - 2)}');
        debugPrint('   - Endpoint: ${AppConfig.otpRequestEndpoint}');
        debugPrint('   - Base URL: ${AppConfig.otpApiBaseUrl}');
        debugPrint('   - Timeout: 15 seconds');
        debugPrint(
            '   - Request timestamp: ${DateTime.now().toIso8601String()}');
      }

      final requestBody = jsonEncode({'phone': phoneNumber});
      final uri = _buildUri(AppConfig.otpRequestEndpoint);

      if (kDebugMode && Environment.enableDebugLogging) {
        debugPrint('📋 OTPApiService: Request details:');
        debugPrint('   - Method: POST');
        debugPrint('   - Headers: Content-Type: application/json');
        debugPrint('   - Body structure: {"phone": "***"}');
        debugPrint('   - Full URL: $uri');
      }

      final response = await http
          .post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: requestBody,
      )
          .timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          if (kDebugMode && Environment.enableDebugLogging) {
            debugPrint('⏰ OTPApiService: Request timeout after 15 seconds');
          }
          throw Exception('Request timeout');
        },
      );

      // ✅ Enhanced debug logging for response
      if (kDebugMode && Environment.enableDebugLogging) {
        debugPrint('📥 OTPApiService: Received response from DEDI Server:');
        debugPrint('   - Status Code: ${response.statusCode}');
        debugPrint('   - Status Text: ${response.reasonPhrase ?? 'Unknown'}');
        debugPrint('   - Response Headers: ${response.headers}');
        debugPrint(
            '   - Response Body Length: ${response.body.length} characters');
        debugPrint(
            '   - Response timestamp: ${DateTime.now().toIso8601String()}');

        // Log response body with length limit for readability
        if (response.body.length <= 500) {
          debugPrint('   - Response Body: ${response.body}');
        } else {
          debugPrint(
              '   - Response Body (truncated): ${response.body.substring(0, 500)}...');
        }
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

      // Show debug toast for server error
      DebugToastService.showOTPError(
        operation: 'Request',
        error: errorMessage,
        statusCode: response.statusCode,
        responseBody: response.body,
      );

      throw Exception(errorMessage);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('OTPApiService: Request OTP error: $e');
      }

      // Show debug toast for network/timeout errors
      final errorStr = e.toString().toLowerCase();
      if (errorStr.contains('timeout')) {
        DebugToastService.showTimeoutError(
          operation: 'OTP Request',
          error: e.toString(),
          timeoutSeconds: 15,
        );
      } else if (errorStr.contains('network') ||
          errorStr.contains('connection')) {
        DebugToastService.showNetworkError(
          operation: 'OTP Request',
          error: e.toString(),
          url: _buildUri(AppConfig.otpRequestEndpoint).toString(),
        );
      } else {
        DebugToastService.showOTPError(
          operation: 'Request',
          error: e.toString(),
        );
      }

      rethrow;
    }
  }

  static Future<Map<String, dynamic>> verifyOTP(
    String phoneNumber,
    String code,
  ) async {
    try {
      // ✅ Enhanced debug logging for OTP verification
      if (kDebugMode && Environment.enableDebugLogging) {
        debugPrint(
            '🔐 OTPApiService: Starting OTP verification with DEDI Server');
        debugPrint('   - Operation: Verify OTP');
        debugPrint(
            '   - Phone (masked): ${phoneNumber.substring(0, 4)}****${phoneNumber.substring(phoneNumber.length - 2)}');
        debugPrint('   - Code (masked): ${code.substring(0, 2)}****');
        debugPrint('   - Endpoint: ${AppConfig.otpVerifyEndpoint}');
        debugPrint('   - Base URL: ${AppConfig.otpApiBaseUrl}');
        debugPrint('   - Timeout: 15 seconds');
        debugPrint(
            '   - Request timestamp: ${DateTime.now().toIso8601String()}');
      }

      final requestBody = jsonEncode({
        'phone': phoneNumber,
        'code': code,
      });
      final uri = _buildUri(AppConfig.otpVerifyEndpoint);

      if (kDebugMode && Environment.enableDebugLogging) {
        debugPrint('📋 OTPApiService: Verification request details:');
        debugPrint('   - Method: POST');
        debugPrint('   - Headers: Content-Type: application/json');
        debugPrint('   - Body structure: {"phone": "***", "code": "****"}');
        debugPrint('   - Full URL: $uri');
      }

      final response = await http
          .post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: requestBody,
      )
          .timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          if (kDebugMode && Environment.enableDebugLogging) {
            debugPrint(
                '⏰ OTPApiService: Verification request timeout after 15 seconds');
          }
          throw Exception('Request timeout');
        },
      );

      // ✅ Enhanced debug logging for response
      if (kDebugMode && Environment.enableDebugLogging) {
        debugPrint(
            '📥 OTPApiService: Received verification response from DEDI Server:');
        debugPrint('   - Status Code: ${response.statusCode}');
        debugPrint('   - Status Text: ${response.reasonPhrase ?? 'Unknown'}');
        debugPrint('   - Response Headers: ${response.headers}');
        debugPrint(
            '   - Response Body Length: ${response.body.length} characters');
        debugPrint(
            '   - Response timestamp: ${DateTime.now().toIso8601String()}');

        // Log response body with length limit for readability
        if (response.body.length <= 500) {
          debugPrint('   - Response Body: ${response.body}');
        } else {
          debugPrint(
              '   - Response Body (truncated): ${response.body.substring(0, 500)}...');
        }
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

      // Show debug toast for server error
      DebugToastService.showOTPError(
        operation: 'Verification',
        error: errorMessage,
        statusCode: response.statusCode,
        responseBody: response.body,
      );

      throw Exception(errorMessage);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('OTPApiService: Verify OTP error: $e');
      }

      // Show debug toast for network/timeout errors
      final errorStr = e.toString().toLowerCase();
      if (errorStr.contains('timeout')) {
        DebugToastService.showTimeoutError(
          operation: 'OTP Verification',
          error: e.toString(),
          timeoutSeconds: 15,
        );
      } else if (errorStr.contains('network') ||
          errorStr.contains('connection')) {
        DebugToastService.showNetworkError(
          operation: 'OTP Verification',
          error: e.toString(),
          url: _buildUri(AppConfig.otpVerifyEndpoint).toString(),
        );
      } else {
        DebugToastService.showOTPError(
          operation: 'Verification',
          error: e.toString(),
        );
      }

      rethrow;
    }
  }

  static Future<Map<String, dynamic>> getMatrixToken(
    String jwtToken,
    String phoneNumber,
  ) async {
    try {
      // ✅ Enhanced debug logging for Matrix token request
      if (kDebugMode && Environment.enableDebugLogging) {
        debugPrint(
            '🔑 OTPApiService: Starting Matrix token request with DEDI Server');
        debugPrint('   - Operation: Get Matrix Token');
        debugPrint(
            '   - Phone (masked): ${phoneNumber.substring(0, 4)}****${phoneNumber.substring(phoneNumber.length - 2)}');
        debugPrint(
            '   - JWT Token (masked): ${jwtToken.substring(0, 10)}...${jwtToken.substring(jwtToken.length - 10)}');
        debugPrint('   - Endpoint: ${AppConfig.otpMatrixTokenEndpoint}');
        debugPrint('   - Base URL: ${AppConfig.otpApiBaseUrl}');
        debugPrint('   - Timeout: 15 seconds');
        debugPrint(
            '   - Request timestamp: ${DateTime.now().toIso8601String()}');
      }

      final requestBody = jsonEncode({
        'jwt_token': jwtToken,
        'phone': phoneNumber,
      });
      final uri = _buildUri(AppConfig.otpMatrixTokenEndpoint);

      if (kDebugMode && Environment.enableDebugLogging) {
        debugPrint('📋 OTPApiService: Matrix token request details:');
        debugPrint('   - Method: POST');
        debugPrint(
            '   - Headers: Content-Type: application/json, Authorization: Bearer ***');
        debugPrint('   - Body structure: {"jwt_token": "***", "phone": "***"}');
        debugPrint('   - Full URL: $uri');
      }

      final response = await http
          .post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
        body: requestBody,
      )
          .timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          if (kDebugMode && Environment.enableDebugLogging) {
            debugPrint(
                '⏰ OTPApiService: Matrix token request timeout after 15 seconds');
          }
          throw Exception('Request timeout');
        },
      );

      // ✅ Enhanced debug logging for response
      if (kDebugMode && Environment.enableDebugLogging) {
        debugPrint(
            '📥 OTPApiService: Received Matrix token response from DEDI Server:');
        debugPrint('   - Status Code: ${response.statusCode}');
        debugPrint('   - Status Text: ${response.reasonPhrase ?? 'Unknown'}');
        debugPrint('   - Response Headers: ${response.headers}');
        debugPrint(
            '   - Response Body Length: ${response.body.length} characters');
        debugPrint(
            '   - Response timestamp: ${DateTime.now().toIso8601String()}');

        // Log response body with length limit for readability
        if (response.body.length <= 500) {
          debugPrint('   - Response Body: ${response.body}');
        } else {
          debugPrint(
              '   - Response Body (truncated): ${response.body.substring(0, 500)}...');
        }
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

      // Show debug toast for server error
      DebugToastService.showOTPError(
        operation: 'Matrix Token',
        error: errorMessage,
        statusCode: response.statusCode,
        responseBody: response.body,
      );

      throw Exception(errorMessage);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('OTPApiService: Get Matrix token error: $e');
      }

      // Show debug toast for network/timeout errors
      final errorStr = e.toString().toLowerCase();
      if (errorStr.contains('timeout')) {
        DebugToastService.showTimeoutError(
          operation: 'Matrix Token',
          error: e.toString(),
          timeoutSeconds: 15,
        );
      } else if (errorStr.contains('network') ||
          errorStr.contains('connection')) {
        DebugToastService.showNetworkError(
          operation: 'Matrix Token',
          error: e.toString(),
          url: _buildUri(AppConfig.otpMatrixTokenEndpoint).toString(),
        );
      } else {
        DebugToastService.showOTPError(
          operation: 'Matrix Token',
          error: e.toString(),
        );
      }

      rethrow;
    }
  }
}
