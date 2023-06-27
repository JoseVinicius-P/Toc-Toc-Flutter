import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toctoc/app/modules/complete_registration/pages/select_sound_page.dart';
import 'package:flutter_test/flutter_test.dart';

// Função auxiliar para envolver os widgets a serem testados.
Widget buildTestableWidget(Widget widget) => MaterialApp(home: widget);

main() {
  group('SelectSoundPage', () {
    testWidgets('has a title and message', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget(SelectSoundPage(title: 'T')));
      final titleFinder = find.text('T');
      expect(titleFinder, findsOneWidget);
    });
  });
}