import 'package:flutter/material.dart';

Widget mobileDediContextMenuBuilder(
  BuildContext context,
  EditableTextState editableTextState,
) {
  if (SystemContextMenu.isSupported(context)) {
    return SystemContextMenu.editableText(
      editableTextState: editableTextState,
    );
  }
  return AdaptiveTextSelectionToolbar.editableText(
    editableTextState: editableTextState,
  );
}
