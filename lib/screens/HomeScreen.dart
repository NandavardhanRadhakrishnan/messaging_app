import 'package:flutter/material.dart';
import 'package:messaging_app/constants.dart';
import 'package:messaging_app/services/AuthenticationService.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text(
          "Chat",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              _auth.signOut();
            },
            icon: Icon(Icons.person),
            label: Text("Sign Out"),
            style: buttonStyle,
          )
        ],
      ),
      body: ListView(

      ),
    );
  }
}
