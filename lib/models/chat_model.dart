class ChatModel {
  late String text;
  late bool isSender;
  String? repliedText;

  ChatModel({
    required this.text,
    required this.isSender,
    this.repliedText,
  });
}
