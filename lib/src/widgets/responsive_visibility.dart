import 'package:app_responsive/src/breakpoints/device_type.dart';
import 'package:app_responsive/src/layout/responsive_builder.dart';
import 'package:flutter/widgets.dart';

/// Muestra u oculta [child] según el [DeviceType] activo.
///
/// Los widgets ocultos **no se construyen** — se reemplazan por
/// [SizedBox.shrink], sin consumir recursos.
///
/// Proporciona [visibleOn] o [hiddenOn], nunca ambos.
///
/// ### ¿Por qué un Set y no una lista?
/// Un [Set] es semánticamente correcto: es una colección sin orden ni
/// duplicados — exactamente lo que es un grupo de breakpoints.
/// Además `Set.contains()` es O(1) vs O(n) de una lista.
///
/// ```dart
/// ResponsiveVisibility(
///   visibleOn: {DeviceType.mobile},
///   child: BottomBar(),
/// )
///
/// ResponsiveVisibility(
///   hiddenOn: {DeviceType.mobile},
///   child: SearchBar(),
/// )
/// ```
class ResponsiveVisibility extends StatelessWidget {
  const ResponsiveVisibility({
    super.key,
    required this.child,
    this.visibleOn,
    this.hiddenOn,
  }) : assert(
         (visibleOn != null) != (hiddenOn != null),
         'Proporciona visibleOn o hiddenOn — no ambos, no ninguno.',
       );

  final Widget child;

  /// El widget solo se muestra cuando el device está en este Set.
  final Set<DeviceType>? visibleOn;

  /// El widget se oculta cuando el device está en este Set.
  final Set<DeviceType>? hiddenOn;

  @override
  Widget build(BuildContext context) => ResponsiveBuilder(
    builder: (context, device, _) {
      final visible = visibleOn != null
          ? visibleOn!.contains(device)
          : !hiddenOn!.contains(device);
      return visible ? child : const SizedBox.shrink();
    },
  );
}

// ── Atajos por nombre ──────────────────────────────────────────────────────

/// Visible únicamente en [DeviceType.mobile].
class MobileOnly extends StatelessWidget {
  const MobileOnly({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => ResponsiveVisibility(
    visibleOn: const {DeviceType.mobile},
    child: child,
  );
}

/// Visible en [DeviceType.tablet] y superiores.
class TabletAndUp extends StatelessWidget {
  const TabletAndUp({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => ResponsiveVisibility(
    visibleOn: const {
      DeviceType.tablet,
      DeviceType.desktop,
      DeviceType.widescreen,
    },
    child: child,
  );
}

/// Visible únicamente en [DeviceType.desktop] y [DeviceType.widescreen].
class DesktopOnly extends StatelessWidget {
  const DesktopOnly({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => ResponsiveVisibility(
    visibleOn: const {DeviceType.desktop, DeviceType.widescreen},
    child: child,
  );
}
