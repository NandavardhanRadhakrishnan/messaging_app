import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/Shared/constants.dart';
import 'package:messaging_app/Shared/loadingScreen.dart';
import 'package:messaging_app/models/userModel.dart';
import 'package:messaging_app/screens/ChatScreen.dart';
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
                        accountName: Text(
                          user?.nickName ?? "set your name",
                          style: TextStyle(fontSize: 22),
                        ),
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
                  backgroundColor: Colors.grey[800],
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) => UsersList(user: user!));
                  },
                ),
                body: StreamBuilder<List>(
                    stream: db.getUsersWhoChatWithUid(),
                    initialData: [],
                    builder: ((context, snapshot) {
                      return snapshot.hasData
                          ? Container(
                              color: Colors.grey[850],
                              child: ListView.builder(
                                itemCount: snapshot.data?.length,
                                itemBuilder: (context, index) {
                                  Users item = snapshot.data![index];
                                  return Column(
                                    children: [
                                      Divider(
                                        color: Colors.white,
                                        height: 2,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      ListTile(
                                        textColor: Colors.black,
                                        title: Text(
                                          item.nickName!,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ChatUser(
                                                        user: user!,
                                                        otherUser: item,
                                                      )));
                                        },
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Divider(
                                        color: Colors.white,
                                        height: 2,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            )
                          : Loading();
                    })));
          } else {
            return Container();
          }
        });
  }
}
