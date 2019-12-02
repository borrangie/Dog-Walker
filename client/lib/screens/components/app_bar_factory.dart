import 'package:flutter/material.dart';

abstract class AppBarFactory {
  static AppBar generate(context, title,
  {Color textColor: Colors.black, Color color: Colors.white, Color buttonColor: Colors.red}) {
    return AppBar(
        title: Text(
          title,
          style: TextStyle(
            color: textColor
          ),
        ),
        backgroundColor: color,
        elevation: 5,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: buttonColor,),
          onPressed: () {
            Navigator.pop(context);
          },
        )
    );
  }
}
