import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messaging_app/models/chatModel.dart';
import 'package:messaging_app/models/userModel.dart';

class Database {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String uid;

  Database({required this.uid});

  Future updateUserData(String? nickName) async {
    return await firestore
        .collection("UsersTable")
        .doc(uid)
        .set({'nickName': nickName ?? ""});
  }

  Future<String> getNickNameFromUid(String Uid) async {
    var data = await firestore.collection("UsersTable").doc(Uid).get();
    return data.get("nickName").toString();
  }

  Users _usersFromSnapshot(DocumentSnapshot snapshot) {
    return Users(uid: uid, nickName: snapshot["nickName"]);
  }

  Stream<Users> get users {
    return firestore
        .collection("UsersTable")
        .doc(uid)
        .snapshots()
        .map(_usersFromSnapshot);
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
    Chat chat = Chat(
        senderUid: uid,
        receiverUid: receiver,
        message: message,
        timestamp: DateTime.now().millisecondsSinceEpoch);
    return firestore.collection("ChatTable").add(chat.toMap());
  }

  Future<List<Chat>> getMessages(String sender, String receiver) async {
    final snapshotChatTable = await firestore.collection("ChatTable").get();
    List<Chat> output = [];
    snapshotChatTable.docs.forEach((element) {
      Chat c = Chat(
          senderUid: element.get("senderUid"),
          receiverUid: element.get("receiverUid"),
          message: element.get("message"),
          timestamp: element.get("timestamp"));
      output.add(c);
    });
    output.removeWhere((element) {
      return !((sender == element.senderUid || sender == element.receiverUid) &&
          (receiver == element.senderUid || receiver == element.receiverUid));
    });
    output.sort(((a, b) => a.timestamp.compareTo(b.timestamp)));
    return output;
  }

  Future<List<Users>> getUsersWhoChatWithUid() async {
    final snapshotChatTable = await firestore.collection("ChatTable").get();
    List<String> uids = [];
    snapshotChatTable.docs.forEach((element) async {
      if (element.get("senderUid") == uid) {
        String otherUid = element.get("receiverUid");
        uids.add(otherUid);
      }
      if (element.get("receiverUid") == uid) {
        String otherUid = element.get("senderUid");
        uids.add(otherUid);
      }
    });
    uids = uids.toSet().toList();
    List<Users> output = [];
    for (var element in uids) {
      Users u =
          Users(uid: element, nickName: await getNickNameFromUid(element));
      output.add(u);
    }
    return output;
  }
}
