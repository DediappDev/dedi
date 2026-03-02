import 'package:dartz/dartz.dart';
import 'package:fluffychat/app_state/failure.dart';
import 'package:fluffychat/app_state/success.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/domain/app_state/contact/get_contacts_state.dart';
import 'package:fluffychat/pages/new_private_chat/widget/loading_contact_widget.dart';
import 'package:fluffychat/presentation/enum/contacts/warning_contacts_banner_enum.dart';
import 'package:fluffychat/presentation/extensions/value_notifier_custom.dart';
import 'package:fluffychat/presentation/model/contact/get_presentation_contacts_empty.dart';
import 'package:fluffychat/presentation/model/contact/get_presentation_contacts_failure.dart';
import 'package:fluffychat/presentation/model/contact/presentation_contact.dart';
import 'package:fluffychat/presentation/model/contact/presentation_contact_success.dart';
import 'package:fluffychat/presentation/model/search/presentation_search.dart';
import 'package:fluffychat/utils/platform_infos.dart';
import 'package:fluffychat/utils/responsive/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:fluffychat/pages/new_private_chat/widget/expansion_contact_list_tile.dart';
import 'package:fluffychat/pages/new_private_chat/widget/no_contacts_found.dart';
import 'package:fluffychat/pages/search/recent_item_widget.dart';
import 'package:linagora_design_flutter/linagora_design_flutter.dart';
import 'package:matrix/matrix.dart';

class ExpansionList extends StatelessWidget {
  final ValueNotifierCustom<Either<Failure, Success>>
      presentationContactsNotifier;
  final ValueNotifierCustom<Either<Failure, Success>>
      presentationPhonebookContactNotifier;
  final ValueNotifierCustom<List<PresentationSearch>>
      presentationRecentContactNotifier;
  final Client client;
  final Function() goToNewGroupChat;
  final Function(BuildContext context, PresentationContact contact)
      onExternalContactTap;
  final Function(BuildContext context, PresentationContact contact)
      onContactTap;
  final TextEditingController textEditingController;
  final ValueNotifier<WarningContactsBannerState> warningBannerNotifier;
  final Function()? closeContactsWarningBanner;
  final Function()? goToSettingsForPermissionActions;

