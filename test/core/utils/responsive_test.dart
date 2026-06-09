import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phicore/core/utils/responsive.dart';

void main() {
  Widget buildWithSize(double width, Widget child) {
    return MediaQuery(
      data: MediaQueryData(size: Size(width, 800)),
      child: child,
    );
  }

  group('Responsive.screenType', () {
    testWidgets('600 altında mobile döner', (tester) async {
      late ScreenType result;
      await tester.pumpWidget(
        buildWithSize(
          400,
          Builder(builder: (context) {
            result = Responsive.screenType(context);
            return const SizedBox();
          }),
        ),
      );
      expect(result, ScreenType.mobile);
    });

    testWidgets('600-1024 arası tablet döner', (tester) async {
      late ScreenType result;
      await tester.pumpWidget(
        buildWithSize(
          800,
          Builder(builder: (context) {
            result = Responsive.screenType(context);
            return const SizedBox();
          }),
        ),
      );
      expect(result, ScreenType.tablet);
    });

    testWidgets('1024+ desktop döner', (tester) async {
      late ScreenType result;
      await tester.pumpWidget(
        buildWithSize(
          1200,
          Builder(builder: (context) {
            result = Responsive.screenType(context);
            return const SizedBox();
          }),
        ),
      );
      expect(result, ScreenType.desktop);
    });
  });

  group('Responsive.value', () {
    testWidgets('mobile ekranda mobile değer döner', (tester) async {
      late double result;
      await tester.pumpWidget(
        buildWithSize(
          400,
          Builder(builder: (context) {
            result = Responsive.value<double>(
              context,
              mobile: 16,
              tablet: 24,
              desktop: 32,
            );
            return const SizedBox();
          }),
        ),
      );
      expect(result, 16);
    });

    testWidgets('tablet değer yoksa mobile fallback', (tester) async {
      late double result;
      await tester.pumpWidget(
        buildWithSize(
          800,
          Builder(builder: (context) {
            result = Responsive.value<double>(
              context,
              mobile: 16,
            );
            return const SizedBox();
          }),
        ),
      );
      expect(result, 16);
    });
  });

  group('ResponsiveBuilder', () {
    testWidgets('mobile ekranda mobile builder çalışır', (tester) async {
      await tester.pumpWidget(
        buildWithSize(
          400,
          ResponsiveBuilder(
            mobile: (_) => const Text('mobile', textDirection: TextDirection.ltr),
            tablet: (_) => const Text('tablet', textDirection: TextDirection.ltr),
          ),
        ),
      );
      expect(find.text('mobile'), findsOneWidget);
    });

    testWidgets('tablet ekranda tablet builder çalışır', (tester) async {
      await tester.pumpWidget(
        buildWithSize(
          800,
          ResponsiveBuilder(
            mobile: (_) => const Text('mobile', textDirection: TextDirection.ltr),
            tablet: (_) => const Text('tablet', textDirection: TextDirection.ltr),
          ),
        ),
      );
      expect(find.text('tablet'), findsOneWidget);
    });
  });
}
