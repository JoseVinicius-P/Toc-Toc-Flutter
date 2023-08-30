import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CallService implements Disposable{
  final db = FirebaseFirestore.instance;
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? listener;


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

  Future<void> deleteOldReply(String friendUid) async {
    DocumentReference editableDataRef = db.collection("Users")
        .doc(friendUid)
        .collection("Calls")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("EditableData").
    doc("editableData");

    await editableDataRef.delete();
  }

  void messageListener(String friendUid, Function(String) update) async {
    await deleteOldReply(friendUid);

    final documentReference = db.collection("Users")
        .doc(friendUid)
        .collection("Calls")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("EditableData")
        .doc('editableData');

    listener = documentReference.snapshots().listen(
          (snapshot) {
        if (snapshot.exists) {
          String? reply = snapshot.get('reply');
          if(reply != null && reply.isNotEmpty){
            update(reply);
          }
        }
      },
      onError: (error) {
        debugPrint(error);
      },
    );
  }

  @override
  void dispose() {
    listener?.cancel();
  }

}