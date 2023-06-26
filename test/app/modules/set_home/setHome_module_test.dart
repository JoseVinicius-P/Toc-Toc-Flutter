import 'package:modular_test/modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toctoc/app/modules/set_home/setHome_module.dart';
 
void main() {

  setUpAll(() {
    initModule(SetHomeModule());
  });
}