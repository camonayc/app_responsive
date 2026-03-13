import 'package:app_responsive/src/breakpoints/device_type.dart';

/// Umbrales de ancho en píxeles lógicos del sistema responsive.
///
/// Alineados con Material Design 3:
/// ```
/// mobile     :    0 –  599 px   (compact — todos los teléfonos portrait)
/// tablet     :  600 – 1023 px   (medium  — tablets, teléfonos landscape)
/// desktop    : 1024 – 1439 px   (expanded)
/// widescreen : 1440+ px
/// ```
abstract final class Breakpoints {
  static const double mobile = 0;
  static const double tablet = 600;
  static const double desktop = 1024;
  static const double widescreen = 1440;

  /// Resuelve un [width] en píxeles al [DeviceType] correspondiente.
  static DeviceType resolve(double width) {
    if (width >= widescreen) return DeviceType.widescreen;
    if (width >= desktop) return DeviceType.desktop;
    if (width >= tablet) return DeviceType.tablet;
    return DeviceType.mobile;
  }
}
