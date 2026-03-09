import 'package:app_responsive/app_responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppResponsiveTheme.inject', () {
    test('agrega ResponsiveThemeExtension al tema base', () {
      final base = ThemeData.light();
      final injected = AppResponsiveTheme.inject(base);
      expect(injected.extension<ResponsiveThemeExtension>(), isNotNull);
    });

    test(
      'es idempotente — devuelve la misma instancia si la extensión ya existe',
      () {
        final base = ThemeData.light();
        final first = AppResponsiveTheme.inject(base);
        final second = AppResponsiveTheme.inject(first);
        expect(identical(first, second), isTrue);
      },
    );

    test('preserva las extensiones previas del tema', () {
      final base = ThemeData.light().copyWith(
        extensions: const [_DummyExtension()],
      );
      final injected = AppResponsiveTheme.inject(base);
      expect(injected.extension<_DummyExtension>(), isNotNull);
      expect(injected.extension<ResponsiveThemeExtension>(), isNotNull);
    });

    test('preserva colorScheme del tema original', () {
      final scheme = ColorScheme.fromSeed(seedColor: const Color(0xFF00C85A));
      final base = ThemeData(colorScheme: scheme);
      final injected = AppResponsiveTheme.inject(base);
      expect(injected.colorScheme.primary, base.colorScheme.primary);
    });

    test('preserva fontFamily del tema original', () {
      final base = ThemeData(fontFamily: 'Poppins');
      final injected = AppResponsiveTheme.inject(base);
      expect(
        injected.textTheme.bodyMedium?.fontFamily,
        base.textTheme.bodyMedium?.fontFamily,
      );
    });
  });

  group('ResponsiveThemeExtension', () {
    test('copyWith devuelve una instancia de ResponsiveThemeExtension', () {
      const ext = ResponsiveThemeExtension();
      expect(ext.copyWith(), isA<ResponsiveThemeExtension>());
    });

    test('lerp devuelve this (sin animación de transición)', () {
      const ext = ResponsiveThemeExtension();
      expect(ext.lerp(null, 0.5), same(ext));
      expect(ext.lerp(const ResponsiveThemeExtension(), 1.0), same(ext));
    });

    testWidgets('typo(ctx) devuelve AdaptiveTypography para el context dado', (
      tester,
    ) async {
      late AdaptiveTypography typo;
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(375, 800)),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Builder(
              builder: (ctx) {
                typo = const ResponsiveThemeExtension().typo(ctx);
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );
      expect(typo, isA<AdaptiveTypography>());
      expect(typo.scaleFactor, 1.00); // mobile
    });
  });
}

// ── Helper ────────────────────────────────────────────────────────────────────

class _DummyExtension extends ThemeExtension<_DummyExtension> {
  const _DummyExtension();

  @override
  _DummyExtension copyWith() => const _DummyExtension();

  @override
  _DummyExtension lerp(ThemeExtension<_DummyExtension>? other, double t) =>
      this;
}
