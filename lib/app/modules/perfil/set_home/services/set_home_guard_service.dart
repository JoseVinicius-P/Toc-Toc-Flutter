import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:toctoc/app/modules/perfil/set_home/services/home_service.dart';

class SetHomeGuardService extends RouteGuard{

  SetHomeGuardService() : super(redirectTo: '/home/');

  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) async {
    /*bool isLocationExists = true;
    if(path.contains('home')){
      isLocationExists = true;
    }else{*/
      bool isLocationExists = await Modular.get<HomeService>().isLocationExists();
    //}
    return !isLocationExists;
  }

}