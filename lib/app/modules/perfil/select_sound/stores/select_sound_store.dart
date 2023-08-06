import 'dart:async';

import 'package:flutter_triple/flutter_triple.dart';
import 'package:toctoc/app/modules/perfil/user_model.dart';
import 'package:toctoc/app/modules/perfil/your_data/services/user_data_service.dart';
import 'package:toctoc/app/modules/perfil/perfil_controller.dart';
import 'package:toctoc/app/modules/perfil/perfil_store.dart';

class SelectSoundStore extends Store<String> {

  final UserDataService service;
  final PerfilController controller;
  final PerfilStore perfilStore;
  Timer? timer;

  SelectSoundStore(this.service, this.controller, this.perfilStore) : super("");

  @override
  void setError(newError, {bool force = false}) {
    super.setError(newError);
    if(newError != null){
      if(timer != null) {
        timer!.cancel();
      }
      timer = Timer(const Duration(seconds: 3), () {
        setError("");
      });
    }
  }

  void saveSound(Function whenToComplete) async {
    setLoading(true);
    if(state.isNotEmpty){
      if(await service.saveSound(state)){
        perfilStore.setSound(state);
        whenToComplete();
      }else{
        setError("Algo deu errado, tente novamente!");
        setLoading(false);
      }
    }else{
      setError("Selecione um dos sons abaixo!");
      setLoading(false);
    }
  }

  void getSoundSelected() async {
    UserModel user = UserModel.empty();
    user.fromDocumentSnapshot(await service.getUserData());
    if(user.sound.isNotEmpty){
      selectSound(user.sound);
    }
  }

  void selectSound(String nameSound){
    update(nameSound);
  }

}