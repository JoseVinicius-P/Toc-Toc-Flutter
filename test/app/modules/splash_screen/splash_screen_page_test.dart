import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:toctoc/app/app_module.dart';
import 'package:toctoc/app/modules/splash_screen/auth_guard_service.dart';
import 'package:toctoc/app/modules/splash_screen/splash_screen_module.dart';
import 'package:toctoc/app/modules/splash_screen/splash_screen_page.dart';
import 'package:toctoc/app/shared/widgets/button_blue_rounded_widget.dart';
import 'package:modular_test/modular_test.dart';
import 'package:mocktail/mocktail.dart';

//Para impedir que que o routerguard redirecione
class MockAuthGuard extends Mock implements AuthGuardService{
  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) {
    return true;
  }
}

//Para simular navegação do modular
class ModularNavigateMock extends Mock implements IModularNavigator {}

void main(){
  //Para impedir que que o routerguard redirecione
  final mockAuthGuard = MockAuthGuard();

  //Para simular a navegação do modular
  final navigator = ModularNavigateMock();
  Modular.navigatorDelegate = navigator;

  //Inicializando modulos necessários para execução da tela e substituindo router guard
  setUpAll((){
    initModules([AppModule(), SplashScreenModule()], replaceBinds: [Bind.instance<AuthGuardService>(mockAuthGuard)]);
  });

  testWidgets("Deve redirecionar para o Login", (WidgetTester tester) async {
    //Faz parte da substituição da navegação
    //Quando o pushNamed for chamado no código deverá retornar um future vazio
    when(() => navigator.pushNamed(any())).thenAnswer((_) => Future.value());

    //Deve ser chamado assim porque as telas usam algumas metricas disponibilizadas pelo Resposive app
    await tester.pumpWidget(
      ResponsiveApp(
        builder: (context) {
          return MaterialApp(
            home: SplashScreenPage(),
          );
        }
      )
    );

    final button = find.byType(ButtonBlueRoundedWidget);
    expect(button, findsOneWidget);
    await tester.tap(button);
    await tester.pumpAndSettle();

    //Verificando se o push named foi chamado após a o toque no botão
    verify(() => navigator.pushNamed(any())).called(1);
  });
}