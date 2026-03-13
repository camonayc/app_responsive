import 'package:app_responsive/app_responsive.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

List<Widget> _items(int n) => List.generate(
  n,
  (i) => SizedBox.square(dimension: 50, key: ValueKey('item$i')),
);

/// Usa [OverflowBox] para pasar constraints exactas al hijo sin que el
/// test runner lance errores de overflow (la superficie de test es 800×600).
/// [SizedBox] acota la altura para que [GridView] pueda hacer layout.
Widget _build({required double width, required Widget child}) => Directionality(
  textDirection: TextDirection.ltr,
  child: OverflowBox(
    alignment: Alignment.topLeft,
    minWidth: width,
    maxWidth: width,
    minHeight: 0,
    maxHeight: double.infinity,
    child: SizedBox(height: 900, child: child),
  ),
);

int _crossAxisCount(WidgetTester tester) {
  final grid = tester.widget<GridView>(find.byType(GridView));
  return (grid.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount)
      .crossAxisCount;
}

void main() {
  group('AdaptiveGrid — renderiza todos los hijos', () {
    testWidgets('4 ítems aparecen en el árbol', (tester) async {
      await tester.pumpWidget(
        _build(
          width: 400,
          child: AdaptiveGrid(children: _items(4)),
        ),
      );
      for (var i = 0; i < 4; i++) {
        expect(find.byKey(ValueKey('item$i')), findsOneWidget);
      }
    });
  });

  group('AdaptiveGrid — columnas por defecto', () {
    testWidgets('mobile (375) → 2 columnas', (tester) async {
      await tester.pumpWidget(
        _build(
          width: 375,
          child: AdaptiveGrid(children: _items(4)),
        ),
      );
      expect(_crossAxisCount(tester), 2);
    });

    testWidgets('mobile (520) → 2 columnas', (tester) async {
      await tester.pumpWidget(
        _build(
          width: 520,
          child: AdaptiveGrid(children: _items(4)),
        ),
      );
      expect(_crossAxisCount(tester), 2);
    });

    testWidgets('tablet (800) → 3 columnas', (tester) async {
      await tester.pumpWidget(
        _build(
          width: 800,
          child: AdaptiveGrid(children: _items(6)),
        ),
      );
      expect(_crossAxisCount(tester), 3);
    });

    testWidgets('desktop (1200) → 4 columnas', (tester) async {
      await tester.pumpWidget(
        _build(
          width: 1200,
          child: AdaptiveGrid(children: _items(8)),
        ),
      );
      expect(_crossAxisCount(tester), 4);
    });

    testWidgets('widescreen (1600) → 5 columnas', (tester) async {
      await tester.pumpWidget(
        _build(
          width: 1600,
          child: AdaptiveGrid(children: _items(10)),
        ),
      );
      expect(_crossAxisCount(tester), 5);
    });
  });

  group('AdaptiveGrid — columnas personalizadas', () {
    testWidgets('mobile con 1 columna (modo lista)', (tester) async {
      await tester.pumpWidget(
        _build(
          width: 375,
          child: AdaptiveGrid(
            columns: const ResponsiveValue(mobile: 1, tablet: 2),
            children: _items(3),
          ),
        ),
      );
      expect(_crossAxisCount(tester), 1);
    });
  });

  group('AdaptiveGrid.categoria — preset', () {
    testWidgets('mobile (375) → 3 columnas', (tester) async {
      await tester.pumpWidget(
        _build(
          width: 375,
          child: AdaptiveGrid.categoria(children: _items(6)),
        ),
      );
      expect(_crossAxisCount(tester), 3);
    });

    testWidgets('mobile (520) → 3 columnas', (tester) async {
      await tester.pumpWidget(
        _build(
          width: 520,
          child: AdaptiveGrid.categoria(children: _items(8)),
        ),
      );
      expect(_crossAxisCount(tester), 3);
    });

    testWidgets('tablet (800) → 5 columnas', (tester) async {
      await tester.pumpWidget(
        _build(
          width: 800,
          child: AdaptiveGrid.categoria(children: _items(10)),
        ),
      );
      expect(_crossAxisCount(tester), 5);
    });

    testWidgets('desktop (1200) → 6 columnas', (tester) async {
      await tester.pumpWidget(
        _build(
          width: 1200,
          child: AdaptiveGrid.categoria(children: _items(12)),
        ),
      );
      expect(_crossAxisCount(tester), 6);
    });
  });

  group('AdaptiveGrid.banner — preset', () {
    testWidgets('mobile (375) → 1 columna', (tester) async {
      await tester.pumpWidget(
        _build(
          width: 375,
          child: AdaptiveGrid.banner(children: _items(3)),
        ),
      );
      expect(_crossAxisCount(tester), 1);
    });

    testWidgets('tablet (800) → 2 columnas', (tester) async {
      await tester.pumpWidget(
        _build(
          width: 800,
          child: AdaptiveGrid.banner(children: _items(4)),
        ),
      );
      expect(_crossAxisCount(tester), 2);
    });

    testWidgets('desktop (1200) → 3 columnas', (tester) async {
      await tester.pumpWidget(
        _build(
          width: 1200,
          child: AdaptiveGrid.banner(children: _items(6)),
        ),
      );
      expect(_crossAxisCount(tester), 3);
    });
  });

  group('adaptiveGridDelegate — función de nivel superior', () {
    test('devuelve SliverGridDelegateWithFixedCrossAxisCount', () {
      final delegate = adaptiveGridDelegate(device: DeviceType.mobile);
      expect(delegate, isA<SliverGridDelegateWithFixedCrossAxisCount>());
    });

    test('mobile → 2 columnas por defecto', () {
      final d =
          adaptiveGridDelegate(device: DeviceType.mobile)
              as SliverGridDelegateWithFixedCrossAxisCount;
      expect(d.crossAxisCount, 2);
    });

    test('tablet → 3 columnas por defecto', () {
      final d =
          adaptiveGridDelegate(device: DeviceType.tablet)
              as SliverGridDelegateWithFixedCrossAxisCount;
      expect(d.crossAxisCount, 3);
    });

    test('desktop → 4 columnas por defecto', () {
      final d =
          adaptiveGridDelegate(device: DeviceType.desktop)
              as SliverGridDelegateWithFixedCrossAxisCount;
      expect(d.crossAxisCount, 4);
    });

    test('widescreen → 5 columnas por defecto', () {
      final d =
          adaptiveGridDelegate(device: DeviceType.widescreen)
              as SliverGridDelegateWithFixedCrossAxisCount;
      expect(d.crossAxisCount, 5);
    });

    test('acepta columns personalizado', () {
      final d =
          adaptiveGridDelegate(
                device: DeviceType.mobile,
                columns: const ResponsiveValue(mobile: 1),
              )
              as SliverGridDelegateWithFixedCrossAxisCount;
      expect(d.crossAxisCount, 1);
    });
  });
}
