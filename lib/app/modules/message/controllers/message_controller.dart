import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MessageController extends GetxController {
  TextEditingController messageTextBox = TextEditingController();

  void sendMessage() {
    Map<String, String> message = {
      'name': 'me',
      'message': messageTextBox.text
    };
    print(messageTextBox.text);
  }

  @override
  void onInit() {
    messageTextBox;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    messageTextBox.dispose();
    super.onClose();
  }
}
