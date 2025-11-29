import 'package:fluffychat/pages/chat_list/chat_list_item_title.dart';
import 'package:fluffychat/widgets/twake_components/twake_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linagora_design_flutter/list_item/twake_list_item.dart';
import 'package:patrol/patrol.dart';
import 'chat_group_detail_robot.dart';
import 'home_robot.dart';
import 'twake_list_item_robot.dart';

class ChatListRobot extends HomeRobot {
  ChatListRobot(super.$);

  PatrolFinder showLessLabel() {
    return $("Show Less");
  }

  PatrolFinder noResultLabel() {
    return $("No Results");
  }

  PatrolFinder getPenIcon() {
    return $(DediFloatingActionButton);
  }

  Future<void> clickOnPenIcon() async {
    await getPenIcon().tap();
    await $.waitUntilVisible($(AppBar).$("New chat"));
  }

  Future<ChatGroupDetailRobot> openChatGroupByIndex(int index) async {
    await (await getListOfChatGroup())[index].root.tap();
    await $.pumpAndSettle();
    return ChatGroupDetailRobot($);
  }

  Future<List<DediListItemRobot>> getListOfChatGroup() async {
    final List<DediListItemRobot> groupList = [];

    // Evaluate once to find how many DediListItem widgets exist
    final matches = $(DediListItem).evaluate();
    for (final element in matches) {
      final finder = $(element.widget.runtimeType);
      groupList.add(DediListItemRobot($, finder));
    }
    return groupList;
  }

  DediListItemRobot getChatGroupByTitle(String title) {
    final finder =
        $(DediListItem).containing($(ChatListItemTitle).containing($(title)));
    return DediListItemRobot($, finder);
  }
}
