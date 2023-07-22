import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:toctoc/app/modules/perfil/user_model.dart';
import 'package:toctoc/app/modules/perfil/your_data/services/user_data_service.dart';
import 'package:toctoc/app/modules/perfil/perfil_controller.dart';
import 'package:toctoc/app/modules/perfil/your_data/stores/select_avatar_store.dart';
import 'package:toctoc/app/modules/perfil/perfil_store.dart';

class YourDataStore extends Store<void> {
  final SelectAvatarStore selectAvatarStore;
  final UserDataService userDataService;
  final PerfilController controller;
  final PerfilStore perfilStore;

  YourDataStore(this.userDataService, this.controller, this.selectAvatarStore, this.perfilStore) : super(null);

  void saveUserData(Function whenToComplete) async {
    String path = selectAvatarStore.state;
    UserModel user = UserModel.onlyName(name: controller.textEditingController.text);
    setLoading(true);
    if(path.isNotEmpty){
      userDataService.saveProfilePicture(path);
    }
    if(user.name.isNotEmpty){
      if(await userDataService.saveUserData(user)){
        perfilStore.setName(user.name);
        whenToComplete();
        setLoading(false);
      }else{
        setError("Não foi possível salvar os dados, tente novamente!");
      }
    }else{
      setError("Digite um nome de usuário");
    }
    setLoading(false);
  }

  void loadUserdata() async {
    setLoading(true);
    DocumentSnapshot snapshot = await userDataService.getUserData();
    if(snapshot.exists){
      selectAvatarStore.update(await userDataService.getUrlProfilePicture());
      controller.textEditingController.text = snapshot.get('name');
      setLoading(false);
    }else{
      setLoading(false);
    }

  }

}