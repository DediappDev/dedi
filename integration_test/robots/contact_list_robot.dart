import 'package:flutter_test/flutter_test.dart';
import 'package:linagora_design_flutter/list_item/twake_list_item.dart';
import 'home_robot.dart';

import 'twake_list_item_robot.dart';

class ContactListRobot extends HomeRobot {
  ContactListRobot(super.$);

  Future<List<DediListItemRobot>> getListOfContact() async {
    final List<DediListItemRobot> contactList = [];

    // Evaluate once to find how many DediListItem widgets exist
    final matches = $(DediListItem).evaluate();

    for (final element in matches) {
      final finder = $(element.widget.runtimeType);
      contactList.add(DediListItemRobot($, finder));
    }

    return contactList;
  }
}
