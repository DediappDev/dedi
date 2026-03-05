import 'package:fluffychat/config/app_config.dart';
import 'package:fluffychat/config/default_power_level_member.dart';
import 'package:fluffychat/domain/model/search/recent_chat_model.dart';
import 'package:fluffychat/utils/matrix_sdk_extensions/client_stories_extension.dart';
import 'package:fluffychat/utils/matrix_sdk_extensions/event_extension.dart';
import 'package:matrix/matrix.dart';

extension RoomExtension on Room {
  RecentChatSearchModel toRecentChatSearchModel(
    MatrixLocalizations matrixLocalizations,
  ) {
    return RecentChatSearchModel(
      id,
      displayName: getLocalizedDisplayname(matrixLocalizations),
      roomSummary: summary,
      directChatMatrixID: directChatMatrixID,
    );
  }

  bool isNotSpaceAndStoryRoom() {
    return !isSpace && !isStoryRoom;
  }

  bool isShowInChatList() {
    return _isDirectChatHaveMessage() || _isGroupChat();
  }

  bool _isGroupChat() {
    return !isDirectChat;
  }

  bool _isDirectChatHaveMessage() {
    return isDirectChat && _isLastEventInRoomIsMessage();
  }

  bool _isLastEventInRoomIsMessage() {
    return [
      EventTypes.Message,
      EventTypes.Sticker,
      EventTypes.Encrypted,
    ].contains(lastEvent?.type);
  }

  Future<void> mute() async {
    await setPushRuleState(PushRuleState.mentionsOnly);
  }

  Future<void> unmute() async {
    await setPushRuleState(PushRuleState.notify);
  }

  bool get isMuted {
    return pushRuleState != PushRuleState.notify;
  }

  String storePlaceholderFileInMem({
    required FileInfo fileInfo,
    String? txid,
  }) {
    txid ??= client.generateUniqueTransactionId();
    final matrixFile = MatrixFile.fromFileInfo(
      fileInfo: fileInfo,
    );
    sendingFilePlaceholders[txid] = matrixFile;
    return txid;
  }

  bool get isInvitation {
    return membership == Membership.invite;
  }

  bool get canPinMessage {
    final currentPowerLevelsMap = getState(EventTypes.RoomPowerLevels)?.content;
    if (currentPowerLevelsMap == null) return 0 <= ownPowerLevel;
    return (currentPowerLevelsMap
                .tryGetMap<String, Object?>('events')
                ?.tryGet<int>(EventTypes.RoomPinnedEvents) ??
            getDefaultPowerLevel(currentPowerLevelsMap)) <=
        ownPowerLevel;
  }

  bool get canSendReactions {
    final currentPowerLevelsMap = getState(EventTypes.RoomPowerLevels)?.content;
    if (currentPowerLevelsMap == null) return 0 <= ownPowerLevel;
    return (currentPowerLevelsMap
                .tryGetMap<String, Object?>('events')
                ?.tryGet<int>(EventTypes.Reaction) ??
            getDefaultPowerLevel(currentPowerLevelsMap)) <=
        ownPowerLevel;
  }

  bool get canChangeRoomName {
    final currentPowerLevelsMap = getState(EventTypes.RoomPowerLevels)?.content;
    if (currentPowerLevelsMap == null) return 0 <= ownPowerLevel;
    return (currentPowerLevelsMap
                .tryGetMap<String, Object?>('events')
                ?.tryGet<int>(EventTypes.RoomName) ??
            currentPowerLevelsMap.tryGet<int>('state_default') ??
            80) <=
        ownPowerLevel;
  }

  bool get canChangeTopic {
    final currentPowerLevelsMap = getState(EventTypes.RoomPowerLevels)?.content;
    if (currentPowerLevelsMap == null) return 0 <= ownPowerLevel;
    return (currentPowerLevelsMap
                .tryGetMap<String, Object?>('events')
                ?.tryGet<int>(EventTypes.RoomTopic) ??
            currentPowerLevelsMap.tryGet<int>('state_default') ??
            80) <=
        ownPowerLevel;
  }

  bool get canChangeRoomAvatar {
    final currentPowerLevelsMap = getState(EventTypes.RoomPowerLevels)?.content;
    if (currentPowerLevelsMap == null) return 0 <= ownPowerLevel;
    return (currentPowerLevelsMap
                .tryGetMap<String, Object?>('events')
                ?.tryGet<int>(EventTypes.RoomAvatar) ??
            currentPowerLevelsMap.tryGet<int>('state_default') ??
            80) <=
        ownPowerLevel;
  }

  bool get canEnableEncryption {
    final currentPowerLevelsMap = getState(EventTypes.RoomPowerLevels)?.content;
    if (currentPowerLevelsMap == null) return 0 <= ownPowerLevel;
    return (currentPowerLevelsMap
                .tryGetMap<String, Object?>('events')
                ?.tryGet<int>(EventTypes.Encryption) ??
            currentPowerLevelsMap.tryGet<int>('state_default') ??
            80) <=
        ownPowerLevel;
  }

