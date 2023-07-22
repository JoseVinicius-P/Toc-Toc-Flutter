import 'package:flutter_test/flutter_test.dart';
import 'package:toctoc/app/modules/perfil/set_home/set_home_store.dart';
 
void main() {
  late SetHomeStore store;

  setUpAll(() {
    store = SetHomeStore();
  });

  test('increment count', () async {
    expect(store.state, equals(0));
    store.update(store.state + 1);
    expect(store.state, equals(1));
  });
}