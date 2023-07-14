import 'package:flutter_triple/flutter_triple.dart';
import 'package:toctoc/app/modules/perfil/models/user_model.dart';
import 'package:toctoc/app/modules/perfil/services/save_user_data_service.dart';

class YourDataStore extends Store<void> {
  final SaveUserDataService saveUserDataService;

  YourDataStore(this.saveUserDataService) : super(null);

  void saveUserData(String path, UserModel user) async {
    setLoading(true);
    if(path.isNotEmpty){
      saveUserDataService.saveProfilePicture(path);
    }
    if(user.name.isNotEmpty){
      if(await saveUserDataService.saveUserData(user)){
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