import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {

  FutureOr<bool> signInWithGoogle() async {
    try{
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential user = await FirebaseAuth.instance.signInWithCredential(credential);

      return user.user != null;
    }catch(e){
      return false;
    }
  }

  Future<void> verifyPhoneNumber(String phoneNumber, Function(String) codeSent) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.verifyPhoneNumber(
      phoneNumber: '+55$phoneNumber',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException error) {  },
      codeSent: (String verificationId, int? forceResendingToken) {
        print('Verification 2: $verificationId');
        codeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {  },
    );
  }

  FutureOr<bool> signInWithPhoneNumber(String smsCode, String verificationId) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      UserCredential user = await auth.signInWithCredential(credential);
      if(user.user != null){
        return true;
      }else{
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}