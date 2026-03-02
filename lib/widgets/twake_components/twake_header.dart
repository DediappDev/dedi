import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/presentation/enum/chat_list/chat_list_enum.dart';
import 'package:fluffychat/presentation/model/chat_list/chat_selection_actions.dart';
import 'package:fluffychat/utils/responsive/responsive_utils.dart';
import 'package:fluffychat/widgets/app_bars/twake_app_bar.dart';
import 'package:fluffychat/widgets/matrix.dart';
import 'package:fluffychat/widgets/mixins/on_account_data_listen_mixin.dart';
import 'package:fluffychat/widgets/mixins/show_dialog_mixin.dart';
import 'package:fluffychat/widgets/twake_components/twake_header_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:linagora_design_flutter/linagora_design_flutter.dart';
import 'package:matrix/matrix.dart';

class DediHeader extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback onClearSelection;
  final ValueNotifier<SelectMode> selectModeNotifier;
  final ValueNotifier<List<ConversationSelectionPresentation>>
      conversationSelectionNotifier;
  final VoidCallback onClickAvatar;
  final Client client;

  const DediHeader({
    super.key,
    required this.onClearSelection,
    required this.client,
    required this.selectModeNotifier,
    required this.conversationSelectionNotifier,
    required this.onClickAvatar,
  });

  @override
  State<DediHeader> createState() => _DediHeaderState();

  @override
  Size get preferredSize =>
      const Size.fromHeight(DediHeaderStyle.toolbarHeight);
}

class _DediHeaderState extends State<DediHeader>
    with ShowDialogMixin, OnProfileChangeMixin {
  final ValueNotifier<Profile> currentProfileNotifier = ValueNotifier(
    Profile(userId: ''),
  );

  static ResponsiveUtils responsive = getIt.get<ResponsiveUtils>();

  void getCurrentProfile(Client client) async {
    final userId = client.userID;
    if (userId == null || userId.isEmpty) {
      Logs().w(
        'DediHeader::getCurrentProfile() skipped: client has no userID',
      );
      return;
    }
    currentProfileNotifier.value = Profile(userId: '');
    final profile = await client.getProfileFromUserId(
      userId,
      getFromRooms: false,
    );
    if (!mounted) return;
    Logs().d(
      'ChatList::_getCurrentProfile() - currentProfile1: $profile',
    );
    currentProfileNotifier.value = profile;
  }

  @override
  void didUpdateWidget(covariant DediHeader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (Matrix.of(context).isValidActiveClient &&
        widget.client != oldWidget.client) {
      getCurrentProfile(widget.client);
      onAccountDataSubscription?.cancel();
      listenOnProfileChangeStream(
        client: Matrix.of(context).client,
        currentProfile: currentProfileNotifier.value,
        onProfileChanged: (newProfile) {
          currentProfileNotifier.value = newProfile;
        },
      );
    }
    if (currentProfileNotifier.value.userId.isEmpty) {
      getCurrentProfile(widget.client);
    }
  }

  @override
  void dispose() {
    super.dispose();
    currentProfileNotifier.dispose();
    onAccountDataSubscription?.cancel();
  }

  @override
  void initState() {
    super.initState();
    listenOnProfileChangeStream(
      client: Matrix.of(context).client,
      currentProfile: currentProfileNotifier.value,
      onProfileChanged: (newProfile) {
        currentProfileNotifier.value = newProfile;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.selectModeNotifier,
      builder: (context, selectMode, _) {
        return selectMode == SelectMode.normal
            ? DediAppBar(
                title: L10n.of(context)!.chats,
                context: context,
              )
            : AppBar(
                backgroundColor: responsive.isMobile(context)
                    ? DediSysColors.material().background
                    : DediSysColors.material().onPrimary,
                toolbarHeight: DediHeaderStyle.toolbarHeight,
                automaticallyImplyLeading: false,
                leadingWidth: DediHeaderStyle.leadingWidth,
                title: Align(
                  alignment: DediHeaderStyle.alignment,
                  child: Row(
                    mainAxisAlignment: responsive.isMobile(context)
                        ? DediHeaderStyle.mobileTitleAllignement
                        : MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: DediHeaderStyle.flexActions,
                        child: Padding(
                          padding: DediHeaderStyle.leadingPadding,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: selectMode == SelectMode.select
                                    ? widget.onClearSelection
                                    : null,
                                borderRadius: BorderRadius.circular(
                                  DediHeaderStyle.closeIconSize,
                                ),
                                child: Icon(
                                  Icons.close,
                                  size: DediHeaderStyle.closeIconSize,
                                  color: selectMode == SelectMode.select
                                      ? Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant
                                      : Colors.transparent,
                                ),
                              ),
                              ValueListenableBuilder(
                                valueListenable:
                                    widget.conversationSelectionNotifier,
                                builder: (context, conversationSelection, _) {
                                  return Padding(
                                    padding:
                                        DediHeaderStyle.counterSelectionPadding,
                                    child: Text(
                                      conversationSelection.length.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            color:
                                                selectMode == SelectMode.select
                                                    ? Theme.of(context)
                                                        .colorScheme
                                                        .onSurfaceVariant
                                                    : Colors.transparent,
                                          ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                centerTitle: true,
              );
      },
    );
  }
}
