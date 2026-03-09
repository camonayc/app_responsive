import 'package:app_responsive/src/breakpoints/device_type.dart';

/// Umbrales de ancho en píxeles lógicos del sistema responsive.
///
/// ```
/// mobile      :    0 – 479 px
/// mobileLarge :  480 – 767 px
/// tablet      :  768 – 1023 px
/// desktop     : 1024 – 1439 px
/// widescreen  : 1440+ px
/// ```
abstract final class Breakpoints {
  static const double mobile = 0;
  static const double mobileLarge = 480;
  static const double tablet = 768;
  static const double desktop = 1024;
  static const double widescreen = 1440;

  /// Resuelve un [width] en píxeles al [DeviceType] correspondiente.
  static DeviceType resolve(double width) {
    if (width >= widescreen) return DeviceType.widescreen;
    if (width >= desktop) return DeviceType.desktop;
    if (width >= tablet) return DeviceType.tablet;
    if (width >= mobileLarge) return DeviceType.mobileLarge;
    return DeviceType.mobile;
  }
}
