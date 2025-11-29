import 'package:fluffychat/domain/model/app_twake_information.dart';
import 'package:fluffychat/domain/model/common_settings_information.dart';
import 'package:fluffychat/domain/model/extensions/homeserver_summary_extensions.dart';
import 'package:fluffychat/domain/model/tom_server_information.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart';

void main() {
  group('extract tom server information', () {
    test('homeserver summary include "t.server" information', () {
      final homeserver = HomeserverSummary(
        discoveryInformation: DiscoveryInformation(
          mHomeserver: HomeserverInformation(
            baseUrl: Uri.parse('https://matrix.dedim.com.tr'),
          ),
          mIdentityServer: IdentityServerInformation(
            baseUrl: Uri.parse('https://tom.dedim.com.tr/'),
          ),
          additionalProperties: {
            't.server': {
              'base_url': 'https://tom.dedim.com.tr/',
              'server_name': 'dedim.com.tr',
            },
          },
        ),
        versions: GetVersionsResponse(
          versions: ['r1.6.0'],
          unstableFeatures: {},
        ),
        loginFlows: [
          LoginFlow(type: 'm.login.sso'),
          LoginFlow(type: 'm.login.token'),
          LoginFlow(type: 'm.login.application_service'),
        ],
      );

      final expected = ToMServerInformation(
        baseUrl: Uri.parse('https://tom.dedim.com.tr/'),
        serverName: 'dedim.com.tr',
      );

      expect(homeserver.tomServer, equals(expected));
    });

    test('homeserver summary not include "t.server" information', () {
      final homeserver = HomeserverSummary(
        discoveryInformation: DiscoveryInformation(
          mHomeserver: HomeserverInformation(
            baseUrl: Uri.parse('https://matrix.dedim.com.tr'),
          ),
          mIdentityServer: IdentityServerInformation(
            baseUrl: Uri.parse('https://tom.dedim.com.tr/'),
          ),
          additionalProperties: {
            't.server-2': {
              'base_url': 'https://tom.dedim.com.tr/',
              'server_name': 'dedim.com.tr',
            },
          },
        ),
        versions: GetVersionsResponse(
          versions: ['r1.6.0'],
          unstableFeatures: {},
        ),
        loginFlows: [
          LoginFlow(type: 'm.login.sso'),
          LoginFlow(type: 'm.login.token'),
          LoginFlow(type: 'm.login.application_service'),
        ],
      );

      expect(homeserver.tomServer, isNull);
    });

    test('homeserver summary but additional properties is null', () {
      final homeserver = HomeserverSummary(
        discoveryInformation: DiscoveryInformation(
          mHomeserver: HomeserverInformation(
            baseUrl: Uri.parse('https://matrix.dedim.com.tr'),
          ),
          mIdentityServer: IdentityServerInformation(
            baseUrl: Uri.parse('https://tom.dedim.com.tr/'),
          ),
        ),
        versions: GetVersionsResponse(
          versions: ['r1.6.0'],
          unstableFeatures: {},
        ),
        loginFlows: [
          LoginFlow(type: 'm.login.sso'),
          LoginFlow(type: 'm.login.token'),
          LoginFlow(type: 'm.login.application_service'),
        ],
      );

      expect(homeserver.tomServer, isNull);
    });
  });

  group('extract app.dedi.chat information', () {
    test('homeserver summary include "app.dedi.chat" information', () {
      final homeserver = HomeserverSummary(
        discoveryInformation: DiscoveryInformation(
          mHomeserver: HomeserverInformation(
            baseUrl: Uri.parse('https://matrix.dedim.com.tr'),
          ),
          mIdentityServer: IdentityServerInformation(
            baseUrl: Uri.parse('https://app.dedim.com.tr/'),
          ),
          additionalProperties: {
            'app.dedi.chat': {
              'common_settings': {
                'enabled': true,
                'application_url': 'https://app.dedim.com.tr/',
              },
            },
          },
        ),
        versions: GetVersionsResponse(
          versions: ['r1.6.0'],
          unstableFeatures: {},
        ),
        loginFlows: [
          LoginFlow(type: 'm.login.sso'),
          LoginFlow(type: 'm.login.token'),
          LoginFlow(type: 'm.login.application_service'),
        ],
      );

      final expected = AppDediInformation(
        commonSettingsInformation: CommonSettingsInformation(
          applicationUrl: 'https://app.dedim.com.tr/',
          enabled: true,
        ),
      );

      expect(homeserver.appDediInformation, equals(expected));
    });

    test('homeserver summary not include "app.twake.chat" information', () {
      final homeserver = HomeserverSummary(
        discoveryInformation: DiscoveryInformation(
          mHomeserver: HomeserverInformation(
            baseUrl: Uri.parse('https://matrix.dedim.com.tr'),
          ),
          mIdentityServer: IdentityServerInformation(
            baseUrl: Uri.parse('https://app.dedim.com.tr/'),
          ),
          additionalProperties: {
            'app.dedi.chat-2': {
              'base_url': 'https://app.dedim.com.tr/',
              'server_name': 'dedim.com.tr',
            },
          },
        ),
        versions: GetVersionsResponse(
          versions: ['r1.6.0'],
          unstableFeatures: {},
        ),
        loginFlows: [
          LoginFlow(type: 'm.login.sso'),
          LoginFlow(type: 'm.login.token'),
          LoginFlow(type: 'm.login.application_service'),
        ],
      );

      expect(homeserver.appDediInformation, isNull);
    });

    test('homeserver summary but additional properties is null', () {
      final homeserver = HomeserverSummary(
        discoveryInformation: DiscoveryInformation(
          mHomeserver: HomeserverInformation(
            baseUrl: Uri.parse('https://matrix.dedim.com.tr'),
          ),
          mIdentityServer: IdentityServerInformation(
            baseUrl: Uri.parse('https://app.dedi.com/'),
          ),
        ),
        versions: GetVersionsResponse(
          versions: ['r1.6.0'],
          unstableFeatures: {},
        ),
        loginFlows: [
          LoginFlow(type: 'm.login.sso'),
          LoginFlow(type: 'm.login.token'),
          LoginFlow(type: 'm.login.application_service'),
        ],
      );

      expect(homeserver.appDediInformation, isNull);
    });

    test('homeserver summary but discovery information is null', () {
      final homeserver = HomeserverSummary(
        discoveryInformation: null,
        versions: GetVersionsResponse(
          versions: ['r1.6.0'],
          unstableFeatures: {},
        ),
        loginFlows: [
          LoginFlow(type: 'm.login.sso'),
          LoginFlow(type: 'm.login.token'),
          LoginFlow(type: 'm.login.application_service'),
        ],
      );

      expect(homeserver.appDediInformation, isNull);
    });

    test('homeserver summary with invalid "app.twake.chat" information', () {
      final homeserver = HomeserverSummary(
        discoveryInformation: DiscoveryInformation(
          mHomeserver: HomeserverInformation(
            baseUrl: Uri.parse('https://matrix.dedim.com.tr'),
          ),
          mIdentityServer: IdentityServerInformation(
            baseUrl: Uri.parse('https://app.dedim.com.tr/'),
          ),
          additionalProperties: {
            'app.dedi.chat': {
              'invalid_key': 'invalid_value',
            },
          },
        ),
        versions: GetVersionsResponse(
          versions: ['r1.6.0'],
          unstableFeatures: {},
        ),
        loginFlows: [
          LoginFlow(type: 'm.login.sso'),
          LoginFlow(type: 'm.login.token'),
          LoginFlow(type: 'm.login.application_service'),
        ],
      );

      final expected = AppDediInformation(
        commonSettingsInformation: null,
      );

      expect(homeserver.appDediInformation, equals(expected));
    });

    test('homeserver summary with "common_settings" being null', () {
      final homeserver = HomeserverSummary(
        discoveryInformation: DiscoveryInformation(
          mHomeserver: HomeserverInformation(
            baseUrl: Uri.parse('https://matrix.dedim.com.tr'),
          ),
          mIdentityServer: IdentityServerInformation(
            baseUrl: Uri.parse('https://app.dedim.com.tr/'),
          ),
          additionalProperties: {
            'app.dedi.chat': {
              'common_settings': null,
            },
          },
        ),
        versions: GetVersionsResponse(
          versions: ['r1.6.0'],
          unstableFeatures: {},
        ),
        loginFlows: [
          LoginFlow(type: 'm.login.sso'),
          LoginFlow(type: 'm.login.token'),
          LoginFlow(type: 'm.login.application_service'),
        ],
      );

      final expected = AppDediInformation(
        commonSettingsInformation: null,
      );

      expect(homeserver.appDediInformation, equals(expected));
    });
  });
}
