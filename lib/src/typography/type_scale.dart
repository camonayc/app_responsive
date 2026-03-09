import 'package:flutter/widgets.dart';

/// Escala tipográfica base del sistema de diseño — valores estáticos constantes.
///
/// Estos son los tamaños al 1× (mobile). [AdaptiveTypography] aplica
/// el multiplicador por dispositivo sobre estos valores.
///
/// No uses esta clase directamente en tus widgets. Usa [AdaptiveTypography]
/// o el shorthand `context.typo` para obtener estilos ya escalados al device.
///
/// ### Categorías (de mayor a menor)
/// ```
/// display  → xl · lg · md · sm       Heroes, splash, banners
/// headline → h1 · h2 · h3 · h4 · h5 · h6   Títulos de pantalla
/// title    → lg · md · sm            Tarjetas, drawer, diálogos
/// body     → lg · md · sm            Párrafos, descripciones
/// label    → lg · md · sm · xs       Botones, chips, captions
/// code     → md · sm                 SKUs, referencias (monospace)
/// ```
///
/// ### Nota sobre colores
/// Esta escala no define colores — el color viene del [ColorScheme]
/// de tu tema o se aplica con `.copyWith(color: ...)` en el widget.
abstract final class TypeScale {

  // ── Display ─────────────────────────────────────────────────────────────────

  static const TextStyle displayXl = TextStyle(
    fontSize: 72, height: 1.05,
    fontWeight: FontWeight.w800, letterSpacing: -2.0,
  );
  static const TextStyle displayLg = TextStyle(
    fontSize: 60, height: 1.08,
    fontWeight: FontWeight.w700, letterSpacing: -1.5,
  );
  static const TextStyle displayMd = TextStyle(
    fontSize: 48, height: 1.10,
    fontWeight: FontWeight.w700, letterSpacing: -1.0,
  );
  static const TextStyle displaySm = TextStyle(
    fontSize: 36, height: 1.12,
    fontWeight: FontWeight.w600, letterSpacing: -0.5,
  );

  // ── Headline ────────────────────────────────────────────────────────────────

  static const TextStyle h1 = TextStyle(
    fontSize: 32, height: 1.20,
    fontWeight: FontWeight.w700, letterSpacing: -0.5,
  );
  static const TextStyle h2 = TextStyle(
    fontSize: 28, height: 1.20,
    fontWeight: FontWeight.w700, letterSpacing: -0.25,
  );
  static const TextStyle h3 = TextStyle(
    fontSize: 24, height: 1.25,
    fontWeight: FontWeight.w600, letterSpacing: 0,
  );
  static const TextStyle h4 = TextStyle(
    fontSize: 20, height: 1.30,
    fontWeight: FontWeight.w600, letterSpacing: 0,
  );
  static const TextStyle h5 = TextStyle(
    fontSize: 18, height: 1.35,
    fontWeight: FontWeight.w600, letterSpacing: 0,
  );
  static const TextStyle h6 = TextStyle(
    fontSize: 16, height: 1.40,
    fontWeight: FontWeight.w600, letterSpacing: 0,
  );

  // ── Title ────────────────────────────────────────────────────────────────────

  static const TextStyle titleLg = TextStyle(
    fontSize: 20, height: 1.35,
    fontWeight: FontWeight.w500, letterSpacing: 0,
  );
  static const TextStyle titleMd = TextStyle(
    fontSize: 16, height: 1.40,
    fontWeight: FontWeight.w500, letterSpacing: 0.15,
  );
  static const TextStyle titleSm = TextStyle(
    fontSize: 14, height: 1.43,
    fontWeight: FontWeight.w500, letterSpacing: 0.10,
  );

  // ── Body ─────────────────────────────────────────────────────────────────────

  static const TextStyle bodyLg = TextStyle(
    fontSize: 16, height: 1.55,
    fontWeight: FontWeight.w400, letterSpacing: 0.15,
  );
  static const TextStyle bodyMd = TextStyle(
    fontSize: 14, height: 1.55,
    fontWeight: FontWeight.w400, letterSpacing: 0.25,
  );
  static const TextStyle bodySm = TextStyle(
    fontSize: 12, height: 1.60,
    fontWeight: FontWeight.w400, letterSpacing: 0.40,
  );

  // ── Label ─────────────────────────────────────────────────────────────────────

  static const TextStyle labelLg = TextStyle(
    fontSize: 14, height: 1.43,
    fontWeight: FontWeight.w500, letterSpacing: 0.10,
  );
  static const TextStyle labelMd = TextStyle(
    fontSize: 12, height: 1.33,
    fontWeight: FontWeight.w500, letterSpacing: 0.50,
  );
  static const TextStyle labelSm = TextStyle(
    fontSize: 11, height: 1.45,
    fontWeight: FontWeight.w500, letterSpacing: 0.50,
  );
  static const TextStyle labelXs = TextStyle(
    fontSize: 10, height: 1.50,
    fontWeight: FontWeight.w500, letterSpacing: 0.40,
  );

  // ── Code ─────────────────────────────────────────────────────────────────────

  static const TextStyle codeMd = TextStyle(
    fontSize: 14, height: 1.50,
    fontWeight: FontWeight.w400, letterSpacing: 0.5,
    fontFamily: 'monospace',
  );
  static const TextStyle codeSm = TextStyle(
    fontSize: 12, height: 1.50,
    fontWeight: FontWeight.w400, letterSpacing: 0.5,
    fontFamily: 'monospace',
  );
}
