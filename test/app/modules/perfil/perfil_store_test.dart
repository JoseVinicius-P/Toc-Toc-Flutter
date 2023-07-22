import 'package:flutter_test/flutter_test.dart';
import 'package:toctoc/app/modules/perfil/perfil_store.dart';
 
void main() {
  late PerfilStore store;

  setUpAll(() {
    store = PerfilStore();
  });

  test('increment count', () async {
    expect(store.state, equals(0));
    store.update(store.state + 1);
    expect(store.state, equals(1));
  });
}