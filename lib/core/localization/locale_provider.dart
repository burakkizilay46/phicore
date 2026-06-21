import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phicore/core/localization/app_localizations.dart';
import 'package:phicore/core/services/storage/storage_service.dart';

const _storageKey = 'app_locale';

/// Uygulama dil ayarını yöneten provider.
///
/// Kullanım:
/// ```dart
/// // Mevcut locale'i oku
/// final locale = ref.watch(localeProvider);
///
/// // Dil değiştir
/// ref.read(localeProvider.notifier).setLocale(const Locale('en'));
/// ```
final localeProvider =
    StateNotifierProvider<LocaleNotifier, Locale>((ref) => LocaleNotifier());

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(const Locale('tr')) {
    _loadSavedLocale();
  }

  /// Storage'dan kayıtlı dili yükle, yoksa Türkçe varsayılan.
  Future<void> _loadSavedLocale() async {
    final code = await StorageService.instance.getString(_storageKey);
    if (code != null &&
        AppLocalizations.supportedLocales
            .any((l) => l.languageCode == code)) {
      state = Locale(code);
    }
  }

  /// Dili değiştir ve storage'a kaydet.
  Future<void> setLocale(Locale locale) async {
    if (!AppLocalizations.supportedLocales
        .any((l) => l.languageCode == locale.languageCode)) {
      return;
    }
    state = locale;
    await StorageService.instance.setString(_storageKey, locale.languageCode);
  }

  /// Türkçe ↔ English toggle.
  Future<void> toggleLocale() async {
    final next = state.languageCode == 'tr'
        ? const Locale('en')
        : const Locale('tr');
    await setLocale(next);
  }
}
