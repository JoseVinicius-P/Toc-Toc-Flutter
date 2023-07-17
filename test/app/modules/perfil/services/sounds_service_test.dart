import 'package:flutter_test/flutter_test.dart';
import 'package:toctoc/app/modules/perfil/services/local_sounds_service.dart';
 
void main() {
  late LoacalSoundsService service;

  setUpAll(() {
    service = LoacalSoundsService();
  });
}