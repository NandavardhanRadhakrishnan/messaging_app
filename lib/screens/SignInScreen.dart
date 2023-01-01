import 'package:flutter/material.dart';
import 'package:messaging_app/Shared/constants.dart';
import 'package:messaging_app/services/AuthenticationService.dart';

class SignIn extends StatefulWidget {
  final Function? toggleView;

  const SignIn({this.toggleView, Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  String error = '';
  String email = '';
  String password = '';
  bool loading = true;
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text("Sign In"),
        actions: [
          TextButton.icon(
            onPressed: () {
              widget.toggleView?.call();
            },
            icon: Icon(Icons.person),
            label: Text("Register"),
            style: buttonStyle,
          ),
        ],
      ),
      body: Container(
          color: Colors.grey[850],
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration: textInputDecoration.copyWith(hintText: "Email"),
                  validator: (val) => val!.isEmpty ? "Enter an email" : null,
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration:
                      textInputDecoration.copyWith(hintText: "Password"),
                  validator: (val) =>
                      val!.length < 6 ? "Enter a password 6+ long" : null,
                  obscureText: true,
                  onChanged: (val) {
                    setState(() {
                      password = val;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.grey[800])),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _auth.signInWithEmailAndPassword(
                          email, password);
                      if (result == null) {
                        setState(() {
                          loading = false;
                          error = "please supply a valid email";
                        });
                      }
                    }
                  },
                  child: Text(
                    "Sign In",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14),
                )
              ],
            ),
          )),
    );
  }
}
