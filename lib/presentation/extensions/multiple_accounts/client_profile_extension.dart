import 'package:fluffychat/presentation/multiple_account/client_profile_presentation.dart';
import 'package:fluffychat/presentation/multiple_account/twake_chat_presentation_account.dart';
import 'package:fluffychat/widgets/avatar/avatar.dart';
import 'package:linagora_design_flutter/multiple_account/models/twake_presentation_account.dart';
import 'package:matrix/matrix.dart';

extension ClientProfileExtension on ClientProfilePresentation {
  DediChatPresentationAccount toDediChatPresentationAccount(
    Client currentActiveClient,
  ) {
    final accountDisplayName = profile.displayName?.trim().isNotEmpty == true
        ? profile.displayName!.trim()
        : profile.userId;
    return DediChatPresentationAccount(
      clientAccount: client,
      accountId: profile.userId,
      accountName: accountDisplayName,
      avatar: Avatar(
        mxContent: profile.avatarUrl,
        name: accountDisplayName,
      ),
      accountActiveStatus: profile.userId == currentActiveClient.userID
          ? AccountActiveStatus.active
          : AccountActiveStatus.inactive,
    );
  }
}
