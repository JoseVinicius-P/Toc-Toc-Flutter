import 'package:flutter_test/flutter_test.dart';
import 'package:toctoc/app/modules/perfil/user_data_guard_service.dart';
 
void main() {
  late UserDataGuardService service;

  setUpAll(() {
    service = UserDataGuardService();
  });
}