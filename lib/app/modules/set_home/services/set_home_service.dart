import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SetHomeService {
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

}