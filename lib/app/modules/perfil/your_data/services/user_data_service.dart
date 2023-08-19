import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toctoc/app/modules/perfil/user_model.dart';

class UserDataService {
  final storage = FirebaseStorage.instance;
  final db = FirebaseFirestore.instance;

  Future<bool> saveProfilePicture(String path) async {
    if(!path.contains('http')){
      final reference = storage.ref().child("profile_pictures/${FirebaseAuth.instance.currentUser!.uid}.jpg");
      try {
        File file = File(path);
        await reference.putFile(file);
        return true;
      } on FirebaseException catch (e) {
        print(e);
        return false;
      }
    }else{
      return false;
    }
  }

  Future<bool> saveUserData(UserModel user) async {
    try{
      await db.collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(user.toFirestore(), SetOptions(merge: true));
      return true;
    }catch(e){
      return false;
    }
  }

  Future<bool> saveSound(String nameSound) async{
    try{
      await db.collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({"sound" : nameSound}, SetOptions(merge: true));
      //Salvando localmente
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('sound', nameSound);
      return true;
    }catch(e){
      return false;
    }
  }

  Future<DocumentSnapshot> getUserData() async{
    DocumentReference docRef = db.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid);
    DocumentSnapshot snapshot = await docRef.get();
    return snapshot;
  }

  Future<bool> isDataComplete() async {
    DocumentSnapshot snapshot = await getUserData();
    if(snapshot.exists){
      try{
        if(snapshot.get('sound') != null){
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

  Future<String> getUrlProfilePicture() async {
    try{
      return await storage.ref().child("profile_pictures/${FirebaseAuth.instance.currentUser!.uid}.jpg").getDownloadURL();
    }catch(e){
      return '';
    }
  }


}