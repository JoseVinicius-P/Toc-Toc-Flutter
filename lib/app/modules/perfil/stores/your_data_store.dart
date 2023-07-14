import 'package:flutter_triple/flutter_triple.dart';
import 'package:toctoc/app/modules/perfil/models/user_model.dart';
import 'package:toctoc/app/modules/perfil/services/user_data_service.dart';
import 'package:toctoc/app/modules/perfil/perfil_controller.dart';

class YourDataStore extends Store<void> {
  final UserDataService saveUserDataService;
  final PerfilController controller;

  YourDataStore(this.saveUserDataService, this.controller) : super(null);

  void saveUserData(String path, UserModel user) async {
    setLoading(true);
    if(path.isNotEmpty){
      saveUserDataService.saveProfilePicture(path);
    }
    if(user.name.isNotEmpty){
      if(await saveUserDataService.saveUserData(user)){
        controller.toSelectSoundPage();
        setLoading(false);
      }else{
        setError("Não foi possível salvar os dados, tente novamente!");
      }
    }else{
      setError("Digite um nome de usuário");
    }
    setLoading(false);
  }

}