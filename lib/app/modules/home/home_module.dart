import 'package:flutter_modular/flutter_modular.dart';
import 'package:toctoc/app/modules/home/home_controller.dart';
import 'package:toctoc/app/modules/perfil/perfil_module.dart';
import 'home_store.dart'; 

import 'home_page.dart';
 
class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeStore()),
    Bind.lazySingleton((i) => HomeController()),
  ];

 @override
 final List<ModularRoute> routes = [
   ChildRoute('/', child: (_, args) => HomePage(), children: [
     ModuleRoute('./perfil', module: PerfilModule()),
   ]),

 ];
}