import 'package:geolocator/geolocator.dart';

class GpsService {
  Future<bool> isLocationEnabled(){
    return Geolocator.isLocationServiceEnabled();
  }

  Future<bool> permissionLocationIsAllowed() async{
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      return false;
    }else{
      return true;
    }
  }

  Future<bool> requestLocationPermission() async {
    bool isAllowed = false;
    if (!await permissionLocationIsAllowed()) {
      await Geolocator.requestPermission();
      if (!await permissionLocationIsAllowed()) {
        isAllowed = false;
      }else{
        isAllowed = true;
      }
    }else{
      isAllowed = true;
    }
    return isAllowed;
  }
}