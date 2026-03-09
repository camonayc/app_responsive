import 'package:app_responsive/app_responsive.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Spacing — valores absolutos', () {
    test('xs = 4', () => expect(Spacing.xs, 4.0));
    test('sm = 8', () => expect(Spacing.sm, 8.0));
    test('md = 16', () => expect(Spacing.md, 16.0));
    test('lg = 24', () => expect(Spacing.lg, 24.0));
    test('xl = 32', () => expect(Spacing.xl, 32.0));
    test('x2l = 48', () => expect(Spacing.x2l, 48.0));
    test('x3l = 64', () => expect(Spacing.x3l, 64.0));
    test('x4l = 96', () => expect(Spacing.x4l, 96.0));
  });

  group('Spacing — orden ascendente', () {
    test('cada token es mayor que el anterior', () {
      final tokens = [
        Spacing.xs,
        Spacing.sm,
        Spacing.md,
        Spacing.lg,
        Spacing.xl,
        Spacing.x2l,
        Spacing.x3l,
        Spacing.x4l,
      ];
      for (var i = 0; i < tokens.length - 1; i++) {
        expect(
          tokens[i],
          lessThan(tokens[i + 1]),
          reason: 'tokens[$i] debería ser < tokens[${i + 1}]',
        );
      }
    });
  });

  group('Spacing — grilla de 4 px', () {
    test('todos los tokens son múltiplos de 4', () {
      final _ =
          {
            'xs': Spacing.xs,
            'sm': Spacing.sm,
            'md': Spacing.md,
            'lg': Spacing.lg,
            'xl': Spacing.xl,
            'x2l': Spacing.x2l,
            'x3l': Spacing.x3l,
            'x4l': Spacing.x4l,
          }..forEach((name, value) {
            expect(
              value % 4,
              0.0,
              reason: 'Spacing.$name ($value) no es múltiplo de 4',
            );
          });
    });
  });
}
