import 'package:fluffychat/config/app_config.dart';
import 'package:fluffychat/widgets/app_bars/twake_app_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:linagora_design_flutter/colors/linagora_state_layer.dart';
import 'package:linagora_design_flutter/colors/linagora_sys_colors.dart';

import '../../pages/contacts_tab/contacts_appbar_style.dart';

class DediAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool withDivider;
  final BuildContext context;
  final Widget? leading;
  final bool? centerTitle;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final double? leadingWidth;
  final VoidCallback? onBack;
  final bool enableLeftTitle;
  final bool isDialog;

  const DediAppBar({
    super.key,
    required this.title,
    required this.context,
    this.withDivider = false,
    this.leading,
    this.centerTitle,
    this.actions,
    this.backgroundColor,
    this.leadingWidth,
    this.onBack,
    this.enableLeftTitle = false,
    this.isDialog = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:
          backgroundColor ?? DediAppBarStyle.appBarBackgroundColor(context),
      toolbarHeight: AppConfig.toolbarHeight(context),
      centerTitle:
          centerTitle ?? DediAppBarStyle.responsiveUtils.isMobile(context),
      automaticallyImplyLeading: false,
      leading: leading,
      leadingWidth: leadingWidth,
      title: isDialog || DediAppBarStyle.responsiveUtils.isMobile(context)
          ? Column(
              children: [
                Padding(
                  padding: centerTitle == true
                      ? EdgeInsets.zero
                      : ContactsAppbarStyle.titlePadding(context),
                  child: Text(
                    title,
                    style: DediAppBarStyle.titleTextStyle(
                      context,
                      isDialog: isDialog,
                    ),
                  ),
                ),
              ],
            )
          : Row(
              children: [
                Padding(
                  padding: enableLeftTitle
                      ? EdgeInsets.zero
                      : const EdgeInsets.only(left: 16),
                  child: Text(
                    title,
                    style: DediAppBarStyle.titleTextStyle(
                      context,
                      isDialog: isDialog,
                    ),
                  ),
                ),
              ],
            ),
      actions: actions,
      bottom: withDivider
          ? PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Divider(
                height: DediAppBarStyle.dividerHeight,
                thickness: DediAppBarStyle.dividerthickness,
                color: DediStateLayer(
                  DediSysColors.material().surfaceTint,
                ).opacityLayer3,
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppConfig.toolbarHeight(context));
}
