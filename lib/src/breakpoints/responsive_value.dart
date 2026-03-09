import 'package:app_responsive/src/breakpoints/breakpoints.dart';
import 'package:app_responsive/src/breakpoints/device_type.dart';

/// Contiene un valor de tipo [T] por cada breakpoint.
///
/// Los tiers no especificados **heredan hacia arriba** desde el más cercano
/// hacia abajo — solo declaras lo que realmente cambia.
///
/// ```dart
/// const columns = ResponsiveValue<int>(mobile: 2, tablet: 3, desktop: 4);
/// columns.resolve(DeviceType.widescreen); // → 4 (hereda de desktop)
/// ```
class ResponsiveValue<T> {
  const ResponsiveValue({
    required this.mobile,
    T? mobileLarge,
    T? tablet,
    T? desktop,
    T? widescreen,
  }) : _mobileLarge = mobileLarge,
       _tablet = tablet,
       _desktop = desktop,
       _widescreen = widescreen;

  /// Valor base para mobile (requerido — es el fallback de todos los tiers).
  final T mobile;
  final T? _mobileLarge;
  final T? _tablet;
  final T? _desktop;
  final T? _widescreen;

  T get mobileLarge => _mobileLarge ?? mobile;
  T get tablet => _tablet ?? mobileLarge;
  T get desktop => _desktop ?? tablet;
  T get widescreen => _widescreen ?? desktop;

  /// Resuelve el valor para el [deviceType] dado.
  T resolve(DeviceType deviceType) => switch (deviceType) {
    DeviceType.mobile => mobile,
    DeviceType.mobileLarge => mobileLarge,
    DeviceType.tablet => tablet,
    DeviceType.desktop => desktop,
    DeviceType.widescreen => widescreen,
  };

  /// Atajo: resuelve directamente desde un ancho en píxeles.
  T resolveWidth(double width) => resolve(Breakpoints.resolve(width));
}
