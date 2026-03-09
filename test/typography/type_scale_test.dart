import 'package:app_responsive/app_responsive.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TypeScale — Display', () {
    test('displayXl: fontSize 72, w800', () {
      expect(TypeScale.displayXl.fontSize, 72);
      expect(TypeScale.displayXl.fontWeight, FontWeight.w800);
    });
    test('displayLg: fontSize 60, w700', () {
      expect(TypeScale.displayLg.fontSize, 60);
      expect(TypeScale.displayLg.fontWeight, FontWeight.w700);
    });
    test('displayMd: fontSize 48, w700', () {
      expect(TypeScale.displayMd.fontSize, 48);
      expect(TypeScale.displayMd.fontWeight, FontWeight.w700);
    });
    test('displaySm: fontSize 36, w600', () {
      expect(TypeScale.displaySm.fontSize, 36);
      expect(TypeScale.displaySm.fontWeight, FontWeight.w600);
    });

    test('decrece Xl → Sm', () {
      expect(
        TypeScale.displayXl.fontSize,
        greaterThan(TypeScale.displayLg.fontSize!),
      );
      expect(
        TypeScale.displayLg.fontSize,
        greaterThan(TypeScale.displayMd.fontSize!),
      );
      expect(
        TypeScale.displayMd.fontSize,
        greaterThan(TypeScale.displaySm.fontSize!),
      );
    });
  });

  group('TypeScale — Headline', () {
    test('h1: fontSize 32, w700', () {
      expect(TypeScale.h1.fontSize, 32);
      expect(TypeScale.h1.fontWeight, FontWeight.w700);
    });
    test('h2: fontSize 28, w700', () {
      expect(TypeScale.h2.fontSize, 28);
      expect(TypeScale.h2.fontWeight, FontWeight.w700);
    });
    test('h3: fontSize 24, w600', () {
      expect(TypeScale.h3.fontSize, 24);
      expect(TypeScale.h3.fontWeight, FontWeight.w600);
    });
    test('h4: fontSize 20, w600', () {
      expect(TypeScale.h4.fontSize, 20);
      expect(TypeScale.h4.fontWeight, FontWeight.w600);
    });
    test('h5: fontSize 18, w600', () {
      expect(TypeScale.h5.fontSize, 18);
      expect(TypeScale.h5.fontWeight, FontWeight.w600);
    });
    test('h6: fontSize 16, w600', () {
      expect(TypeScale.h6.fontSize, 16);
      expect(TypeScale.h6.fontWeight, FontWeight.w600);
    });
  });

  group('TypeScale — Title', () {
    test('titleLg: fontSize 20, w500', () {
      expect(TypeScale.titleLg.fontSize, 20);
      expect(TypeScale.titleLg.fontWeight, FontWeight.w500);
    });
    test('titleMd: fontSize 16, w500', () {
      expect(TypeScale.titleMd.fontSize, 16);
      expect(TypeScale.titleMd.fontWeight, FontWeight.w500);
    });
    test('titleSm: fontSize 14, w500', () {
      expect(TypeScale.titleSm.fontSize, 14);
      expect(TypeScale.titleSm.fontWeight, FontWeight.w500);
    });
  });

  group('TypeScale — Body', () {
    test('bodyLg: fontSize 16, w400', () {
      expect(TypeScale.bodyLg.fontSize, 16);
      expect(TypeScale.bodyLg.fontWeight, FontWeight.w400);
    });
    test('bodyMd: fontSize 14, w400', () {
      expect(TypeScale.bodyMd.fontSize, 14);
      expect(TypeScale.bodyMd.fontWeight, FontWeight.w400);
    });
    test('bodySm: fontSize 12, w400', () {
      expect(TypeScale.bodySm.fontSize, 12);
      expect(TypeScale.bodySm.fontWeight, FontWeight.w400);
    });
  });

  group('TypeScale — Label', () {
    test('labelLg: fontSize 14, w500', () {
      expect(TypeScale.labelLg.fontSize, 14);
      expect(TypeScale.labelLg.fontWeight, FontWeight.w500);
    });
    test('labelMd: fontSize 12, w500', () {
      expect(TypeScale.labelMd.fontSize, 12);
      expect(TypeScale.labelMd.fontWeight, FontWeight.w500);
    });
    test('labelSm: fontSize 11, w500', () {
      expect(TypeScale.labelSm.fontSize, 11);
      expect(TypeScale.labelSm.fontWeight, FontWeight.w500);
    });
    test('labelXs: fontSize 10, w500', () {
      expect(TypeScale.labelXs.fontSize, 10);
      expect(TypeScale.labelXs.fontWeight, FontWeight.w500);
    });
  });

  group('TypeScale — Code (monospace)', () {
    test('codeMd: fontSize 14, monospace, w400', () {
      expect(TypeScale.codeMd.fontSize, 14);
      expect(TypeScale.codeMd.fontFamily, 'monospace');
      expect(TypeScale.codeMd.fontWeight, FontWeight.w400);
    });
    test('codeSm: fontSize 12, monospace, w400', () {
      expect(TypeScale.codeSm.fontSize, 12);
      expect(TypeScale.codeSm.fontFamily, 'monospace');
      expect(TypeScale.codeSm.fontWeight, FontWeight.w400);
    });
  });

  group('TypeScale — los estilos son const', () {
    test('misma referencia si se accede dos veces', () {
      expect(identical(TypeScale.h1, TypeScale.h1), isTrue);
    });
  });
}
