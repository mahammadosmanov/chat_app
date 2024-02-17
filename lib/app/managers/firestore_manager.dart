import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FireStoreManager extends ChangeNotifier{
  FireStoreManager._();
  static FireStoreManager instance = FireStoreManager._();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

}