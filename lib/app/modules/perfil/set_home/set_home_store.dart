import 'package:flutter_triple/flutter_triple.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:toctoc/app/modules/perfil/set_home/set_home_controller.dart';
import 'package:toctoc/app/modules/perfil/set_home/services/gps_service.dart';
import 'package:toctoc/app/modules/perfil/set_home/services/home_service.dart';
import 'package:toctoc/app/modules/perfil/perfil_store.dart';
import 'package:toctoc/app/modules/perfil/user_model.dart';

class SetHomeStore extends Store<LatLng> {
  final SetHomeController controller;
  final GpsService gpsService;
  final HomeService homeService;
  //Usado para dar reatividade a tela de perfil
  final PerfilStore perfilStore;

  SetHomeStore(this.controller, this.gpsService, this.homeService, this.perfilStore) : super(const LatLng(-10.2524869, -48.3256559));

  void saveLocation(Function whenToComplete) async {
    setLoading(true);
    gpsService.stopLocationUpdates();
    if(await homeService.saveLocation(state.latitude, state.longitude)){
      perfilStore.setlocation(state.latitude, state.longitude);
      whenToComplete();
      setLoading(false);
    }else{
      setLoading(false);
    }
  }

  void getPosition() async {
    setLoading(true);
    Position? position;

    try {
      position = await gpsService.getPosition();
      if(position != null){
        update(LatLng(position.latitude, position.longitude));
        controller.mapController.move(LatLng(position.latitude, position.longitude), 18.0);
      }
      setLoading(false);
      gpsService.startLocationUpdates((position) {
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

  Future<bool> permissionLocationIsAllowed() async{
    setLoading(true);
    return await gpsService.permissionLocationIsAllowed();
  }

  Future<bool> requestLocationPermission() async {
    setLoading(true);
    return gpsService.requestLocationPermission();
  }

  Future<bool> isLocationEnabled() async {
    setLoading(true);
    return gpsService.isLocationEnabled();
  }


}