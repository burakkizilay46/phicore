import 'package:flutter/material.dart';
import 'package:phicore/features/onboarding/data/model/onboarding_step.dart';

/// Onboarding akışının tek yapılandırma noktası.
///
/// Geliştirici buradan adım ekler / çıkarır / sıralar. Soru ve etiket metinleri
/// lokalizasyon anahtarı olarak tutulur; karşılıkları `en.dart` ve `tr.dart`
/// içinde tanımlıdır.
class OnboardingConfig {
  OnboardingConfig._();

  /// Geliştirme modu: her açılışta onboarding gösterilir.
  ///
  /// Prod'da `false` yapıldığında onboarding yalnızca bir kez gösterilir
  /// (tamamlanınca [AppConstants.onboardingKey] = true yazılır).
  static const bool alwaysShow = true;

  /// Akıştaki adımlar — sıralı.
  static const List<OnboardingStep> steps = [
    // ── Karşılama / değer önerisi slaytları ──
    OnboardingInfoStep(
      titleKey: 'onb_welcome1_title',
      descriptionKey: 'onb_welcome1_desc',
      icon: Icons.bolt_outlined,
    ),
    OnboardingInfoStep(
      titleKey: 'onb_welcome2_title',
      descriptionKey: 'onb_welcome2_desc',
      icon: Icons.lock_outline,
    ),

    // ── Soru 1: Kullanım amacı (segmentasyon / kişiselleştirme) ──
    OnboardingQuestionStep(
      key: 'use_case',
      questionKey: 'onb_q_usecase',
      options: [
        OnboardingOption(
          value: 'personal',
          labelKey: 'onb_usecase_personal',
          icon: Icons.person_outline,
        ),
        OnboardingOption(
          value: 'work',
          labelKey: 'onb_usecase_work',
          icon: Icons.work_outline,
        ),
        OnboardingOption(
          value: 'education',
          labelKey: 'onb_usecase_education',
          icon: Icons.school_outlined,
        ),
      ],
    ),

    // ── Soru 2: Deneyim seviyesi ──
    OnboardingQuestionStep(
      key: 'experience',
      questionKey: 'onb_q_experience',
      options: [
        OnboardingOption(value: 'beginner', labelKey: 'onb_exp_beginner'),
        OnboardingOption(
          value: 'intermediate',
          labelKey: 'onb_exp_intermediate',
        ),
        OnboardingOption(value: 'advanced', labelKey: 'onb_exp_advanced'),
      ],
    ),

    // ── Soru 3: Bizi nereden keşfettiniz? (attribution) ──
    OnboardingQuestionStep(
      key: 'discovery',
      questionKey: 'onb_q_discovery',
      options: [
        OnboardingOption(
          value: 'app_store',
          labelKey: 'onb_disc_appstore',
          icon: Icons.storefront_outlined,
        ),
        OnboardingOption(
          value: 'social_media',
          labelKey: 'onb_disc_social',
          icon: Icons.share_outlined,
        ),
        OnboardingOption(
          value: 'friend',
          labelKey: 'onb_disc_friend',
          icon: Icons.people_outline,
        ),
        OnboardingOption(
          value: 'search',
          labelKey: 'onb_disc_search',
          icon: Icons.search,
        ),
        OnboardingOption(
          value: 'other',
          labelKey: 'onb_disc_other',
          icon: Icons.more_horiz,
        ),
      ],
    ),

    // ── Bildirim izni hazırlık (soft-ask) ──
    OnboardingPermissionStep(
      titleKey: 'onb_notif_title',
      descriptionKey: 'onb_notif_desc',
    ),
  ];
}
