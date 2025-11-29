import 'package:fluffychat/data/network/service_path.dart';

class TomEndpoint {
  static final ServicePath recoveryWordsServicePath = ServicePath(
    '/_dedi/recoveryWords',
  );

  static final ServicePath addressbookServicePath = ServicePath(
    '/_dedi/addressbook',
  );

  static final ServicePath invitationServicePath = ServicePath(
    '/invite',
  );

  static final ServicePath generateInvitationServicePath = ServicePath(
    '/invite/generate',
  );

  static final ServicePath userInfoServicePath = ServicePath(
    '/user_info',
  );

  static const String dediRootPath = '/_dedi';

  static const String dediAPIVersion = 'v1';
}

extension ServicePathTom on ServicePath {
  String generateTomEndpoint({
    String rootPath = TomEndpoint.dediRootPath,
    String apiVersion = TomEndpoint.dediAPIVersion,
  }) {
    return '$rootPath/$apiVersion$path';
  }

  String generateTomUserInfoEndpoint(
    String userId, {
    String rootPath = TomEndpoint.dediRootPath,
    String apiVersion = TomEndpoint.dediAPIVersion,
  }) {
    return '$rootPath/$apiVersion$path/$userId';
  }
}
