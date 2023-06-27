import 'package:flutter_modular/flutter_modular.dart';

class SetHomeController implements Disposable{

  SetHomeController();

  @override
  void dispose() {

  }

  void toHomeModule(){
    Modular.to.navigate('/home/');
  }

}