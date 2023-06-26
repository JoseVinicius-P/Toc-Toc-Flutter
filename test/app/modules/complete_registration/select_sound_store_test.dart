import 'package:flutter_test/flutter_test.dart';
import 'package:toctoc/app/modules/complete_registration/select_sound_store.dart';
 
void main() {
  late SelectSoundStore store;

  setUpAll(() {
    store = SelectSoundStore();
  });

  test('increment count', () async {
    expect(store.state, equals(0));
    store.update(store.state + 1);
    expect(store.state, equals(1));
  });
}