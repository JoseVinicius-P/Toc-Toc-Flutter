import 'package:flutter_modular/flutter_modular.dart';

class CreateAccountController implements Disposable{

  CreateAccountController();

  @override
  void dispose() {

  }

  void toCompleteRegistrationModule(){
    Modular.to.navigate('/complete_registration/');
  }

}