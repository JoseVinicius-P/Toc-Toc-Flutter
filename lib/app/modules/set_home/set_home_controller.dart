import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geolocator/geolocator.dart';

class SetHomeController implements Disposable{
  MapController mapController = MapController();
  late LocationPermission permission;

  SetHomeController();

  @override
  void dispose() {

  }

  void toHomeModule(){
    Modular.to.navigate('/home/');
  }

  Future<bool> requestLocationPermission() async {
    bool isAllowed = false;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }else{
        isAllowed = true;
      }
    }else{
      isAllowed = true;
    }
    return isAllowed;
  }

}