import 'dart:convert';

import 'package:dio/dio.dart';

class DioErrorMessageExtractor {
  static String? extract(Object? error) {
    if (error is DioException) {
      return extractFromDio(error);
    }
    return null;
  }

  static String? extractFromDio(DioException exception) {
    final data = exception.response?.data;
    final messageFromBody = _extractFromDynamic(data);
    if (messageFromBody != null) {
      return messageFromBody;
    }

    return _clean(exception.response?.statusMessage);
  }

  static String? _extractFromDynamic(dynamic data) {
    if (data == null) return null;

    if (data is String) {
      final text = _clean(data);
      if (text == null) return null;
      try {
        final decoded = jsonDecode(text);
        final nestedMessage = _extractFromDynamic(decoded);
        if (nestedMessage != null) {
          return nestedMessage;
        }
      } catch (_) {
        // Keep plain string response as a fallback.
      }
      return text;
    }

    if (data is Map) {
      const preferredKeys = [
        'message',
        'error_description',
        'error',
        'detail',
        'reason',
        'title',
      ];

      for (final key in preferredKeys) {
        final value = data[key];
        final message = _extractFromDynamic(value);
        if (message != null) {
          return message;
        }
      }

      for (final value in data.values) {
        final message = _extractFromDynamic(value);
        if (message != null) {
          return message;
        }
      }
      return null;
    }

    if (data is List) {
      for (final item in data) {
        final message = _extractFromDynamic(item);
        if (message != null) {
          return message;
        }
      }
      return null;
    }

    return _clean('$data');
  }

  static String? _clean(String? value) {
    if (value == null) return null;
    final trimmed = value.trim();
    if (trimmed.isEmpty || trimmed.toLowerCase() == 'null') {
      return null;
    }
    return trimmed;
  }
}
