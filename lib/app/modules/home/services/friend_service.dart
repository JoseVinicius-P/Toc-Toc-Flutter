import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toctoc/app/modules/home/friend_model.dart';

class FriendService {

  final db = FirebaseFirestore.instance;

  void callFriend(String uid) async {
    //Isso aqui tem mudar, pegar o nome do usuario logado com shared preferences
    DocumentReference docRef = db.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid);
    DocumentSnapshot snapshot = await docRef.get();

    await db.collection("Users")
        .doc(uid)
        .collection("Calls")
        .doc()
        .set({"name" : snapshot.get("name")},);
  }

  Future<List<FriendModel>> getFriends() async {
    List<FriendModel> friends = [];
    try{
      await db.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).collection("Friends").get().then(
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