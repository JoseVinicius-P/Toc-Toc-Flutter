import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:toctoc/app/modules/perfil/user_model.dart';
import 'package:toctoc/app/modules/perfil/perfil_controller.dart';
import 'package:toctoc/app/modules/perfil/your_data/services/user_data_service.dart';
import 'package:latlong2/latlong.dart';

class PerfilStore extends Store<UserModel> {
  final UserDataService userDataService;
  final PerfilController controller;

  PerfilStore(this.userDataService, this.controller) : super(UserModel.empty());

  void getUserData() async {
    setLoading(true);
    DocumentSnapshot documentSnapshot = await userDataService.getUserData();
    update(state.fromDocumentSnapshot(documentSnapshot));
    controller.mapController.move(LatLng(state.location.latitude, state.location.longitude), 15.0);
    setLoading(false);
  }

}