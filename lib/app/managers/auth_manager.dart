import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:flutter/material.dart';

class AuthManager extends ChangeNotifier{
  AuthManager._();
  static AuthManager instance = AuthManager._();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();
  
  String verificationId = "";
  int forceResendingToken = 0;

  void signInWithPhone(String phoneNumber,String smsCode,) async {
    ConfirmationResult confirmationResult = await _auth.signInWithPhoneNumber(phoneNumber,RecaptchaVerifier(auth: FirebaseAuthPlatform.instance,container: 'recaptcha',size: RecaptchaVerifierSize.compact,
  theme: RecaptchaVerifierTheme.dark,onError: (exception) {
    //TODO error handling
  },onExpired: () {
    //TODO on expired
  },
  onSuccess: () {
    //TODO on success
  },),);
    UserCredential userCredential = await confirmationResult.confirm(smsCode);
  }

  

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    _auth.verifyPhoneNumber(
      
      verificationCompleted: (phoneAuthCredential) async {
      await _auth.signInWithCredential(phoneAuthCredential);
          },
        verificationFailed: (error) {
          //TODO error handling
        },
        codeSent: (verificationId, forceResendingToken) {
          verificationId = verificationId;
          forceResendingToken = forceResendingToken;  
          },
        codeAutoRetrievalTimeout: (verificationId) {
          
        },
    );
  }

  Future<UserCredential> verifySms(String smsCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
    return await _auth.signInWithCredential(credential);
  }
}