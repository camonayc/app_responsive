import 'package:app_responsive/app_responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _withWidth(double width, Widget child) => MediaQuery(
  data: MediaQueryData(size: Size(width, 900)),
  child: Directionality(textDirection: TextDirection.ltr, child: child),
);

void main() {
  group('AdaptiveTypography — scaleFactor por dispositivo', () {
    Future<double> factor(WidgetTester t, double width) async {
      late double f;
      await t.pumpWidget(
        _withWidth(
          width,
          Builder(
            builder: (ctx) {
              f = AdaptiveTypography.of(ctx).scaleFactor;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      return f;
    }

    testWidgets(
      'mobile (375) → 1.00',
      (t) async => expect(await factor(t, 375), 1.00),
    );
    testWidgets(
      'mobile (520) → 1.00',
      (t) async => expect(await factor(t, 520), 1.00),
    );
    testWidgets(
      'tablet (800) → 1.10',
      (t) async => expect(await factor(t, 800), closeTo(1.10, 0.001)),
    );
    testWidgets(
      'desktop (1200) → 1.15',
      (t) async => expect(await factor(t, 1200), closeTo(1.15, 0.001)),
    );
    testWidgets(
      'widescreen (1600) → 1.20',
      (t) async => expect(await factor(t, 1600), closeTo(1.20, 0.001)),
    );
  });

  group('AdaptiveTypography — fontSize escalado correctamente', () {
    testWidgets('h1 en mobile: 32 × 1.00 = 32.0', (tester) async {
      late double size;
      await tester.pumpWidget(
        _withWidth(
          375,
          Builder(
            builder: (ctx) {
              size = AdaptiveTypography.of(ctx).h1.fontSize!;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      expect(size, closeTo(32.0, 0.001));
    });

    testWidgets('h1 en widescreen: 32 × 1.20 = 38.4', (tester) async {
      late double size;
      await tester.pumpWidget(
        _withWidth(
          1600,
          Builder(
            builder: (ctx) {
              size = AdaptiveTypography.of(ctx).h1.fontSize!;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      expect(size, closeTo(38.4, 0.01));
    });

    testWidgets('bodyMd en tablet: 14 × 1.10 = 15.4', (tester) async {
      late double size;
      await tester.pumpWidget(
        _withWidth(
          800,
          Builder(
            builder: (ctx) {
              size = AdaptiveTypography.of(ctx).bodyMd.fontSize!;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      expect(size, closeTo(15.4, 0.01));
    });

    testWidgets('displayXl en desktop: 72 × 1.15 = 82.8', (tester) async {
      late double size;
      await tester.pumpWidget(
        _withWidth(
          1200,
          Builder(
            builder: (ctx) {
              size = AdaptiveTypography.of(ctx).displayXl.fontSize!;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      expect(size, closeTo(82.8, 0.01));
    });
  });

  group('AdaptiveTypography — todos los getters de estilo existen', () {
    testWidgets('devuelve TextStyle no nulo para cada getter', (tester) async {
      await tester.pumpWidget(
        _withWidth(
          375,
          Builder(
            builder: (ctx) {
              final t = AdaptiveTypography.of(ctx);
              final styles = [
                t.displayXl,
                t.displayLg,
                t.displayMd,
                t.displaySm,
                t.h1,
                t.h2,
                t.h3,
                t.h4,
                t.h5,
                t.h6,
                t.titleLg,
                t.titleMd,
                t.titleSm,
                t.bodyLg,
                t.bodyMd,
                t.bodySm,
                t.labelLg,
                t.labelMd,
                t.labelSm,
                t.labelXs,
                t.codeMd,
                t.codeSm,
              ];
              for (final s in styles) {
                expect(s.fontSize, isNotNull);
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });
  });

  group('AdaptiveTypography — context.typo shorthand', () {
    testWidgets('context.typo.h1 == AdaptiveTypography.of(ctx).h1', (
      tester,
    ) async {
      late double fromExtension, fromFactory;
      await tester.pumpWidget(
        _withWidth(
          375,
          Builder(
            builder: (ctx) {
              fromExtension = ctx.typo.h1.fontSize!;
              fromFactory = AdaptiveTypography.of(ctx).h1.fontSize!;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      expect(fromExtension, fromFactory);
    });
  });

  group('AdaptiveTypography.toTextTheme', () {
    testWidgets('no lanza y mapea displayXl → displayLarge', (tester) async {
      late TextTheme theme;
      await tester.pumpWidget(
        _withWidth(
          375,
          Builder(
            builder: (ctx) {
              theme = AdaptiveTypography.of(ctx).toTextTheme();
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      // displayLarge debería tener el fontSize de displayXl × scaleFactor(mobile)
      expect(
        theme.displayLarge?.fontSize,
        closeTo(TypeScale.displayXl.fontSize! * 1.0, 0.001),
      );
    });

    testWidgets('headlineLarge coincide con h1 escalado', (tester) async {
      late TextTheme theme;
      late double h1Size;
      await tester.pumpWidget(
        _withWidth(
          800,
          Builder(
            builder: (ctx) {
              final typo = AdaptiveTypography.of(ctx);
              theme = typo.toTextTheme();
              h1Size = typo.h1.fontSize!;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      expect(theme.headlineLarge?.fontSize, closeTo(h1Size, 0.001));
    });
  });
}
