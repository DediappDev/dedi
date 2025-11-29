import 'package:fluffychat/widgets/context_menu/context_menu_action.dart';
import 'package:fluffychat/widgets/context_menu/twake_context_menu.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Show a [DediContextMenu] on the given [BuildContext]. For other parameters, see [DediContextMenu].
mixin DediContextMenuMixin {
  void disableRightClick() {
    if (kIsWeb) {
      BrowserContextMenu.disableContextMenu();
    }
  }

  void enableRightClick() {
    if (kIsWeb) {
      BrowserContextMenu.enableContextMenu();
    }
  }

  Future<dynamic> showDediContextMenu({
    required List<ContextMenuAction> listActions,
    required Offset offset,
    required BuildContext context,
    double? verticalPadding,
    VoidCallback? onClose,
  }) async {
    dynamic result;
    await showDialog(
      context: context,
      barrierColor: Colors.transparent,
      barrierDismissible: false,
      builder: (dialogContext) => DediContextMenu(
        dialogContext: dialogContext,
        listActions: listActions,
        position: offset,
        verticalPadding: verticalPadding,
      ),
    ).then((value) {
      result = value;
      onClose?.call();
    });
    return result;
  }
}
