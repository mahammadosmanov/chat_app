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
                      color: Colors.black26,
                      elevation: 30,
                      child: Center(
                        child: Text(
                          controller.users[index],
                          style: const TextStyle(
                              fontSize: 44, color: Colors.deepPurple),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.black26),
                        foregroundColor:
                            MaterialStatePropertyAll(Colors.deepPurple),
                      ),
                      onPressed: () {
                        controller
                            .onTapAdd({'friendName': controller.users[index]});
                      },
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
