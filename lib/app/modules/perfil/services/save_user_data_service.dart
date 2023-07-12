import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:toctoc/app/modules/perfil/models/user_model.dart';

class SaveUserDataService {
  final storage = FirebaseStorage.instance;
  final db = FirebaseFirestore.instance;
  
  void saveProfilePicture(String path) async {
    final reference = storage.ref().child("profile_pictures/${FirebaseAuth.instance.currentUser!.uid}.jpg");

    File file = File(path);

    try {
      await reference.putFile(file);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  Future<bool> saveUserData(UserModel user) async {

    try{
      await db.collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(user.toFirestore());
      return true;
    }catch(e){
      return false;
    }
  }
}