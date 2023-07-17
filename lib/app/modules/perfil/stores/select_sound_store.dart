import 'package:flutter_triple/flutter_triple.dart';
import 'package:toctoc/app/modules/perfil/services/user_data_service.dart';
import 'package:toctoc/app/modules/perfil/perfil_controller.dart';

class SelectSoundStore extends Store<String> {

  final UserDataService service;
  final PerfilController controller;

  SelectSoundStore(this.service, this.controller) : super("");

  void saveSound(String nameSound) async {
    setLoading(true);
    if(state.isNotEmpty){
      if(await service.saveSound(nameSound)){
        controller.toSetHomeModule();
      }else{
        setError("Algo deu errado, tente novamente!");
      }
    }else{
      setError("Selecione um som");
    }
    setLoading(false);
  }

  void selectSound(String nameSound){
    update(nameSound);
  }

}