/// Categoría lógica del dispositivo, derivada del ancho de layout disponible.
///
/// Ordenada de menor a mayor — las comparaciones por índice funcionan
/// como se espera:
/// ```dart
/// DeviceType.tablet.index > DeviceType.mobile.index // true
/// ```
enum DeviceType {
  /// < 480 px — teléfonos en portrait
  mobile,

  /// 480–767 px — teléfonos grandes / phablets
  mobileLarge,

  /// 768–1023 px — tablets / teléfonos en landscape
  tablet,

  /// 1024–1439 px — laptops / tablets en landscape
  desktop,

  /// ≥ 1440 px — monitores anchos
  widescreen;

  // ── Grupos de conveniencia ────────────────────────────────────────────────

  /// `true` en [mobile] y [mobileLarge].
  bool get isMobileFamily => index <= mobileLarge.index;

  /// `true` en [tablet] y dispositivos más grandes.
  bool get isTabletOrLarger => index >= tablet.index;

  /// `true` en [desktop] y [widescreen].
  bool get isDesktopFamily => index >= desktop.index;
}
