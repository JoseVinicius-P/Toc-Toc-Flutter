import 'package:toctoc/app/modules/call/call_page.dart';
import 'package:toctoc/app/modules/call/call_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CallModule extends Module {
  @override
  final List<Bind> binds = [Bind.lazySingleton((i) => CallStore()),];

  @override
  final List<ModularRoute> routes = [ChildRoute('/', child: (_, args) => CallPage()),];

}