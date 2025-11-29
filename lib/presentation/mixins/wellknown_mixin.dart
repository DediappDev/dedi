import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';

mixin WellKnownMixin {
  static const _dediChatKey = 'app.dedi.chat';
  static const _enableInvitation = 'enable_invitations';

  final ValueNotifier<DiscoveryInformation?> discoveryInformationNotifier =
      ValueNotifier(null);

  Future<void> getWellKnownInformation(Client client) async {
    try {
      final result = await client.getWellknown();
      Logs().d('WellKnownMixin::getWellKnownInformation() well-known $result');
      discoveryInformationNotifier.value = result;
    } catch (e) {
      discoveryInformationNotifier.value = null;
      Logs().e(
        'WellKnownMixin::getWellKnownInformation() Error checking wellknown status: $e',
      );
    }
  }

  bool supportInvitation() {
    final additionalProperties =
        discoveryInformationNotifier.value?.additionalProperties;
    final enableInvitation =
        additionalProperties?[_dediChatKey]?[_enableInvitation] as bool?;
    Logs().d(
      'WellKnownMixin::supportInvitation(): enableInvitation - $enableInvitation',
    );
    return enableInvitation ?? false;
  }
}
