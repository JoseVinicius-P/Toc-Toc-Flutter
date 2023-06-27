
import 'package:flutter_modular/flutter_modular.dart';
import 'package:toctoc/app/modules/complete_registration/completeRegistration_module.dart';
import 'package:toctoc/app/modules/home/home_module.dart';
import 'package:toctoc/app/modules/login/login_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/', module: LoginModule()),
    ModuleRoute('/home', module: HomeModule()),
    ModuleRoute('/complete_registration', module: CompleteRegistrationModule())
  ];

}