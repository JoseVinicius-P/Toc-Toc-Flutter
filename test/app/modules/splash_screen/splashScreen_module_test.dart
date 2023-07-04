import 'package:modular_test/modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toctoc/app/modules/splash_screen/splashScreen_module.dart';
 
void main() {

  setUpAll(() {
    initModule(SplashScreenModule());
  });
}