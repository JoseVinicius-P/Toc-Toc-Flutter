import 'package:flutter_test/flutter_test.dart';
import 'package:toctoc/app/modules/login/auth_service.dart';
 
void main() {
  late AuthService service;

  setUpAll(() {
    service = AuthService();
  });
}