import 'dart:async';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:toctoc/app/modules/login/auth_service.dart';

class LoginController implements Disposable{
  final AuthService authService;

  LoginController({required this.authService});

  @override
  void dispose() {

  }

  void toCompleteRegistrationModule(){
    Modular.to.navigate('/complete_registration/');
  }

  FutureOr<bool> signInWithGoogle() async{
    return await authService.signInWithGoogle();
  }

}