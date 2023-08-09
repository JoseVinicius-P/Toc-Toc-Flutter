import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toctoc/app/modules/perfil/your_data/services/image_picker_service.dart';
import 'package:toctoc/app/modules/perfil/select_sound/local_sounds_service.dart';

class PerfilController implements Disposable{
  final ImagePickerService imagePickerService;
  final LoacalSoundsService soundsService;
  MapController mapController = MapController();
  TextEditingController textEditingController = TextEditingController();

  PerfilController(this.imagePickerService, this.soundsService);

  @override
  void dispose() {

  }

  void toSelectSoundPage(){
    Modular.to.pushNamed('./select_sound');
  }

  void toSetHomeModule(){
    Modular.to.pushNamed('./set_home');
  }

  FutureOr<String> pickImage() async{
    return await imagePickerService.pickImage();
  }

  Future<List<String>> findSounds(BuildContext context) async {
    return await soundsService.findSounds(context);
  }

  void signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(await prefs.clear()){
      await FirebaseMessaging.instance.deleteToken();
      await FirebaseAuth.instance.signOut().then((value) => Modular.to.navigate('/login/'));
    }
  }

}