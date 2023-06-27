import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toctoc/app/modules/complete_registration/widgets/select_avatar_widget.dart';
import 'package:flutter_test/flutter_test.dart';

// Função auxiliar para envolver os widgets a serem testados.
Widget buildTestableWidget(Widget widget) => MaterialApp(home: widget);

main() {
  group('SelectAvatarWidget', () {
    testWidgets('has a title and message', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget(SelectAvatarWidget(title: 'T')));
      final titleFinder = find.text('T');
      expect(titleFinder, findsOneWidget);
    });
  });
}