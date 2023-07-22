import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:toctoc/app/modules/perfil/set_home/services/home_service.dart';

class SetHomeGuardService extends RouteGuard{

  SetHomeGuardService() : super(redirectTo: '/home/');

  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) async {
    bool isLocationExists = false;
    if(path.contains('/home')){
      isLocationExists = false;
    }else{
      isLocationExists = await Modular.get<HomeService>().isLocationExists(); //true
    }
    return !isLocationExists;
  }

}