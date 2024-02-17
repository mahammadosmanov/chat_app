import 'package:chat_app/app/managers/auth_manager.dart';
import 'package:chat_app/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class SignUpController extends GetxController {

  FocusNode pinPutFocusNode = FocusNode();
  String phoneNumber = '';

  Rx<bool> codeSent = false.obs;
  void onInputChange(String number) {
    phoneNumber = number;
  }

  void onTapSignUpButton() async {
    codeSent.value = await AuthManager.instance.verifyPhoneNumber(phoneNumber);
  }

  void onSubmittedSmsCodeEnter(String smsCode) async {
    bool signedIn = await AuthManager.instance.verifySms(smsCode);
    print(signedIn);
    if(signedIn) {
      Get.toNamed(Routes.HOME);
    }
  }

  @override
  void onInit() {
    AuthManager.instance.addListener(() {
      codeSent.value = !codeSent.value;
    });
    pinPutFocusNode;
    pinPutFocusNode.requestFocus();

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
