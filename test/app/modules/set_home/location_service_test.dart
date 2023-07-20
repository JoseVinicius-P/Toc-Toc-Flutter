import 'package:flutter_test/flutter_test.dart';
import 'package:toctoc/app/modules/set_home/position_service.dart';
 
void main() {
  late PositionService service;

  setUpAll(() {
    service = PositionService();
  });
}