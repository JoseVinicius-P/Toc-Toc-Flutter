import 'package:flutter_test/flutter_test.dart';
import 'package:toctoc/app/modules/perfil/services/sounds_service.dart';
 
void main() {
  late SoundsService service;

  setUpAll(() {
    service = SoundsService();
  });
}