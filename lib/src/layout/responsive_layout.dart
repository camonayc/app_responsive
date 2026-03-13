import 'package:app_responsive/src/breakpoints/device_type.dart';
import 'package:app_responsive/src/layout/responsive_builder.dart';
import 'package:flutter/widgets.dart';

/// Renderiza un árbol de widgets diferente por cada tier de dispositivo.
///
/// Solo se construye la rama que coincide con el [DeviceType] activo.
/// Los tiers no especificados heredan del más cercano hacia abajo.
///
/// Usa [ResponsiveBuilder] internamente — responde al espacio de layout real.
///
/// ```dart
/// ResponsiveLayout(
///   mobile:  const PantallaMobile(),
///   tablet:  const PantallaTablet(),
///   desktop: const PantallaDesktop(),
/// )
/// ```
class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
    this.widescreen,
  });

  /// Layout para [DeviceType.mobile] — requerido, es el fallback base.
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;
  final Widget? widescreen;

  @override
  Widget build(BuildContext context) => ResponsiveBuilder(
    builder: (BuildContext context, DeviceType device, _) => switch (device) {
      DeviceType.widescreen => widescreen ?? desktop ?? tablet ?? mobile,
      DeviceType.desktop => desktop ?? tablet ?? mobile,
      DeviceType.tablet => tablet ?? mobile,
      DeviceType.mobile => mobile,
    },
  );
}
