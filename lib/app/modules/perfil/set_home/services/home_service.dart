import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeService {
  final db = FirebaseFirestore.instance;

  Future<bool> saveLocation(double latitude, double longitude) async {
    try{
      await db.collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({"location": GeoPoint(latitude, longitude)}, SetOptions(merge: true));
      return true;
    }catch(e){
      return false;
    }
  }

  Future<bool> isLocationExists() async {
    DocumentReference docRef = db.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid);
    DocumentSnapshot snapshot = await docRef.get();
    if(snapshot.exists){
      try{
        if(snapshot.get('location') != null){
          return true;
        }else{
          return false;
        }
      }catch(e){
        return false;
      }
    }else{
      return false;
    }
  }


}