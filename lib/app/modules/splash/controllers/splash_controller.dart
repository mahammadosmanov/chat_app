import 'package:chat_app/app/managers/auth_manager.dart';
import 'package:chat_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    if (AuthManager.instance.signedIn) {
      Get.offNamed(Routes.HOME);
    } else {
      Get.offNamed(Routes.SIGN_UP);
    }
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
