import 'package:app_responsive/app_responsive.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ResponsiveValue — todos los tiers definidos', () {
    const v = ResponsiveValue<int>(
      mobile: 1,
      mobileLarge: 2,
      tablet: 3,
      desktop: 4,
      widescreen: 5,
    );

    test('resolve(mobile) = 1', () => expect(v.resolve(DeviceType.mobile), 1));
    test(
      'resolve(mobileLarge) = 2',
      () => expect(v.resolve(DeviceType.mobileLarge), 2),
    );
    test('resolve(tablet) = 3', () => expect(v.resolve(DeviceType.tablet), 3));
    test(
      'resolve(desktop) = 4',
      () => expect(v.resolve(DeviceType.desktop), 4),
    );
    test(
      'resolve(widescreen) = 5',
      () => expect(v.resolve(DeviceType.widescreen), 5),
    );
  });

  group('ResponsiveValue — herencia hacia arriba (cascade)', () {
    const v = ResponsiveValue<int>(mobile: 1, tablet: 3);

    test(
      'mobileLarge hereda de mobile',
      () => expect(v.resolve(DeviceType.mobileLarge), 1),
    );
    test(
      'desktop hereda de tablet',
      () => expect(v.resolve(DeviceType.desktop), 3),
    );
    test(
      'widescreen hereda de desktop (→ tablet)',
      () => expect(v.resolve(DeviceType.widescreen), 3),
    );
  });

  group('ResponsiveValue — solo mobile definido', () {
    const v = ResponsiveValue<String>(mobile: 'base');

    test('todos los tiers devuelven mobile', () {
      for (final d in DeviceType.values) {
        expect(v.resolve(d), 'base', reason: '$d debe heredar "base"');
      }
    });
  });

  group('ResponsiveValue — getters directos', () {
    const v = ResponsiveValue<double>(mobile: 8, tablet: 16, widescreen: 32);

    test('mobile getter', () => expect(v.mobile, 8));
    test('mobileLarge hereda mobile', () => expect(v.mobileLarge, 8));
    test('tablet getter', () => expect(v.tablet, 16));
    test('desktop hereda tablet', () => expect(v.desktop, 16));
    test('widescreen getter', () => expect(v.widescreen, 32));
  });

  group('ResponsiveValue — resolveWidth', () {
    const v = ResponsiveValue<int>(mobile: 1, tablet: 3, desktop: 4);

    test('320 → 1 (mobile)', () => expect(v.resolveWidth(320), 1));
    test(
      '520 → 1 (mobileLarge hereda mobile)',
      () => expect(v.resolveWidth(520), 1),
    );
    test('800 → 3 (tablet)', () => expect(v.resolveWidth(800), 3));
    test('1200 → 4 (desktop)', () => expect(v.resolveWidth(1200), 4));
    test(
      '1920 → 4 (widescreen hereda desktop)',
      () => expect(v.resolveWidth(1920), 4),
    );
  });

  group('ResponsiveValue — tipos genéricos distintos', () {
    test('funciona con bool', () {
      const v = ResponsiveValue<bool>(mobile: false, tablet: true);
      expect(v.resolve(DeviceType.mobile), isFalse);
      expect(v.resolve(DeviceType.tablet), isTrue);
    });

    test('funciona con String', () {
      const v = ResponsiveValue<String>(mobile: 'compact', desktop: 'expanded');
      expect(v.resolve(DeviceType.mobile), 'compact');
      expect(v.resolve(DeviceType.desktop), 'expanded');
    });
  });
}