  bool get canEditChatDetails {
    return canChangeRoomName ||
        canChangeTopic ||
        canChangeRoomAvatar ||
        canEnableEncryption ||
        canChangePowerLevel ||
        canAssignRoles;
  }

  bool get canSendRedactEvent {
    final currentPowerLevelsMap = getState(EventTypes.RoomPowerLevels)?.content;
    if (currentPowerLevelsMap == null) return 0 <= ownPowerLevel;
    return (currentPowerLevelsMap
                .tryGetMap<String, Object?>('events')
                ?.tryGet<int>(EventTypes.Redaction) ??
            getDefaultPowerLevel(currentPowerLevelsMap)) <=
        ownPowerLevel;
  }

  bool get canRedactEventSentByOther {
    if (!canSendRedactEvent) return false;
    return canRedact;
  }

  Future<Event?> lastEventAvailableInPreview() async {
    // as lastEvent calculation is based on the state events we unfortunately cannot
    // use sortOrder here: With many state events we just know which ones are the
    // newest ones, without knowing in which order they actually happened. As such,
    // using the origin_server_ts is the best guess for this algorithm. While not
    // perfect, it is only used for the room preview in the room list and sorting
    // said room list, so it should be good enough.
    Event? lastEventAvailableInPreview;
    try {
      final lastEvents =
          client.roomPreviewLastEvents.map(getState).whereType<Event>();

      lastEventAvailableInPreview = lastEvents.isEmpty
          ? null
          : lastEvents.reduce((a, b) {
              if (AppConfig.hideRedactedEvents) {
                if (a.redacted) return b;
                if (b.redacted) return a;
              }
              if (a.originServerTs == b.originServerTs) {
                // if two events have the same sort order we want to give encrypted events a lower priority
                // This is so that if the same event exists in the state both encrypted *and* unencrypted,
                // the unencrypted one is picked
                return a.type == EventTypes.Encrypted ? b : a;
              }
              return a.originServerTs.millisecondsSinceEpoch >
                      b.originServerTs.millisecondsSinceEpoch
                  ? a
                  : b;
            });

      final timelineLastEvent = _sanitizePreviewEvent(lastEvent);
      lastEventAvailableInPreview = _pickNewestPreviewEvent(
        _sanitizePreviewEvent(lastEventAvailableInPreview),
        timelineLastEvent,
      );

      if (lastEventAvailableInPreview == null) {
        final lastState = _getLastestRoomState();

        if (lastState == null) return null;

        lastEventAvailableInPreview = lastState;
        final messageEvents =
            await client.database?.getEventList(this, limit: 10);
        if (messageEvents == null || messageEvents.isEmpty) {
          return lastState;
        }

        Event? newestTimelineEvent;
        for (final messageEvent in messageEvents) {
          final sanitizedEvent = _sanitizePreviewEvent(messageEvent);
          if (sanitizedEvent == null) continue;
          newestTimelineEvent = _pickNewestPreviewEvent(
            newestTimelineEvent,
            sanitizedEvent,
          );
        }

        lastEventAvailableInPreview = _pickNewestPreviewEvent(
          lastState,
          newestTimelineEvent,
        );
        if (lastEventAvailableInPreview == null) {
          return null;
        }
      }
    } catch (e) {
      Logs().e('Room::lastEventAvailableInPreview: room: $id error - $e');
      return null;
    }

    return lastEventAvailableInPreview;
  }

  Event? _sanitizePreviewEvent(Event? event) {
    if (event == null) return null;
    if (event.shouldHideRedactedEvent()) return null;
    if (event.shouldHideBannedEvent()) return null;
    return event;
  }

  Event? _pickNewestPreviewEvent(Event? left, Event? right) {
    final first = _sanitizePreviewEvent(left);
    final second = _sanitizePreviewEvent(right);
    if (first == null) return second;
    if (second == null) return first;
    return first.originServerTs.millisecondsSinceEpoch >=
            second.originServerTs.millisecondsSinceEpoch
        ? first
        : second;
  }

  Event? _getLastestRoomState() {
    var lastTime = DateTime.fromMillisecondsSinceEpoch(0);
    Event? lastState;
    states.forEach((final String key, final entry) {
      final state = entry[''];
      if (state == null) return;
      if (state.shouldHideRedactedEvent()) return;
      if (state.shouldHideBannedEvent()) return;
      if (state.originServerTs.millisecondsSinceEpoch >
          lastTime.millisecondsSinceEpoch) {
        lastTime = state.originServerTs;
        lastState = state;
      }
    });
    return lastState;
  }

