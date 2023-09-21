import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toctoc/app/modules/home/friend_model.dart';

class FriendService {

  final db = FirebaseFirestore.instance;

  Future<List<FriendModel>> getFriends() async {
    List<FriendModel> friends = [];
    try{
      await db.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).collection("Friends").orderBy('lastVisit').get().then(
            (querySnapshot) {
          for (var docSnapshot in querySnapshot.docs) {
            FriendModel? friend = FriendModel().fromDocumentSnapshot(docSnapshot);
            if(friend != null){
              friends.add(friend);
            }
          }
        },
        onError: (e) => print("Error completing: $e"),
      );
    }catch(e){
      print("ERRO: $e");
    }


    return friends;
  }

  Future<FriendModel?> addFriend(String uid) async {
    FriendModel? friend = FriendModel();
    friend = friend.fromDocumentSnapshot(await getFriendData(uid));

    if(friend != null){
      try{
        await db.collection("Users/${FirebaseAuth.instance.currentUser!.uid}/Friends")
            .doc(friend.uid)
            .set(friend.toFirestore(), SetOptions(merge: true));
        return friend;
      }catch(e){
        return null;
      }
    }else{
      return null;
    }
  }

  Future<DocumentSnapshot> getFriendData(String uid) async{
    DocumentReference docRef = db.collection('Users').doc(uid);
    DocumentSnapshot snapshot = await docRef.get();
    return snapshot;
  }

}