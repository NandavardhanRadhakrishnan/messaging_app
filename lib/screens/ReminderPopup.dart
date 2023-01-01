import 'package:flutter/material.dart';

class SetNickNamePopUp extends StatelessWidget {
  const SetNickNamePopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[850],
      title: Text(
        "Profile Creation",
        style: TextStyle(color: Colors.white),
      ),
      content: Text(
        "Set your nick name in the home screen drawer. otherwise others wont be able to identify you",
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("OK", style: TextStyle(color: Colors.white)))
      ],
    );
  }
}
