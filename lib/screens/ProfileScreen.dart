import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/Shared/constants.dart';
import 'package:messaging_app/models/userModel.dart';
import 'package:messaging_app/services/AuthenticationService.dart';
import 'package:messaging_app/services/DatabaseService.dart';

class Profile extends StatefulWidget {
  final Users user ;
  Profile( {Key? key, required this.user}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? nickName;

  @override
  Widget build(BuildContext context) {
    Database db = Database(uid:widget.user.uid);
    return Dialog(
      backgroundColor: Colors.grey[800],
      child: Container(
        height: 200,
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Modify your nick name",style: TextStyle(color: Colors.white,fontSize: 20),),
              SizedBox(height: 10,),
              TextFormField(
                style: TextStyle(color: Colors.white),
                initialValue: widget.user.nickName,
                decoration: textInputDecoration.copyWith(hintText: "Display Name"),
                onChanged: (val) {
                  setState(() {
                    nickName = val;
                  });
                },
              ),
              SizedBox(height: 10,),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.white),
                  foregroundColor: MaterialStatePropertyAll(Colors.black),
                ),
                onPressed: () {
                  db.updateUserData(nickName);
                  Navigator.pop(context);
                },
                child: Text("submit"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
