import 'package:fluffychat/widgets/context_menu/context_menu_action.dart';
import 'package:fluffychat/widgets/mixins/twake_context_menu_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ContextMenuActionItemWidget extends StatelessWidget {
  final ContextMenuAction action;
  final void Function()? closeMenuAction;

  const ContextMenuActionItemWidget({
    super.key,
    required this.action,
    this.closeMenuAction,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        closeMenuAction?.call();
      },
      child: _itemBuilder(
        context,
        action.name,
        iconAction: action.icon,
        imagePath: action.imagePath,
        colorIcon: action.colorIcon,
        iconSize: action.iconSize,
        styleName: action.styleName,
        padding: action.padding,
      ),
    );
  }

  Widget _itemBuilder(
    BuildContext context,
    String nameAction, {
    IconData? iconAction,
    String? imagePath,
    Color? colorIcon,
    double? iconSize,
    TextStyle? styleName,
    EdgeInsets? padding,
  }) {
    Widget buildIcon() {
      // We try to get the SVG first and then the IconData
      if (imagePath != null) {
        return SvgPicture.asset(
          imagePath,
          width: iconSize ?? DediContextMenuStyle.defaultItemIconSize,
          height: iconSize ?? DediContextMenuStyle.defaultItemIconSize,
          fit: BoxFit.fill,
          colorFilter: ColorFilter.mode(
            colorIcon ?? DediContextMenuStyle.defaultItemColorIcon(context)!,
            BlendMode.srcIn,
          ),
        );
      }

      if (iconAction != null) {
        return Icon(
          iconAction,
          size: iconSize ?? DediContextMenuStyle.defaultItemIconSize,
          color:
              colorIcon ?? DediContextMenuStyle.defaultItemColorIcon(context),
        );
      }

      return const SizedBox.shrink();
    }

    return Padding(
      padding: padding ?? DediContextMenuStyle.defaultItemPadding,
      child: SizedBox(
        child: Row(
          children: [
            Expanded(
              child: Text(
                nameAction,
                style: styleName ??
                    DediContextMenuStyle.defaultItemTextStyle(context),
              ),
            ),
            const SizedBox(width: DediContextMenuStyle.defaultItemElementsGap),
            buildIcon(),
          ],
        ),
      ),
    );
  }
}
