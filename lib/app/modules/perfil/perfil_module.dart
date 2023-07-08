import 'package:toctoc/app/modules/perfil/perfil_controller.dart';
import 'package:toctoc/app/modules/perfil/pages/select_sound_page.dart';
import 'package:toctoc/app/modules/perfil/stores/select_sound_store.dart';
import 'package:toctoc/app/modules/perfil/pages/your_data_page.dart';
import 'package:toctoc/app/modules/perfil/stores/your_data_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:toctoc/app/modules/set_home/setHome_module.dart';
import 'package:toctoc/app/shared/services/auth_guard_service.dart';

class CompleteRegistrationModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SelectSoundStore()),
    Bind.lazySingleton((i) => YourDataStore()),
    Bind.lazySingleton((i) => CompleteRegistrationController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const YourDataPage(), guards: [AuthGuardService()]),
    ChildRoute('/select_sound', child: (_, args) => const SelectSoundPage(), guards: [AuthGuardService()]),
    ModuleRoute('/set_home', module: SetHomeModule(), guards: [AuthGuardService()]),
  ];

}