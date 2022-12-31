import 'package:flutter/material.dart';
import 'package:messaging_app/Shared/constants.dart';
import 'package:messaging_app/services/AuthenticationService.dart';

class Register extends StatefulWidget {
  final Function? toggleView;

  const Register({this.toggleView, Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
        backgroundColor: Colors.grey[800],
        title: Text("Register"),
        actions: [
          TextButton.icon(
            onPressed: () {
              widget.toggleView?.call();
            },
            icon: Icon(Icons.person),
            label: Text("Sign In"),
            style: buttonStyle,
          ),
        ],
      ),
      body: Container(
          color: Colors.grey[900],
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
                  decoration: textInputDecoration.copyWith(hintText: "Password"),
                  validator: (val) => val!.length < 6 ? "Enter a password 6+ long" : null,
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
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.grey[800])),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                      if (result == null) {
                        setState(() {
                          loading = false;
                          error = "please supply a valid email";
                        });
                      }
                    }
                  },
                  child: Text(
                    "Register",
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
