import 'package:toctoc/app/shared/services/screen_service.dart';
import 'package:toctoc/app/modules/call/call_module.dart';
import 'package:toctoc/app/modules/perfil/your_data/services/user_data_service.dart';
import 'package:toctoc/app/modules/perfil/set_home/services/home_service.dart';
import 'package:toctoc/app/shared/services/auth_service.dart';
import 'package:toctoc/app/shared/services/auth_guard_service.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:toctoc/app/modules/perfil/perfil_module.dart';
import 'package:toctoc/app/modules/home/home_module.dart';
import 'package:toctoc/app/modules/login/login_module.dart';
import 'package:toctoc/app/modules/splash_screen/splash_screen_module.dart';
import 'package:toctoc/app/shared/services/notification_service.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ScreenService()),
    Bind.lazySingleton((i) => HomeService()),
    Bind.lazySingleton((i) => AuthService()),
    Bind.lazySingleton((i) => AuthGuardService()),
    Bind.lazySingleton((i) => UserDataService()),
    Bind.lazySingleton((i) => NotificationService()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/', module: SplashScreenModule()),
    ModuleRoute('/login', module: LoginModule()),
    ModuleRoute('/home', module: HomeModule()),
    ModuleRoute('/perfil', module: PerfilModule()),
    ModuleRoute('/call', module: CallModule()),
  ];
}