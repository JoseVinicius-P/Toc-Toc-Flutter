import 'package:flutter_test/flutter_test.dart';
import 'package:toctoc/app/shared/services/auth_service.dart';
 
void main() {
  late AuthService service;

  setUpAll(() {
    service = AuthService();
  });
}