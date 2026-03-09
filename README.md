# app_responsive

Fundación responsive interna para aplicaciones Flutter del ecosistema.  
Un único import da acceso a breakpoints, tipografía adaptativa, tokens de espaciado, widgets de layout e integración con el tema.

> **Paquete privado** — no publicado en pub.dev. Se consume como dependencia local por `path` o por referencia `git`.

---

## Contenido

- [Instalación](#instalación)
- [Setup](#setup)
- [Breakpoints](#breakpoints)
- [Context extensions](#context-extensions)
- [ResponsiveValue](#responsivevalue)
- [Espaciado](#espaciado)
- [Tipografía](#tipografía)
- [Layout](#layout)
- [Visibilidad](#visibilidad)
- [Filosofía](#filosofía)
- [Estructura del paquete](#estructura-del-paquete)

---

## Instalación

**Por path local** (recomendado en monorepo):

```yaml
# pubspec.yaml de tu app
dependencies:
  app_responsive:
    path: ../app_responsive
```

**Por referencia git:**

```yaml
dependencies:
  app_responsive:
    git:
      url: https://github.com/tu-org/app_responsive.git
      ref: main
```

**Import único:**

```dart
import 'package:app_responsive/app_responsive.dart';
```

---

## Setup

Inyecta la extensión responsive en **tu propio** `ThemeData` usando `AppResponsiveTheme.inject()`.  
El paquete nunca crea ni sobreescribe tu tema — solo agrega la extensión necesaria para que `context.typo` esté disponible en toda la app.

```dart
// tu_tema.dart
final lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF00C85A)),
  fontFamily: 'Poppins',
  // No definas textTheme — los tamaños los maneja el paquete
);

// main.dart
MaterialApp(
  theme:     AppResponsiveTheme.inject(lightTheme),
  darkTheme: AppResponsiveTheme.inject(darkTheme),
)
```

> Llamar a `inject()` con un tema que ya tiene la extensión registrada es seguro — devuelve el tema sin modificar.

### División de responsabilidades

| Tu `ThemeData`                    | `app_responsive`                          |
|-----------------------------------|-------------------------------------------|
| `fontFamily`                      | `fontSize`, `fontWeight`, `height`        |
| `colorScheme` (colores de texto)  | `letterSpacing`, escala por dispositivo   |
| Shapes, elevaciones, efectos      | —                                         |

---

## Breakpoints

Los breakpoints se resuelven a partir del **ancho de layout disponible**, no del ancho físico de la pantalla.

| Tier           | Ancho mínimo | Dispositivos típicos              |
|----------------|-------------|-----------------------------------|
| `mobile`       | 0 px        | Teléfonos en portrait             |
| `mobileLarge`  | 480 px      | Teléfonos grandes / phablets      |
| `tablet`       | 768 px      | Tablets / teléfonos en landscape  |
| `desktop`      | 1024 px     | Laptops / tablets en landscape    |
| `widescreen`   | 1440 px     | Monitores anchos                  |

`Breakpoints.resolve(width)` convierte cualquier ancho en píxeles al `DeviceType` correspondiente.

```dart
DeviceType device = Breakpoints.resolve(constraints.maxWidth);
```

---

## Context extensions

La extensión `ResponsiveContext` sobre `BuildContext` expone los helpers más usados directamente desde el contexto.

### Dimensiones de pantalla

```dart
context.screenWidth   // double — ancho total de pantalla
context.screenHeight  // double — alto total de pantalla
```

### Tipo de dispositivo

```dart
context.deviceType        // DeviceType — tier exacto del dispositivo

context.isMobile          // true solo en mobile
context.isMobileLarge     // true solo en mobileLarge
context.isTablet          // true solo en tablet
context.isDesktop         // true solo en desktop
context.isWidescreen      // true solo en widescreen

context.isMobileFamily    // true en mobile + mobileLarge
context.isTabletOrLarger  // true en tablet, desktop y widescreen
context.isDesktopFamily   // true en desktop + widescreen
```

### Valor adaptativo inline

Devuelve el valor correspondiente al tier activo.  
Los tiers no especificados **heredan del más cercano hacia abajo**.

```dart
final columns = context.responsive<int>(
  mobile: 1,
  tablet: 2,
  desktop: 3,
);

final padding = context.responsive<double>(
  mobile: 16,
  tablet: 24,
  desktop: 32,
);
```

---

## ResponsiveValue

Constante reutilizable tipada que encapsula un valor por tier.  
Ideal para definiciones fuera del árbol de widgets o en archivos de configuración.

```dart
// Definición — puede ser const y vivir fuera del árbol
const gridColumns = ResponsiveValue<int>(
  mobile:      1,
  mobileLarge: 2,
  tablet:      3,
  desktop:     4,
);

// Uso en build()
final cols = gridColumns.resolve(context.deviceType);

// Directamente desde un ancho en píxeles
final cols = gridColumns.resolveWidth(constraints.maxWidth);
```

Los tiers no especificados heredan automáticamente hacia arriba:

```
mobile: 1  →  mobileLarge hereda 1  →  tablet hereda 1  →  …
```

---

## Espaciado

Tokens de referencia en grilla de **4 px**. Úsalos como valores constantes y combínalos con `context.responsive()` cuando el espaciado varía por breakpoint.

| Token         | Valor  |
|---------------|--------|
| `Spacing.xs`  | 4 dp   |
| `Spacing.sm`  | 8 dp   |
| `Spacing.md`  | 16 dp  |
| `Spacing.lg`  | 24 dp  |
| `Spacing.xl`  | 32 dp  |
| `Spacing.x2l` | 48 dp  |
| `Spacing.x3l` | 64 dp  |
| `Spacing.x4l` | 96 dp  |

```dart
// Constante — mismo valor en todos los tiers
const SizedBox(height: Spacing.md)

// Adaptativo — valor distinto por breakpoint
SizedBox(
  height: context.responsive(
    mobile: Spacing.md,
    tablet: Spacing.lg,
    desktop: Spacing.xl,
  ),
)

Padding(
  padding: EdgeInsets.all(
    context.responsive(mobile: Spacing.sm, tablet: Spacing.md),
  ),
  child: content,
)
```

---

## Tipografía

### Factores de escala

Los tamaños de `TypeScale` se definen en base 1× (mobile) y `AdaptiveTypography` aplica automáticamente el multiplicador por dispositivo.

| Dispositivo   | Factor |
|---------------|--------|
| mobile        | 1.00×  |
| mobileLarge   | 1.05×  |
| tablet        | 1.10×  |
| desktop       | 1.15×  |
| widescreen    | 1.20×  |

### Tokens disponibles

| Categoría | Tokens                                            | Uso                                  |
|-----------|---------------------------------------------------|--------------------------------------|
| `display` | `displayXl · displayLg · displayMd · displaySm`  | Heroes, splash, banners grandes      |
| `headline`| `h1 · h2 · h3 · h4 · h5 · h6`                    | Títulos de pantalla y sección        |
| `title`   | `titleLg · titleMd · titleSm`                    | Tarjetas, drawer, encabezados        |
| `body`    | `bodyLg · bodyMd · bodySm`                       | Párrafos, descripciones              |
| `label`   | `labelLg · labelMd · labelSm · labelXs`          | Botones, chips, badges, captions     |
| `code`    | `codeMd · codeSm`                                | SKUs, referencias (monospace)        |

> Los estilos **no incluyen color**. El color va en el `ColorScheme` de tu tema y se aplica con `.copyWith()` solo cuando hace falta.

### Acceso desde el contexto

```dart
// Shorthand recomendado
Text('Título',  style: context.typo.h1)
Text('Cuerpo',  style: context.typo.bodyMd)

// Con color puntual
Text('Precio', style: context.typo.labelLg.copyWith(
  color: Theme.of(context).colorScheme.primary,
))

// Subtítulo con color secundario
Text('Detalle', style: context.typo.bodyMd.copyWith(
  color: Theme.of(context).colorScheme.onSurfaceVariant,
))

// Instancia directa
final typo = AdaptiveTypography.of(context);
Text('Ejemplo', style: typo.h3);
```

### Widget declarativo — AdaptiveText

`AdaptiveText` resuelve automáticamente el estilo al construirse, sin necesitar el contexto de forma explícita.

```dart
AdaptiveText('Bienvenido',  style: (t) => t.h1)
AdaptiveText('Descripción', style: (t) => t.bodyMd)

// Con propiedades adicionales
AdaptiveText(
  'Precio especial',
  style:     (t) => t.labelLg,
  color:     Colors.green,
  maxLines:  1,
  overflow:  TextOverflow.ellipsis,
  textAlign: TextAlign.center,
)
```

Ambas formas son equivalentes dentro de `build()`:

```dart
// Declarativo — sin context explícito
AdaptiveText('Hola', style: (t) => t.h1)

// Inline — cuando ya tienes context o necesitas combinar estilos
Text('Hola', style: context.typo.h1)
```

---

## Layout

### ResponsiveBuilder

Wrapper sobre `LayoutBuilder` — responde al **espacio de layout real disponible**, no al ancho de la pantalla completa.  
Seguro dentro de sidebars, diálogos, bottom sheets y cualquier widget anidado.

```
┌────────────────────────────────────┐  pantalla: 1200 px
│  Sidebar 260 px │  Contenido       │
│                 │  940 px          │
│                 │  ResponsiveBuilder  ← trata el espacio como 940 px ✓
└────────────────────────────────────┘       MediaQuery diría 1200 px ✗
```

```dart
ResponsiveBuilder(
  builder: (context, device, constraints) {
    return device.isDesktopFamily
        ? const SidebarLayout()
        : const StackLayout();
  },
)
```

---

### ResponsiveLayout

Selector declarativo de widget por tier. Solo se construye la rama activa.  
Los tiers no especificados heredan del más cercano hacia abajo.

```dart
// Con los tres tiers principales
ResponsiveLayout(
  mobile:  const MobileShell(),
  tablet:  const TabletShell(),
  desktop: const DesktopShell(),
)

// Solo mobile es requerido — tablet y superiores heredan mobile
ResponsiveLayout(
  mobile:  const SimpleLayout(),
  desktop: const WideLayout(),
)

// Con todos los tiers
ResponsiveLayout(
  mobile:      const MobileLayout(),
  mobileLarge: const MobileLargeLayout(),
  tablet:      const TabletLayout(),
  desktop:     const DesktopLayout(),
  widescreen:  const WidescreenLayout(),
)
```

---

### AdaptiveGrid

Grid que escala automáticamente el número de columnas según el dispositivo.  
Usa `LayoutBuilder` internamente — responde al espacio real disponible.

**Comportamiento por defecto:**

| Tier          | Columnas |
|---------------|----------|
| mobile        | 2        |
| mobileLarge   | 2        |
| tablet        | 3        |
| desktop       | 4        |
| widescreen    | 5        |

```dart
// Grid estándar — 2 columnas en mobile
AdaptiveGrid(children: tarjetas)

// Lista en mobile — 1 columna
AdaptiveGrid(
  columns: const ResponsiveValue(mobile: 1, mobileLarge: 2, tablet: 3),
  children: productos,
)
```

**Presets incluidos:**

```dart
// Tiles cuadrados de categorías (3 cols en mobile, compactos)
AdaptiveGrid.categoria(children: tiles)

// Banners / cards en ratio paisaje (1 col en mobile, 2 en tablet…)
AdaptiveGrid.banner(children: banners)
```

**Para `CustomScrollView`:**

```dart
SliverGrid(
  delegate: SliverChildBuilderDelegate(
    (ctx, i) => TarjetaProducto(items[i]),
    childCount: items.length,
  ),
  gridDelegate: adaptiveGridDelegate(device: context.deviceType),
)
```

---

## Visibilidad

Muestra u oculta widgets según el tier activo. Los widgets ocultos **no se construyen** — se reemplazan por `SizedBox.shrink()` sin consumir recursos.

### Atajos semánticos

```dart
MobileOnly(child: BottomNavigationBar(...))  // visible en mobile + mobileLarge
TabletAndUp(child: NavigationRail(...))       // visible en tablet, desktop y widescreen
DesktopOnly(child: SidePanel(...))            // visible en desktop + widescreen
```

### Control granular

Proporciona `visibleOn` o `hiddenOn` — nunca ambos.

```dart
// Mostrar solo en tiers específicos
ResponsiveVisibility(
  visibleOn: {DeviceType.mobile, DeviceType.mobileLarge},
  child: const BottomBar(),
)

// Ocultar en tiers específicos
ResponsiveVisibility(
  hiddenOn: {DeviceType.mobile},
  child: const SearchBar(),
)
```

---

## Filosofía

El paquete provee **herramientas**, no decisiones de diseño.  
Define cuándo y cómo cambia el layout — las decisiones concretas de cada app son tuyas.

- Los **breakpoints** definen cuándo cambia el layout — tú defines qué cambia.
- Los **tokens de espaciado** dan una escala de referencia — tú decides qué valor usar en cada caso.
- La **tipografía** define la escala y jerarquía — tú defines la familia y los colores.

Cualquier valor concreto (cuánto padding tiene una tarjeta, qué gap va entre secciones) es responsabilidad de cada app, no del paquete.

---

## Estructura del paquete

```
lib/
├── app_responsive.dart              ← export único
└── src/
    ├── breakpoints/
    │   ├── device_type.dart         ← enum DeviceType (5 tiers)
    │   ├── breakpoints.dart         ← umbrales + Breakpoints.resolve()
    │   ├── responsive_value.dart    ← ResponsiveValue<T> con herencia
    │   └── responsive_context.dart  ← extensión en BuildContext
    ├── typography/
    │   ├── type_scale.dart          ← estilos base constantes (1×)
    │   ├── adaptive_typography.dart ← estilos escalados + context.typo
    │   └── adaptive_text.dart       ← widget AdaptiveText declarativo
    ├── spacing/
    │   └── spacing.dart             ← tokens xs → x4l (grilla 4 px)
    ├── layout/
    │   ├── responsive_builder.dart  ← LayoutBuilder con DeviceType
    │   ├── responsive_layout.dart   ← selector declarativo de widget
    │   └── adaptive_grid.dart       ← AdaptiveGrid + adaptiveGridDelegate
    ├── widgets/
    │   └── responsive_visibility.dart ← MobileOnly / TabletAndUp / DesktopOnly
    └── theme/
        ├── app_responsive_theme.dart        ← AppResponsiveTheme.inject()
        └── responsive_theme_extension.dart  ← ThemeExtension interna
```

---

## Tests

```bash
flutter test
```

Cobertura disponible en:

```
test/
├── breakpoints/
├── layout/
├── spacing/
├── theme/
├── typography/
└── widgets/
```
