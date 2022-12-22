import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messaging_app/models/userModel.dart';

class Database {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<Users>> getUsersWhoChatWithUid(String _uid) async {
    final snapshotChatTable = await firestore.collection("ChatTable").get();
    List<Users> output = List.empty();

    snapshotChatTable.docs.forEach((element) {
      //output list

      //if the _uid has received a chat from user then add user(reciver) to output
      if (element.get("sender") == _uid) {
        Users u = Users(uid: element.get("reciver"), nickName: element.get("nickName"));
        output.add(u);
      }
      //if the _uid has sent a chat from user then add user(sender) to output
      else if (element.get("reciver") == _uid) {
        Users u = Users(uid: element.get("sender"), nickName: element.get("nickName"));
        output.add(u);
      }
    });
    return output;
  }
}
