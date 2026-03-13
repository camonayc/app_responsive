import 'package:app_responsive/app_responsive.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DeviceType — valores del enum', () {
    test('tiene exactamente 4 valores', () {
      expect(DeviceType.values.length, 4);
    });

    test('orden correcto de índices', () {
      expect(DeviceType.mobile.index, 0);
      expect(DeviceType.tablet.index, 1);
      expect(DeviceType.desktop.index, 2);
      expect(DeviceType.widescreen.index, 3);
    });

    test('índices ascendentes mobile → widescreen', () {
      const ordered = DeviceType.values;
      for (var i = 0; i < ordered.length - 1; i++) {
        expect(ordered[i].index, lessThan(ordered[i + 1].index));
      }
    });
  });

  group('DeviceType.isMobileFamily', () {
    test(
      'mobile → true',
      () => expect(DeviceType.mobile.isMobileFamily, isTrue),
    );
    test(
      'tablet → false',
      () => expect(DeviceType.tablet.isMobileFamily, isFalse),
    );
    test(
      'desktop → false',
      () => expect(DeviceType.desktop.isMobileFamily, isFalse),
    );
    test(
      'widescreen → false',
      () => expect(DeviceType.widescreen.isMobileFamily, isFalse),
    );
  });

  group('DeviceType.isTabletOrLarger', () {
    test(
      'mobile → false',
      () => expect(DeviceType.mobile.isTabletOrLarger, isFalse),
    );
    test(
      'tablet → true',
      () => expect(DeviceType.tablet.isTabletOrLarger, isTrue),
    );
    test(
      'desktop → true',
      () => expect(DeviceType.desktop.isTabletOrLarger, isTrue),
    );
    test(
      'widescreen → true',
      () => expect(DeviceType.widescreen.isTabletOrLarger, isTrue),
    );
  });

  group('DeviceType.isDesktopFamily', () {
    test(
      'mobile → false',
      () => expect(DeviceType.mobile.isDesktopFamily, isFalse),
    );
    test(
      'tablet → false',
      () => expect(DeviceType.tablet.isDesktopFamily, isFalse),
    );
    test(
      'desktop → true',
      () => expect(DeviceType.desktop.isDesktopFamily, isTrue),
    );
    test(
      'widescreen → true',
      () => expect(DeviceType.widescreen.isDesktopFamily, isTrue),
    );
  });
}
