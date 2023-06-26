import 'package:toctoc/app/modules/complete_registration/complete_registration_controller.dart';
import 'package:toctoc/app/modules/complete_registration/select_sound_page.dart';
import 'package:toctoc/app/modules/complete_registration/select_sound_store.dart';
import 'package:toctoc/app/modules/complete_registration/completeRegistration_page.dart';
import 'package:toctoc/app/modules/complete_registration/completeRegistration_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
  ];

}