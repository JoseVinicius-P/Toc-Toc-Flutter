import 'package:flutter_test/flutter_test.dart';
import 'package:toctoc/app/modules/set_home/services/gps_service.dart';
 
void main() {
  late GpsService service;

  setUpAll(() {
    service = GpsService();
  });
}