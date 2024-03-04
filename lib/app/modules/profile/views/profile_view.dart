import 'package:chat_app/app/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: 1,
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Card(
                    color: Colors.grey,
                    elevation: 30,
                    child: Center(
                      child: Text(
                        '',
                        style: TextStyle(fontSize: 44),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.black12),
                      foregroundColor: MaterialStatePropertyAll(Colors.black),
                    ),
                    onPressed: controller.signOut,
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
    );
  }
}
