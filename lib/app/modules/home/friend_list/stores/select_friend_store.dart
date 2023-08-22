import 'package:flutter_triple/flutter_triple.dart';
import 'package:toctoc/app/modules/home/friend_model.dart';
import 'package:toctoc/app/modules/home/services/friend_service.dart';

class SelectFriendStore extends Store<FriendModel> {
  final FriendService service;

  SelectFriendStore(this.service) : super(FriendModel());

}