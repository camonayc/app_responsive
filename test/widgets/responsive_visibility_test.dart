import 'package:app_responsive/app_responsive.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usa [OverflowBox] para pasar constraints exactas al hijo sin que el
/// test runner lance errores de overflow (la superficie de test es 800×600).
Widget _build({required double width, required Widget child}) => Directionality(
  textDirection: TextDirection.ltr,
  child: OverflowBox(
    alignment: Alignment.topLeft,
    minWidth: width,
    maxWidth: width,
    minHeight: 0,
    maxHeight: double.infinity,
    child: child,
  ),
);

void main() {
  group('ResponsiveVisibility — visibleOn', () {
    testWidgets('visible cuando el device está en visibleOn', (tester) async {
      await tester.pumpWidget(
        _build(
          width: 375,
          child: const ResponsiveVisibility(
            visibleOn: {DeviceType.mobile},
            child: Text('visible'),
          ),
        ),
      );
      expect(find.text('visible'), findsOneWidget);
    });

    testWidgets('oculto cuando el device NO está en visibleOn', (tester) async {
      await tester.pumpWidget(
        _build(
          width: 800, // tablet
          child: const ResponsiveVisibility(
            visibleOn: {DeviceType.mobile},
            child: Text('debería ocultarse'),
          ),
        ),
      );
      expect(find.text('debería ocultarse'), findsNothing);
    });

    testWidgets('reemplazado por SizedBox.shrink cuando oculto', (
      tester,
    ) async {
      await tester.pumpWidget(
        _build(
          width: 800,
          child: const ResponsiveVisibility(
            visibleOn: {DeviceType.mobile},
            child: Text('oculto'),
          ),
        ),
      );
      expect(find.byType(SizedBox), findsWidgets);
    });
  });

  group('ResponsiveVisibility — hiddenOn', () {
    testWidgets('oculto cuando el device está en hiddenOn', (tester) async {
      await tester.pumpWidget(
        _build(
          width: 375, // mobile
          child: const ResponsiveVisibility(
            hiddenOn: {DeviceType.mobile},
            child: Text('oculto'),
          ),
        ),
      );
      expect(find.text('oculto'), findsNothing);
    });

    testWidgets('visible cuando el device NO está en hiddenOn', (tester) async {
      await tester.pumpWidget(
        _build(
          width: 800, // tablet
          child: const ResponsiveVisibility(
            hiddenOn: {DeviceType.mobile},
            child: Text('visible'),
          ),
        ),
      );
      expect(find.text('visible'), findsOneWidget);
    });

    testWidgets('oculto en todos los device del set', (tester) async {
      for (final width in [375.0, 520.0]) {
        await tester.pumpWidget(
          _build(
            width: width,
            child: const ResponsiveVisibility(
              hiddenOn: {DeviceType.mobile, DeviceType.mobileLarge},
              child: Text('mobile-hidden'),
            ),
          ),
        );
        expect(
          find.text('mobile-hidden'),
          findsNothing,
          reason: '${width}px debería estar oculto',
        );
      }
    });
  });

  group('ResponsiveVisibility — assert', () {
    test('lanza AssertionError si se pasan visibleOn y hiddenOn a la vez', () {
      expect(
        () => ResponsiveVisibility(
          visibleOn: const {DeviceType.mobile},
          hiddenOn: const {DeviceType.tablet},
          child: const SizedBox.shrink(),
        ),
        throwsAssertionError,
      );
    });

    test('lanza AssertionError si no se pasa ninguno', () {
      expect(
        () => ResponsiveVisibility(child: const SizedBox.shrink()),
        throwsAssertionError,
      );
    });
  });

  group('MobileOnly', () {
    testWidgets('visible en mobile (375)', (tester) async {
      await tester.pumpWidget(
        _build(
          width: 375,
          child: const MobileOnly(child: Text('solo-mobile')),
        ),
      );
      expect(find.text('solo-mobile'), findsOneWidget);
    });

    testWidgets('visible en mobileLarge (520)', (tester) async {
      await tester.pumpWidget(
        _build(
          width: 520,
          child: const MobileOnly(child: Text('solo-mobile')),
        ),
      );
      expect(find.text('solo-mobile'), findsOneWidget);
    });

    testWidgets('oculto en tablet (800)', (tester) async {
      await tester.pumpWidget(
        _build(
          width: 800,
          child: const MobileOnly(child: Text('solo-mobile')),
        ),
      );
      expect(find.text('solo-mobile'), findsNothing);
    });

    testWidgets('oculto en desktop (1200)', (tester) async {
      await tester.pumpWidget(
        _build(
          width: 1200,
          child: const MobileOnly(child: Text('solo-mobile')),
        ),
      );
      expect(find.text('solo-mobile'), findsNothing);
    });

    testWidgets('oculto en widescreen (1600)', (tester) async {
      await tester.pumpWidget(
        _build(
          width: 1600,
          child: const MobileOnly(child: Text('solo-mobile')),
        ),
      );
      expect(find.text('solo-mobile'), findsNothing);
    });
  });

  group('TabletAndUp', () {
    testWidgets('oculto en mobile (375)', (tester) async {
      await tester.pumpWidget(
        _build(
          width: 375,
          child: const TabletAndUp(child: Text('tablet+')),
        ),
      );
      expect(find.text('tablet+'), findsNothing);
    });

    testWidgets('oculto en mobileLarge (520)', (tester) async {
      await tester.pumpWidget(
        _build(
          width: 520,
          child: const TabletAndUp(child: Text('tablet+')),
        ),
      );
      expect(find.text('tablet+'), findsNothing);
    });

    testWidgets('visible en tablet (800)', (tester) async {
      await tester.pumpWidget(
        _build(
          width: 800,
          child: const TabletAndUp(child: Text('tablet+')),
        ),
      );
      expect(find.text('tablet+'), findsOneWidget);
    });

    testWidgets('visible en desktop (1200)', (tester) async {
      await tester.pumpWidget(
        _build(
          width: 1200,
          child: const TabletAndUp(child: Text('tablet+')),
        ),
      );
      expect(find.text('tablet+'), findsOneWidget);
    });

    testWidgets('visible en widescreen (1600)', (tester) async {
      await tester.pumpWidget(
        _build(
          width: 1600,
          child: const TabletAndUp(child: Text('tablet+')),
        ),
      );
      expect(find.text('tablet+'), findsOneWidget);
    });
  });

  group('DesktopOnly', () {
    testWidgets('oculto en mobile (375)', (tester) async {
      await tester.pumpWidget(
        _build(
          width: 375,
          child: const DesktopOnly(child: Text('solo-desktop')),
        ),
      );
      expect(find.text('solo-desktop'), findsNothing);
    });

    testWidgets('oculto en tablet (800)', (tester) async {
      await tester.pumpWidget(
        _build(
          width: 800,
          child: const DesktopOnly(child: Text('solo-desktop')),
        ),
      );
      expect(find.text('solo-desktop'), findsNothing);
    });

    testWidgets('visible en desktop (1200)', (tester) async {
      await tester.pumpWidget(
        _build(
          width: 1200,
          child: const DesktopOnly(child: Text('solo-desktop')),
        ),
      );
      expect(find.text('solo-desktop'), findsOneWidget);
    });

    testWidgets('visible en widescreen (1600)', (tester) async {
      await tester.pumpWidget(
        _build(
          width: 1600,
          child: const DesktopOnly(child: Text('solo-desktop')),
        ),
      );
      expect(find.text('solo-desktop'), findsOneWidget);
    });
  });
}
