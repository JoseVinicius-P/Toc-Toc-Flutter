// ignore_for_file: constant_identifier_names

import 'package:flutter_triple/flutter_triple.dart';
import 'package:toctoc/app/modules/login/auth_service.dart';
import 'package:toctoc/app/modules/login/login_controller.dart';

//State é o tipo do login
class LoginStore extends Store<String> {
  static const String GOOGLE_METHOD = 'GOOGLE_METHOD';
  static const String PHONE_NUMBER_METHOD = 'PHONENUMBER_METHOD';
  final AuthService authService;
  final LoginController controller;

  LoginStore(this.authService, this.controller) : super(GOOGLE_METHOD);

  void signInWithGoogle() async {
    update(GOOGLE_METHOD);
    setLoading(true);
    if(await authService.signInWithGoogle()){
      controller.toPerfilModule();
    }else{
      setLoading(false);
    }
  }

  void verifyPhoneNumber(String phoneNumber) async {
    update(PHONE_NUMBER_METHOD);
    setLoading(true);
    try{
      await authService.verifyPhoneNumber(phoneNumber, (String verificationId){
          controller.toSmsCodePage(verificationId);
          setLoading(false);
        }
      );
    }catch(e){
      print("ERRO: $e");
    }
  }

  void signInWithPhoneNumber(String smsCode, String verificationId) async {
    update(PHONE_NUMBER_METHOD);
    setLoading(true);
    if(await authService.signInWithPhoneNumber(smsCode, verificationId)){
      controller.toPerfilModule();
      setLoading(false);
    }else{
      setLoading(false);
    }

  }


}