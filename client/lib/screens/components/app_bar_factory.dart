import 'package:flutter/material.dart';

abstract class AppBarFactory {
  static AppBar generate(context, title) {
    return AppBar(
        title: Text(title),
        backgroundColor: Colors.white,
        elevation: 5,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.red,),
          onPressed: () {
            Navigator.pop(context);
          },
        )
    );
  }
}
