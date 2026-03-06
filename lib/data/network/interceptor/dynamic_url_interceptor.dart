import 'package:dio/dio.dart';

class DynamicUrlInterceptors extends InterceptorsWrapper {
  String? _baseUrl;

  void changeBaseUrl(String? url) {
    if (!_isValidBaseUrl(url)) {
      return;
    }
    _baseUrl = url;
  }

  String? get baseUrl => _baseUrl;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_isValidBaseUrl(_baseUrl)) {
      options.baseUrl = _baseUrl!;
    }
    super.onRequest(options, handler);
  }

  bool _isValidBaseUrl(String? url) {
    if (url == null || url.trim().isEmpty) {
      return false;
    }
    final uri = Uri.tryParse(url);
    if (uri == null) {
      return false;
    }
    return (uri.scheme == 'http' || uri.scheme == 'https') &&
        uri.host.isNotEmpty;
  }
}
