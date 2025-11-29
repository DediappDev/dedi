import 'package:fluffychat/widgets/twake_components/twake_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import '../base/core_robot.dart';
import 'twake_list_item_robot.dart';

class ForwardRobot extends CoreRobot {
  ForwardRobot(super.$);

  Future<PatrolFinder> getBackIcon() async {
    return $(AppBar).$(DediIconButton).$(Icon);
  }

  Future<List<DediListItemRobot>> getListOfRecentContacts() async {
    final List<DediListItemRobot> contactList = [];

    final matches = $(Material).evaluate();

    for (int i = 0; i < matches.length; i++) {
      final item = $(Material).at(i);
      contactList.add(DediListItemRobot($, item));
    }
    return contactList;
  }
}
