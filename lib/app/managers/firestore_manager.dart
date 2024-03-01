import 'package:chat_app/app/managers/auth_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class FireStoreManager extends ChangeNotifier {
  FireStoreManager._();

  static FireStoreManager instance = FireStoreManager._();

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> friends = [];

  void createUser(
    PhoneAuthCredential phoneAuthCredential,
    Map<String, String> data,
  ) {
    _fireStore.collection('users').doc(AuthManager.instance.uid).set(data);
    _fireStore.collection('messages').doc(AuthManager.instance.uid).set(data);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> get friendsSnapshots {
    return _fireStore
        .collection('users')
        .doc(AuthManager.instance.uid)
        .collection('friends')
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> get usersSnapshots {
    return _fireStore.collection('users').snapshots();
  }
}
