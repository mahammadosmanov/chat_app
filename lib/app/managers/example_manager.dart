import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ExampleManager extends ChangeNotifier{
  ExampleManager._();
  static ExampleManager instance = ExampleManager._();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> init() async {
    firestore.collection('s').doc('a').collection('q').orderBy('field').snapshots().listen((event) {
      //FirebaseFirestore listener example when something changes in accessed collection this listener triggers with the snapshot of the collection in event variable
      //Logic will be handled here to be listened from controllers in ui logic
      notifyListeners();
    }
    );
  }
}