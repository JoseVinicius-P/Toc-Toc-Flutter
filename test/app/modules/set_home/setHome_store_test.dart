import 'package:flutter_test/flutter_test.dart';
import 'package:toctoc/app/modules/set_home/setHome_store.dart';
 
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