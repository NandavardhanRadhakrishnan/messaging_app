import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/Shared/constants.dart';
import 'package:messaging_app/models/userModel.dart';
import 'package:messaging_app/screens/ProfileScreen.dart';
import 'package:messaging_app/screens/UsersScreen.dart';
import 'package:messaging_app/services/AuthenticationService.dart';
import 'package:provider/provider.dart';
import 'package:messaging_app/services/DatabaseService.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final u = Provider.of<User?>(context);
    Database db = Database(uid: u!.uid);
    return StreamBuilder(
        stream: Database(uid: u.uid).users,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Users? user = snapshot.data;
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
                  ),
                ],
              ),
              drawer: Drawer(
                backgroundColor: Colors.grey[900],
                child: ListView(
                  children: [
                    UserAccountsDrawerHeader(
                      decoration: BoxDecoration(color: Colors.grey[700]),
                      accountName: Text(user?.nickName ?? "set your name" , style: TextStyle(fontSize: 22),),
                      accountEmail: null,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      title: Text(
                        "Profile",
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => Profile(user: user!),
                        );
                      },
                    )
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.chat),
                onPressed: (){
                  showDialog(context: context, builder: (_)=>UsersList(user: user!));
                },
              ),
              body: Container(),
            );
          } else {
            return Container();
          }
        });
  }
}
