import 'package:chat_app/app/managers/firestore_manager.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxList friends = [].obs;

  @override
  void onInit() {
    FireStoreManager.instance.friendsSnapshots.forEach(
      (collection) {
        friends.value = [];
        for (var doc in collection.docs) {
          friends.add(doc.data());
        }
      },
    );

    FireStoreManager.instance.friendsSnapshots.listen(
      (collection) {
        friends.value = [];
        for (var doc in collection.docs) {
          friends.add(doc.data());
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
    super.onClose();
  }
}
