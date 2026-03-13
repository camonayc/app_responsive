import 'package:app_responsive/src/breakpoints/breakpoints.dart';
import 'package:app_responsive/src/breakpoints/device_type.dart';
import 'package:app_responsive/src/breakpoints/responsive_value.dart';
import 'package:flutter/widgets.dart';

/// Extiende [BuildContext] con helpers de responsive.
///
/// ```dart
/// // Verificaciones de dispositivo
/// context.isTablet
/// context.isMobileFamily
///
/// // Valor adaptativo inline — cualquier tipo
/// context.responsive<int>(mobile: 1, tablet: 2, desktop: 3)
/// ```
extension ResponsiveContext on BuildContext {
  // ── Dimensiones ───────────────────────────────────────────────────────────

  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;

  // ── Tipo de dispositivo ───────────────────────────────────────────────────

  DeviceType get deviceType => Breakpoints.resolve(screenWidth);

  bool get isMobile => deviceType == DeviceType.mobile;
  bool get isTablet => deviceType == DeviceType.tablet;
  bool get isDesktop => deviceType == DeviceType.desktop;
  bool get isWidescreen => deviceType == DeviceType.widescreen;

  /// `true` solo en [DeviceType.mobile].
  bool get isMobileFamily => deviceType.isMobileFamily;

  /// `true` en [DeviceType.tablet] y superiores.
  bool get isTabletOrLarger => deviceType.isTabletOrLarger;

  /// `true` en [DeviceType.desktop] y [DeviceType.widescreen].
  bool get isDesktopFamily => deviceType.isDesktopFamily;

  // ── Valor adaptativo ──────────────────────────────────────────────────────

  /// Devuelve el valor que corresponde al [DeviceType] actual.
  /// Los tiers no especificados heredan del más cercano hacia abajo.
  ///
  /// ```dart
  /// final padding = context.responsive<double>(
  ///   mobile: 16, tablet: 24, desktop: 32,
  /// );
  /// ```
  T responsive<T>({
    required T mobile,
    T? tablet,
    T? desktop,
    T? widescreen,
  }) => ResponsiveValue<T>(
    mobile: mobile,
    tablet: tablet,
    desktop: desktop,
    widescreen: widescreen,
  ).resolve(deviceType);
}
