import 'package:toctoc/app/modules/complete_registration/complete_registration_controller.dart';
import 'package:toctoc/app/modules/complete_registration/pages/select_sound_page.dart';
import 'package:toctoc/app/modules/complete_registration/stores/select_sound_store.dart';
import 'package:toctoc/app/modules/complete_registration/pages/completeRegistration_page.dart';
import 'package:toctoc/app/modules/complete_registration/stores/completeRegistration_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:toctoc/app/modules/set_home/setHome_module.dart';

class CompleteRegistrationModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SelectSoundStore()),
    Bind.lazySingleton((i) => CompleteRegistrationStore()),
    Bind.lazySingleton((i) => CompleteRegistrationController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const CompleteRegistrationPage()),
    ChildRoute('/select_sound', child: (_, args) => const SelectSoundPage()),
    ModuleRoute('/set_home', module: SetHomeModule()),
  ];

}