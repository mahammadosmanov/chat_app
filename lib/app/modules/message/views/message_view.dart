import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/message_controller.dart';

class MessageView extends GetView<MessageController> {
  const MessageView({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(children: [

      ],)
    );
  }

  Widget appBar() {return const Row(children: [],);}
}
