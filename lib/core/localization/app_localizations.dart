import 'package:flutter/material.dart';
import 'package:phicore/core/localization/translations/en.dart' as lang_en;
import 'package:phicore/core/localization/translations/tr.dart' as lang_tr;

/// Desteklenen diller.
class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  /// Desteklenen locale listesi.
  static const supportedLocales = [
    Locale('tr'),
    Locale('en'),
  ];

  /// Dil haritaları.
  static const _translations = {
    'tr': lang_tr.tr,
    'en': lang_en.en,
  };

  /// Context üzerinden erişim: `AppLocalizations.of(context)`.
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  /// Key'e karşılık gelen çeviriyi döner.
  /// Bulamazsa key'in kendisini döner (debug kolaylığı).
  String translate(String key) {
    final map = _translations[locale.languageCode];
    return map?[key] ?? key;
  }

  /// Delegate — MaterialApp'e eklenir.
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      AppLocalizations.supportedLocales
          .map((l) => l.languageCode)
          .contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async =>
      AppLocalizations(locale);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

/// BuildContext extension — kısa erişim.
extension LocalizationExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);

  /// `context.tr('key')` şeklinde doğrudan kullanım.
  String tr(String key) => AppLocalizations.of(this).translate(key);
}
