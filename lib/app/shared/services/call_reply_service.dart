import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CallReplyService {
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

    if(reply == "Estou indo!"){
      updateLastVisit(uidCall);
    }
  }

  void updateLastVisit(String uidFriend) async {
    DocumentReference callRef = db.collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Friends")
        .doc(uidFriend);

    await callRef.set({
      "lastVisit" : Timestamp.now(),
    }, SetOptions(merge: true));
  }

}