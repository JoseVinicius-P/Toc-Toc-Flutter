import 'package:flutter_test/flutter_test.dart';
import 'package:toctoc/app/modules/perfil/your_data/services/image_picker_service.dart';
 
void main() {
  late ImagePickerService service;

  setUpAll(() {
    service = ImagePickerService();
  });
}