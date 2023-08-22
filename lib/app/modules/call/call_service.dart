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

}