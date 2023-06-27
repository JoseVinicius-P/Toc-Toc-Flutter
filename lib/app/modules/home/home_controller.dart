import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

//Classe responsavel por controladores e regras de negocio do modulo home
//Implementa o Disposable para o Flutter modular entender que pode
//dispensar quando o modulo não estiver em uso
class HomeController implements Disposable{

  //Usando para controlar o PageView da HomePage
  final pageViewController = PageController();

  @override
  void dispose() {
    //Dispensando controller quando a tela for fechada
    pageViewController.dispose();
  }

}