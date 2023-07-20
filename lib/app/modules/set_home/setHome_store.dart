import 'package:flutter_triple/flutter_triple.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:toctoc/app/modules/set_home/set_home_controller.dart';

class SetHomeStore extends Store<LatLng> {
  final SetHomeController controller;

  SetHomeStore(this.controller) : super(const LatLng(-10.2524869, -48.3256559));

  void getLocation() async {
    setLoading(true);
    Position? position;

    try {
      position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      update(LatLng(position.latitude, position.longitude));
      controller.mapController.move(LatLng(position.latitude, position.longitude), 18.0);
      setLoading(false);
    } catch (e) {
      print("Erro ao obter a localização: $e");
      position = null;
      getLocation();
      setLoading(false);
    }
  }

}