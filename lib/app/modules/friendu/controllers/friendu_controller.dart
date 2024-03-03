import 'package:chat_app/app/managers/firestore_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FrienduController extends GetxController {
  RxList users = [].obs;

  void onTapAdd(String friendUid) {
    FireStoreManager.instance.addFriend(friendUid);
  }

  @override
  void onInit() {
    FireStoreManager.instance.usersSnapshots.forEach(
      (collection) {
        users.value = [];
        for (QueryDocumentSnapshot<Map<String, dynamic>> doc
            in collection.docs) {
          users.add(doc.data());
        }
      },
    );
    FireStoreManager.instance.usersSnapshots.listen(
      (collection) {
        users.value = [];
        for (QueryDocumentSnapshot doc in collection.docs) {
          users.add(doc.data());
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
