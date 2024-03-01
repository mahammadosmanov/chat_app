import 'package:get/get.dart';

import '../controllers/friendu_controller.dart';

class FrienduBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FrienduController>(
      () => FrienduController(),
    );
  }
}
