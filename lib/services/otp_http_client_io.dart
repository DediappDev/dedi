import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

import '../config/app_config.dart';

http.Client? _cachedOtpClient;
Completer<http.Client>? _otpClientCompleter;

Future<http.Client> buildOtpHttpClient() async {
  if (_cachedOtpClient != null) {
    return _cachedOtpClient!;
  }

  if (_otpClientCompleter != null) {
    return _otpClientCompleter!.future;
  }

  if (!kDebugMode) {
    return http.Client();
  }

  if (!Platform.isIOS && !Platform.isAndroid && !Platform.isMacOS) {
    return http.Client();
  }

  final completer = Completer<http.Client>();
  _otpClientCompleter = completer;

  () async {
    try {
      // In debug mode, bypass certificate verification for development server
      final httpClient = HttpClient()
        ..connectionTimeout = const Duration(seconds: 20)
        ..badCertificateCallback = (cert, host, port) {
          if (kDebugMode) {
            debugPrint(
              'OTPHttpClientFactory: Bypassing certificate verification for $host:$port (debug mode).',
            );
            return true; // Accept all certificates in debug mode
          }
          return false;
        };

      final ioClient = IOClient(httpClient);
      _cachedOtpClient = ioClient;
      completer.complete(ioClient);
    } catch (error, stackTrace) {
      if (kDebugMode) {
        debugPrint(
          'OTPHttpClientFactory: Failed to create OTP client. Falling back to default client. Error: $error',
        );
        debugPrint('$stackTrace');
      }
      completer.complete(http.Client());
    } finally {
      _otpClientCompleter = null;
    }
  }();

  return completer.future;
}
