import 'package:chat_app/app/managers/auth_manager.dart';
import 'package:chat_app/app/models/messages_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FireStoreManager extends ChangeNotifier {
  FireStoreManager._();

  static FireStoreManager instance = FireStoreManager._();

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  String userName = '';

  List myFriendsIdList = [];
  List friendFriendsIdList = [];

  CollectionReference get chatsCollection {
    return _fireStore
        .collection('messages')
        .doc(AuthManager.instance.uid)
        .collection('chats');
  }

  CollectionReference<Map<String, dynamic>> get usersCollection {
    return _fireStore.collection('users');
  }

  CollectionReference<Map<String, dynamic>> get friendsCollection {
    return _fireStore.collection('friends');
  }

  void createUser(
    Map<String, String> data,
  ) {
    _fireStore.collection('users').doc(AuthManager.instance.uid).set(data);
    _fireStore.collection('messages').doc(AuthManager.instance.uid).set(data);
    _fireStore.collection('friends').doc(AuthManager.instance.uid).set(data);
  }

  void getUserName() async {
    await usersCollection.snapshots().forEach(
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

  Future<DocumentSnapshot<Map<String, dynamic>>> get userDocument async {
    return await _fireStore
        .collection('users')
        .doc(AuthManager.instance.uid)
        .get();
  }

  void addFriend(String friendUid) async {
    DocumentSnapshot<Map<String, dynamic>> receiverDoc =
        await _fireStore.collection('friends').doc(friendUid).get();
    myFriendsIdList = await receiverDoc.data()?['friends'] ?? [];
    myFriendsIdList.add(friendUid);
    _fireStore.collection('friends').doc(friendUid).set(
      {
        'friends': myFriendsIdList,
      },
    );
    DocumentSnapshot<Map<String, dynamic>> senderDoc = await _fireStore
        .collection('friends')
        .doc(AuthManager.instance.uid)
        .get();
    myFriendsIdList = await senderDoc.data()?['friends'] ?? [];
    myFriendsIdList.add(friendUid);
    _fireStore.collection('friends').doc(AuthManager.instance.uid).set(
      {
        'friends': myFriendsIdList,
      },
    );
  }

  void sendMessage(MessageModel message) async {
    final DocumentReference senderMessageDocRef = _fireStore
        .collection('messages')
        .doc(message.senderId)
        .collection('chats')
        .doc(message.receiverId)
        .collection('messages')
        .doc();

    final DocumentReference receiverMessageDocRef = _fireStore
        .collection('messages')
        .doc(message.receiverId)
        .collection('chats')
        .doc(message.senderId)
        .collection('messages')
        .doc();

    final DocumentReference senderDocRef =
        _fireStore.collection('messages').doc(message.senderId);
    final DocumentReference receiverDocRef =
        _fireStore.collection('messages').doc(message.receiverId);

    await senderDocRef
        .set({"name": message.senderName, "uid": message.senderId});

    await receiverDocRef
        .set({"name": message.receiverName, "uid": message.receiverId});

    await senderMessageDocRef.set(
      {
        'messageId': senderMessageDocRef.id,
        'isSender': true,
        'receiverId': message.receiverId,
        'receiverName': message.receiverName,
        'senderId': message.senderId,
        'senderName': message.senderName,
        'text': message.text,
        'timeStamp': message.timeStamp,
      },
    );

    await receiverMessageDocRef.set(
      {
        'messageId': senderMessageDocRef.id,
        'isSender': false,
        'receiverId': message.receiverId,
        'receiverName': message.receiverName,
        'senderId': message.senderId,
        'senderName': message.senderName,
        'text': message.text,
        'timeStamp': message.timeStamp,
      },
    );
  }

  List messageList = [];

  void getMessages(String friendId) async {
    await _fireStore
        .collection('messages')
        .doc(AuthManager.instance.uid)
        .collection('chats')
        .doc(friendId)
        .snapshots()
        .forEach(
      (doc) {
        messageList.add(doc.data());
      },
    );
  }
}
