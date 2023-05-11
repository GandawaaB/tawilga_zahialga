import "package:flutter/material.dart";

final messengerKey = GlobalKey<ScaffoldMessengerState>();
class Utils{
  static showSnackBar(String text){
    // ignore: unnecessary_null_comparison
    if(text == null) return;
    final snackBar = SnackBar(content: Text(text),backgroundColor: Colors.blue,);
    messengerKey.currentState !
    ..removeCurrentSnackBar()
    ..showSnackBar(snackBar);
  }
}