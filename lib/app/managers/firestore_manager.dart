import 'package:chat_app/app/managers/auth_manager.dart';
import 'package:chat_app/app/models/messages_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class FireStoreManager extends ChangeNotifier {
  FireStoreManager._();

  static FireStoreManager instance = FireStoreManager._();

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> friends = [];

  String userName = '';

  void get() async {
    await usersSnapshots.forEach(
      (collection) {
        for (QueryDocumentSnapshot<Map<String, dynamic>> doc
            in collection.docs) {
          if (doc.reference.id == AuthManager.instance.uid) {
            userName = doc.data()['name'];
          }
        }
      },
    );
  }

  void createUser(
    PhoneAuthCredential phoneAuthCredential,
    Map<String, String> data,
  ) {
    _fireStore.collection('users').doc(AuthManager.instance.uid).set(data);
    _fireStore.collection('messages').doc(AuthManager.instance.uid).set(data);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> get usersSnapshots {
    return _fireStore.collection('users').snapshots();
  }

  List myFriendsIdList = [];
  List friendFriendsIdList = [];

  void addFriend(String friendUid) async {
    DocumentSnapshot<Map<String, dynamic>> myDocument = await _fireStore
        .collection('users')
        .doc(AuthManager.instance.uid)
        .get();
    DocumentSnapshot<Map<String, dynamic>> friendDocument =
        await _fireStore.collection('users').doc(friendUid).get();
    myFriendsIdList = myDocument.data()!['friends'] ?? [];
    friendFriendsIdList = friendDocument.data()!['friends'] ?? [];
    myFriendsIdList.add(friendUid);
    friendFriendsIdList.add(friendUid);
    _fireStore.collection('users').doc(AuthManager.instance.uid).update(
      {
        'friends': myFriendsIdList,
      },
    );
    _fireStore.collection('users').doc(friendUid).update(
      {
        'friends': friendFriendsIdList,
      },
    );
  }

  void sendMessage(MessageModel message) {
    final DocumentReference senderMessageDocRef = _fireStore
        .collection('messages')
        .doc(message.senderId)
        .collection('chats')
        .doc(message.receiverId)
        .collection('messages')
        .doc();

    senderMessageDocRef.set(
      {
        'messageId': senderMessageDocRef.id,
        'isSender': message.isSender,
        'receiverId': message.receiverId,
        'receiverName': message.receiverName,
        'senderId': message.senderId,
        'senderName': message.senderName,
        'text': message.text,
        'timeStamp': message.timeStamp,
      },
    );

    final DocumentReference receiverMessageDocRef = _fireStore
        .collection('messages')
        .doc(message.receiverId)
        .collection('chats')
        .doc(message.senderId)
        .collection('messages')
        .doc();

    receiverMessageDocRef.set(
      {
        'messageId': senderMessageDocRef.id,
        'isSender': message.isSender,
        'receiverId': message.receiverId,
        'receiverName': message.receiverName,
        'senderId': message.senderId,
        'senderName': message.senderName,
        'text': message.text,
        'timeStamp': message.timeStamp,
      },
    );
  }

  void getMessages(String friendId) async {
    await _fireStore
        .collection('messages')
        .doc(AuthManager.instance.uid)
        .collection('chats')
        .doc(friendId)
        .snapshots()
        .forEach(
      (doc) {
        doc.data();
      },
    );
  }
}
