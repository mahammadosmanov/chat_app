import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthManager extends ChangeNotifier {
  AuthManager._();

  static AuthManager instance = AuthManager._();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool get signedIn {
    if (_auth.currentUser == null) {
      return false;
    } else {
      return true;
    }
  }

  String? get uid {
    return _auth.currentUser?.uid;
  }

  String verificationId = "";
  int forceResendingToken = 0;
  late PhoneAuthCredential credential;

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      timeout: const Duration(seconds: 10),
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
        this.verificationId = verificationId;
        notifyListeners();
      },
    );
  }

  Future<bool> verifySms(String smsCode) async {
    credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    try {
      await _auth.signInWithCredential(credential);

      return true;
    } catch (error) {
      return false;
    }
  }
}
