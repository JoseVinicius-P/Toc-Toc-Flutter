import 'package:flutter_test/flutter_test.dart';
import 'package:toctoc/app/modules/perfil/stores/sound_reproduction_store.dart';
 
void main() {
  late SoundReproductionStore store;

  setUpAll(() {
    store = SoundReproductionStore();
  });

  test('increment count', () async {
    expect(store.state, equals(0));
    store.update(store.state + 1);
    expect(store.state, equals(1));
  });
}