import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

extension LocaleExtension on Locale {
  String getLanguageNameByCurrentLocale(BuildContext context) {
    final fallbackL10n = L10n.of(context)!;
    switch (languageCode) {
      case 'tr':
        return LocaleNames.of(context)!.nameOf('tr') ?? 'Türkçe';
      case 'fr':
        return LocaleNames.of(context)!.nameOf('fr') ??
            fallbackL10n.languageFrench;
      case 'en':
        return LocaleNames.of(context)!.nameOf('en') ??
            fallbackL10n.languageEnglish;
      case 'vi':
        return LocaleNames.of(context)!.nameOf('vi') ??
            fallbackL10n.languageVietnamese;
      case 'ru':
        return LocaleNames.of(context)!.nameOf('ru') ??
            fallbackL10n.languageRussian;
      default:
        return LocaleNames.of(context)!.nameOf(languageCode) ?? languageCode;
    }
  }

  String getSourceLanguageName() {
    switch (languageCode) {
      case 'tr':
        return 'Türkçe';
      case 'fr':
        return 'Français';
      case 'en':
        return 'English';
      case 'vi':
        return 'Tiếng Việt';
      case 'ru':
        return 'Русский';
      default:
        return languageCode;
    }
  }
}
