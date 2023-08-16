import 'dart:async';

import 'package:flutter_triple/flutter_triple.dart';
import 'package:toctoc/app/modules/home/friend_model.dart';
import 'package:toctoc/app/modules/home/services/friend_service.dart';

class SelectFriendStore extends Store<FriendModel> {
  final FriendService service;
  Timer? _timer;

  SelectFriendStore(this.service) : super(FriendModel());

  void callFriend(FriendModel friend){
    update(friend);
    service.callFriend(friend.uid);
    endCall(); // após alguns segundos
  }

  void endCall(){
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
    _timer = Timer(const Duration(seconds: 15), () {
      update(FriendModel());
    });
  }

}