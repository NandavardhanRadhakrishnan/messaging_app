import 'package:flutter/material.dart';
import 'package:messaging_app/screens/AuthenticateScreen.dart';
import 'package:messaging_app/screens/HomeScreen.dart';
import 'package:provider/provider.dart';
import 'models/userModel.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return home or authenticate widget

    final user = Provider.of<Users?>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
