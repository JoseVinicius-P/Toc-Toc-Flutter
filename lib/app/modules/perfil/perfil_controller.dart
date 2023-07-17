import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:toctoc/app/modules/perfil/services/image_picker_service.dart';
import 'package:toctoc/app/modules/perfil/services/local_sounds_service.dart';

class PerfilController implements Disposable{
  final ImagePickerService imagePickerService;
  final LoacalSoundsService soundsService;
  TextEditingController textEditingController = TextEditingController();

  PerfilController(this.imagePickerService, this.soundsService);

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

  Future<List<String>> findSounds(BuildContext context) async {
    return await soundsService.findSounds(context);
  }

}