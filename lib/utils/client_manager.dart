import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:matrix/encryption/utils/key_verification.dart';
import 'package:matrix/matrix.dart';

import 'package:fluffychat/utils/custom_http_client.dart';
import 'package:fluffychat/utils/custom_image_resizer.dart';
import 'package:fluffychat/utils/matrix_session_hydrator.dart';
import 'package:fluffychat/utils/matrix_sdk_extensions/flutter_hive_collections_database.dart';
import 'package:fluffychat/utils/platform_infos.dart';
import 'package:fluffychat/services/session_credentials_storage.dart';
import 'famedlysdk_store.dart';

abstract class ClientManager {
  static const String clientNamespace = 'im.fluffychat.store.clients';

  static Future<List<Client>> getClients({bool initialize = true}) async {
    final clientNames = <String>{};
    try {
      final rawClientNames = await Store().getItem(clientNamespace);
      if (rawClientNames != null) {
        final clientNamesList =
            (jsonDecode(rawClientNames) as List).cast<String>();
        clientNames.addAll(clientNamesList);
      }
    } catch (e, s) {
      Logs().w('Client names in store are corrupted', e, s);
      await Store().deleteItem(clientNamespace);
    }
    final signedOutClientNames =
        await SessionCredentialsStorage.loadSignedOutClientNames();
    clientNames.removeWhere(signedOutClientNames.contains);

    final sessionsByClientName =
        await SessionCredentialsStorage.loadAllByClientName();
    if (sessionsByClientName.isNotEmpty) {
      final missingClientNames = sessionsByClientName.keys
          .where(
            (clientName) =>
                !clientNames.contains(clientName) &&
                !signedOutClientNames.contains(clientName),
          )
          .toList();
      if (missingClientNames.isNotEmpty) {
        clientNames.addAll(missingClientNames);
        await Store()
            .setItem(clientNamespace, jsonEncode(clientNames.toList()));
      }
    }
    if (clientNames.isEmpty) {
      clientNames.add(PlatformInfos.clientName);
      await Store().setItem(clientNamespace, jsonEncode(clientNames.toList()));
    }

    final clients = clientNames.map(createClient).toList();
    if (initialize) {
      await Future.wait(
        clients.map(
          (client) => client
              .init(
                waitForFirstSync: false,
                waitUntilLoadCompletedLoaded: false,
              )
              .catchError(
                (e, s) => Logs().e('Unable to initialize client', e, s),
              ),
        ),
      );

      for (final client in clients.where((c) => !c.isLogged())) {
        final session = sessionsByClientName[client.clientName];
        if (session == null ||
            signedOutClientNames.contains(client.clientName)) {
          continue;
        }
        try {
          await MatrixSessionHydrator.fromAccessToken(
            client: client,
            homeserverBaseUrl: session.homeserver,
            userId: session.userId,
            accessToken: session.accessToken,
            deviceId: session.deviceId,
            verifyHomeserver: false,
            startSync: false,
          );
          Logs().i(
            'Restored session from secure storage for ${client.clientName} (${session.userId})',
          );
        } catch (e, s) {
          Logs().w(
            'Failed to restore session for ${client.clientName}',
            e,
            s,
          );
        }
      }
    }
    if (clients.length > 1 && clients.any((c) => !c.isLogged())) {
      final loggedOutClients = clients.where((c) => !c.isLogged()).toList();
      for (final client in loggedOutClients) {
        Logs().w(
          'Multi account client ${client.clientName} is not logged in. Keeping client entry until explicit sign out.',
        );
      }
    }
    return clients;
  }

  static Future<void> addClientNameToStore(String clientName) async {
    final clientNamesList = <String>[];
    final rawClientNames = await Store().getItem(clientNamespace);
    if (rawClientNames != null) {
      final stored = (jsonDecode(rawClientNames) as List).cast<String>();
      clientNamesList.addAll(stored);
    }
    if (!clientNamesList.contains(clientName)) {
      clientNamesList.add(clientName);
    }
    await Store().setItem(clientNamespace, jsonEncode(clientNamesList));
  }

  static Future<void> removeClientNameFromStore(String clientName) async {
    final clientNamesList = <String>[];
    final rawClientNames = await Store().getItem(clientNamespace);
    if (rawClientNames != null) {
      final stored = (jsonDecode(rawClientNames) as List).cast<String>();
      clientNamesList.addAll(stored);
    }
    clientNamesList.removeWhere((name) => name == clientName);
    await Store().setItem(clientNamespace, jsonEncode(clientNamesList));
  }

  static NativeImplementations get nativeImplementations => kIsWeb
      ? const NativeImplementationsDummy()
      : NativeImplementationsIsolate(compute);

  static Client createClient(String clientName) {
    return Client(
      clientName,
      httpClient:
          PlatformInfos.isAndroid ? CustomHttpClient.createHTTPClient() : null,
      verificationMethods: {
        KeyVerificationMethod.numbers,
        if (kIsWeb || PlatformInfos.isMobile || PlatformInfos.isLinux)
          KeyVerificationMethod.emoji,
      },
      importantStateEvents: <String>{
        // To make room emotes work
        'im.ponies.room_emotes',
        // To check which story room we can post in
        EventTypes.RoomPowerLevels,
      },
      logLevel: kReleaseMode ? Level.warning : Level.verbose,
      databaseBuilder: FlutterHiveCollectionsDatabase.databaseBuilder,
      supportedLoginTypes: {
        AuthenticationTypes.password,
        if (PlatformInfos.isMobile ||
            PlatformInfos.isWeb ||
            PlatformInfos.isMacOS)
          AuthenticationTypes.sso,
      },
      nativeImplementations: nativeImplementations,
      customImageResizer: PlatformInfos.isMobile ? customImageResizer : null,
    );
  }
}
