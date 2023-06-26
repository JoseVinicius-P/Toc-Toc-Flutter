import 'package:flutter_modular/flutter_modular.dart';

class CompleteRegistrationController implements Disposable{

  CompleteRegistrationController();

  @override
  void dispose() {

  }

  void toSelectSoundPage(){
    Modular.to.pushNamed('./select_sound');
  }

}