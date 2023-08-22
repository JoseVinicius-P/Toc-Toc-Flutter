import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CallService {
  final db = FirebaseFirestore.instance;

  Future<void> sendReply(String reply, String uidCall) async {
    DocumentReference callRef = db.collection("Users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("Calls")
      .doc(uidCall)
      .collection("EditableData")
      .doc("editableData");

    await callRef.set({
      "reply" : reply,
    }, SetOptions(merge: true));
  }

  Future<void> callFriend(String friendUid) async {
    //Isso aqui tem mudar, pegar o nome do usuario logado com shared preferences
    DocumentReference userRef = db.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid);
    DocumentSnapshot snapshot = await userRef.get();

    DocumentReference callRef = db.collection("Users")
        .doc(friendUid)
        .collection("Calls")
        .doc(FirebaseAuth.instance.currentUser!.uid);

    await callRef.set({
      "name" : snapshot.get("name"),
      "profilePictureUrl" : snapshot.get("profilePictureUrl"),
      "date_hour" : Timestamp.now(),
    }, SetOptions(merge: true));
  }

}