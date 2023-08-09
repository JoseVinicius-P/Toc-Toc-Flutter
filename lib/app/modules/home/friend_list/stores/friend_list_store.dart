import 'package:flutter_triple/flutter_triple.dart';
import 'package:toctoc/app/modules/home/friend_model.dart';
import 'package:toctoc/app/modules/home/services/friend_service.dart';

class FriendListStore extends Store<List<FriendModel>> {
  final FriendService service;

  FriendListStore(this.service) : super([]);

  void loadFriends() async {
    setLoading(true);
    update(await service.getFriends());
    setLoading(false);
  }
}