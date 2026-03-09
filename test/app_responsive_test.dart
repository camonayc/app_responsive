// Smoke tests que verifican que la API pública del paquete es accesible
// con un único import.
//
// Los tests detallados de cada módulo están en sus respectivos archivos:
//   test/breakpoints/   — Breakpoints, DeviceType, ResponsiveValue, ResponsiveContext
//   test/spacing/       — Spacing
//   test/typography/    — TypeScale, AdaptiveTypography, AdaptiveText
//   test/layout/        — ResponsiveBuilder, ResponsiveLayout, AdaptiveGrid
//   test/widgets/       — ResponsiveVisibility, MobileOnly, TabletAndUp, DesktopOnly
//   test/theme/         — AppResponsiveTheme, ResponsiveThemeExtension

import 'package:app_responsive/app_responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('app_responsive — exports accesibles desde un solo import', () {
    test('Breakpoints está disponible', () {
      expect(Breakpoints.mobile, isA<double>());
    });

    test('DeviceType está disponible', () {
      expect(DeviceType.values, isNotEmpty);
    });

    test('ResponsiveValue está disponible', () {
      const v = ResponsiveValue<int>(mobile: 1);
      expect(v.mobile, 1);
    });

    test('Spacing está disponible', () {
      expect(Spacing.md, 16.0);
    });

    test('TypeScale está disponible', () {
      expect(TypeScale.h1.fontSize, isNotNull);
    });

    test('adaptiveGridDelegate está disponible', () {
      final delegate = adaptiveGridDelegate(device: DeviceType.mobile);
      expect(delegate, isA<SliverGridDelegate>());
    });

    test('AppResponsiveTheme.inject funciona sobre ThemeData', () {
      final theme = AppResponsiveTheme.inject(ThemeData.light());
      expect(theme.extension<ResponsiveThemeExtension>(), isNotNull);
    });
  });

  group('app_responsive — integración Breakpoints ↔ DeviceType', () {
    test('resolve cubre todos los DeviceType', () {
      const anchuras = {
        DeviceType.mobile: 375.0,
        DeviceType.mobileLarge: 520.0,
        DeviceType.tablet: 800.0,
        DeviceType.desktop: 1200.0,
        DeviceType.widescreen: 1600.0,
      };
      anchuras.forEach((device, width) {
        expect(Breakpoints.resolve(width), device);
      });
    });

    test('ResponsiveValue.resolveWidth encadena con Breakpoints.resolve', () {
      const v = ResponsiveValue<String>(
        mobile: 'mobile',
        tablet: 'tablet',
        desktop: 'desktop',
      );
      expect(v.resolveWidth(375), 'mobile');
      expect(v.resolveWidth(800), 'tablet');
      expect(v.resolveWidth(1200), 'desktop');
    });
  });
}
