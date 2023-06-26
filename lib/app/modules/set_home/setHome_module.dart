import 'package:toctoc/app/modules/set_home/setHome_page.dart';
import 'package:toctoc/app/modules/set_home/setHome_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SetHomeModule extends Module {
  @override
  final List<Bind> binds = [Bind.lazySingleton((i) => SetHomeStore()),];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => SetHomePage()),
  ];

}