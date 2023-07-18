import 'package:toctoc/app/modules/set_home/setHome_page.dart';
import 'package:toctoc/app/modules/set_home/setHome_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:toctoc/app/modules/set_home/set_home_controller.dart';

class SetHomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SetHomeStore(i())),
    Bind.lazySingleton((i) => SetHomeController())
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const SetHomePage()),
  ];

}