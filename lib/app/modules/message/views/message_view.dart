import 'package:chat_app/app/core/constants/assets_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/message_controller.dart';

enum ProfilePhotoScale { small, medium, large }

class MessageView extends GetView<MessageController> {
  const MessageView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            _buildAppBar(
              'Rohtolos',
            ),
            //TODO change profile name to bring It from Database
            const SizedBox(
              height: 10,
            ),
            _buildChatterProfile('Rohtolos', false),
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

  Widget _buildChatterProfile(String profileName, bool isMe) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe)
            const SizedBox(
              width: 20,
            ),
          if (isMe)
            const Align(
              alignment: Alignment.topCenter,
              child: Text('Roh'),
            ),
          if (isMe)
            const SizedBox(
              width: 10,
            ),
          _buildProfilePhoto(ProfilePhotoScale.small),
          SizedBox(
            width: isMe ? 20 : 10,
          ),
          if (!isMe)
            const Align(
              alignment: Alignment.topCenter,
              child: Text('Roh'),
            ),
        ],
      ),
    );
  }

  Widget _buildChatBubble(
    bool isMe,
    String message,
  ) {
    return Padding(
      padding: EdgeInsets.only(
        left: isMe ? 0 : 70,
        right: isMe ? 70 : 0,
      ),
      child: Align(
        alignment: isMe ? Alignment.bottomRight : Alignment.bottomLeft,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(message),
          ),
        ),
      ),
    );
  }

// Widget _buildChat(
//   List messages,
//   bool isMe,
// ) {
//   return GroupedListView(
//     reverse: true,
//     order: GroupedListOrder.DESC,
//     useStickyGroupSeparators: true,
//     floatingHeader: true,
//     elements: messages,
//     groupBy: (message) => DateTime.now(),
//     groupHeaderBuilder: ,
//     itemBuilder: (context, element) {
//       return _buildChatBubble(isMe, messages[0]); //TODO
//     },
//   );
// }

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
