import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:fluffychat/config/environment.dart';
import 'package:fluffychat/domain/exception/auth/otp_exceptions.dart';
import 'package:fluffychat/services/models/otp_responses.dart';
import 'package:fluffychat/utils/debug_toast_service.dart';

const _otpBase = String.fromEnvironment(
  'OTP_BASE',
  defaultValue: 'https://tom.dedim.com.tr',
);
const _otpRequestEndpoint = '/otp/request';
const _otpVerifyEndpoint = '/otp/verify';
const _otpMatrixTokenEndpoint = '/otp/matrix-token';

/// Service for handling OTP-based authentication with the backend
///
/// This service provides three main operations:
/// 1. Request OTP code for a phone number
/// 2. Verify OTP code and get JWT token
/// 3. Exchange JWT for Matrix access token
///
/// Features:
/// - Automatic retry with exponential backoff for network errors
/// - Rate limit detection and handling
/// - Structured error responses with specific exception types
/// - Comprehensive debug logging
class OTPApiService {
  /// Maximum number of retry attempts for failed requests
  static const int maxRetries = 3;

  /// Initial delay before first retry
  static const Duration initialRetryDelay = Duration(seconds: 1);

  /// Request timeout duration
  static const Duration requestTimeout = Duration(seconds: 15);

  /// Builds a URI for the given endpoint
  static Uri _buildUri(String endpoint) {
    final uri = Uri.parse('$_otpBase$endpoint');

    if (kDebugMode && Environment.enableDebugLogging) {
      debugPrint('🌐 OTPApiService: Building URI for DEDI Server:');
      debugPrint('   - Base URL: $_otpBase');
      debugPrint('   - Endpoint: $endpoint');
      debugPrint('   - Full URI: $uri');
    }

    return uri;
  }

