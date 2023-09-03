import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:toctoc/app/shared/services/gps_service.dart';

class GpsSetHomeService extends GpsService{
  Timer? locationTimer;

  void startLocationUpdates(Function(Position) updateLocation) {
    // Verifique se o timer já está em execução para evitar múltiplas instâncias
    if (locationTimer != null && locationTimer!.isActive) {
      return;
    }

    // Defina o intervalo de tempo para repetir a obtenção da localização (2 segundos)
    const Duration interval = Duration(seconds: 2);

    // Crie um Timer periódico para executar a função getLocation a cada 2 segundos
    locationTimer = Timer.periodic(interval, (Timer timer) async {
      Position? position = await getPosition();
      if(position != null){
        updateLocation(position);
      }
    });
  }

  void stopLocationUpdates() {
    // Verifique se o timer está ativo antes de tentar cancelá-lo
    if (locationTimer != null && locationTimer!.isActive) {
      locationTimer!.cancel();
    }
  }

  Future<Position?> getPosition() async {
    Position? position;

    try {
      position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
    } catch (e) {
      print("Erro ao obter a localização: $e");
      position = null;
      return getPosition();
    }

    return position;
  }

}