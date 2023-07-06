import 'package:flutter_triple/flutter_triple.dart';
import 'package:toctoc/app/modules/login/auth_service.dart';
import 'package:toctoc/app/modules/login/login_controller.dart';

class LoginStore extends Store<bool> {
  final AuthService authService;
  final LoginController controller;

  LoginStore(this.authService, this.controller) : super(false);

  void signInWithGoogle() async {
    setLoading(true);
    if(await authService.signInWithGoogle()){
      controller.toCompleteRegistrationModule();
      update(true);
    }else{
      setLoading(false);
    }
    if(!state){
      setLoading(false);
    }

  }


}