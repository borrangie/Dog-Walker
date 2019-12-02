import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class ToastFactory {
  static void showError(String text) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        timeInSecForIos: 1
    );
  }

  static void showInfo(String text) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        timeInSecForIos: 1
    );
  }
}
