import 'package:modular_test/modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toctoc/app/modules/create_account/createAccount_module.dart';
 
void main() {

  setUpAll(() {
    initModule(CreateAccountModule());
  });
}