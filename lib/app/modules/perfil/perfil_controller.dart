import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:toctoc/app/modules/perfil/services/image_picker_service.dart';

class PerfilController implements Disposable{
  final ImagePickerService imagePickerService;

  PerfilController(this.imagePickerService);

  @override
  void dispose() {

  }

  void toSelectSoundPage(){
    Modular.to.pushNamed('./select_sound');
  }

  void toSetHomeModule(){
    Modular.to.pushNamed('./set_home/');
  }

  FutureOr<String> pickImage() async{
    return await imagePickerService.pickImage();
  }

}