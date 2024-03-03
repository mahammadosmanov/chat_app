import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MessageController extends GetxController {
  TextEditingController messageTextBox = TextEditingController();

  void onTapSend() {}

  void onTapBackButton() {
    Get.back();
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
