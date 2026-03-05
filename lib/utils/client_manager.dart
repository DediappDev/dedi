import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:matrix/encryption/utils/key_verification.dart';
import 'package:matrix/matrix.dart';

import 'package:fluffychat/utils/custom_http_client.dart';
import 'package:fluffychat/utils/custom_image_resizer.dart';
import 'package:fluffychat/utils/matrix_sdk_extensions/flutter_hive_collections_database.dart';
import 'package:fluffychat/utils/platform_infos.dart';
import 'famedlysdk_store.dart';

abstract class ClientManager {
  static const String clientNamespace = 'im.fluffychat.store.clients';

  static Future<List<Client>> getClients({bool initialize = true}) async {
    final clientNames = <String>{};
    try {
      final rawClientNames = await Store().getItem(clientNamespace);
      if (rawClientNames != null) {
        final decodedClientNames = jsonDecode(rawClientNames);
        if (decodedClientNames is List) {
          for (final name in decodedClientNames) {
            if (name is String && name.trim().isNotEmpty) {
              clientNames.add(name.trim());
            }
          }
        } else {
          throw const FormatException(
            'Client namespace must be a JSON list',
          );
        }
      }
    } catch (e, s) {
      Logs().w('Client names in store are corrupted', e, s);
      await Store().deleteItem(clientNamespace);
    }
    if (clientNames.isEmpty) {
      clientNames.add(PlatformInfos.clientName);
      await Store().setItem(clientNamespace, jsonEncode(clientNames.toList()));
    }
    final clients = clientNames.map(createClient).toList();
    if (initialize) {
      for (final client in clients) {
        await _repairCorruptedPersistedClientRecord(client);
      }

      final corruptedClientNames = <String>{};
      await Future.wait(
        clients.map(
          (client) => client
              .init(
            waitForFirstSync: false,
            waitUntilLoadCompletedLoaded: false,
          )
              .catchError((e, s) async {
            Logs().e('Unable to initialize client', e, s);
            if (_isCorruptedClientStateError(e)) {
              corruptedClientNames.add(client.clientName);
              await client.clear().catchError((_, __) => null);
            }
          }),
        ),
      );

      for (final client in clients) {
        if (!_hasBrokenLoggedSession(client)) continue;
        corruptedClientNames.add(client.clientName);
        await client.clear().catchError((_, __) => null);
      }

      if (corruptedClientNames.isNotEmpty) {
        clientNames.removeWhere(corruptedClientNames.contains);
        clients.removeWhere(
          (client) => corruptedClientNames.contains(client.clientName),
        );
        if (clientNames.isEmpty) {
          clientNames.add(PlatformInfos.clientName);
          clients.add(createClient(PlatformInfos.clientName));
        }
        await Store()
            .setItem(clientNamespace, jsonEncode(clientNames.toList()));
      }
    }
    if (clients.length > 1 && clients.any((c) => !c.isLogged())) {
      final loggedOutClients = clients.where((c) => !c.isLogged()).toList();
      for (final client in loggedOutClients) {
        Logs().w(
          'Multi account is enabled but client ${client.userID} is not logged in. Removing...',
        );
        clientNames.remove(client.clientName);
        clients.remove(client);
      }
      await Store().setItem(clientNamespace, jsonEncode(clientNames.toList()));
    }
    return clients;
  }

  static bool _isCorruptedClientStateError(Object error) {
    final message = error.toString().toLowerCase();
    return message.contains("type 'null' is not a subtype of type 'string'") ||
        message.contains("type 'null' is not a subtype of type 'string?'") ||
        message.contains('no host specified in uri') ||
        message.contains('invalid argument(s): no host specified in uri');
  }

  static bool _hasBrokenLoggedSession(Client client) {
    if (!client.isLogged()) return false;
    final userId = client.userID;
    final accessToken = client.accessToken;
    final homeserver = client.homeserver;
    final hasValidHomeserver = homeserver != null &&
        homeserver.scheme.isNotEmpty &&
        homeserver.host.isNotEmpty;
    return userId == null ||
        userId.isEmpty ||
        accessToken == null ||
        accessToken.isEmpty ||
        !hasValidHomeserver;
  }

  static Future<void> _repairCorruptedPersistedClientRecord(
    Client client,
  ) async {
    try {
      final database = await FlutterHiveCollectionsDatabase.databaseBuilder(
        client,
      );
      final account = await database.getClient(client.clientName);
      if (account == null) return;
      if (_isInvalidPersistedClientRecord(account)) {
        Logs().w(
          'Client ${client.clientName} has invalid persisted session. Clearing local matrix database before init.',
        );
        await database
            .clear(supportDeleteCollections: !PlatformInfos.isWeb)
            .catchError((_, __) => null);
      }
    } catch (e, s) {
      Logs().w(
        'Unable to preflight persisted client record for ${client.clientName}',
        e,
        s,
      );
    }
  }

  static bool _isInvalidPersistedClientRecord(Map<String, dynamic> account) {
    final homeserverRaw = account['homeserver_url'];
    final tokenRaw = account['token'];
    final userIdRaw = account['user_id'];
    if (homeserverRaw is! String || homeserverRaw.trim().isEmpty) return true;
    if (tokenRaw is! String || tokenRaw.trim().isEmpty) return true;
    if (userIdRaw is! String || userIdRaw.trim().isEmpty) return true;
    final homeserver = Uri.tryParse(homeserverRaw.trim());
    return homeserver == null ||
        homeserver.scheme.isEmpty ||
        homeserver.host.isEmpty;
  }

  static Future<void> addClientNameToStore(String clientName) async {
    if (clientName.trim().isEmpty) return;
    final clientNamesList = <String>{};
    final rawClientNames = await Store().getItem(clientNamespace);
    if (rawClientNames != null) {
      final decoded = jsonDecode(rawClientNames);
      if (decoded is List) {
        for (final name in decoded) {
          if (name is String && name.trim().isNotEmpty) {
            clientNamesList.add(name.trim());
          }
        }
      }
    }
    clientNamesList.add(clientName.trim());
    await Store()
        .setItem(clientNamespace, jsonEncode(clientNamesList.toList()));
  }

  static Future<void> removeClientNameFromStore(String clientName) async {
    final clientNamesList = <String>{};
    final rawClientNames = await Store().getItem(clientNamespace);
    if (rawClientNames != null) {
      final decoded = jsonDecode(rawClientNames);
      if (decoded is List) {
        for (final name in decoded) {
          if (name is String && name.trim().isNotEmpty) {
            clientNamesList.add(name.trim());
          }
        }
      }
    }
    clientNamesList.remove(clientName.trim());
    await Store()
        .setItem(clientNamespace, jsonEncode(clientNamesList.toList()));
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
