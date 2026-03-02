import 'package:collection/collection.dart';
import 'package:fluffychat/presentation/multiple_account/twake_chat_presentation_account.dart';
import 'package:fluffychat/widgets/layouts/agruments/switch_active_account_body_args.dart';
import 'package:fluffychat/widgets/matrix.dart';
import 'package:fluffychat/widgets/twake_components/twake_header_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:linagora_design_flutter/linagora_design_flutter.dart';
import 'package:linagora_design_flutter/multiple_account/models/twake_presentation_account.dart';
import 'package:matrix/matrix.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

typedef OnGoToAccountSettings = void Function(TwakePresentationAccount account);

class MultipleAccountsPickerController {
  final BuildContext context;
  final List<DediChatPresentationAccount> multipleAccounts;

  MultipleAccountsPickerController({
    required this.context,
    required this.multipleAccounts,
  });

  MatrixState get _matrixState => Matrix.of(context);

  void showMultipleAccountsPicker(
    Client currentActiveClient, {
    required VoidCallback onGoToAccountSettings,
  }) async {
    multipleAccounts.sort((pre, next) {
      return pre.accountActiveStatus.index
          .compareTo(next.accountActiveStatus.index);
    });
    MultipleAccountPicker.showMultipleAccountPicker(
      accounts: multipleAccounts,
      context: context,
      onAddAnotherAccount: _onAddAnotherAccount,
      onGoToAccountSettings: onGoToAccountSettings,
      onSetAccountAsActive: (account) => _onSetAccountAsActive(
        multipleAccounts: multipleAccounts,
        account: account,
      ),
      titleAddAnotherAccount: L10n.of(context)!.addAnotherAccount,
      titleAccountSettings: L10n.of(context)!.accountSettings,
      logoApp: Padding(
        padding: DediHeaderStyle.logoAppOfMultiplePadding,
        child: Text(
          L10n.of(context)!.selectAccount,
          style: DediHeaderStyle.selectAccountTextStyle(context),
        ),
      ),
      accountNameStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: DediSysColors.material().onSurface,
          ),
      accountIdStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: DediRefColors.material().tertiary[20],
          ),
      addAnotherAccountStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
            color: DediSysColors.material().onPrimary,
          ),
      titleAccountSettingsStyle:
          Theme.of(context).textTheme.labelLarge!.copyWith(
                color: DediSysColors.material().primary,
              ),
    );
  }

  void _onSetAccountAsActive({
    required List<DediChatPresentationAccount> multipleAccounts,
    required TwakePresentationAccount account,
  }) async {
    final client = multipleAccounts
        .firstWhereOrNull(
          (element) => element.accountId == account.accountId,
        )
        ?.clientAccount;
    if (client == null || client == _matrixState.client) return;
    await _setActiveClient(client);
  }

  void _onAddAnotherAccount() {
    context.push('/rooms/addaccount');
  }

  Future<void> _setActiveClient(Client newClient) async {
    final result = await _matrixState.setActiveClient(newClient);
    if (!result.isSuccess) {
      // If this client is persisted but not yet attached to MatrixState.clients,
      // register it first, then continue with the normal switch flow.
      await _matrixState.registerAndActivateAddedAccount(newClient);
    }

    await _matrixState.cancelListenSynchronizeContacts();
    _matrixState.reSyncContacts();
    context.go(
      '/rooms',
      extra: SwitchActiveAccountBodyArgs(
        newActiveClient: _matrixState.client,
      ),
    );
  }
}
