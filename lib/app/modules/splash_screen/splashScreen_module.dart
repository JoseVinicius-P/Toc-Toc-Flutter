import 'package:toctoc/app/modules/splash_screen/splashScreen_page.dart';
import 'package:toctoc/app/modules/splash_screen/splashScreen_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashScreenModule extends Module {
  @override
  final List<Bind> binds = [Bind.lazySingleton((i) => SplashScreenStore()),];

  @override
  final List<ModularRoute> routes = [ChildRoute('/', child: (_, args) => SplashScreenPage()),];

}