  bool get canAssignRoles {
    final currentPowerLevelsMap = getState(EventTypes.RoomPowerLevels)?.content;
    if (currentPowerLevelsMap == null) return 0 <= ownPowerLevel;
    return (currentPowerLevelsMap
                .tryGetMap<String, Object?>('events')
                ?.tryGet<int>(EventTypes.RoomPowerLevels) ??
            currentPowerLevelsMap.tryGet<int>('state_default') ??
            DefaultPowerLevelMember.admin.powerLevel) <=
        ownPowerLevel;
  }

  List<User> getAssignRolesMember() {
    final members = getParticipants();
    if (members.isEmpty) return [];
    return members.where((final User member) {
      final powerLevel = member.powerLevel;
      return powerLevel >= DefaultPowerLevelMember.moderator.powerLevel &&
          member.membership == Membership.join;
    }).toList()
      ..sort(
        (small, great) => great.powerLevel.compareTo(small.powerLevel),
      );
  }

  List<User> getExceptionsMember() {
    final members = getParticipants();
    if (members.isEmpty) return [];
    return members.where((final User member) {
      final powerLevel = member.powerLevel;
      return powerLevel < DefaultPowerLevelMember.member.powerLevel &&
          member.membership == Membership.join;
    }).toList()
      ..sort(
        (small, great) => great.powerLevel.compareTo(small.powerLevel),
      );
  }

  List<User> getBannedMembers() {
    final members = getParticipants(
      membershipFilter: [Membership.ban],
    );
    if (members.isEmpty) return [];
    return members
      ..sort(
        (small, great) => great.powerLevel.compareTo(small.powerLevel),
      );
  }

  List<User> getCurrentMembers() {
    final members = getParticipants(
      membershipFilter: [
        Membership.invite,
        Membership.join,
      ],
    );
    if (members.isEmpty) return [];
    return members
      ..sort(
        (small, great) => great.powerLevel.compareTo(small.powerLevel),
      );
  }

  bool canUpdateRoleInRoom(User user) {
    return ownPowerLevel > user.powerLevel && canAssignRoles;
  }

  bool canBanMemberInRoom(User user) {
    return ownPowerLevel > user.powerLevel && canBan;
  }

  Stream get powerLevelsChanged => client.onSync.stream.where(
        (e) =>
            (e.rooms?.join?.containsKey(id) ?? false) &&
            ((e.rooms!.join![id]?.timeline?.events
                        ?.any((s) => s.type == EventTypes.RoomPowerLevels) ??
                    false) ||
                (e.rooms!.join![id]?.timeline?.events
                        ?.any((s) => s.type == EventTypes.RoomMember) ??
                    false)),
      );

  int getUserDefaultLevel() {
    return getState(EventTypes.RoomPowerLevels)!
            .content
            .tryGet<int>('users_default') ??
        0;
  }

  bool get canTransferOwnership {
    return ownPowerLevel >= DefaultPowerLevelMember.owner.powerLevel &&
        canAssignRoles;
  }

  User get ownUser {
    return getParticipants().firstWhere(
      (user) => user.id == client.userID,
    );
  }

  int get ownPowerLevelRobust {
    final powerLevelsContent = getState(EventTypes.RoomPowerLevels)?.content;
    if (powerLevelsContent == null) {
      return ownPowerLevel;
    }
    final users = powerLevelsContent['users'];
    final currentUserId = client.userID;
    if (currentUserId != null && users is Map) {
      final userPowerLevel = _parsePowerLevel(users[currentUserId]);
      if (userPowerLevel != null) {
        return userPowerLevel;
      }
    }
    return _parsePowerLevel(powerLevelsContent['users_default']) ??
        ownPowerLevel;
  }

  bool get canSendDefaultMessagesRobust {
    final powerLevelsContent = getState(EventTypes.RoomPowerLevels)?.content;
    if (powerLevelsContent == null) {
      return canSendDefaultMessages;
    }
    final events = powerLevelsContent['events'];
    final messagePowerLevel =
        events is Map ? _parsePowerLevel(events[EventTypes.Message]) : null;
    final requiredPowerLevel = messagePowerLevel ??
        _parsePowerLevel(powerLevelsContent['events_default']) ??
        getDefaultPowerLevel(powerLevelsContent);
    return ownPowerLevelRobust >= requiredPowerLevel;
  }

  int? _parsePowerLevel(dynamic raw) {
    if (raw is int) return raw;
    if (raw is num) return raw.toInt();
    if (raw is String) return int.tryParse(raw);
    return null;
  }

  bool get canReportContent => membership.isJoin;
}

extension SortByPowerLevel on List<User> {
  List<User> sortByPowerLevel() {
    final newList = [...this];
    newList.sort((a, b) => b.powerLevel.compareTo(a.powerLevel));
    return newList;
  }
}
