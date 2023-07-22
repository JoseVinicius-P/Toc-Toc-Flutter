import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  String name = "";
  String sound = "";
  GeoPoint location = const GeoPoint(-10.2524869, -48.3256559);

  UserModel.empty();

  UserModel.copy(UserModel oldUserModel) {
    name = oldUserModel.name;
    sound = oldUserModel.sound;
    location = oldUserModel.location;
  }

  UserModel.onlyName({required this.name});

  UserModel(this.sound, this.location, {required this.name});

  UserModel fromDocumentSnapshot (DocumentSnapshot snapshot){
    name = snapshot.get('name');
    sound = snapshot.get('sound');
    try{
      location = snapshot.get('location');
    }catch(e){
      print("ERRO: $e");
    }

    try{
      profilePictureUrl = snapshot.get('profilePictureUrl');
    }catch(e){
      print(e);
    }
    return this;
  }

  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      "profilePictureUrl": profilePictureUrl
    };
  }
}