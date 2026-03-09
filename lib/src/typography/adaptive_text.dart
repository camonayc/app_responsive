import 'package:app_responsive/src/typography/adaptive_typography.dart';
import 'package:flutter/widgets.dart';

/// Widget de texto que resuelve automáticamente el estilo tipográfico
/// según el dispositivo actual.
///
/// ### ¿Por qué una función y no el estilo directo?
///
/// [AdaptiveTypography] necesita el [BuildContext] para saber en qué
/// dispositivo está — no existe antes de que el widget se construya.
/// La función `(t) => t.h2` es un callback que se ejecuta internamente
/// cuando ya hay contexto disponible.
///
/// Ambas formas son equivalentes dentro de `build()`:
///
/// ```dart
/// // Con AdaptiveText — declarativo, no necesitas el context explícitamente
/// AdaptiveText('Bienvenido', style: (t) => t.h1)
///
/// // Inline — cuando ya tienes context disponible
/// Text('Bienvenido', style: context.typo.h1)
/// ```
///
/// Usa [AdaptiveText] para texto limpio y declarativo.
/// Usa `context.typo` cuando necesites combinar o modificar el estilo:
/// ```dart
/// Text('Precio', style: context.typo.labelLg.copyWith(color: Colors.green))
/// ```
class AdaptiveText extends StatelessWidget {
  const AdaptiveText(
    this.data, {
    super.key,
    required this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.color,
    this.semanticsLabel,
  });

  final String data;

  /// Selector del estilo desde [AdaptiveTypography].
  ///
  /// ```dart
  /// style: (t) => t.bodyMd
  /// style: (t) => t.labelLg
  /// ```
  final TextStyle Function(AdaptiveTypography) style;

  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;

  /// Color puntual sobre el estilo resuelto.
  /// Para colores semánticos, mejor usa `context.typo` con `.copyWith()`.
  final Color? color;
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final resolved = style(context.typo);
    return Text(
      data,
      style: color != null ? resolved.copyWith(color: color) : resolved,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      semanticsLabel: semanticsLabel,
    );
  }
}
