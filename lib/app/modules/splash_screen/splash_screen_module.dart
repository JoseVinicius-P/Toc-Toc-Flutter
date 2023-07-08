import 'package:toctoc/app/modules/splash_screen/auth_guard_service.dart';
import 'package:toctoc/app/modules/splash_screen/splash_screen_controller.dart';
import 'package:toctoc/app/modules/splash_screen/splash_screen_page.dart';
import 'package:toctoc/app/modules/splash_screen/splash_screen_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashScreenModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SplashScreenStore()),
    Bind.lazySingleton((i) => SplashScreenController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => SplashScreenPage(), guards: [AuthGuardService()]),
  ];

}