  /// Request OTP code for a phone number
  ///
  /// Sends a POST request to /otp/request with the phone number.
  /// In development mode, the response includes a dev_otp field for testing.
  ///
  /// Throws:
  /// - [InvalidPhoneNumberException] if phone format is invalid
  /// - [OTPRateLimitException] if too many requests
  /// - [OTPNetworkException] if network error
  /// - [OTPTimeoutException] if request times out
  /// - [OTPRequestFailedException] for other errors
  static Future<OTPRequestResponse> requestOTP(String phoneNumber) async {
    if (kDebugMode && Environment.enableDebugLogging) {
      debugPrint('📤 OTPApiService: Starting OTP request');
      debugPrint('   - Phone (masked): ${_maskPhone(phoneNumber)}');
      debugPrint('   - Timestamp: ${DateTime.now().toIso8601String()}');
    }

    return _executeWithRetry(() async {
      try {
        final response = await http
            .post(
          _buildUri(_otpRequestEndpoint),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'phone': phoneNumber}),
        )
            .timeout(
          requestTimeout,
          onTimeout: () {
            if (kDebugMode) debugPrint('⏰ OTPApiService: Request timeout');
            throw const OTPTimeoutException('Request timeout after 15 seconds');
          },
        );

        if (kDebugMode && Environment.enableDebugLogging) {
          debugPrint('📥 OTPApiService: Received response');
          debugPrint('   - Status: ${response.statusCode}');
          debugPrint('   - Body length: ${response.body.length} chars');
        }

        if (response.statusCode == 200 || response.statusCode == 201) {
          final data = jsonDecode(response.body) as Map<String, dynamic>;
          return OTPRequestResponse.fromJson(data);
        }

        throw _parseError(response);
      } on SocketException catch (e) {
        throw OTPNetworkException(
          'Network error: ${e.message}',
        );
      } on TimeoutException catch (_) {
        throw const OTPTimeoutException(
          'Request timeout after 15 seconds',
        );
      }
    }, operationName: 'OTP Request');
  }

  /// Verify OTP code and get JWT token
  ///
  /// Sends a POST request to /otp/verify with phone number and code.
  /// Returns a short-lived JWT token (valid for 5 minutes) that must be
  /// exchanged for a Matrix token.
  ///
  /// Throws:
  /// - [OTPInvalidException] if code is wrong
  /// - [OTPExpiredException] if code has expired
  /// - [OTPRateLimitException] if too many attempts
  /// - [OTPNetworkException] if network error
  /// - [OTPTimeoutException] if request times out
  static Future<OTPVerifyResponse> verifyOTP(
    String phoneNumber,
    String code,
  ) async {
    if (kDebugMode && Environment.enableDebugLogging) {
      debugPrint('🔐 OTPApiService: Starting OTP verification');
      debugPrint('   - Phone (masked): ${_maskPhone(phoneNumber)}');
      debugPrint('   - Code (masked): ${code.substring(0, 2)}****');
      debugPrint('   - Timestamp: ${DateTime.now().toIso8601String()}');
    }

    return _executeWithRetry(() async {
      try {
        final response = await http
            .post(
          _buildUri(_otpVerifyEndpoint),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'phone': phoneNumber, 'code': code}),
        )
            .timeout(
          requestTimeout,
          onTimeout: () {
            if (kDebugMode) debugPrint('⏰ OTPApiService: Verification timeout');
            throw const OTPTimeoutException(
                'Verification timeout after 15 seconds');
          },
        );

        if (kDebugMode && Environment.enableDebugLogging) {
          debugPrint('📥 OTPApiService: Received verification response');
          debugPrint('   - Status: ${response.statusCode}');
        }

        if (response.statusCode == 200 || response.statusCode == 201) {
          final data = jsonDecode(response.body) as Map<String, dynamic>;
          return OTPVerifyResponse.fromJson(data);
        }

        throw _parseError(response);
      } on SocketException catch (e) {
        throw OTPNetworkException(
          'Network error: ${e.message}',
        );
      } on TimeoutException catch (_) {
        throw const OTPTimeoutException(
          'Verification timeout after 15 seconds',
        );
      }
    }, operationName: 'OTP Verification');
  }

  /// Exchange JWT token for Matrix access token
  ///
  /// Sends a POST request to /otp/matrix-token with the JWT from OTP verification.
  /// Returns a permanent Matrix access token and connection details.
  ///
  /// Throws:
  /// - [MatrixTokenException] if token exchange fails
  /// - [OTPExpiredException] if JWT has expired
  /// - [OTPNetworkException] if network error
  /// - [OTPTimeoutException] if request times out
  static Future<MatrixTokenResponse> getMatrixToken(
    String jwtToken,
    String phoneNumber,
  ) async {
    if (kDebugMode && Environment.enableDebugLogging) {
      debugPrint('🔑 OTPApiService: Starting Matrix token request');
      debugPrint('   - Phone (masked): ${_maskPhone(phoneNumber)}');
      debugPrint('   - JWT (masked): ${_maskToken(jwtToken)}');
      debugPrint('   - Timestamp: ${DateTime.now().toIso8601String()}');
    }

    return _executeWithRetry(() async {
      try {
        var response = await http
            .post(
          _buildUri(_otpMatrixTokenEndpoint),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $jwtToken',
          },
          body: jsonEncode({'phone': phoneNumber}),
        )
            .timeout(
          requestTimeout,
          onTimeout: () {
            if (kDebugMode) debugPrint('⏰ OTPApiService: Matrix token timeout');
            throw const OTPTimeoutException(
                'Token request timeout after 15 seconds');
          },
        );

        if (response.statusCode == 401 || response.statusCode == 415) {
          // Fallback payload for stricter servers
          response = await http
              .post(
            _buildUri(_otpMatrixTokenEndpoint),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'phone': phoneNumber, 'jwt_token': jwtToken}),
          )
              .timeout(
            requestTimeout,
            onTimeout: () {
              if (kDebugMode) {
                debugPrint('⏰ OTPApiService: Matrix token timeout (fallback)');
              }
              throw const OTPTimeoutException(
                  'Token request timeout after 15 seconds');
            },
          );
        }

        if (kDebugMode && Environment.enableDebugLogging) {
          debugPrint('📥 OTPApiService: Received Matrix token response');
          debugPrint('   - Status: ${response.statusCode}');
          debugPrint('   - Body length: ${response.body.length} chars');
        }

        if (response.statusCode == 200 || response.statusCode == 201) {
          final data = jsonDecode(response.body) as Map<String, dynamic>;
          return MatrixTokenResponse.fromJson(data);
        }

        throw _parseError(response);
      } on SocketException catch (e) {
        throw OTPNetworkException(
          'Network error: ${e.message}',
        );
      } on TimeoutException catch (_) {
        throw const OTPTimeoutException(
          'Token request timeout after 15 seconds',
        );
      }
    }, operationName: 'Matrix Token');
  }

  /// Execute an operation with retry logic for network errors
  ///
  /// Retries the operation up to [maxRetries] times with exponential backoff.
  /// Only retries on network/timeout errors, not on validation errors.
  static Future<T> _executeWithRetry<T>(
    Future<T> Function() operation, {
    required String operationName,
  }) async {
    int attempt = 0;
    Duration delay = initialRetryDelay;

    while (true) {
      try {
        return await operation();
      } on OTPException catch (e) {
        attempt++;

        // Don't retry on validation errors or rate limits
        if (e is OTPInvalidException ||
            e is InvalidPhoneNumberException ||
            e is OTPRateLimitException ||
            e is OTPExpiredException) {
          if (kDebugMode) {
            debugPrint('❌ $operationName failed (no retry): ${e.message}');
          }
          _showDebugToast(operationName, e);
          rethrow;
        }

        // Retry on network/timeout errors
        if (e is OTPNetworkException || e is OTPTimeoutException) {
          if (attempt >= maxRetries) {
            if (kDebugMode) {
              debugPrint(
                  '❌ $operationName failed after $maxRetries attempts: ${e.message}');
            }
            _showDebugToast(operationName, e);
            rethrow;
          }

          if (kDebugMode) {
            debugPrint(
                '🔄 Retrying $operationName (attempt $attempt/$maxRetries) after ${delay.inSeconds}s');
          }

          await Future.delayed(delay);
          delay *= 2; // Exponential backoff
          continue;
        }

        // Other errors, rethrow
        _showDebugToast(operationName, e);
        rethrow;
      } catch (e) {
        if (kDebugMode) {
          debugPrint('❌ $operationName unexpected error: $e');
        }
        rethrow;
      }
    }
  }

  /// Parse error response and return appropriate exception
  static OTPException _parseError(http.Response response) {
    // Check for rate limiting
    if (response.statusCode == 429) {
      final retryAfter =
          int.tryParse(response.headers['retry-after'] ?? '60') ?? 60;
      return OTPRateLimitException(
        'Too many requests. Please wait $retryAfter seconds.',
        retryAfterSeconds: retryAfter,
        statusCode: response.statusCode,
      );
    }

    // Try to parse error message from response body
    String errorMessage = 'Request failed';
    String? errorCode;

    try {
      final errorData = jsonDecode(response.body) as Map<String, dynamic>;
      errorMessage = errorData['message'] as String? ??
          errorData['error'] as String? ??
          'Request failed';
      errorCode = errorData['error'] as String?;
    } catch (_) {
      // If JSON parsing fails, use default message
    }

    // Return appropriate exception based on status code
    switch (response.statusCode) {
      case 400:
        if (errorCode == 'INVALID_PHONE') {
          return InvalidPhoneNumberException(
            errorMessage,
            code: errorCode,
            statusCode: response.statusCode,
          );
        }
        return OTPInvalidException(
          errorMessage,
          code: errorCode,
          statusCode: response.statusCode,
        );

      case 401:
        if (errorCode == 'INVALID_CODE' ||
            errorCode == 'EXPIRED_CODE' ||
            errorMessage.toLowerCase().contains('expired')) {
          return OTPExpiredException(
            errorMessage,
            code: errorCode,
            statusCode: response.statusCode,
          );
        }
        return OTPInvalidException(
          errorMessage,
          code: errorCode,
          statusCode: response.statusCode,
        );

      case 500:
      case 502:
      case 503:
        return MatrixTokenException(
          errorMessage,
          code: errorCode,
          statusCode: response.statusCode,
        );

      default:
        return OTPRequestFailedException(
          errorMessage,
          code: errorCode,
          statusCode: response.statusCode,
        );
    }
  }

  /// Show debug toast for errors (if enabled)
  static void _showDebugToast(String operation, OTPException error) {
    if (error is OTPTimeoutException) {
      DebugToastService.showTimeoutError(
        operation: operation,
        error: error.message,
        timeoutSeconds: 15,
      );
    } else if (error is OTPNetworkException) {
      DebugToastService.showNetworkError(
        operation: operation,
        error: error.message,
        url: _otpBase,
      );
    } else if (error is OTPRateLimitException) {
      DebugToastService.showOTPError(
        operation: operation,
        error: 'Rate limit: wait ${error.retryAfterSeconds}s',
        statusCode: error.statusCode,
      );
    } else {
      DebugToastService.showOTPError(
        operation: operation,
        error: error.message,
        statusCode: error.statusCode,
      );
    }
  }

  /// Mask phone number for logging (show first 4 and last 2 digits)
  static String _maskPhone(String phone) {
    if (phone.length < 6) return '***';
    return '${phone.substring(0, 4)}****${phone.substring(phone.length - 2)}';
  }

  /// Mask token for logging (show first 10 and last 10 characters)
  static String _maskToken(String token) {
    if (token.length < 20) return '***';
    return '${token.substring(0, 10)}...${token.substring(token.length - 10)}';
  }
}
