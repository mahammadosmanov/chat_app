import 'dart:async';

import 'package:chat_app/app/managers/auth_manager.dart';
import 'package:chat_app/app/managers/firestore_manager.dart';
import 'package:chat_app/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  List friendsIdList = [];
  RxList friendsNameList = [].obs;
  StreamSubscription? _userStream;

  void onTapUser(
    String friendName,
    String friendUid,
  ) {
    Get.toNamed(
      Routes.MESSAGE,
      arguments: {"friendName": friendName, "friendUid": friendUid},
    );
  }

  @override
  Future<void> onInit() async {
    friendsIdList = [];
    friendsNameList.value = [];

    _userStream = FireStoreManager.instance.friendsCollection
        .doc(AuthManager.instance.uid)
        .snapshots()
        .listen(
      (event) async {
        friendsIdList = [];
        friendsNameList.value = [];
        friendsIdList = event.data()?['friends'];
        for (var friendId in friendsIdList) {
          DocumentSnapshot<Map<String, dynamic>> friendDoc =
              await FireStoreManager.instance.usersCollection
                  .doc(friendId)
                  .get();
          friendsNameList.add(friendDoc.data()?['name']);
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
  void onClose() async {
    await _userStream?.cancel();
    _userStream = null;
    super.onClose();
  }
}
