import 'package:app_responsive/app_responsive.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Breakpoints — constantes', () {
    test('mobile = 0', () => expect(Breakpoints.mobile, 0));
    test('mobileLarge = 480', () => expect(Breakpoints.mobileLarge, 480));
    test('tablet = 768', () => expect(Breakpoints.tablet, 768));
    test('desktop = 1024', () => expect(Breakpoints.desktop, 1024));
    test('widescreen = 1440', () => expect(Breakpoints.widescreen, 1440));
  });

  group('Breakpoints.resolve — zona mobile (< 480)', () {
    test('0 → mobile', () => expect(Breakpoints.resolve(0), DeviceType.mobile));
    test(
      '320 → mobile',
      () => expect(Breakpoints.resolve(320), DeviceType.mobile),
    );
    test(
      '479 → mobile',
      () => expect(Breakpoints.resolve(479), DeviceType.mobile),
    );
  });

  group('Breakpoints.resolve — zona mobileLarge [480, 768)', () {
    test(
      '480 → mobileLarge',
      () => expect(Breakpoints.resolve(480), DeviceType.mobileLarge),
    );
    test(
      '600 → mobileLarge',
      () => expect(Breakpoints.resolve(600), DeviceType.mobileLarge),
    );
    test(
      '767 → mobileLarge',
      () => expect(Breakpoints.resolve(767), DeviceType.mobileLarge),
    );
  });

  group('Breakpoints.resolve — zona tablet [768, 1024)', () {
    test(
      '768 → tablet',
      () => expect(Breakpoints.resolve(768), DeviceType.tablet),
    );
    test(
      '900 → tablet',
      () => expect(Breakpoints.resolve(900), DeviceType.tablet),
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
