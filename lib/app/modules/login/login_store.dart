// ignore_for_file: constant_identifier_names

import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:toctoc/app/modules/login/auth_service.dart';
import 'package:toctoc/app/modules/login/login_controller.dart';

//State é o tipo do login
class LoginStore extends Store<String> implements Disposable{
  static const String GOOGLE_METHOD = 'GOOGLE_METHOD';
  static const String PHONE_NUMBER_METHOD = 'PHONENUMBER_METHOD';

  final AuthService authService;
  final LoginController controller;
  Timer? timer;

  LoginStore(this.authService, this.controller) : super(GOOGLE_METHOD);

  @override
  void dispose() {
    if(timer != null) {
      timer!.cancel();
      setError("");
    }
  }

  @override
  void setError(newError, {bool force = false}) {
    super.setError(newError);
    if(newError != null){
      initTimer();
    }
  }

  void initTimer(){
    if(timer != null) {
      timer!.cancel();
    }
    timer = Timer(const Duration(seconds: 3), () {
      setError("");
    });
  }

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
    if(phoneNumber.isNotEmpty){
      if(phoneNumber.length == 11){
        update(PHONE_NUMBER_METHOD);
        setLoading(true);
        try{
          await authService.verifyPhoneNumber(
              phoneNumber,
                  (String verificationId){
                controller.toSmsCodePage(verificationId);
                setLoading(false);
              },
                  () {
                setError("Talvez este número não esteja correto");
                setLoading(false);
              }
          );
        }catch(e){
          setError("Talvez este número não esteja correto");
          setLoading(false);
        }
      }else{
        setError("Talvez este número não esteja correto");
        setLoading(false);
      }
    }else{
      setError("Digite o número de telefone");
      setLoading(false);
    }
  }

  void signInWithPhoneNumber(String smsCode, String verificationId) async {
    if(smsCode.isNotEmpty && smsCode.length == 6){
      update(PHONE_NUMBER_METHOD);
      setLoading(true);
      if(await authService.signInWithPhoneNumber(smsCode, verificationId)){
        controller.toPerfilModule();
        setLoading(false);
      }else{
        setError("Código inválido!");
        setLoading(false);
      }
    }else{
      setError("Código inválido!");
      setLoading(false);
    }
  }
}