import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

extension LocaleExtension on Locale {
  String getLanguageNameByCurrentLocale(BuildContext context) {
    if (languageCode == 'tr') return L10n.of(context)!.languageTurkish;
    if (languageCode == 'ar') return L10n.of(context)!.languageArabic;
    if (languageCode == 'fa') return L10n.of(context)!.languagePersian;
    if (languageCode == 'fr') return L10n.of(context)!.languageFrench;
    if (languageCode == 'en') return L10n.of(context)!.languageEnglish;
    if (languageCode == 'ru') return L10n.of(context)!.languageRussian;
    return LocaleNames.of(context)!.nameOf(languageCode) ?? languageCode;
  }

  String getSourceLanguageName() {
    switch (languageCode) {
      case 'tr':
        return 'Türkçe';
      case 'ar':
        return 'العربية';
      case 'fa':
        return 'فارسی';
      case 'fr':
        return 'Français';
      case 'en':
        return 'English';
      case 'ru':
        return 'Русский';
      default:
        return '';
    }
  }
}
