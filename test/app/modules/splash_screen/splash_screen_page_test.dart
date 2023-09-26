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
import 'package:mockito/mockito.dart';
import 'package:modular_test/modular_test.dart';

class MockAuthGuard extends Mock implements AuthGuardService{
  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) {
    return true;
  }
}

void main(){
  final mockAuthGuard = MockAuthGuard();
  setUpAll((){
    initModules([AppModule(), SplashScreenModule()], replaceBinds: [Bind.instance<AuthGuardService>(mockAuthGuard)]);
  });


  testWidgets("Teste Splash Screen", (WidgetTester tester) async {
    await tester.pumpWidget(
      ResponsiveApp(
        builder: (context) {
          return MaterialApp(
            home: SplashScreenPage(),
          );
        }
      )
    );

    final buttonVamosComecar = find.byType(ButtonBlueRoundedWidget);
    expect(buttonVamosComecar, findsOneWidget);
  });
}