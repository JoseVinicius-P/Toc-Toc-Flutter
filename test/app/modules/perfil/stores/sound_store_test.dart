import 'package:flutter_test/flutter_test.dart';
import 'package:toctoc/app/modules/perfil/stores/sound_store.dart';
 
void main() {
  late SoundStore store;

  setUpAll(() {
    store = SoundStore();
  });

  test('increment count', () async {
    expect(store.state, equals(0));
    store.update(store.state + 1);
    expect(store.state, equals(1));
  });
}