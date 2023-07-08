import 'package:flutter_test/flutter_test.dart';
import 'package:toctoc/app/shared/services/auth_guard_service.dart';
 
void main() {
  late AuthGuardService service;

  setUpAll(() {
    service = AuthGuardService();
  });
}