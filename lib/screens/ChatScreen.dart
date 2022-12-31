import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/models/userModel.dart';
import 'package:messaging_app/services/DatabaseService.dart';
import 'package:provider/provider.dart';

class ChatUser extends StatefulWidget {
  final Users otherUser;
  final Users user;
  ChatUser({ required this.otherUser,required this.user, Key? key}) : super(key: key);

  @override
  State<ChatUser> createState() => _ChatUserState();
}

class _ChatUserState extends State<ChatUser> {
  String? msg;
  @override
  Widget build(BuildContext context) {
    Database db = Database(uid: widget.user.uid);
    //TODO implement the commented lines as a the chat widget
    // var data = db.getMessages(widget.user.uid, widget.otherUser.uid);
    // data.then((value) => value.forEach((element) {print(element.message);}));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text(widget.otherUser.nickName!),
      ),
      body: Column(
        children: [
          TextFormField(onChanged: (val){
            setState(() {
              msg = val;
            });
          },),
          ElevatedButton(onPressed: (){db.sendMessage(widget.otherUser.uid, msg??"");}, child: Text("send")),
        ],
      )
    );
  }
}
