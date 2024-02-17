import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthManager extends ChangeNotifier {
  AuthManager._();
  static AuthManager instance = AuthManager._();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool get signedIn {
    if(_auth.currentUser == null) {
      return false;
    }
    else {
      return true;
    }
  }

  String verificationId = "";
  int forceResendingToken = 0;

  Future<bool> verifyPhoneNumber(String phoneNumber) async {
    bool result = false;
    await _auth.verifyPhoneNumber(

      phoneNumber: phoneNumber,
      verificationCompleted: (phoneAuthCredential) async {
        await _auth.signInWithCredential(phoneAuthCredential);
      },
      verificationFailed: (error) {
        //TODO error handling
      },
      codeSent: (verificationId, forceResendingToken) {
        this.verificationId = verificationId;
        this.forceResendingToken = forceResendingToken!;
        notifyListeners();
      },
      codeAutoRetrievalTimeout: (verificationId) {
        notifyListeners();
      },
    );
    return result;
  }

  Future<bool> verifySms(String smsCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    try {
      await _auth.signInWithCredential(credential);
      return true;
    }
    catch (error) {
      return false;
    }
  }
}
