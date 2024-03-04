import 'dart:async';

import 'package:chat_app/app/managers/auth_manager.dart';
import 'package:chat_app/app/managers/firestore_manager.dart';
import 'package:chat_app/app/models/messages_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MessageController extends GetxController {
  TextEditingController messageTextEditingController = TextEditingController();
  StreamSubscription? _streamSubscription;

  void onTapSend() {}

  void onTapBackButton() {
    Get.back();
  }

  Map<String, String> friendData = Get.arguments;

  void getMessageList() {
    FireStoreManager.instance.getMessages(friendData['friendUid'] ?? '');
  }

  void sendMessage() {
    MessageModel messageModel = MessageModel(
      receiverId: friendData['friendUid'] ?? '',
      senderId: AuthManager.instance.uid ?? '',
      receiverName: friendData['friendName'] ?? '',
      senderName: FireStoreManager.instance.userName,
      text: messageTextEditingController.text,
      timeStamp: DateTime.now(),
    );

    FireStoreManager.instance.sendMessage(
      messageModel,
    );
  }

  RxList messageList = [].obs;
  // RxList filteredMessageList = [].obs;

  @override
  void onInit() async {
    messageTextEditingController;
    _streamSubscription = FireStoreManager.instance.chatsCollection
        .doc(friendData['friendUid'])
        .collection('messages')
        .snapshots()
        .listen(
      (event) {
        messageList.value = [];
        for (var doc in event.docs) {
          messageList.add(
            MessageModel(
              isSender: doc.data()['isSender'],
              receiverId: doc.data()['receiverId'],
              senderId: doc.data()['senderId'],
              receiverName: doc.data()['receiverName'],
              senderName: doc.data()['senderName'],
              text: doc.data()['text'],
              timeStamp:
                  DateTime.parse(doc.data()['timeStamp'].toDate().toString()),
            ),
          );

          messageList.sort(
            (a, b) {
              var adate = DateTime.parse(a.timeStamp.toString());
              var bdate = DateTime.parse(b.timeStamp.toString());
              return adate.compareTo(bdate);
            },
          );
        }
      },
    );

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    messageTextEditingController.dispose();
    _streamSubscription?.cancel();

    super.onClose();
  }
}
