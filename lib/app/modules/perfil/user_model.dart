import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  String name = "";
  String sound = "";
  String profilePictureUrl = "";
  GeoPoint location = const GeoPoint(-10.2524869, -48.3256559);

  UserModel.full({required this.name, required this.sound, required this.profilePictureUrl, required this.location});

  UserModel.empty();

  UserModel.copy(UserModel oldUserModel) {
    name = oldUserModel.name;
    sound = oldUserModel.sound;
    location = oldUserModel.location;
    profilePictureUrl = oldUserModel.profilePictureUrl;
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
    String name = this.name.trim();
    if(name.isNotEmpty){
      return {
        "name": name,
        "profilePictureUrl": profilePictureUrl
      };
    }else{
      throw Exception("Variable name is empty");
    }

  }
}