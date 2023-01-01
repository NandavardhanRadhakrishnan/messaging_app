import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/Shared/loadingScreen.dart';
import 'package:messaging_app/models/chatModel.dart';
import 'package:messaging_app/models/userModel.dart';
import 'package:messaging_app/screens/ChatBubble.dart';
import 'package:messaging_app/services/DatabaseService.dart';
import 'package:provider/provider.dart';

class ChatUser extends StatefulWidget {
  final Users otherUser;
  final Users user;
  ChatUser({required this.otherUser, required this.user, Key? key})
      : super(key: key);

  @override
  State<ChatUser> createState() => _ChatUserState();
}

class _ChatUserState extends State<ChatUser> {
  String? msg;
  //Bool used to refresh future builder
  bool refresh = true;
  @override
  Widget build(BuildContext context) {
    Database db = Database(uid: widget.user.uid);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text(widget.otherUser.nickName!),
      ),
      backgroundColor: Colors.grey[850],
      body: Column(
        children: [
          SizedBox(height: 20),

          //TODO resize when keyboard is open
          FutureBuilder(
            future: db.getMessages(widget.user.uid, widget.otherUser.uid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  height: MediaQuery.of(context).size.height - 180,
                  child: ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (_, int position) {
                      final item = snapshot.data![position];
                      return ChatBubble(
                          isSentByUser: item.senderUid == widget.user.uid,
                          chat: item);
                    },
                  ),
                );
              } else {
                return Container(
                    height: MediaQuery.of(context).size.height - 160,
                    child: Loading());
              }
            },
          ),
          SizedBox(
            height: 10,
          ),
          //TODO style this message bar properly
          MessageBar(
            onSend: (val) {
              setState(() {
                refresh = !refresh;
              });
              db.sendMessage(widget.otherUser.uid, val);
            },
          )
        ],
      ),
    );
  }
}
