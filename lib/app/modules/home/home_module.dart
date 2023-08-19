import 'package:toctoc/app/modules/home/friend_list/stores/select_friend_store.dart';
import 'package:toctoc/app/modules/home/services/token_service.dart';
import 'package:toctoc/app/modules/home/services/friend_service.dart';
import 'package:toctoc/app/modules/home/friend_list/stores/friend_list_store.dart';
import 'package:toctoc/app/modules/home/add_friend/add_friend_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:toctoc/app/modules/home/home_controller.dart';
import 'package:toctoc/app/modules/perfil/perfil_module.dart';
import 'package:toctoc/app/shared/services/notification_guard_service.dart';
import 'home_store.dart'; 

import 'home_page.dart';
 
class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SelectFriendStore(i())),
    Bind.lazySingleton((i) => TokenService()),
    Bind.lazySingleton((i) => FriendListStore(i())),
    Bind.lazySingleton((i) => FriendService()),
    Bind.lazySingleton((i) => AddFriendStore(i(), i())),
    Bind.lazySingleton((i) => HomeStore()),
    Bind.lazySingleton((i) => HomeController(i())),
  ];

 @override
 final List<ModularRoute> routes = [
   ChildRoute('/', child: (_, args) => HomePage(), children: [
     ModuleRoute('./perfil', module: PerfilModule()),
   ], guards: [NotificationGuardService()]),

 ];
}