import 'package:app_responsive/src/breakpoints/device_type.dart';
import 'package:app_responsive/src/breakpoints/responsive_value.dart';
import 'package:app_responsive/src/layout/responsive_builder.dart';
import 'package:flutter/widgets.dart';

/// Grid adaptativo — escala el número de columnas según el dispositivo.
///
/// Usa [LayoutBuilder] internamente, por lo que responde al **espacio de
/// layout real** disponible, no al ancho de pantalla completa.
///
/// ### Comportamiento por defecto
/// ```
/// mobile     → 2 columnas
/// tablet     → 3 columnas
/// desktop    → 4 columnas
/// widescreen → 5 columnas
/// ```
///
/// ### ¿Lista o grid en mobile?
/// Controla el número de columnas con la propiedad [columns]:
///
/// ```dart
/// // Lista (1 columna en mobile)
/// AdaptiveGrid(
///   columns: const ResponsiveValue(mobile: 1, tablet: 3),
///   children: productos,
/// )
///
/// // Grid desde mobile (por defecto — 2 columnas)
/// AdaptiveGrid(children: tarjetas)
/// ```
///
/// ### Presets
/// ```dart
/// AdaptiveGrid.categoria(children: tiles)   // tiles cuadrados
/// AdaptiveGrid.banner(children: banners)    // banners anchos
/// ```
class AdaptiveGrid extends StatelessWidget {
  // ── Constructor principal ────────────────────────────────────────────────

  const AdaptiveGrid({
    super.key,
    required this.children,
    this.columns = const ResponsiveValue(
      mobile: 2,
      tablet: 3,
      desktop: 4,
      widescreen: 5,
    ),
    this.spacing = const ResponsiveValue(
      mobile: 8.0,
      tablet: 12.0,
      desktop: 16.0,
    ),
    this.childAspectRatio = const ResponsiveValue(
      mobile: 0.75,
      tablet: 0.78,
      desktop: 0.82,
    ),
    this.padding,
    this.shrinkWrap = false,
    this.physics,
    this.primary,
  });

  // ── Preset: tiles cuadrados de categoría ─────────────────────────────────

  /// Preset para grids de íconos o categorías — tiles cuadrados.
  /// En mobile arranca en 3 columnas porque los tiles son compactos.
  const AdaptiveGrid.categoria({
    Key? key,
    required List<Widget> children,
    EdgeInsetsGeometry? padding,
    bool shrinkWrap = false,
    ScrollPhysics? physics,
  }) : this(
         key: key,
         children: children,
         padding: padding,
         shrinkWrap: shrinkWrap,
         physics: physics,
         columns: const ResponsiveValue(
           mobile: 3,
           tablet: 5,
           desktop: 6,
         ),
         childAspectRatio: const ResponsiveValue(
           mobile: 1.0,
           tablet: 1.0,
           desktop: 1.0,
         ),
         spacing: const ResponsiveValue(
           mobile: 8.0,
           tablet: 12.0,
           desktop: 16.0,
         ),
       );

  // ── Preset: banners promocionales ────────────────────────────────────────

  /// Preset para banners o cards de ratio paisaje — pocas columnas, anchos.
  const AdaptiveGrid.banner({
    Key? key,
    required List<Widget> children,
    EdgeInsetsGeometry? padding,
    bool shrinkWrap = false,
    ScrollPhysics? physics,
  }) : this(
         key: key,
         children: children,
         padding: padding,
         shrinkWrap: shrinkWrap,
         physics: physics,
         columns: const ResponsiveValue(
           mobile: 1,
           tablet: 2,
           desktop: 3,
         ),
         childAspectRatio: const ResponsiveValue(
           mobile: 2.2,
           tablet: 2.0,
           desktop: 1.8,
         ),
         spacing: const ResponsiveValue(
           mobile: 8.0,
           tablet: 12.0,
           desktop: 16.0,
         ),
       );

  // ── Fields ───────────────────────────────────────────────────────────────

  final List<Widget> children;

  /// Número de columnas por tier. Pasa `mobile: 1` para comportamiento de lista.
  final ResponsiveValue<int> columns;

  /// Espacio entre celdas (horizontal y vertical).
  final ResponsiveValue<double> spacing;

  /// Relación ancho/alto de cada celda.
  final ResponsiveValue<double> childAspectRatio;

  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final bool? primary;

  // ── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, device, _) {
        final gap = spacing.resolve(device);
        final ratio = childAspectRatio.resolve(device);
        final cols = columns.resolve(device);

        return GridView.count(
          crossAxisCount: cols,
          crossAxisSpacing: gap,
          mainAxisSpacing: gap,
          childAspectRatio: ratio,
          padding: padding,
          shrinkWrap: shrinkWrap,
          physics: physics,
          primary: primary,
          children: children,
        );
      },
    );
  }
}

// ── Sliver helper ─────────────────────────────────────────────────────────────

/// Devuelve un [SliverGridDelegate] ajustado al [device] actual.
///
/// Usar cuando construyes un [CustomScrollView] manualmente:
/// ```dart
/// SliverGrid(
///   delegate: SliverChildBuilderDelegate(
///     (ctx, i) => TarjetaProducto(items[i]),
///     childCount: items.length,
///   ),
///   gridDelegate: adaptiveGridDelegate(device: context.deviceType),
/// )
/// ```
SliverGridDelegate adaptiveGridDelegate({
  required DeviceType device,
  ResponsiveValue<int> columns = const ResponsiveValue(
    mobile: 2,
    tablet: 3,
    desktop: 4,
    widescreen: 5,
  ),
  ResponsiveValue<double> spacing = const ResponsiveValue(
    mobile: 8.0,
    tablet: 12.0,
    desktop: 16.0,
  ),
  ResponsiveValue<double> childAspectRatio = const ResponsiveValue(
    mobile: 0.75,
    tablet: 0.78,
    desktop: 0.82,
  ),
}) => SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: columns.resolve(device),
  mainAxisSpacing: spacing.resolve(device),
  crossAxisSpacing: spacing.resolve(device),
  childAspectRatio: childAspectRatio.resolve(device),
);
