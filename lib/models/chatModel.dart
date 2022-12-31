import 'package:firebase_auth/firebase_auth.dart';
import 'package:messaging_app/models/userModel.dart';

class Chat {
  String senderUid;
  String receiverUid;
  String message;
  int timestamp;

  Chat({required this.senderUid,required this.receiverUid,required this.message,required this.timestamp});

  Map<String,dynamic> toMap(){
    return{
      'senderUid':senderUid,
      'receiverUid':receiverUid,
      'message':message,
      'timestamp':timestamp
    };
  }

}