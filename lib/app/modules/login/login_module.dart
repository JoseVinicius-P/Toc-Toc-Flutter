import 'package:toctoc/app/modules/login/auth_service.dart';
import 'package:toctoc/app/modules/login/login_controller.dart';
import 'package:toctoc/app/modules/login/login_page.dart';
import 'package:toctoc/app/modules/login/login_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => AuthService()),
    Bind.lazySingleton((i) => LoginStore()),
    Bind.lazySingleton((i) => LoginController(authService: i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => LoginPage()),
  ];

}