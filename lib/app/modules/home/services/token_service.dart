import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  final db = FirebaseFirestore.instance;
  late SharedPreferences prefs;

  Future<String> getToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    if(fcmToken != null){
      return fcmToken;
    }else{
      throw("Erro ao obter token");
    }
  }

  Future<bool> tokenExists(String token) async {
    prefs = await SharedPreferences.getInstance();
    String? tokenShared = prefs.getString("token");

    if(tokenShared != null){
      if(tokenShared == token){
        return true;
      }else{
        return false;
      }
    }else{
      return false;
    }
  }

  void saveToken() async {
    prefs = await SharedPreferences.getInstance();
    String token = await getToken();
    if(!await tokenExists(token)){
      await db.collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({"token" : token},  SetOptions(merge: true))
        .then((value){
          prefs.setString("token", token);
        });
    }
  }

}