import 'package:flutter_test/flutter_test.dart';
import 'package:toctoc/app/modules/perfil/stores/select_avatar_store.dart';
 
void main() {
  late SelectAvatarStore store;

  setUpAll(() {
    store = SelectAvatarStore();
  });

  test('increment count', () async {
    expect(store.state, equals(0));
    store.update(store.state + 1);
    expect(store.state, equals(1));
  });
}