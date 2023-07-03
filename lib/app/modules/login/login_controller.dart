import 'package:flutter_modular/flutter_modular.dart';

class LoginController implements Disposable{

  LoginController();

  @override
  void dispose() {

  }

  void toCompleteRegistrationModule(){
    Modular.to.navigate('/complete_registration/');
  }

}