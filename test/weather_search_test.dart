import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tenkoyoho2/screen/weather_search/weather_search_screen.dart';

void main() {
  testWidgets(
    'Test in widget FLutter',
    (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(
        const MaterialApp(
          home: WeatherSearchScreen(),
        ),
      );

      // Verify that our counter starts at 0.
      expect(
        find.text('Select a City of Country'),
        findsOneWidget,
      );
      expect(
        find.byType(Image),
        findsOneWidget,
      );
      expect(
        find.byType(IconButton),
        findsWidgets,
      );
      expect(
        find.byType(SvgPicture),
        findsOneWidget,
      );
    },
  );
}
