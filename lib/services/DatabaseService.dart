import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messaging_app/models/chatModel.dart';
import 'package:messaging_app/models/userModel.dart';

class Database {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String uid;

  Database({required this.uid});

  Future<List<Users>> getUsersWhoChatWithUid() async {
    final snapshotChatTable = await firestore.collection("ChatTable").get();
    List<Users> output = List.empty();

    snapshotChatTable.docs.forEach((element) {
      //output list

      //if the _uid has received a chat from user then add user(reciver) to output
      if (element.get("sender") == uid) {
        Users u = Users(uid: element.get("reciver"), nickName: element.get("nickName"));
        output.add(u);
      }
      //if the _uid has sent a chat from user then add user(sender) to output
      else if (element.get("reciver") == uid) {
        Users u = Users(uid: element.get("sender"), nickName: element.get("nickName"));
        output.add(u);
      }
    });
    return output;
  }

  Future updateUserData(String? nickName) async {
    return await firestore.collection("UsersTable").doc(uid).set({'nickName': nickName ?? ""});
  }

  Future<String> getNickNameFromUid() async {
    var data = await firestore.collection("UsersTable").doc(uid).get();
    return data.toString();
  }

  Users _usersFromSnapshot(DocumentSnapshot snapshot) {
    return Users(uid: uid!, nickName: snapshot["nickName"]);
  }

  Stream<Users> get users {
    return firestore.collection("UsersTable").doc(uid).snapshots().map(_usersFromSnapshot);
  }

  Future<List<Users>> getAllUsers() async {
    final snapshotUsersTable = await firestore.collection("UsersTable").get();
    List<Users> output = [];
    snapshotUsersTable.docs.forEach((element) {
      Users u = Users(uid: element.id, nickName: element.get("nickName"));
      output.add(u);
    });
    output.removeWhere((element) => element.uid == uid);
    return output;
  }

  Future sendMessage(String receiver, String message) async {
    Chat chat = Chat(senderUid: uid,receiverUid: receiver,message: message,timestamp: DateTime.now().millisecondsSinceEpoch);
    return firestore.collection("ChatTable").add(chat.toMap());
  }
  
  Future<List<Chat>> getMessages(String sender,String receiver) async {
    final snapshotChatTable = await firestore.collection("ChatTable").get();
    List<Chat> output = [];
    snapshotChatTable.docs.forEach((element) { 
      Chat c = Chat(senderUid: element.get("senderUid"), receiverUid: element.get("receiverUid"), message: element.get("message"), timestamp: element.get("timestamp"));
      output.add(c);
    });
    output.removeWhere((element){
      return !((sender==element.senderUid||sender==element.receiverUid)&&(receiver==element.senderUid||receiver==element.receiverUid));
    });
    return output;
  }
}
