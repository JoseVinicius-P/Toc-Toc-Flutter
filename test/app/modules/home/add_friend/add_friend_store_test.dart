import 'package:flutter_test/flutter_test.dart';
import 'package:toctoc/app/modules/home/add_friend/add_friend_store.dart';
 
void main() {
  late AddFriendStore store;

  setUpAll(() {
    store = AddFriendStore();
  });

  test('increment count', () async {
    expect(store.state, equals(0));
    store.update(store.state + 1);
    expect(store.state, equals(1));
  });
}