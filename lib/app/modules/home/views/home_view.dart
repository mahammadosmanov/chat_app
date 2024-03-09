import 'package:chat_app/app/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: controller.friendsNameList.length,
              itemBuilder: (context, index) {
                if (controller.friendsNameList[index] != null) {
                  return _buildUserCard(controller.friendsNameList[index],
                      controller.friendsIdList[index]);
                }
                return null;
              },
            ),
            const Spacer(),
            const BottomBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserCard(
    String profileName,
    String profileUid,
  ) {
    return GestureDetector(
      onTap: () {
        controller.onTapUser(profileName, profileUid);
      },
      child: Card(
        shape: const Border(
          left: BorderSide(width: 100),
        ),
        child: Center(
          child: Text(
            profileName,
            style: const TextStyle(fontSize: 44),
          ),
        ),
      ),
    );
  }
}
