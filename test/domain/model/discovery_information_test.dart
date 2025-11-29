import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart';

void main() {
  group('Customization field test cases', () {
    test('multiple valid customization fields', () {
      final multipleCustomizationFields = {
        "m.homeserver": {"base_url": "matrix.dedim.com.tr"},
        "m.identity_server": {"base_url": "https://tom.dedim.com.tr/"},
        "t.server": {"base_url": "https://tom.dedim.com.tr/"},
        "m.integrations": {
          "jitsi": {
            "preferredDomain": "jitsi.dedim.com.tr",
            "baseUrl": "https://jitsi.dedim.com.tr",
            "useJwt": false,
          },
        },
        "t.domain": {"url": "dedim.com.tr"},
      };

      final actual = DiscoveryInformation.fromJson(multipleCustomizationFields);
      expect(actual, isNotNull);
      expect(actual.additionalProperties['m.integrations'], isNotNull);
      expect(actual.additionalProperties['t.server'], isNotNull);
      expect(actual.additionalProperties['t.domain'], isNotNull);
    });

    test('multiple valid customization from ToM', () {
      final multipleCustomizationFields = {
        "m.homeserver": {"base_url": "matrix.dedim.com.tr"},
        "m.identity_server": {"base_url": "https://tom.dedim.com.tr/"},
        "t.server": {
          "base_url": "https://tom.dedim.com.tr/",
          "server_name": "dedim.com.tr",
        },
        "m.integrations": {
          "jitsi": {
            "preferredDomain": "jitsi.dedim.com.tr",
            "baseUrl": "https://jitsi.dedim.com.tr",
            "useJwt": false,
          },
        },
      };

      final actual = DiscoveryInformation.fromJson(multipleCustomizationFields);

      expect(actual, isNotNull);
      expect(actual.additionalProperties['m.integrations'], isNotNull);
      expect(actual.additionalProperties['t.server'], isNotNull);
    });

    test('one invalid customization field', () {
      final multipleCustomizationFields = {
        "m.homeserver": {"base_url": "matrix.dedim.com.tr"},
        "m.identity_server": {"base_url": "https://tom.dedim.com.tr/"},
        "t.server": {"base_url": "https://tom.dedim.com.tr/"},
        "m.integrations": {
          "jitsi": {
            "preferredDomain": "jitsi.dedim.com.tr",
            "baseUrl": "https://jitsi.dedim.com.tr",
            "useJwt": false,
          },
        },
        "t.domain": "dedim.com.tr",
      };
      expect(
        () => DiscoveryInformation.fromJson(multipleCustomizationFields),
        throwsA(isA<TypeError>()),
      );
    });
  });
}
