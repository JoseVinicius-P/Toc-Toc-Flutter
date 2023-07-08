import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:toctoc/app/shared/services/auth_service.dart';

class AuthGuardService extends RouteGuard{

  AuthGuardService() : super(redirectTo: '/complete_registration');

  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) {
    return !AuthService.isUserLoggedIn();
  }
}