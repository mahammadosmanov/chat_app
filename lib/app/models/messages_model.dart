class MessageModel {
  MessageModel({
    this.isSender,
    required this.receiverId,
    required this.senderId,
    required this.receiverName,
    required this.senderName,
    required this.text,
    required this.timeStamp,
    this.messageId,
  });

  final String? messageId;
  final bool? isSender;
  final String receiverId;
  final String senderId;
  final String receiverName;
  final String senderName;
  final String text;
  final DateTime timeStamp;
}
