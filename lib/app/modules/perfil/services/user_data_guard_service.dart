import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:toctoc/app/modules/perfil/services/user_data_service.dart';

class UserDataGuardService extends RouteGuard{

  UserDataGuardService() : super(redirectTo: '/set_home/');

  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) async {
    //Essa verificação está sendo feita pq quando a pagina é chamada a partir do modulo home
    //a verificação não deve ser feita e ela deve abrir de qualquer forma
    bool isDataComplete = false;
    if(path.contains("home")){
      isDataComplete = false;
    }else{
      isDataComplete = await Modular.get<UserDataService>().isDataComplete();
    }

    return !isDataComplete;
  }



}