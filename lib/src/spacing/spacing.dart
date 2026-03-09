/// Tokens de espaciado — escala en grilla de 4px.
///
/// Úsalos como referencia consistente dentro de tus apps.
/// Para valores que cambian por breakpoint usa [ResponsiveValue]:
///
/// ```dart
/// SizedBox(height: context.responsive(mobile: Spacing.md, tablet: Spacing.lg))
///
/// Padding(
///   padding: EdgeInsets.all(
///     context.responsive(mobile: Spacing.sm, tablet: Spacing.md, desktop: Spacing.lg),
///   ),
/// )
/// ```
abstract final class Spacing {
  static const double xs  =  4;
  static const double sm  =  8;
  static const double md  = 16;
  static const double lg  = 24;
  static const double xl  = 32;
  static const double x2l = 48;
  static const double x3l = 64;
  static const double x4l = 96;
}
