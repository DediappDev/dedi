import 'package:http/http.dart' as http;

import 'otp_http_client_stub.dart'
    if (dart.library.io) 'otp_http_client_io.dart';

Future<http.Client> createOtpHttpClient() {
  return buildOtpHttpClient();
}
