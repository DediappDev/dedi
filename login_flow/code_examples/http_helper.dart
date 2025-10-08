/// HTTP Helper for Authentication API
/// Based on: lib/utils/http_helper.dart
///
/// This helper class provides:
/// - Cross-platform HTTP requests (Mobile, Web, Desktop)
/// - CORS handling for web platforms
/// - Retry mechanisms and error handling
/// - OTP-specific API methods

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:universal_html/html.dart' as html;

class HttpHelper {
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://api.yourapp.com',
  );

  /// Make a POST request to the server
  /// Handles both mobile and web platforms with CORS support
  static Future<http.Response> post({
    required String endpoint,
    required Map<String, String> headers,
    required String body,
  }) async {
    final url = '$baseUrl$endpoint';

    if (kDebugMode) {
      print('[HttpHelper] POST to: $url');
      print('[HttpHelper] Headers: $headers');
      print('[HttpHelper] Body: $body');
    }

    if (kIsWeb) {
      try {
        // Use XMLHttpRequest for better CORS support on web
        final request = html.HttpRequest();
        request.open('POST', url);

        // Set headers
        headers.forEach((key, value) {
          request.setRequestHeader(key, value);
        });

        // Send request
        request.send(body);

        // Wait for completion - check both success and error
        await Future.any([
          request.onLoad.first,
          request.onError.first,
        ]);

        final responseText = request.responseText ?? '';
        final statusCode = request.status ?? 0;

        if (kDebugMode) {
          print('[HttpHelper] Web response: $statusCode');
          print('[HttpHelper] Web response body: $responseText');
          print('[HttpHelper] Ready state: ${request.readyState}');
        }

        if (statusCode == 0) {
          throw Exception('Network error or CORS issue - status code 0');
        }

        return http.Response(responseText, statusCode);
      } catch (e) {
        if (kDebugMode) {
          print('[HttpHelper] Web error: $e');
        }
        rethrow;
      }
    } else {
      // Standard HTTP for non-web platforms
      try {
        final response = await http.post(
          Uri.parse(url),
          headers: headers,
          body: body,
        ).timeout(
          const Duration(seconds: 30),
          onTimeout: () {
            throw Exception('Request timeout');
          },
        );

        if (kDebugMode) {
          print('[HttpHelper] Response: ${response.statusCode}');
          print('[HttpHelper] Response body: ${response.body}');
        }

        return response;
      } catch (e) {
        if (kDebugMode) {
          print('[HttpHelper] Request error: $e');
        }
        rethrow;
      }
    }
  }

  /// Make a GET request to the server
  static Future<http.Response> get({
    required String endpoint,
    Map<String, String>? headers,
  }) async {
    final url = '$baseUrl$endpoint';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: headers ?? {},
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw Exception('Request timeout');
        },
      );

      if (kDebugMode) {
        print('[HttpHelper] GET $url: ${response.statusCode}');
      }

      return response;
    } catch (e) {
      if (kDebugMode) {
        print('[HttpHelper] GET error: $e');
      }
      rethrow;
    }
  }

  /// Send OTP request to phone number
  /// Returns: { "status": "sent", "dev_otp": "123456" } (dev_otp only in development)
  static Future<Map<String, dynamic>> sendOtpRequest(String phone) async {
    try {
      if (kDebugMode) {
        print('[HttpHelper] Sending OTP request');
        print('[HttpHelper] Phone: $phone');
      }

      // Use text/plain content type to avoid preflight OPTIONS request
      final response = await post(
        endpoint: '/otp/request',
        headers: {
          'Content-Type': kIsWeb ? 'text/plain' : 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({'phone': phone}),
      );

      if (kDebugMode) {
        print('[HttpHelper] OTP request response: ${response.statusCode}');
        print('[HttpHelper] Response body: ${response.body}');
      }

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        return data;
      } else {
        // Try to parse error message
        try {
          final errorData = json.decode(response.body);
          throw Exception(errorData['message'] ?? 'OTP request failed');
        } catch (_) {
          throw Exception('OTP request failed: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('[HttpHelper] OTP request error: $e');
      }
      rethrow;
    }
  }

  /// Verify OTP code
  /// Returns: { "access_token": "jwt...", "mxid": "@user:domain.com", "user_id": "@user:domain.com" }
  static Future<Map<String, dynamic>> verifyOtp(String phone, String code) async {
    try {
      if (kDebugMode) {
        print('[HttpHelper] Verifying OTP');
        print('[HttpHelper] Phone: $phone, Code: $code');
      }

      final response = await post(
        endpoint: '/otp/verify',
        headers: {
          'Content-Type': kIsWeb ? 'text/plain' : 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'phone': phone,
          'code': code,
        }),
      );

      if (kDebugMode) {
        print('[HttpHelper] OTP verify response: ${response.statusCode}');
        print('[HttpHelper] Response body: ${response.body}');
      }

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        return data;
      } else {
        // Try to parse error message
        try {
          final errorData = json.decode(response.body);
          throw Exception(errorData['message'] ?? 'Invalid OTP code');
        } catch (_) {
          throw Exception('OTP verification failed: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('[HttpHelper] OTP verify error: $e');
      }
      rethrow;
    }
  }

  /// Exchange JWT token for Matrix credentials
  /// Returns: { "access_token": "matrix_token", "mxid": "@user:matrix.domain", "device_id": "DEVICE123" }
  static Future<Map<String, dynamic>> getMatrixToken({
    required String jwtToken,
    required String phoneNumber,
  }) async {
    try {
      if (kDebugMode) {
        print('[HttpHelper] Requesting Matrix token');
      }

      final requestBody = {
        'jwt_token': jwtToken,
        'phone': phoneNumber, // Backend can use this if JWT doesn't have phone_number claim
      };

      final response = await post(
        endpoint: '/otp/matrix-token',
        headers: {
          'Content-Type': kIsWeb ? 'text/plain' : 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
        body: json.encode(requestBody),
      );

      if (kDebugMode) {
        print('[HttpHelper] Matrix token response: ${response.statusCode}');
        print('[HttpHelper] Response body: ${response.body}');
      }

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        return data;
      } else {
        // Try to parse error message
        try {
          final errorData = json.decode(response.body);
          throw Exception(errorData['error'] ?? 'Matrix token request failed');
        } catch (_) {
          throw Exception('Matrix token request failed: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('[HttpHelper] Matrix token request error: $e');
      }
      rethrow;
    }
  }

  /// Generic method for making authenticated requests
  static Future<http.Response> authenticatedRequest({
    required String method,
    required String endpoint,
    required String accessToken,
    Map<String, String>? additionalHeaders,
    String? body,
  }) async {
    final headers = {
      'Authorization': 'Bearer $accessToken',
      'Accept': 'application/json',
      if (body != null) 'Content-Type': 'application/json',
      ...?additionalHeaders,
    };

    switch (method.toUpperCase()) {
      case 'GET':
        return get(endpoint: endpoint, headers: headers);
      case 'POST':
        return post(
          endpoint: endpoint,
          headers: headers,
          body: body ?? '',
        );
      default:
        throw Exception('Unsupported HTTP method: $method');
    }
  }

  /// Utility method to handle API errors consistently
  static Exception handleApiError(http.Response response) {
    try {
      final errorData = json.decode(response.body);
      final message = errorData['message'] ?? errorData['error'] ?? 'API request failed';
      return Exception('$message (${response.statusCode})');
    } catch (_) {
      return Exception('API request failed: ${response.statusCode}');
    }
  }

  /// Check if the response indicates success
  static bool isSuccessResponse(http.Response response) {
    return response.statusCode >= 200 && response.statusCode < 300;
  }

  /// Parse JSON response safely
  static Map<String, dynamic>? parseJsonResponse(http.Response response) {
    try {
      return json.decode(response.body) as Map<String, dynamic>;
    } catch (e) {
      if (kDebugMode) {
        print('[HttpHelper] Failed to parse JSON response: $e');
        print('[HttpHelper] Response body: ${response.body}');
      }
      return null;
    }
  }
}

/// Custom exceptions for specific error types
class OtpException implements Exception {
  final String message;
  final int? statusCode;

  OtpException(this.message, [this.statusCode]);

  @override
  String toString() => 'OtpException: $message${statusCode != null ? ' ($statusCode)' : ''}';
}

class NetworkException implements Exception {
  final String message;

  NetworkException(this.message);

  @override
  String toString() => 'NetworkException: $message';
}

class AuthenticationException implements Exception {
  final String message;

  AuthenticationException(this.message);

  @override
  String toString() => 'AuthenticationException: $message';
}