/// Categoría lógica del dispositivo, derivada del ancho de layout disponible.
///
/// Ordenada de menor a mayor — las comparaciones por índice funcionan
/// como se espera:
/// ```dart
/// DeviceType.tablet.index > DeviceType.mobile.index // true
/// ```
enum DeviceType {
  /// < 600 px — teléfonos en portrait (alinea con Material Design 3 compact)
  mobile,

  /// 600–1023 px — tablets / teléfonos en landscape (M3 medium)
  tablet,

  /// 1024–1439 px — laptops / tablets en landscape
  desktop,

  /// ≥ 1440 px — monitores anchos
  widescreen;

  // ── Grupos de conveniencia ────────────────────────────────────────────────

  /// `true` solo en [mobile].
  bool get isMobileFamily => index < DeviceType.tablet.index;

  /// `true` en [tablet] y dispositivos más grandes.
  bool get isTabletOrLarger => index >= tablet.index;

  /// `true` en [desktop] y [widescreen].
  bool get isDesktopFamily => index >= desktop.index;
}
