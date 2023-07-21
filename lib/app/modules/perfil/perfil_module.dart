import 'package:toctoc/app/modules/perfil/pages/perfil_page.dart';
import 'package:toctoc/app/modules/perfil/services/user_data_guard_service.dart';
import 'package:toctoc/app/modules/perfil/stores/sound_reproduction_store.dart';
import 'package:toctoc/app/modules/perfil/services/local_sounds_service.dart';
import 'package:toctoc/app/modules/perfil/services/user_data_service.dart';
import 'package:toctoc/app/modules/perfil/stores/select_avatar_store.dart';
import 'package:toctoc/app/modules/perfil/services/image_picker_service.dart';
import 'package:toctoc/app/modules/perfil/perfil_controller.dart';
import 'package:toctoc/app/modules/perfil/pages/select_sound_page.dart';
import 'package:toctoc/app/modules/perfil/stores/select_sound_store.dart';
import 'package:toctoc/app/modules/perfil/pages/your_data_page.dart';
import 'package:toctoc/app/modules/perfil/stores/your_data_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:toctoc/app/shared/services/auth_guard_service.dart';

class PerfilModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => UserDataGuardService()),
    Bind.lazySingleton((i) => SoundReproductionStore(i())),
    Bind.lazySingleton((i) => LoacalSoundsService()),
    Bind.lazySingleton((i) => UserDataService()),
    Bind.lazySingleton((i) => ImagePickerService()),
    Bind.lazySingleton((i) => SelectSoundStore(i(), i())),
    Bind.lazySingleton((i) => YourDataStore(i(), i(), i())),
    Bind.lazySingleton((i) => SelectAvatarStore(i())),
    Bind.lazySingleton((i) => PerfilController(i(), i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const PerfilPage()),
    ChildRoute('/your_data', child: (_, args) => const YourDataPage(), guards: [AuthGuardService(), UserDataGuardService()]),
    ChildRoute('/select_sound', child: (_, args) => const SelectSoundPage(), guards: [AuthGuardService(), UserDataGuardService()]),
  ];

}