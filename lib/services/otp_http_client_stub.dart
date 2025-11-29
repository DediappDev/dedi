import 'package:http/http.dart' as http;

Future<http.Client> buildOtpHttpClient() async {
  return http.Client();
}
