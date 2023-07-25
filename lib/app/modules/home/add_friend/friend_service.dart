import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toctoc/app/modules/home/friend_model.dart';

class FriendService {

  final db = FirebaseFirestore.instance;

  Future<bool> addFriend(String uid) async {
    FriendModel? friend = FriendModel();
    friend = friend.fromDocumentSnapshot(await getFriendData(uid));

    if(friend != null){
      try{
        await db.collection("Users/${FirebaseAuth.instance.currentUser!.uid}/Friends")
            .doc(friend.uid)
            .set(friend.toFirestore(), SetOptions(merge: true));
        return true;
      }catch(e){
        return false;
      }
    }else{
      return false;
    }
  }

  Future<DocumentSnapshot> getFriendData(String uid) async{
    DocumentReference docRef = db.collection('Users').doc(uid);
    DocumentSnapshot snapshot = await docRef.get();
    return snapshot;
  }

}