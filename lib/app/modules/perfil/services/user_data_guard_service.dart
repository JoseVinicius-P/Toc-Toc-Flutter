import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:toctoc/app/modules/perfil/services/user_data_service.dart';

class UserDataGuardService extends RouteGuard{

  UserDataGuardService() : super(redirectTo: '/set_home/');

  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) async {
    bool isDataComplete = await Modular.get<UserDataService>().isDataComplete();
    return !isDataComplete;
  }



}