import 'package:app_responsive/app_responsive.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _withWidth(double width, Widget child) => MediaQuery(
  data: MediaQueryData(size: Size(width, 900)),
  child: Directionality(textDirection: TextDirection.ltr, child: child),
);

void main() {
  group('AdaptiveText — renderiza el texto', () {
    testWidgets('muestra el string dado', (tester) async {
      await tester.pumpWidget(
        _withWidth(375, AdaptiveText('Hola mundo', style: (t) => t.bodyMd)),
      );
      expect(find.text('Hola mundo'), findsOneWidget);
    });

    testWidgets('el widget encontrado es un Text', (tester) async {
      await tester.pumpWidget(
        _withWidth(375, AdaptiveText('Test', style: (t) => t.h3)),
      );
      expect(find.byType(Text), findsOneWidget);
    });
  });

  group('AdaptiveText — fontSize resuelto correctamente', () {
    testWidgets('usa el fontSize de h1 escalado al dispositivo actual', (
      tester,
    ) async {
      late double expectedSize;
      await tester.pumpWidget(
        _withWidth(
          375,
          Builder(
            builder: (ctx) {
              expectedSize = ctx.typo.h1.fontSize!;
              return AdaptiveText('Título', style: (t) => t.h1);
            },
          ),
        ),
      );
      final text = tester.widget<Text>(find.text('Título'));
      expect(text.style?.fontSize, closeTo(expectedSize, 0.001));
    });

    testWidgets('bodyMd en tablet tiene fontSize escalado', (tester) async {
      late double expectedSize;
      await tester.pumpWidget(
        _withWidth(
          800,
          Builder(
            builder: (ctx) {
              expectedSize = ctx.typo.bodyMd.fontSize!;
              return AdaptiveText('Descripción', style: (t) => t.bodyMd);
            },
          ),
        ),
      );
      final text = tester.widget<Text>(find.text('Descripción'));
      expect(text.style?.fontSize, closeTo(expectedSize, 0.001));
    });
  });

  group('AdaptiveText — propiedad color', () {
    testWidgets('aplica color cuando se especifica', (tester) async {
      await tester.pumpWidget(
        _withWidth(
          375,
          AdaptiveText(
            'Precio',
            style: (t) => t.labelLg,
            color: const Color(0xFF00C85A),
          ),
        ),
      );
      final text = tester.widget<Text>(find.text('Precio'));
      expect(text.style?.color, const Color(0xFF00C85A));
    });

    testWidgets('no aplica color cuando es null', (tester) async {
      await tester.pumpWidget(
        _withWidth(375, AdaptiveText('Sin color', style: (t) => t.bodyLg)),
      );
      final text = tester.widget<Text>(find.text('Sin color'));
      // TypeScale no define color — color del estilo resuelto viene de la fuente
      expect(text.style?.color, isNull);
    });
  });

  group('AdaptiveText — propiedades de Text', () {
    testWidgets('aplica textAlign', (tester) async {
      await tester.pumpWidget(
        _withWidth(
          375,
          AdaptiveText(
            'Centrado',
            style: (t) => t.bodySm,
            textAlign: TextAlign.center,
          ),
        ),
      );
      final text = tester.widget<Text>(find.text('Centrado'));
      expect(text.textAlign, TextAlign.center);
    });

    testWidgets('aplica maxLines y overflow', (tester) async {
      await tester.pumpWidget(
        _withWidth(
          375,
          AdaptiveText(
            'Largo texto...',
            style: (t) => t.bodyMd,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
      final text = tester.widget<Text>(find.text('Largo texto...'));
      expect(text.maxLines, 2);
      expect(text.overflow, TextOverflow.ellipsis);
    });

    testWidgets('aplica softWrap', (tester) async {
      await tester.pumpWidget(
        _withWidth(
          375,
          AdaptiveText(
            'Wrap test',
            style: (t) => t.bodyMd,
            // ignore: avoid_redundant_argument_values
            softWrap: true,
          ),
        ),
      );
      final text = tester.widget<Text>(find.text('Wrap test'));
      expect(text.softWrap, isTrue);
    });

    testWidgets('aplica semanticsLabel', (tester) async {
      await tester.pumpWidget(
        _withWidth(
          375,
          AdaptiveText(
            '★★★★☆',
            style: (t) => t.labelMd,
            semanticsLabel: '4 de 5 estrellas',
          ),
        ),
      );
      final text = tester.widget<Text>(find.text('★★★★☆'));
      expect(text.semanticsLabel, '4 de 5 estrellas');
    });
  });

  group('AdaptiveText — selector de estilo es un callback', () {
    testWidgets('puede usarse con cualquier getter de AdaptiveTypography', (
      tester,
    ) async {
      final selectors = <TextStyle Function(AdaptiveTypography)>[
        (t) => t.displayXl,
        (t) => t.h2,
        (t) => t.titleMd,
        (t) => t.bodyLg,
        (t) => t.labelSm,
        (t) => t.codeMd,
      ];
      for (final sel in selectors) {
        await tester.pumpWidget(
          _withWidth(375, AdaptiveText('texto', style: sel)),
        );
        expect(find.text('texto'), findsOneWidget);
      }
    });
  });
}
