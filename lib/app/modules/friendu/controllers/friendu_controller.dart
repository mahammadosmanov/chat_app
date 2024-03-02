import 'package:chat_app/app/managers/firestore_manager.dart';
import 'package:get/get.dart';

class FrienduController extends GetxController {
  RxList users = [].obs;

  void onTapAdd(Map<String, String> friend) {
    FireStoreManager.instance.addFriend(friend);
  }

  @override
  void onInit() {
    FireStoreManager.instance.usersSnapshots.forEach(
      (collection) {
        for (var doc in collection.docs) {
          users.value = [];
          users.add(doc.data()['name']);
        }
      },
    );
    FireStoreManager.instance.usersSnapshots.listen(
      (collection) {
        for (var doc in collection.docs) {
          users.value = [];
          users.add(doc.data()['name']);
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
