import 'package:flutter_triple/flutter_triple.dart';
import 'package:toctoc/app/modules/home/friend_list/gps_distance_service.dart';
import 'package:toctoc/app/modules/home/friend_model.dart';
import 'package:toctoc/app/modules/home/services/friend_service.dart';

class FriendListStore extends Store<List<FriendModel>> {
  final FriendService friendService;
  final GpsDistanceService gpsService;

  FriendListStore(this.friendService, this.gpsService) : super([]);

  void loadFriends() async {
    setLoading(true);
    update(await friendService.getFriends());
    setLoading(false);
    listenDistanceFriends();
  }

  void listenDistanceFriends(){
    gpsService.listenDistanceFriends(state, (friendList) => update(friendList));
  }
}