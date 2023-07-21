import 'package:flutter_test/flutter_test.dart';
import 'package:toctoc/app/modules/set_home/services/home_service.dart';
 
void main() {
  late HomeService service;

  setUpAll(() {
    service = HomeService();
  });
}