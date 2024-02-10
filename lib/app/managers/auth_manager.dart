import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthManager extends ChangeNotifier{
  AuthManager._();
  static AuthManager instance = AuthManager._();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String verificationId = "";

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    _auth.verifyPhoneNumber(verificationCompleted: (phoneAuthCredential) async {
      await _auth.signInWithCredential(phoneAuthCredential);
    },
        verificationFailed: (error) {

        },
        codeSent: (verificationId, forceResendingToken) {
          verificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId) {
          //TODO
        },
    );
  }

  Future<UserCredential> verifySms(String smsCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
    return await _auth.signInWithCredential(credential);
  }
    
  @override
  void dispose() {
    super.dispose();
  }
}