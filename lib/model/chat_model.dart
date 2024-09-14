import 'package:armywiki/utility/enum.dart';

class ChatModel {
  ChatModel(
    this.text,
    this.sender,
  );

  final String text;
  final Sender sender;

  factory ChatModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      ChatModel(
        json["answer"],
        Sender.ai,
      );
}
