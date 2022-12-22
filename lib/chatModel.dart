import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messaging_app/userModel.dart';

class Chat {
  Users sender;
  Users reciver;
  String message;
  int? timestamp;

  Chat({required this.sender,required this.reciver,required this.message,int? timestamp})
  : this.timestamp = DateTime.now().millisecondsSinceEpoch;
}