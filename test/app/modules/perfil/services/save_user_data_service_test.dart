import 'package:flutter_test/flutter_test.dart';
import 'package:toctoc/app/modules/perfil/services/save_user_data_service.dart';
 
void main() {
  late SaveUserDataService service;

  setUpAll(() {
    service = SaveUserDataService();
  });
}