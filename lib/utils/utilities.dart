import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class utilities{
  void toastMessages(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.indigo.shade500,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
  void successMessage(String message) {
    Fluttertoast.showToast(
        msg: "Successfully registered",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.indigo.shade500,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}