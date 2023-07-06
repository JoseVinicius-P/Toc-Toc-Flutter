import 'package:flutter_test/flutter_test.dart';
import 'package:toctoc/app/modules/create_account/create_account_auth_service.dart';
 
void main() {
  late CreateAccountAuthService service;

  setUpAll(() {
    service = CreateAccountAuthService();
  });
}