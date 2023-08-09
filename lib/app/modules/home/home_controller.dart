import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:toctoc/app/modules/home/services/token_service.dart';

//Classe responsavel por controladores e regras de negocio do modulo home
//Implementa o Disposable para o Flutter modular entender que pode
//dispensar quando o modulo não estiver em uso
class HomeController implements Disposable{
  final TokenService tokenService;
  //Usando para controlar o PageView da HomePage
  final pageViewController = PageController();
  QRViewController? qrViewController;
  Barcode? result;

  HomeController(this.tokenService);

  @override
  void dispose() {
    //Dispensando controller quando a tela for fechada
    pageViewController.dispose();
    if(qrViewController != null){
      qrViewController!.dispose();
    }
  }

  void saveToken(){
    tokenService.saveToken();
  }

}