import 'package:flutter/material.dart';

Widget mobileDediContextMenuBuilder(
  BuildContext context,
  EditableTextState editableTextState,
) {
  return AdaptiveTextSelectionToolbar.editableText(
    editableTextState: editableTextState,
  );
}
