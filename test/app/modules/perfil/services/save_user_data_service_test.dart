import 'package:flutter_test/flutter_test.dart';
import 'package:toctoc/app/modules/perfil/your_data/services/user_data_service.dart';
 
void main() {
  late UserDataService service;

  setUpAll(() {
    service = UserDataService();
  });
}