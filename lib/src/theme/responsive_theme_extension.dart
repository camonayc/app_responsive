import 'package:app_responsive/src/typography/adaptive_typography.dart';
import 'package:flutter/material.dart';

/// [ThemeExtension] que conecta [AdaptiveTypography] con el sistema
/// de temas de Flutter.
///
/// Regístrala usando [AppResponsiveTheme.inject] — no la uses directamente.
/// Accede a la tipografía vía `context.typo`.
class ResponsiveThemeExtension
    extends ThemeExtension<ResponsiveThemeExtension> {
  const ResponsiveThemeExtension();

  AdaptiveTypography typo(BuildContext context) =>
      AdaptiveTypography.of(context);

  @override
  ResponsiveThemeExtension copyWith() => const ResponsiveThemeExtension();

  @override
  ResponsiveThemeExtension lerp(
    ThemeExtension<ResponsiveThemeExtension>? other,
    double t,
  ) => this;
}
