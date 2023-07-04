import 'package:flutter_test/flutter_test.dart';
import 'package:toctoc/app/modules/create_account/createAccount_store.dart';
 
void main() {
  late CreateAccountStore store;

  setUpAll(() {
    store = CreateAccountStore();
  });

  test('increment count', () async {
    expect(store.state, equals(0));
    store.update(store.state + 1);
    expect(store.state, equals(1));
  });
}