import 'package:cloud_firestore/cloud_firestore.dart';

class FriendModel{
  late String name;
  late String uid;
  late String profilePictureUrl;
  GeoPoint? location;
  Timestamp? lastVisit;
  double distance = double.infinity;

  FriendModel();

  FriendModel? fromDocumentSnapshot (DocumentSnapshot snapshot){
    try{
      location = snapshot.get('location');
    }catch(e){
      location = null;
      print("ERRO: $e");
    }
    try{
      lastVisit = snapshot.get('lastVisit');
    }catch(e){
      lastVisit = null;
      print("ERRO: $e");
    }

    if(location != null){
      name = snapshot.get('name');
      uid = snapshot.id;
      profilePictureUrl = snapshot.get('profilePictureUrl');
      return this;
    }else{
      return null;
    }
  }

  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      "profilePictureUrl": profilePictureUrl,
      "location": location,
      "lastVisit": lastVisit
    };
  }


}