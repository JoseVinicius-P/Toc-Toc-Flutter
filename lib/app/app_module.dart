import 'package:toctoc/app/modules/perfil/services/user_data_service.dart';
import 'package:toctoc/app/modules/set_home/services/home_service.dart';
import 'package:toctoc/app/modules/set_home/set_home_module.dart';
import 'package:toctoc/app/shared/services/auth_service.dart';
import 'package:toctoc/app/shared/services/auth_guard_service.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:toctoc/app/modules/perfil/perfil_module.dart';
import 'package:toctoc/app/modules/home/home_module.dart';
import 'package:toctoc/app/modules/login/login_module.dart';
import 'package:toctoc/app/modules/splash_screen/splash_screen_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeService()),
    Bind.lazySingleton((i) => AuthService()),
    Bind.lazySingleton((i) => AuthGuardService()),
    Bind.lazySingleton((i) => UserDataService()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/', module: SplashScreenModule()),
    ModuleRoute('/login', module: LoginModule()),
    ModuleRoute('/home', module: HomeModule()),
    ModuleRoute('/perfil', module: PerfilModule()),
    ModuleRoute('/set_home', module: SetHomeModule()),
  ];

}