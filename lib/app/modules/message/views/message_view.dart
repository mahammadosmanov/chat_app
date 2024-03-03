import 'package:chat_app/app/core/constants/assets_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/message_controller.dart';

enum ProfilePhotoScale { small, medium, large }

class MessageView extends GetView<MessageController> {
  const MessageView({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    String profileName = Get.arguments;
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            _buildAppBar(
              profileName,
            ),
            const SizedBox(
              height: 10,
            ),
            _buildChatterProfile('Hi', false),
            _buildChatBubble(false, 'hello motherfuckers'),
            Expanded(
              child: Container(),
            ),
            _buildMessageBox(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(String profileName) {
    return Row(
      children: [
        _buildBackButton(),
        _buildProfilePhoto(ProfilePhotoScale.medium),
        const SizedBox(
          width: 10,
        ),
        _buildProfileName(profileName)
      ],
    );
  }

  Widget _buildProfilePhoto(ProfilePhotoScale photoScale) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Image.asset(
        generalProfilePhoto,
        scale: photoScale == ProfilePhotoScale.small
            ? 20
            : photoScale == ProfilePhotoScale.medium
                ? 15
                : 10,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildBackButton() {
    return GestureDetector(
      onTap: controller.onTapBackButton,
      child: const Icon(
        Icons.arrow_back,
        size: 44,
      ),
    );
  }

  Widget _buildProfileName(String profileName) {
    return Text(
      profileName,
      style: const TextStyle(fontSize: 24),
    );
  }

  Widget _buildChatterProfile(String profileName, bool isSender) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment:
            isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isSender)
            const SizedBox(
              width: 20,
            ),
          if (isSender)
            const Align(
              alignment: Alignment.topCenter,
              child: Text('Roh'),
            ),
          if (isSender)
            const SizedBox(
              width: 10,
            ),
          _buildProfilePhoto(ProfilePhotoScale.small),
          SizedBox(
            width: isSender ? 20 : 10,
          ),
          if (!isSender)
            const Align(
              alignment: Alignment.topCenter,
              child: Text('Roh'),
            ),
        ],
      ),
    );
  }

  Widget _buildChatBubble(
    bool isSender,
    String message,
  ) {
    return Padding(
      padding: EdgeInsets.only(
        left: isSender ? 0 : 70,
        right: isSender ? 70 : 0,
      ),
      child: Align(
        alignment: isSender ? Alignment.bottomRight : Alignment.bottomLeft,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(message),
          ),
        ),
      ),
    );
  }

  Widget _buildMessageBox() {
    return Row(
      children: [
        const SizedBox(
          width: 50,
        ),
        SizedBox(
          width: 280,
          child: TextField(
            controller: controller.messageTextBox,
            decoration: const InputDecoration(
              enabled: true,
              fillColor: Colors.grey,
              filled: true,
              hintText: 'Message',
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {}, //TODO implement send message logic
          child: const Icon(
            Icons.send,
            color: Colors.green,
          ),
        ),
      ],
    );
  }
}
