import 'package:app_responsive/app_responsive.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// Monta un widget con un [MediaQuery] que reporta [width] px de ancho.
Widget _withWidth(double width, Widget child) => MediaQuery(
  data: MediaQueryData(size: Size(width, 900)),
  child: Directionality(textDirection: TextDirection.ltr, child: child),
);

void main() {
  group('ResponsiveContext.deviceType', () {
    testWidgets('375 → mobile', (tester) async {
      late DeviceType dt;
      await tester.pumpWidget(
        _withWidth(
          375,
          Builder(
            builder: (ctx) {
              dt = ctx.deviceType;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      expect(dt, DeviceType.mobile);
    });

    testWidgets('520 → mobileLarge', (tester) async {
      late DeviceType dt;
      await tester.pumpWidget(
        _withWidth(
          520,
          Builder(
            builder: (ctx) {
              dt = ctx.deviceType;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      expect(dt, DeviceType.mobileLarge);
    });

    testWidgets('800 → tablet', (tester) async {
      late DeviceType dt;
      await tester.pumpWidget(
        _withWidth(
          800,
          Builder(
            builder: (ctx) {
              dt = ctx.deviceType;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      expect(dt, DeviceType.tablet);
    });

    testWidgets('1200 → desktop', (tester) async {
      late DeviceType dt;
      await tester.pumpWidget(
        _withWidth(
          1200,
          Builder(
            builder: (ctx) {
              dt = ctx.deviceType;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      expect(dt, DeviceType.desktop);
    });

    testWidgets('1920 → widescreen', (tester) async {
      late DeviceType dt;
      await tester.pumpWidget(
        _withWidth(
          1920,
          Builder(
            builder: (ctx) {
              dt = ctx.deviceType;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      expect(dt, DeviceType.widescreen);
    });
  });

  group('ResponsiveContext — flags booleanos', () {
    Future<Map<String, bool>> flags(WidgetTester t, double width) async {
      late Map<String, bool> result;
      await t.pumpWidget(
        _withWidth(
          width,
          Builder(
            builder: (ctx) {
              result = {
                'isMobile': ctx.isMobile,
                'isMobileLarge': ctx.isMobileLarge,
                'isTablet': ctx.isTablet,
                'isDesktop': ctx.isDesktop,
                'isWidescreen': ctx.isWidescreen,
                'isMobileFamily': ctx.isMobileFamily,
                'isTabletOrLarger': ctx.isTabletOrLarger,
                'isDesktopFamily': ctx.isDesktopFamily,
              };
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      return result;
    }

    testWidgets('mobile (375)', (tester) async {
      final f = await flags(tester, 375);
      expect(f['isMobile'], isTrue);
      expect(f['isMobileLarge'], isFalse);
      expect(f['isMobileFamily'], isTrue);
      expect(f['isTabletOrLarger'], isFalse);
      expect(f['isDesktopFamily'], isFalse);
    });

    testWidgets('mobileLarge (520)', (tester) async {
      final f = await flags(tester, 520);
      expect(f['isMobile'], isFalse);
      expect(f['isMobileLarge'], isTrue);
      expect(f['isMobileFamily'], isTrue);
      expect(f['isTabletOrLarger'], isFalse);
    });

    testWidgets('tablet (900)', (tester) async {
      final f = await flags(tester, 900);
      expect(f['isTablet'], isTrue);
      expect(f['isMobileFamily'], isFalse);
      expect(f['isTabletOrLarger'], isTrue);
      expect(f['isDesktopFamily'], isFalse);
    });

    testWidgets('desktop (1200)', (tester) async {
      final f = await flags(tester, 1200);
      expect(f['isDesktop'], isTrue);
      expect(f['isDesktopFamily'], isTrue);
      expect(f['isTabletOrLarger'], isTrue);
    });

    testWidgets('widescreen (1600)', (tester) async {
      final f = await flags(tester, 1600);
      expect(f['isWidescreen'], isTrue);
      expect(f['isDesktopFamily'], isTrue);
    });
  });

  group('ResponsiveContext — screenWidth / screenHeight', () {
    testWidgets('refleja el tamaño del MediaQuery', (tester) async {
      late double w, h;
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(412, 915)),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Builder(
              builder: (ctx) {
                w = ctx.screenWidth;
                h = ctx.screenHeight;
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );
      expect(w, 412);
      expect(h, 915);
    });
  });

  group('ResponsiveContext.responsive<T>', () {
    Future<int> resolve(WidgetTester t, double width) async {
      late int val;
      await t.pumpWidget(
        _withWidth(
          width,
          Builder(
            builder: (ctx) {
              val = ctx.responsive<int>(
                mobile: 1,
                mobileLarge: 2,
                tablet: 3,
                desktop: 4,
                widescreen: 5,
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      return val;
    }

    testWidgets(
      'devuelve 1 en mobile (375)',
      (t) async => expect(await resolve(t, 375), 1),
    );
    testWidgets(
      'devuelve 2 en mobileLarge (520)',
      (t) async => expect(await resolve(t, 520), 2),
    );
    testWidgets(
      'devuelve 3 en tablet (800)',
      (t) async => expect(await resolve(t, 800), 3),
    );
    testWidgets(
      'devuelve 4 en desktop (1200)',
      (t) async => expect(await resolve(t, 1200), 4),
    );
    testWidgets(
      'devuelve 5 en widescreen (1600)',
      (t) async => expect(await resolve(t, 1600), 5),
    );

    testWidgets('hereda hacia arriba cuando el tier no está definido', (
      tester,
    ) async {
      late int val;
      await tester.pumpWidget(
        _withWidth(
          1200,
          Builder(
            builder: (ctx) {
              val = ctx.responsive<int>(mobile: 1, tablet: 3);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      // desktop hereda de tablet
      expect(val, 3);
    });
  });
}
