import 'package:toctoc/app/modules/create_account/createAccount_page.dart';
import 'package:toctoc/app/modules/create_account/createAccount_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CreateAccountModule extends Module {
  @override
  final List<Bind> binds = [Bind.lazySingleton((i) => CreateAccountStore()),];

  @override
  final List<ModularRoute> routes = [ChildRoute('/', child: (_, args) => CreateAccountPage()),];

}