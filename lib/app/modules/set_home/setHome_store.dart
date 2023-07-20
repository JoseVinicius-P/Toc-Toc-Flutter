import 'package:flutter_triple/flutter_triple.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:toctoc/app/modules/set_home/set_home_controller.dart';
import 'package:toctoc/app/modules/set_home/position_service.dart';

class SetHomeStore extends Store<LatLng> {
  final SetHomeController controller;
  final PositionService positionService;

  SetHomeStore(this.controller, this.positionService) : super(const LatLng(-10.2524869, -48.3256559));

  void getPosition() async {
    setLoading(true);
    Position? position;

    try {
      position = await positionService.getPosition();
      if(position != null){
        update(LatLng(position.latitude, position.longitude));
        controller.mapController.move(LatLng(position.latitude, position.longitude), 18.0);
      }
      setLoading(false);
      positionService.startLocationUpdates((position) {
        update(LatLng(position.latitude, position.longitude));
        controller.mapController.move(LatLng(position.latitude, position.longitude), 18.0);
      });
    } catch (e) {
      print("Erro ao obter a localização: $e");
      position = null;
      setLoading(false);
      getPosition();
    }
  }

}