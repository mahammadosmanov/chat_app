import 'package:chat_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          highlightColor: Colors.blue,
          onTap: () {
            Get.offNamed(Routes.HOME);
          },
          child: const SizedBox(
            width: 84,
            height: 56,
            child: Icon(Icons.chat),
          ),
        ),
        const Spacer(),
        InkWell(
          highlightColor: Colors.green,
          onTap: () {
            Get.offNamed(Routes.FRIENDU);
          },
          child: const SizedBox(
            width: 84,
            height: 56,
            child: Icon(Icons.mobile_friendly),
          ),
        ),
        const Spacer(),
        InkWell(
          highlightColor: Colors.red,
          onTap: () {
            Get.offNamed(Routes.PROFILE);
          },
          child: const SizedBox(
            width: 84,
            height: 56,
            child: Icon(Icons.accessibility),
          ),
        ),
      ],
    );
  }
}
