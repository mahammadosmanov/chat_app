import 'package:chat_app/app/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/friendu_controller.dart';

class FrienduView extends GetView<FrienduController> {
  const FrienduView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: controller.users.length,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      color: Colors.grey,
                      elevation: 30,
                      child: Center(
                        child: Text(
                          controller.users[index],
                          style: const TextStyle(fontSize: 44),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.black12),
                        foregroundColor: MaterialStatePropertyAll(Colors.black),
                      ),
                      onPressed: () {},
                      child: const Icon(Icons.add),
                    )
                  ],
                );
              },
            ),
            const Spacer(),
            const BottomBar(),
          ],
        ),
      ),
    );
  }
}
