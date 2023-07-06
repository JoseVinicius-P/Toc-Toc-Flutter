import 'package:toctoc/app/modules/create_account/create_account_auth_service.dart';
import 'package:toctoc/app/modules/create_account/createAccount_page.dart';
import 'package:toctoc/app/modules/create_account/createAccount_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:toctoc/app/modules/create_account/create_account_controller.dart';

class CreateAccountModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CreateAccountAuthService()),
    Bind.lazySingleton((i) => CreateAccountController()),
    Bind.lazySingleton((i) => CreateAccountStore(i(), i())),
  ];

  @override
  final List<ModularRoute> routes = [ChildRoute('/', child: (_, args) => CreateAccountPage()),];

}