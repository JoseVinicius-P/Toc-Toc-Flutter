import 'package:flutter_test/flutter_test.dart';
import 'package:toctoc/app/modules/complete_registration/stores/complete_registration_store.dart';
 
void main() {
  late CompleteRegistrationStore store;

  setUpAll(() {
    store = CompleteRegistrationStore();
  });

  test('increment count', () async {
    expect(store.state, equals(0));
    store.update(store.state + 1);
    expect(store.state, equals(1));
  });
}