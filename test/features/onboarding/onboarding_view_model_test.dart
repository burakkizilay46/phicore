import 'package:flutter_test/flutter_test.dart';
import 'package:phicore/features/onboarding/config/onboarding_config.dart';
import 'package:phicore/features/onboarding/data/model/onboarding_step.dart';
import 'package:phicore/features/onboarding/view_model/onboarding_view_model.dart';

void main() {
  late OnboardingViewModel vm;

  setUp(() {
    vm = OnboardingViewModel();
  });

  group('OnboardingViewModel - başlangıç', () {
    test('ilk adımda ve cevapsız başlar', () {
      expect(vm.state.currentIndex, 0);
      expect(vm.state.answers, isEmpty);
      expect(vm.isFirstStep, isTrue);
    });
  });

  group('OnboardingViewModel - cevaplar', () {
    test('selectAnswer cevabı state\'e yazar', () {
      vm.selectAnswer('use_case', 'work');
      expect(vm.state.answers['use_case'], 'work');
    });

    test('aynı soru tekrar cevaplanınca üzerine yazar', () {
      vm.selectAnswer('use_case', 'work');
      vm.selectAnswer('use_case', 'personal');
      expect(vm.state.answers['use_case'], 'personal');
    });
  });

  group('OnboardingViewModel - navigasyon', () {
    test('next index\'i artırır', () {
      vm.next();
      expect(vm.state.currentIndex, 1);
    });

    test('back index\'i azaltır, ilk adımda sınırlı kalır', () {
      vm.next();
      vm.back();
      expect(vm.state.currentIndex, 0);

      // İlk adımda back etkisiz.
      vm.back();
      expect(vm.state.currentIndex, 0);
    });

    test('next son adıma kadar ilerler (complete tetiklenmeden)', () {
      final lastIndex = OnboardingConfig.steps.length - 1;
      for (var i = 0; i < lastIndex; i++) {
        vm.next();
      }
      expect(vm.state.currentIndex, lastIndex);
      expect(vm.isLastStep, isTrue);
    });
  });

  group('OnboardingViewModel - canAdvance', () {
    test('zorunlu soru cevapsızken false, cevaplanınca true', () {
      final questionIndex =
          OnboardingConfig.steps.indexWhere((s) => s is OnboardingQuestionStep);
      expect(questionIndex, greaterThanOrEqualTo(0),
          reason: 'Config en az bir soru içermeli');

      for (var i = 0; i < questionIndex; i++) {
        vm.next();
      }

      final question = vm.currentStep as OnboardingQuestionStep;
      expect(vm.canAdvance, isFalse);

      vm.selectAnswer(question.key, question.options.first.value);
      expect(vm.canAdvance, isTrue);
    });

    test('bilgi/slayt adımında her zaman true', () {
      expect(vm.currentStep, isA<OnboardingInfoStep>());
      expect(vm.canAdvance, isTrue);
    });
  });
}
