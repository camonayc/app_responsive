import 'package:app_responsive/src/breakpoints/breakpoints.dart';
import 'package:app_responsive/src/breakpoints/device_type.dart';
import 'package:flutter/widgets.dart';

/// Widget base responsive — usa [LayoutBuilder] internamente.
///
/// ### ¿Por qué LayoutBuilder y no MediaQuery?
///
/// `MediaQuery.sizeOf(context).width` devuelve siempre el **ancho de pantalla
/// completo**, sin importar dónde esté el widget en el árbol.
///
/// El problema surge cuando el widget no ocupa toda la pantalla:
///
/// ```
/// ┌───────────────────────────────────┐  pantalla: 1200px
/// │  Sidebar 260px │   Contenido      │
/// │                │   940px          │
/// │                │   AdaptiveGrid   │  ← MediaQuery dice 1200px ✗
/// │                │                  │    LayoutBuilder dice 940px ✓
/// └───────────────────────────────────┘
/// ```
///
/// Con [MediaQuery] el grid mostraría 4 columnas cuando en realidad
/// solo dispone de 940px. [LayoutBuilder] responde al **espacio real
/// disponible**, lo que lo hace seguro dentro de sidebars, diálogos,
/// bottom sheets y cualquier layout anidado.
///
/// ### Uso
/// ```dart
/// ResponsiveBuilder(
///   builder: (context, device, constraints) {
///     return device.isDesktopFamily
///         ? const LayoutDesktop()
///         : const LayoutMobile();
///   },
/// )
/// ```
class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({super.key, required this.builder});

  final Widget Function(
    BuildContext context,
    DeviceType device,
    BoxConstraints constraints,
  )
  builder;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) => builder(
      context,
      Breakpoints.resolve(constraints.maxWidth),
      constraints,
    ),
  );
}
