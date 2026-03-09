import 'package:app_responsive/app_responsive.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usa [OverflowBox] para pasar constraints exactas al hijo sin que el
/// test runner lance errores de overflow (la superficie de test es 800×600).
Widget _build({required double width, required Widget layout}) =>
    Directionality(
      textDirection: TextDirection.ltr,
      child: OverflowBox(
        alignment: Alignment.topLeft,
        minWidth: width,
        maxWidth: width,
        minHeight: 0,
        maxHeight: double.infinity,
        child: layout,
      ),
    );

void main() {
  group('ResponsiveLayout — renderiza la rama correcta', () {
    final layout = ResponsiveLayout(
      mobile: const Text('mobile'),
      mobileLarge: const Text('mobileLarge'),
      tablet: const Text('tablet'),
      desktop: const Text('desktop'),
      widescreen: const Text('widescreen'),
    );

    testWidgets('375px → mobile', (tester) async {
      await tester.pumpWidget(_build(width: 375, layout: layout));
      expect(find.text('mobile'), findsOneWidget);
    });

    testWidgets('520px → mobileLarge', (tester) async {
      await tester.pumpWidget(_build(width: 520, layout: layout));
      expect(find.text('mobileLarge'), findsOneWidget);
    });

    testWidgets('800px → tablet', (tester) async {
      await tester.pumpWidget(_build(width: 800, layout: layout));
      expect(find.text('tablet'), findsOneWidget);
    });

    testWidgets('1200px → desktop', (tester) async {
      await tester.pumpWidget(_build(width: 1200, layout: layout));
      expect(find.text('desktop'), findsOneWidget);
    });

    testWidgets('1600px → widescreen', (tester) async {
      await tester.pumpWidget(_build(width: 1600, layout: layout));
      expect(find.text('widescreen'), findsOneWidget);
    });
  });

  group('ResponsiveLayout — herencia (fallback hacia abajo)', () {
    testWidgets('mobileLarge hereda de mobile cuando no está definida', (
      tester,
    ) async {
      await tester.pumpWidget(
        _build(
          width: 520,
          layout: const ResponsiveLayout(mobile: Text('base')),
        ),
      );
      expect(find.text('base'), findsOneWidget);
    });

    testWidgets('tablet hereda de mobile si solo existe mobile', (
      tester,
    ) async {
      await tester.pumpWidget(
        _build(
          width: 800,
          layout: const ResponsiveLayout(mobile: Text('base')),
        ),
      );
      expect(find.text('base'), findsOneWidget);
    });

    testWidgets('desktop hereda de tablet', (tester) async {
      await tester.pumpWidget(
        _build(
          width: 1200,
          layout: const ResponsiveLayout(
            mobile: Text('mobile'),
            tablet: Text('tablet'),
          ),
        ),
      );
      expect(find.text('tablet'), findsOneWidget);
    });

    testWidgets('widescreen hereda de desktop (que hereda de tablet)', (
      tester,
    ) async {
      await tester.pumpWidget(
        _build(
          width: 1600,
          layout: const ResponsiveLayout(
            mobile: Text('mobile'),
            tablet: Text('tablet'),
          ),
        ),
      );
      expect(find.text('tablet'), findsOneWidget);
    });

    testWidgets('todos los tiers heredan de mobile cuando solo existe mobile', (
      tester,
    ) async {
      for (final width in [375.0, 520.0, 800.0, 1200.0, 1600.0]) {
        await tester.pumpWidget(
          _build(
            width: width,
            layout: const ResponsiveLayout(mobile: Text('solo-mobile')),
          ),
        );
        expect(
          find.text('solo-mobile'),
          findsOneWidget,
          reason: 'falló en ${width}px',
        );
      }
    });
  });

  group('ResponsiveLayout — no renderiza ramas inactivas', () {
    testWidgets('en mobile no hay rama tablet en el árbol', (tester) async {
      final tabletKey = GlobalKey();
      await tester.pumpWidget(
        _build(
          width: 375,
          layout: ResponsiveLayout(
            mobile: const Text('mobile'),
            tablet: Text('tablet', key: tabletKey),
          ),
        ),
      );
      expect(find.byKey(tabletKey), findsNothing);
    });
  });
}
