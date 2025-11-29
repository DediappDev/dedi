import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import '../config/app_config.dart';

/// Service for showing debug toasts with detailed error information
/// Only shows toasts when debug mode is enabled
class DebugToastService {
  /// Shows a debug toast with detailed error information
  /// Only displays when AppConfig.enableDebugToasts is true
  static void showDebugError({
    required String title,
    required String error,
    String? context,
    int? statusCode,
    String? responseBody,
  }) {
    // Debug: Always show a test toast to verify the service is working
    if (kDebugMode) {
      debugPrint(
          '🐛 DebugToastService: enableDebugToasts = ${AppConfig.enableDebugToasts}');
    }

    if (!AppConfig.enableDebugToasts) {
      if (kDebugMode) {
        debugPrint('🐛 DebugToastService: Debug toasts are disabled');
      }
      return;
    }

    if (kDebugMode) {
      debugPrint('🐛 Debug Toast: $title');
      debugPrint('🐛 Error: $error');
      if (context != null) debugPrint('🐛 Context: $context');
      if (statusCode != null) debugPrint('🐛 Status Code: $statusCode');
      if (responseBody != null) debugPrint('🐛 Response Body: $responseBody');
    }

    // Build detailed error message
    final buffer = StringBuffer();
    buffer.writeln('🐛 $title');
    buffer.writeln('Error: $error');

    if (context != null) {
      buffer.writeln('Context: $context');
    }

    if (statusCode != null) {
      buffer.writeln('Status: $statusCode');
    }

    if (responseBody != null && responseBody.isNotEmpty) {
      // Truncate response body if too long
      final truncatedBody = responseBody.length > 200
          ? '${responseBody.substring(0, 200)}...'
          : responseBody;
      buffer.writeln('Response: $truncatedBody');
    }

    // Show toast with detailed information
    Fluttertoast.showToast(
      msg: buffer.toString(),
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.red.shade700,
      textColor: Colors.white,
      fontSize: 12.0,
    );
  }

  /// Shows a debug toast for OTP API errors
  static void showOTPError({
    required String operation,
    required String error,
    int? statusCode,
    String? responseBody,
  }) {
    showDebugError(
      title: 'OTP $operation Failed',
      error: error,
      context: 'Phone number authentication',
      statusCode: statusCode,
      responseBody: responseBody,
    );
  }

  /// Shows a debug toast for network errors
  static void showNetworkError({
    required String operation,
    required String error,
    String? url,
  }) {
    showDebugError(
      title: 'Network $operation Failed',
      error: error,
      context: url != null ? 'URL: $url' : 'Network request',
    );
  }

  /// Shows a debug toast for SSL/TLS errors
  static void showSslError({
    required String operation,
    required String error,
    required String url,
  }) {
    showDebugError(
      title: 'SSL $operation Failed',
      error: error,
      context: 'URL: $url',
    );
  }

  /// Shows a debug toast for timeout errors
  static void showTimeoutError({
    required String operation,
    required String error,
    int? timeoutSeconds,
  }) {
    showDebugError(
      title: 'Timeout $operation Failed',
      error: error,
      context: timeoutSeconds != null
          ? 'Timeout: ${timeoutSeconds}s'
          : 'Request timeout',
    );
  }

  /// ✅ Shows a debug toast for successful operations
  static void showSuccess({
    required String title,
    required String message,
    String? context,
  }) {
    if (!AppConfig.enableDebugToasts) {
      if (kDebugMode) {
        debugPrint('🐛 DebugToastService: Debug toasts are disabled');
      }
      return;
    }

    if (kDebugMode) {
      debugPrint('✅ Debug Success Toast: $title - $message');
      if (context != null) debugPrint('✅ Context: $context');
    }

    // Build success message
    final buffer = StringBuffer();
    buffer.writeln('✅ $title');
    buffer.writeln(message);

    if (context != null) {
      buffer.writeln('Context: $context');
    }

    // Show success toast with green background
    Fluttertoast.showToast(
      msg: buffer.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.green.shade700,
      textColor: Colors.white,
      fontSize: 12.0,
    );
  }

  /// ✅ Shows a debug toast for informational messages
  static void showInfo({
    required String title,
    required String message,
    String? context,
  }) {
    if (!AppConfig.enableDebugToasts) {
      if (kDebugMode) {
        debugPrint('🐛 DebugToastService: Debug toasts are disabled');
      }
      return;
    }

    if (kDebugMode) {
      debugPrint('ℹ️ Debug Info Toast: $title - $message');
      if (context != null) debugPrint('ℹ️ Context: $context');
    }

    // Build info message
    final buffer = StringBuffer();
    buffer.writeln('ℹ️ $title');
    buffer.writeln(message);

    if (context != null) {
      buffer.writeln('Context: $context');
    }

    // Show info toast with blue background
    Fluttertoast.showToast(
      msg: buffer.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.blue.shade700,
      textColor: Colors.white,
      fontSize: 12.0,
    );
  }

  /// ✅ Shows a debug toast for configuration events
  static void showConfigurationInfo({
    required String event,
    required String details,
  }) {
    showInfo(
      title: 'Configuration $event',
      message: details,
      context: 'DEDI Server Configuration',
    );
  }

  /// ✅ Shows a debug toast for API operation success
  static void showApiSuccess({
    required String operation,
    required String result,
    String? endpoint,
  }) {
    showSuccess(
      title: 'API $operation Success',
      message: result,
      context: endpoint != null ? 'Endpoint: $endpoint' : 'API Operation',
    );
  }
}
