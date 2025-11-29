import 'package:fluffychat/data/network/service_path.dart';

class IdentityEndpoint {
  static const String matrixIdentityRootPath = '/_matrix/identity';
  static const String matrixIdentityAPIVersion = 'v2';

  static const String dediIdentityRootPath = '/_dedi/identity';
  static const String dediIdentityAPIVersion = 'v1';

  static final ServicePath matchUserIdServicePath = ServicePath(
    '/lookup/match',
  );
  static final ServicePath matchListUserIdsServicePath = ServicePath(
    '/lookup',
  );
  static final ServicePath hashDetailsServicePath = ServicePath(
    '/hash_details',
  );
  static final ServicePath accountRegisterServicePath = ServicePath(
    '/account/register',
  );
}

extension ServicePathExtensions on ServicePath {
  String generateDediIdentityEndpoint({
    String rootPath = IdentityEndpoint.dediIdentityRootPath,
    String apiVersion = IdentityEndpoint.dediIdentityAPIVersion,
  }) {
    return '$rootPath/$apiVersion$path';
  }

  String generateMatrixIdentityEndpoint({
    String rootPath = IdentityEndpoint.matrixIdentityRootPath,
    String apiVersion = IdentityEndpoint.matrixIdentityAPIVersion,
  }) {
    return '$rootPath/$apiVersion$path';
  }
}