  const ExpansionList({
    super.key,
    required this.presentationContactsNotifier,
    required this.presentationRecentContactNotifier,
    required this.client,
    required this.goToNewGroupChat,
    required this.onExternalContactTap,
    required this.onContactTap,
    required this.textEditingController,
    required this.warningBannerNotifier,
    this.closeContactsWarningBanner,
    this.goToSettingsForPermissionActions,
    required this.presentationPhonebookContactNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ..._buildResponsiveButtons(context),
        _recentContactsList(),
        _sliverContactsList(),
        if (PlatformInfos.isMobile) _sliverPhonebookList(),
      ],
    );
  }

  Widget _recentContactsList() {
    return ValueListenableBuilder(
      valueListenable: presentationRecentContactNotifier,
      builder: (context, recentContacts, child) {
        if (recentContacts.isEmpty) return child!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 4.0),
              child: Text(
                L10n.of(context)!.recent,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: recentContacts.length,
              itemBuilder: (context, index) {
                final recent = recentContacts[index];
                final presentationContact = recent.toPresentationContact();
                if (presentationContact.matrixId == null ||
                    presentationContact.matrixId!.isEmpty) {
                  return const SizedBox.shrink();
                }
                return RecentItemWidget(
                  presentationSearch: recent,
                  highlightKeyword: textEditingController.text,
                  client: client,
                  onTap: () => onContactTap(context, presentationContact),
                );
              },
            ),
          ],
        );
      },
      child: const SizedBox.shrink(),
    );
  }

  Widget _sliverContactsList() {
    return ValueListenableBuilder(
      valueListenable: presentationContactsNotifier,
      builder: (context, state, child) {
        return state.fold(
          (failure) {
            if (presentationRecentContactNotifier.value.isNotEmpty) {
              return child!;
            }
            final textControllerIsEmpty = textEditingController.text.isEmpty;
            if (PlatformInfos.isWeb) {
              if (failure is GetPresentationContactsFailure ||
                  failure is GetPresentationContactsEmpty) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    NoContactsFound(
                      keyword: textControllerIsEmpty
                          ? null
                          : textEditingController.text,
                    ),
                  ],
                );
              }
              return child!;
            } else {
              return presentationPhonebookContactNotifier.value.fold(
                (_) {
                  if (presentationPhonebookContactNotifier.value.isRight()) {
                    return child!;
                  }
                  if (failure is GetPresentationContactsFailure ||
                      failure is GetPresentationContactsEmpty) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        NoContactsFound(
                          keyword: textControllerIsEmpty
                              ? null
                              : textEditingController.text,
                        ),
                      ],
                    );
                  }
                  return child!;
                },
                (success) => child!,
              );
            }
          },
          (success) {
            if (success is ContactsLoading) {
              return const LoadingContactWidget();
            }

            if (success is PresentationExternalContactSuccess) {
              if (!PlatformInfos.isWeb) {
                if (presentationPhonebookContactNotifier.value.isRight()) {
                  return child!;
                }
              }
              return DediInkWell(
                onTap: () {
                  onContactTap(
                    context,
                    success.contact,
                  );
                },
                child: ExpansionContactListTile(
                  contact: success.contact,
                  highlightKeyword: textEditingController.text,
                ),
              );
            }

            if (success is PresentationContactsSuccess) {
              final contacts = success.contacts;
              final matrixContacts = contacts
                  .where(
                    (contact) =>
                        contact.matrixId != null &&
                        contact.matrixId!.isNotEmpty,
                  )
                  .toList();
              if (matrixContacts.isEmpty &&
                  textEditingController.text.isNotEmpty) {
                return NoContactsFound(
                  keyword: textEditingController.text.isEmpty
                      ? null
                      : textEditingController.text,
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: matrixContacts.length,
                itemBuilder: (context, index) {
                  return DediInkWell(
                    onTap: () {
                      onContactTap(
                        context,
                        matrixContacts[index],
                      );
                    },
                    child: ExpansionContactListTile(
                      contact: matrixContacts[index],
                      highlightKeyword: textEditingController.text,
                    ),
                  );
                },
              );
            }

            return child!;
          },
        );
      },
      child: const SizedBox(),
    );
  }

  Widget _sliverPhonebookList() {
    return ValueListenableBuilder(
      valueListenable: presentationPhonebookContactNotifier,
      builder: (context, phonebookContactState, child) {
        return phonebookContactState.fold(
          (failure) {
            return child!;
          },
          (success) {
            if (success is PresentationContactsSuccess) {
              final contacts = success.contacts
                  .where(
                    (contact) =>
                        contact.matrixId != null &&
                        contact.matrixId!.isNotEmpty,
                  )
                  .toList();
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  return DediInkWell(
                    onTap: () {
                      onContactTap(
                        context,
                        contacts[index],
                      );
                    },
                    child: ExpansionContactListTile(
                      contact: contacts[index],
                      highlightKeyword: textEditingController.text,
                    ),
                  );
                },
              );
            }
            return child!;
          },
        );
      },
      child: const SizedBox(),
    );
  }

  List<Widget> _buildResponsiveButtons(BuildContext context) {
    if (!getIt.get<ResponsiveUtils>().isSingleColumnLayout(context)) return [];

    return [
      _NewGroupButton(
        onPressed: goToNewGroupChat,
      ),
    ];
  }
}

class _IconTextTileButton extends StatelessWidget {
  const _IconTextTileButton({
    required this.context,
    required this.onPressed,
    required this.iconData,
    required this.text,
  });

  final BuildContext context;
  final Function()? onPressed;
  final IconData iconData;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(16.0),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Material(
          color: Colors.transparent,
          child: SizedBox(
            height: 56.0,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Icon(
                    iconData,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Text(
                  text,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        letterSpacing: -0.15,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NewGroupButton extends StatelessWidget {
  final Function() onPressed;

  const _NewGroupButton({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return _IconTextTileButton(
      context: context,
      onPressed: onPressed,
      iconData: Icons.supervisor_account_outlined,
      text: L10n.of(context)!.newGroupChat,
    );
  }
}
