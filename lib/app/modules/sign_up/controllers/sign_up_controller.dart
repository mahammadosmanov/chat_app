import 'package:chat_app/app/managers/auth_manager.dart';
import 'package:chat_app/app/managers/firestore_manager.dart';
import 'package:chat_app/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  FocusNode pinPutFocusNode = FocusNode();
  TextEditingController profileNameTextEditingController =
      TextEditingController();

  String phoneNumber = '';
  Rx<bool> isCodeSent = false.obs;
  Rx<bool> isAuthorized = false.obs;

  void onInputChange(String number) {
    phoneNumber = number;
  }

  void onTapSignUpButton() async {
    await AuthManager.instance.verifyPhoneNumber(phoneNumber);
  }

  void onSubmittedSmsCode(String smsCode) async {
    bool signedIn = await AuthManager.instance.verifySms(smsCode);
    if (signedIn) {
      isAuthorized.value = true;
    }
  }

  void tapNextButton() async {
    FireStoreManager.instance.createUser(
      {
        "name": profileNameTextEditingController.text,
        "uid": AuthManager.instance.uid ?? ''
      },
    );
    FireStoreManager.instance.getUserName();
    Get.toNamed(Routes.HOME);
  }

  @override
  void onInit() {
    AuthManager.instance.addListener(
      () {
        isCodeSent.value = !isCodeSent.value;
      },
    );
    pinPutFocusNode;
    pinPutFocusNode.requestFocus();
    profileNameTextEditingController;
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
