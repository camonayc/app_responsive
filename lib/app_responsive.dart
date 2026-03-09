/// app_responsive
///
/// Fundación responsive interna para todas las apps del ecosistema.
/// Un solo import da acceso a breakpoints, tipografía adaptativa,
/// tokens de espaciado, widgets de layout e integración con el tema.
///
/// ```dart
/// import 'package:app_responsive/app_responsive.dart';
/// ```
library;

export 'src/breakpoints/breakpoints.dart';
// Breakpoints
export 'src/breakpoints/device_type.dart';
export 'src/breakpoints/responsive_context.dart';
export 'src/breakpoints/responsive_value.dart';
export 'src/layout/adaptive_grid.dart';
// Layout
export 'src/layout/responsive_builder.dart';
export 'src/layout/responsive_layout.dart';
// Espaciado
export 'src/spacing/spacing.dart';
export 'src/theme/app_responsive_theme.dart';
// Tema
export 'src/theme/responsive_theme_extension.dart';
export 'src/typography/adaptive_text.dart';
export 'src/typography/adaptive_typography.dart';
// Tipografía
export 'src/typography/type_scale.dart';
// Widgets
export 'src/widgets/responsive_visibility.dart';
