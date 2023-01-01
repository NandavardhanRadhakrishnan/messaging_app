import 'package:flutter/material.dart';
import 'package:messaging_app/models/chatModel.dart';
import 'package:messaging_app/models/userModel.dart';
import 'package:chat_bubbles/chat_bubbles.dart';

class ChatBubble extends StatelessWidget {
  bool isSentByUser;
  Chat chat;
  ChatBubble({required this.isSentByUser, required this.chat, super.key});

  @override
  Widget build(BuildContext context) {
    return BubbleNormal(
      text: chat.message,
      isSender: isSentByUser,
      color: isSentByUser ? Colors.white : Colors.grey[800]!,
      textStyle: TextStyle(color: isSentByUser ? Colors.black : Colors.white),
    );
  }
}
