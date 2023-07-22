import 'package:flutter_triple/flutter_triple.dart';
import 'package:toctoc/app/modules/perfil/your_data/services/user_data_service.dart';
import 'package:toctoc/app/modules/perfil/perfil_controller.dart';

class SelectSoundStore extends Store<String> {

  final UserDataService service;
  final PerfilController controller;

  SelectSoundStore(this.service, this.controller) : super("");

  void saveSound(Function whenToComplete) async {
    setLoading(true);
    if(state.isNotEmpty){
      if(await service.saveSound(state)){
        whenToComplete();
      }else{
        setError("Algo deu errado, tente novamente!");
        setLoading(false);
      }
    }else{
      setError("Selecione um som");
      setLoading(false);
    }
  }

  void selectSound(String nameSound){
    update(nameSound);
  }

}