import 'package:chat_app/app/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: controller.friends.length,
              itemBuilder: (context, index) {
                return _buildUserCard(controller.friends[index]['name']);
              },
            ),
            const Spacer(),
            const BottomBar(),
          ],
        ),
      );
    });
  }

  Widget _buildUserCard(String profileName) {
    return Card(
      shape: const Border(
        left: BorderSide(width: 100),
      ),
      child: Center(
        child: Text(
          profileName,
          style: const TextStyle(fontSize: 44),
        ),
      ),
    );
  }
}
