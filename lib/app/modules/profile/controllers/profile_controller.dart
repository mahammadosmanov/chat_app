import 'package:chat_app/app/managers/auth_manager.dart';
import 'package:chat_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  void signOut() {
    AuthManager.instance.signOut();
    Get.offNamed(Routes.SPLASH);
  }

  @override
  void onInit() {
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
