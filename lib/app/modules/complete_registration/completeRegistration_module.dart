import 'package:toctoc/app/modules/complete_registration/completeRegistration_page.dart';
import 'package:toctoc/app/modules/complete_registration/completeRegistration_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CompleteRegistrationModule extends Module {
  @override
  final List<Bind> binds = [Bind.lazySingleton((i) => CompleteRegistrationStore()),];

  @override
  final List<ModularRoute> routes = [ChildRoute('/', child: (_, args) => CompleteRegistrationPage()),];

}