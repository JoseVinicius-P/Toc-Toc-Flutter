import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_test/modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toctoc/app/modules/complete_registration/perfil_module.dart';
 
void main() {

  setUpAll(() {
    initModule(CompleteRegistrationModule());
  });
}