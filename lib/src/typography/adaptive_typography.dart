import 'package:flutter/material.dart';

import '../breakpoints/breakpoints.dart';
import '../breakpoints/device_type.dart';
import 'type_scale.dart';

/// Escala tipográfica adaptativa — aplica un multiplicador de tamaño
/// según el dispositivo actual, sobre los valores base de [TypeScale].
///
/// ### Factores de escala
/// ```
/// mobile      → 1.00×  (base)
/// mobileLarge → 1.05×
/// tablet      → 1.10×
/// desktop     → 1.15×
/// widescreen  → 1.20×
/// ```
///
/// ### Nota sobre colores
/// Los estilos no incluyen color. El color de texto se define en el
/// [ColorScheme] de tu tema y lo aplicas con `.copyWith()` cuando necesitas
/// uno específico:
/// ```dart
/// context.typo.bodyMd.copyWith(
///   color: Theme.of(context).colorScheme.onSurfaceVariant,
/// )
/// ```
///
/// ### Uso
/// ```dart
/// // Shorthand desde context (recomendado)
/// Text('Hola', style: context.typo.h1)
///
/// // Instancia directa
/// final typo = AdaptiveTypography.of(context);
/// Text('Hola', style: typo.h1);
/// ```
class AdaptiveTypography {
  const AdaptiveTypography._(this.deviceType);

  final DeviceType deviceType;

  /// Crea una instancia resolviendo el dispositivo desde el [context].
  factory AdaptiveTypography.of(BuildContext context) => AdaptiveTypography._(
    Breakpoints.resolve(MediaQuery.sizeOf(context).width),
  );

  // ── Scale factor ──────────────────────────────────────────────────────────

  double get scaleFactor => switch (deviceType) {
    DeviceType.mobile => 1.00,
    DeviceType.mobileLarge => 1.05,
    DeviceType.tablet => 1.10,
    DeviceType.desktop => 1.15,
    DeviceType.widescreen => 1.20,
  };

  TextStyle _scale(TextStyle base) =>
      base.copyWith(fontSize: base.fontSize! * scaleFactor);

  // ── Display ────────────────────────────────────────────────────────────────
  /// Heroes, splash screens, banners grandes.
  TextStyle get displayXl => _scale(TypeScale.displayXl);
  TextStyle get displayLg => _scale(TypeScale.displayLg);
  TextStyle get displayMd => _scale(TypeScale.displayMd);
  TextStyle get displaySm => _scale(TypeScale.displaySm);

  // ── Headline ───────────────────────────────────────────────────────────────
  /// Títulos de pantalla y secciones principales.
  TextStyle get h1 => _scale(TypeScale.h1);
  TextStyle get h2 => _scale(TypeScale.h2);
  TextStyle get h3 => _scale(TypeScale.h3);
  TextStyle get h4 => _scale(TypeScale.h4);
  TextStyle get h5 => _scale(TypeScale.h5);
  TextStyle get h6 => _scale(TypeScale.h6);

  // ── Title ──────────────────────────────────────────────────────────────────
  /// Títulos de tarjetas, drawer, encabezados de diálogos.
  TextStyle get titleLg => _scale(TypeScale.titleLg);
  TextStyle get titleMd => _scale(TypeScale.titleMd);
  TextStyle get titleSm => _scale(TypeScale.titleSm);

  // ── Body ───────────────────────────────────────────────────────────────────
  /// Párrafos, descripciones, detalle de productos.
  TextStyle get bodyLg => _scale(TypeScale.bodyLg);
  TextStyle get bodyMd => _scale(TypeScale.bodyMd);
  TextStyle get bodySm => _scale(TypeScale.bodySm);

  // ── Label ──────────────────────────────────────────────────────────────────
  /// Botones, chips, badges, etiquetas de campos, captions.
  TextStyle get labelLg => _scale(TypeScale.labelLg);
  TextStyle get labelMd => _scale(TypeScale.labelMd);
  TextStyle get labelSm => _scale(TypeScale.labelSm);
  TextStyle get labelXs => _scale(TypeScale.labelXs);

  // ── Code ───────────────────────────────────────────────────────────────────
  /// SKUs, códigos de referencia, identificadores técnicos.
  TextStyle get codeMd => _scale(TypeScale.codeMd);
  TextStyle get codeSm => _scale(TypeScale.codeSm);

  // ── Flutter TextTheme bridge ──────────────────────────────────────────────

  /// Mapea la escala a un [TextTheme] de Flutter para pasarlo a
  /// [ThemeData.textTheme] si lo necesitas.
  TextTheme toTextTheme() => TextTheme(
    displayLarge: displayXl,
    displayMedium: displayLg,
    displaySmall: displayMd,
    headlineLarge: h1,
    headlineMedium: h2,
    headlineSmall: h3,
    titleLarge: titleLg,
    titleMedium: titleMd,
    titleSmall: titleSm,
    bodyLarge: bodyLg,
    bodyMedium: bodyMd,
    bodySmall: bodySm,
    labelLarge: labelLg,
    labelMedium: labelMd,
    labelSmall: labelSm,
  );
}

/// Acceso directo a la tipografía adaptativa desde cualquier widget.
///
/// ```dart
/// context.typo.h2
/// context.typo.bodyMd.copyWith(color: Theme.of(context).colorScheme.primary)
/// ```
extension AdaptiveTypographyContext on BuildContext {
  AdaptiveTypography get typo => AdaptiveTypography.of(this);
}
