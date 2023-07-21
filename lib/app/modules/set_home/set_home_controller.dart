import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SetHomeController implements Disposable{
  MapController mapController = MapController();

  SetHomeController();

  @override
  void dispose() {

  }

  void toHomeModule(){
    Modular.to.navigate('/home/');
  }
}