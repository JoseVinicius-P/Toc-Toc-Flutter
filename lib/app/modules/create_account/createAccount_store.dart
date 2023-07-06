import 'package:flutter_triple/flutter_triple.dart';
import 'package:toctoc/app/modules/create_account/create_account_auth_service.dart';
import 'package:toctoc/app/modules/create_account/create_account_controller.dart';

class CreateAccountStore extends Store<bool> {
  final CreateAccountAuthService authService;
  final CreateAccountController controller;

  CreateAccountStore(this.authService, this.controller) : super(false);

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