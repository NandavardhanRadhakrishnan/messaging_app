import 'package:flutter/material.dart';

var buttonStyle = ButtonStyle(foregroundColor: MaterialStatePropertyAll<Color>(Colors.white));
var textInputDecoration = InputDecoration(
    hintStyle: TextStyle(color: Colors.white),
    fillColor: Colors.grey[800],
    filled: true,
    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[900]!, width: 2)),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2)));
