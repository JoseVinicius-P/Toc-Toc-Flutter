import 'package:flutter_modular/flutter_modular.dart';

class SplashScreenController implements Disposable{

  SplashScreenController();

  @override
  void dispose() {

  }

  void toLoginModule(){
    Modular.to.pushNamed('/login/');
  }

}