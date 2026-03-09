import 'package:app_responsive/src/theme/responsive_theme_extension.dart';
import 'package:flutter/material.dart';

/// Inyecta [ResponsiveThemeExtension] en **tu propio** [ThemeData].
///
/// El paquete nunca crea ni sobreescribe tu tema. Solo agrega la extensión
/// necesaria para que `context.typo` esté disponible en toda la app.
///
/// ### División de responsabilidades
///
/// | Tu ThemeData                    | app_responsive                          |
/// |--------------------------------|-----------------------------------------|
/// | `fontFamily`                   | `fontSize`, `fontWeight`, `height`      |
/// | `colorScheme`                  | `letterSpacing`                         |
/// | Shapes, elevaciones, etc.      | Escalado automático por dispositivo     |
///
/// > **No definas `textTheme` en tu tema.** Los tamaños de fuente los
/// > maneja el paquete. Solo define `fontFamily` para tu tipografía.
/// >
/// > Los colores de texto van en tu `ColorScheme`, no en `TextStyle`.
/// > Úsalos en el widget con `.copyWith()` cuando los necesites.
///
/// ### Ejemplo
///
/// ```dart
/// // tu_tema.dart
/// final lightTheme = ThemeData(
///   colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF00C85A)),
///   fontFamily: 'Poppins',
///   // NO definas textTheme aquí
/// );
///
/// // main.dart
/// MaterialApp(
///   theme:     AppResponsiveTheme.inject(lightTheme),
///   darkTheme: AppResponsiveTheme.inject(darkTheme),
/// )
/// ```
///
/// Llamar a [inject] con un tema que ya tiene la extensión registrada
/// es seguro — devuelve el tema sin modificar (no duplica).
abstract final class AppResponsiveTheme {
  /// Devuelve [base] con [ResponsiveThemeExtension] en sus extensiones.
  static ThemeData inject(ThemeData base) {
    if (base.extension<ResponsiveThemeExtension>() != null) return base;

    return base.copyWith(
      extensions: [
        ...base.extensions.values,
        const ResponsiveThemeExtension(),
      ],
    );
  }
}
