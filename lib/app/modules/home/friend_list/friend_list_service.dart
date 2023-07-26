import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toctoc/app/modules/home/friend_model.dart';

class FriendListService {
  final db = FirebaseFirestore.instance;

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

}