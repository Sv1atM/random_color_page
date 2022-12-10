import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_app/src/ui/ui.dart';
import 'package:test_app/src/utils/utils.dart';

import 'widget_tests.mocks.dart';

@GenerateMocks([ColorGenerator])
void main() {
  group(
    'ColorfulPage test',
    () {
      const text = 'Some text';
      const initialColor = Colors.green;
      late ColorGenerator generator;

      setUp(() => generator = MockColorGenerator());

      Widget createWidgetToTest() => MaterialApp(
            home: ColorfulPage(
              generator: generator,
              text: text,
            ),
          );

      testWidgets(
        'The page contains a Scaffold and correct text',
        (widgetTester) async {
          when(generator.generate()).thenReturn(initialColor);

          final widget = createWidgetToTest();
          await widgetTester.pumpWidget(widget);

          expect(find.byType(Scaffold), findsOneWidget);
          expect(find.text(text), findsOneWidget);
        },
        skip: false,
      );

      testWidgets(
        'Random color is set just after the widget is created',
        (widgetTester) async {
          const someColor = Colors.amberAccent;
          when(generator.generate()).thenReturn(someColor);

          final widget = createWidgetToTest();
          await widgetTester.pumpWidget(widget);
          final scaffoldFinder = find.byType(Scaffold);

          expect(
            widgetTester.firstWidget<Scaffold>(scaffoldFinder).backgroundColor,
            someColor,
          );
          verify(generator.generate()).called(1);
        },
        skip: false,
      );

      testWidgets(
        'Scaffold background color is changed after user taps on it',
        (widgetTester) async {
          when(generator.generate()).thenReturn(initialColor);

          final widget = createWidgetToTest();
          await widgetTester.pumpWidget(widget);
          final scaffoldFinder = find.byType(Scaffold);
          final tappableAreaFinder = find.byKey(tappableAreaKey);
          final textFinder = find.text(text);

          expect(
            widgetTester.firstWidget<Scaffold>(scaffoldFinder).backgroundColor,
            initialColor,
          );

          const colorAfterTap = Colors.red;
          when(generator.generate()).thenReturn(colorAfterTap);

          final tappableAreaOrigin =
              widgetTester.getTopLeft(tappableAreaFinder);
          final textOrigin = widgetTester.getTopLeft(textFinder);
          final tapLocation = Offset(
            (textOrigin.dx + tappableAreaOrigin.dx) / 2,
            (textOrigin.dy + tappableAreaOrigin.dy) / 2,
          );
          await widgetTester.tapAt(tapLocation);
          await widgetTester.pump();

          expect(
            widgetTester.firstWidget<Scaffold>(scaffoldFinder).backgroundColor,
            colorAfterTap,
          );
        },
        skip: false,
      );

      testWidgets(
        'Scaffold background color is changed after user taps on the text',
        (widgetTester) async {
          when(generator.generate()).thenReturn(initialColor);

          final widget = createWidgetToTest();
          await widgetTester.pumpWidget(widget);
          final scaffoldFinder = find.byType(Scaffold);
          final textFinder = find.text(text);

          expect(
            widgetTester.firstWidget<Scaffold>(scaffoldFinder).backgroundColor,
            initialColor,
          );

          const colorAfterTap = Colors.blue;
          when(generator.generate()).thenReturn(colorAfterTap);

          await widgetTester.tap(textFinder);
          await widgetTester.pump();

          expect(
            widgetTester.firstWidget<Scaffold>(scaffoldFinder).backgroundColor,
            colorAfterTap,
          );
        },
        skip: false,
      );
    },
    skip: false,
  );
}
