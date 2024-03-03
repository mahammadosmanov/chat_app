import 'package:chat_app/app/managers/auth_manager.dart';
import 'package:chat_app/app/managers/firestore_manager.dart';
import 'package:chat_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  List friendsIdList = [];
  RxList friendsNameList = [].obs;

  void onTapUser(String profileName) {
    Get.toNamed(
      Routes.MESSAGE,
      arguments: profileName,
    );
  }

  @override
  void onInit() {
    FireStoreManager.instance.usersSnapshots.listen(
      (collection) {
        friendsIdList = [];
        friendsNameList.value = [];
        for (var doc in collection.docs) {
          if (doc.id == AuthManager.instance.uid) {
            friendsIdList = doc.data()['friends'];
          }
          if (friendsIdList.contains(doc.id)) {
            friendsNameList.add(doc.data()['name']);
          }
        }
      },
    );

    super.onInit();

    // FireStoreManager.instance.usersSnapshots.forEach(
    //   (collection) {
    //     friends.value = [];
    //     for (var doc in collection.docs) {
    //       friends.add(doc.data()[]);
    //     }
    //   },
    // );

    // FireStoreManager.instance.usersSnapshots.listen(
    //   (collection) {
    //     friends.value = [];
    //     for (var doc in collection.docs) {
    //       friends.add(doc.data());
    //     }
    //   },
    // );
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
