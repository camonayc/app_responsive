import 'package:app_responsive/app_responsive.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usa [OverflowBox] para pasar constraints exactas al hijo sin que el
/// test runner lance errores de overflow (la superficie de test es 800×600).
Widget _constrained(double width, Widget child) => Directionality(
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
  group('ResponsiveBuilder — resuelve DeviceType desde LayoutBuilder', () {
    testWidgets('375px → mobile', (tester) async {
      late DeviceType captured;
      await tester.pumpWidget(
        _constrained(
          375,
          ResponsiveBuilder(
            builder: (ctx, device, _) {
              captured = device;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      expect(captured, DeviceType.mobile);
    });

    testWidgets('520px → mobileLarge', (tester) async {
      late DeviceType captured;
      await tester.pumpWidget(
        _constrained(
          520,
          ResponsiveBuilder(
            builder: (ctx, device, _) {
              captured = device;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      expect(captured, DeviceType.mobileLarge);
    });

    testWidgets('800px → tablet', (tester) async {
      late DeviceType captured;
      await tester.pumpWidget(
        _constrained(
          800,
          ResponsiveBuilder(
            builder: (ctx, device, _) {
              captured = device;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      expect(captured, DeviceType.tablet);
    });

    testWidgets('1200px → desktop', (tester) async {
      late DeviceType captured;
      await tester.pumpWidget(
        _constrained(
          1200,
          ResponsiveBuilder(
            builder: (ctx, device, _) {
              captured = device;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      expect(captured, DeviceType.desktop);
    });

    testWidgets('1600px → widescreen', (tester) async {
      late DeviceType captured;
      await tester.pumpWidget(
        _constrained(
          1600,
          ResponsiveBuilder(
            builder: (ctx, device, _) {
              captured = device;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      expect(captured, DeviceType.widescreen);
    });
  });

  group('ResponsiveBuilder — expone BoxConstraints correctas', () {
    testWidgets('maxWidth coincide con el SizedBox padre', (tester) async {
      late BoxConstraints captured;
      await tester.pumpWidget(
        _constrained(
          450,
          ResponsiveBuilder(
            builder: (ctx, _, constraints) {
              captured = constraints;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      expect(captured.maxWidth, 450);
    });
  });

  group('ResponsiveBuilder — devuelve el widget del builder', () {
    testWidgets('muestra "mobile" cuando el device es mobileFamily', (
      tester,
    ) async {
      await tester.pumpWidget(
        _constrained(
          375,
          ResponsiveBuilder(
            builder: (ctx, device, _) => device.isMobileFamily
                ? const Text('mobile')
                : const Text('grande'),
          ),
        ),
      );
      expect(find.text('mobile'), findsOneWidget);
      expect(find.text('grande'), findsNothing);
    });

    testWidgets('muestra "grande" en desktop', (tester) async {
      await tester.pumpWidget(
        _constrained(
          1200,
          ResponsiveBuilder(
            builder: (ctx, device, _) => device.isMobileFamily
                ? const Text('mobile')
                : const Text('grande'),
          ),
        ),
      );
      expect(find.text('grande'), findsOneWidget);
    });
  });

  group('ResponsiveBuilder — es un StatelessWidget', () {
    test('instancia es StatelessWidget', () {
      final widget = ResponsiveBuilder(
        builder: (_, _, _) => const SizedBox.shrink(),
      );
      expect(widget, isA<StatelessWidget>());
    });
  });
}
