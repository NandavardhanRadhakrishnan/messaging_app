import 'package:flutter/material.dart';
import 'package:messaging_app/Shared/loadingScreen.dart';
import 'package:messaging_app/models/chatModel.dart';
import 'package:messaging_app/models/userModel.dart';
import 'package:messaging_app/screens/ChatScreen.dart';
import 'package:messaging_app/services/DatabaseService.dart';

class UsersList extends StatefulWidget {
  final Users user;

  const UsersList({Key? key, required this.user}) : super(key: key);

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  @override
  Widget build(BuildContext context) {
    Database db = Database(uid: widget.user.uid);
    return Dialog(
      backgroundColor: Colors.grey[800],
      child: Container(
        height: 600,
        child: Padding(
            padding: EdgeInsets.all(12),
            child: FutureBuilder<List>(
              future: db.getAllUsers(),
              initialData: [],
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, int index) {
                          final item = snapshot.data![index];
                          return Card(
                            color: Colors.grey[900],
                            child: ListTile(
                              title: Text(
                                item.nickName,
                                style: TextStyle(color: Colors.white),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChatUser(
                                              user: widget.user,
                                              otherUser: item,
                                            )));
                              },
                            ),
                          );
                        },
                      )
                    : Loading();
              },
            )),
      ),
    );
  }
}
