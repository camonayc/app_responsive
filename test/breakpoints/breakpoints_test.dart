import 'package:app_responsive/app_responsive.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Breakpoints — constantes', () {
    test('mobile = 0', () => expect(Breakpoints.mobile, 0));
    test('tablet = 600', () => expect(Breakpoints.tablet, 600));
    test('desktop = 1024', () => expect(Breakpoints.desktop, 1024));
    test('widescreen = 1440', () => expect(Breakpoints.widescreen, 1440));
  });

  group('Breakpoints.resolve — zona mobile (< 600)', () {
    test('0 → mobile', () => expect(Breakpoints.resolve(0), DeviceType.mobile));
    test(
      '375 → mobile',
      () => expect(Breakpoints.resolve(375), DeviceType.mobile),
    );
    test(
      '599 → mobile',
      () => expect(Breakpoints.resolve(599), DeviceType.mobile),
    );
  });

  group('Breakpoints.resolve — zona tablet [600, 1024)', () {
    test(
      '600 → tablet',
      () => expect(Breakpoints.resolve(600), DeviceType.tablet),
    );
    test(
      '800 → tablet',
      () => expect(Breakpoints.resolve(800), DeviceType.tablet),
    );
    test(
      '1023 → tablet',
      () => expect(Breakpoints.resolve(1023), DeviceType.tablet),
    );
  });

  group('Breakpoints.resolve — zona desktop [1024, 1440)', () {
    test(
      '1024 → desktop',
      () => expect(Breakpoints.resolve(1024), DeviceType.desktop),
    );
    test(
      '1200 → desktop',
      () => expect(Breakpoints.resolve(1200), DeviceType.desktop),
    );
    test(
      '1439 → desktop',
      () => expect(Breakpoints.resolve(1439), DeviceType.desktop),
    );
  });

  group('Breakpoints.resolve — zona widescreen [1440, ∞)', () {
    test(
      '1440 → widescreen',
      () => expect(Breakpoints.resolve(1440), DeviceType.widescreen),
    );
    test(
      '1920 → widescreen',
      () => expect(Breakpoints.resolve(1920), DeviceType.widescreen),
    );
    test(
      '2560 → widescreen',
      () => expect(Breakpoints.resolve(2560), DeviceType.widescreen),
    );
  });
}
