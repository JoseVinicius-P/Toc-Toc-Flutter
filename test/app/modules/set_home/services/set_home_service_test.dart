import 'package:flutter_test/flutter_test.dart';
import 'package:toctoc/app/modules/set_home/services/set_home_service.dart';
 
void main() {
  late SetHomeService service;

  setUpAll(() {
    service = SetHomeService();
  });
}