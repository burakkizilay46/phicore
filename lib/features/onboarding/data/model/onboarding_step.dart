import 'package:flutter/material.dart';

/// Onboarding adım tipleri.
///
/// Sealed sınıf — yeni bir adım eklemek için bir alt-tip oluşturup
/// [OnboardingConfig.steps] listesine eklemen yeterli. Kod üretimi gerekmez,
/// view tarafındaki `switch` exhaustive olduğu için derleyici eksik dalı yakalar.
sealed class OnboardingStep {
  const OnboardingStep();
}

/// Bilgi / karşılama (value-proposition) slaytı.
class OnboardingInfoStep extends OnboardingStep {
  /// Lokalizasyon anahtarı (en.dart / tr.dart). View'da `context.tr()` ile çözülür.
  final String titleKey;
  final String descriptionKey;
  final IconData icon;

  const OnboardingInfoStep({
    required this.titleKey,
    required this.descriptionKey,
    required this.icon,
  });
}

/// Tek seçimli anket sorusu.
class OnboardingQuestionStep extends OnboardingStep {
  /// Cevap haritasındaki benzersiz anahtar (ör. 'use_case').
  final String key;

  /// Soru metninin lokalizasyon anahtarı.
  final String questionKey;

  final List<OnboardingOption> options;

  /// true ise cevap zorunlu değildir; "Devam" butonu cevapsız da aktif olur.
  final bool optional;

  const OnboardingQuestionStep({
    required this.key,
    required this.questionKey,
    required this.options,
    this.optional = false,
  });
}

/// Bir [OnboardingQuestionStep] seçeneği.
class OnboardingOption {
  /// State'e yazılan değer (ör. 'personal').
  final String value;

  /// Etiketin lokalizasyon anahtarı.
  final String labelKey;

  final IconData? icon;

  const OnboardingOption({
    required this.value,
    required this.labelKey,
    this.icon,
  });
}

/// Bildirim izni hazırlık (soft-ask) adımı.
class OnboardingPermissionStep extends OnboardingStep {
  final String titleKey;
  final String descriptionKey;

  const OnboardingPermissionStep({
    required this.titleKey,
    required this.descriptionKey,
  });
}
