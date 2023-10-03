import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:toctoc/app/modules/login/pages/login_page.dart';
import 'package:toctoc/app/modules/splash_screen/splash_screen_page.dart';
import 'package:toctoc/app/shared/widgets/button_blue_rounded_widget.dart';
import 'package:toctoc/app/shared/widgets/text_field_widget.dart';
import 'package:toctoc/main.dart' as app;



void main(){
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Teste no loguin', (tester) async {
    await tester.runAsync(() => app.main());
    await tester.pumpAndSettle();
    expect(find.byType(SplashScreenPage), findsOneWidget);

    await tester.tap(find.byType(ButtonBlueRoundedWidget));
    await tester.pumpAndSettle();

    expect(find.byType(LoginPage), findsOneWidget);

    final phoneTextField = find.byType(TextFieldWidget);
    final sendCodeButton = find.byType(ButtonBlueRoundedWidget);
    final errorText = find.textContaining("*");

    expect(phoneTextField, findsOneWidget);
    expect(sendCodeButton, findsOneWidget);
    expect(errorText, findsNothing);

    // Encontrando o TextField dentro do widget phoneTextField
    final textFormField = find.descendant(
      of: phoneTextField,
      matching: find.byType(TextFormField),
    );

    await tester.runAsync(() async => await tester.tap(sendCodeButton));
    await tester.pumpAndSettle();
    expect(errorText, findsOneWidget);
    await tester.runAsync(() async => await Future.delayed(Duration(seconds: 3)));
    await tester.pumpAndSettle();
    expect(errorText, findsNothing);

    await tester.enterText(textFormField, ' ');
    await tester.runAsync(() async => await tester.tap(sendCodeButton));
    await tester.pumpAndSettle();
    expect(errorText, findsOneWidget);
    await tester.runAsync(() async => await Future.delayed(Duration(seconds: 3)));
    await tester.pumpAndSettle();
    expect(errorText, findsNothing);

    String fakePhoneNumber = "";
    for(int i = 1; i < 11; i++) {
      expect(errorText, findsNothing);
      fakePhoneNumber += "9";
      print("Testando com ${fakePhoneNumber.length} digitos");
      await tester.enterText(textFormField, fakePhoneNumber);
      await tester.pump();
      expect(find.textContaining("(9"), findsOneWidget);
      await tester.runAsync(() async => await tester.tap(sendCodeButton));
      await tester.pumpAndSettle();
      expect(errorText, findsOneWidget);
      await tester.runAsync(() async => await Future.delayed(Duration(seconds: 3)));
      await tester.pumpAndSettle();
      expect(errorText, findsNothing);
    }

    // Escrevendo o texto no campo de texto
    await tester.enterText(textFormField, '99999999999');
    await tester.pumpAndSettle();
    // Verifiqcando se o texto foi inserido corretamente
    expect(find.text('(99) 9 9999-9999'), findsOneWidget);

    await tester.tap(find.byType(ButtonBlueRoundedWidget));
    await tester.pumpAndSettle();
  });
}