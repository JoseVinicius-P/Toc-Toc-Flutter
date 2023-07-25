import 'package:flutter_test/flutter_test.dart';
import 'package:toctoc/app/modules/home/add_friend/friend_service.dart';
 
void main() {
  late FriendService service;

  setUpAll(() {
    service = FriendService();
  });
}