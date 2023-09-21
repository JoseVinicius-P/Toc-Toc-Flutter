import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:geolocator/geolocator.dart';
import 'package:toctoc/app/modules/home/friend_model.dart';
import 'package:toctoc/app/shared/services/gps_service.dart';

class GpsDistanceService extends GpsService implements Disposable{
  StreamSubscription<Position>? positionStream;

  void listenDistanceFriends(List<FriendModel> friendsList, Function(List<FriendModel>) update){
    if(friendsList.isNotEmpty){
      final LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 1,
      );
      positionStream = Geolocator
          .getPositionStream(locationSettings: locationSettings)
          .listen((Position? position) {
            if(position != null){
              for(int i = 0; i < friendsList.length ; i++){
                if(friendsList[i].location != null){
                  friendsList[i].distance = Geolocator.distanceBetween(position.latitude, position.longitude, friendsList[i].location!.latitude, friendsList[i].location!.longitude);
                }
              }
              print("Tamanho da Lista: ${friendsList.length}");
              friendsList.sort((friend1, friend2) => friend1.distance.compareTo(friend2.distance));
              print("Tamanho da Lista: ${friendsList.length}");
              update(List.from(friendsList));
              print("Tamanho da Lista: ${List.from(friendsList).length}");
            }
      });
    }
  }

  @override
  void dispose() {
    positionStream?.cancel();
  }
}