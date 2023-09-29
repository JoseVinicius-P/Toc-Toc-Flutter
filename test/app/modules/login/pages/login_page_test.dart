import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_test/modular_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:toctoc/app/app_module.dart';
import 'package:toctoc/app/modules/login/login_module.dart';
import 'package:toctoc/app/modules/login/pages/login_page.dart';
import 'package:toctoc/app/shared/widgets/button_blue_rounded_widget.dart';
import 'package:toctoc/app/shared/widgets/text_field_widget.dart';

// Função auxiliar para envolver os widgets a serem testados.
Widget buildTestableWidget(Widget widget) =>
    ResponsiveApp(builder: (context) => MaterialApp(home: widget));

//Para simular navegação do modular
class ModularNavigateMock extends Mock implements IModularNavigator {}

void main(){

  //Para simular a navegação do modular
  final navigator = ModularNavigateMock();
  Modular.navigatorDelegate = navigator;

  //Inicializando modulos necessários para execução da tela e substituindo router guard
  setUpAll((){
    initModule(AppModule());
    initModule(LoginModule());
  });

  testWidgets('Deve chamar o pop do modular no botão de voltar', (tester) async {
    //Faz parte da substituição da navegação
    //Quando o pop for chamado no código deverá retornar um future vazio
    when(() => navigator.pop()).thenAnswer((_) => Future.value());
    await tester.pumpWidget(buildTestableWidget(LoginPage()));
    final backButton = find.byType(IconButton);
    expect(backButton, findsOneWidget);
    await tester.tap(backButton);
    await tester.pumpAndSettle();
    //Verificando se o pop foi chamado após a o toque no botão
    verify(() => navigator.pop()).called(1);
  });

  group('Deve mostrar um erro no campo de telefone', () {

    testWidgets('Quando o campo está vazio', (tester) async {
      await tester.pumpWidget(buildTestableWidget(LoginPage()));

      final phoneTextField = find.byType(TextFieldWidget);
      final sendCodeButton = find.byType(ButtonBlueRoundedWidget);
      final errorText = find.textContaining("*");

      expect(phoneTextField, findsOneWidget);
      expect(sendCodeButton, findsOneWidget);
      expect(errorText, findsNothing);

      await tester.runAsync(() async => await tester.tap(sendCodeButton));
      await tester.pump();
      expect(errorText, findsOneWidget);
      await tester.runAsync(() async => await Future.delayed(Duration(seconds: 3)));
      await tester.pump();
      expect(errorText, findsNothing);

    });

    testWidgets('Quanto o campo tem espaços em branco', (tester) async {
      await tester.pumpWidget(buildTestableWidget(LoginPage()));

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

      await tester.enterText(textFormField, ' ');
      await tester.runAsync(() async => await tester.tap(sendCodeButton));
      await tester.pump();
      expect(errorText, findsOneWidget);
      await tester.runAsync(() async => await Future.delayed(Duration(seconds: 3)));
      await tester.pump();
      expect(errorText, findsNothing);
    });

    testWidgets('Quanto não tem um numero completo', (tester) async {
      await tester.pumpWidget(buildTestableWidget(LoginPage()));

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

      String fakePhoneNumber = "";
      for(int i = 1; i < 11; i++) {
        expect(errorText, findsNothing);
        fakePhoneNumber += "9";
        print("Testando com ${fakePhoneNumber.length} digitos");
        await tester.enterText(textFormField, fakePhoneNumber);
        await tester.pump();
        expect(find.textContaining("(9"), findsOneWidget);
        await tester.runAsync(() async => await tester.tap(sendCodeButton));
        await tester.pump();
        expect(errorText, findsOneWidget);
        await tester.runAsync(() async => await Future.delayed(Duration(seconds: 3)));
        await tester.pump();
        expect(errorText, findsNothing);
      }
    });
  });

  testWidgets("Deve ter uma mascara no campo telefone", (tester) async {
    await tester.pumpWidget(buildTestableWidget(LoginPage()));

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

    // Escrevendo o texto no campo de texto
    await tester.enterText(textFormField, '99999999999');
    await tester.pump();
    // Verifiqcando se o texto foi inserido corretamente
    expect(find.text('(99) 9 9999-9999'), findsOneWidget);
  });

}