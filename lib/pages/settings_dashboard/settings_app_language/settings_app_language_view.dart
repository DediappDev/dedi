import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/pages/settings_dashboard/settings_app_language/settings_app_language.dart';
import 'package:fluffychat/pages/settings_dashboard/settings_app_language/settings_app_language_view_style.dart';
import 'package:fluffychat/presentation/extensions/localizations/locale_extension.dart';
import 'package:fluffychat/utils/extension/string_extension.dart';
import 'package:fluffychat/utils/responsive/responsive_utils.dart';
import 'package:fluffychat/widgets/app_bars/twake_app_bar.dart';
import 'package:fluffychat/widgets/app_bars/twake_app_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:linagora_design_flutter/linagora_design_flutter.dart';

class SettingsAppLanguageView extends StatelessWidget {
  final SettingsAppLanguageController controller;
  final ResponsiveUtils responsiveUtils = getIt.get<ResponsiveUtils>();

  SettingsAppLanguageView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DediSysColors.material().onPrimary,
      appBar: DediAppBar(
        title: L10n.of(context)!.appLanguage,
        context: context,
        leading: responsiveUtils.isMobile(context)
            ? Padding(
                padding: DediAppBarStyle.leadingIconPadding,
                child: IconButton(
                  tooltip: L10n.of(context)!.back,
                  icon: const Icon(Icons.chevron_left_outlined),
                  onPressed: () => context.pop(),
                  iconSize: DediAppBarStyle.leadingIconSize,
                ),
              )
            : const SizedBox.shrink(),
        centerTitle: true,
        withDivider: true,
      ),
      body: SingleChildScrollView(
        padding: SettingsAppLanguageViewStyle.paddingBody,
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.separated(
              padding: SettingsAppLanguageViewStyle.paddingListItems,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final localeItem = controller.supportedLocales[index];
                return ValueListenableBuilder(
                  valueListenable: controller.currentLocale,
                  builder: (context, locale, child) {
                    final localizedLanguageName =
                        localeItem.getLanguageNameByCurrentLocale(context);
                    return ListTile(
                      splashColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          SettingsAppLanguageViewStyle.borderRadius,
                        ),
                      ),
                      title: Text(
                        localizedLanguageName.capitalize(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      subtitle: Text(
                        localeItem.getSourceLanguageName(),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: DediRefColors.material().neutral[40],
                            ),
                      ),
                      trailing: localeItem.languageCode == locale.languageCode
                          ? Icon(
                              Icons.check,
                              color: Theme.of(context).colorScheme.secondary,
                              size: SettingsAppLanguageViewStyle.iconSize,
                            )
                          : null,
                      onTap: () {
                        controller.changeLanguage(
                          localeItem,
                        );
                      },
                    );
                  },
                );
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: controller.supportedLocales.length,
            ),
          ],
        ),
      ),
    );
  }
}
