class MessagesModel {
  MessagesModel(
    this.isSender,
    this.receiverId,
    this.senderId,
    this.receiverName,
    this.senderName,
    this.text,
    this.timeStamp,
  );

  final bool isSender;
  final String receiverId;
  final String senderId;
  final String receiverName;
  final String senderName;
  final String text;
  final DateTime timeStamp;
}
