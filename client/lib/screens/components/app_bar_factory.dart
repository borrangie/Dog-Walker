import 'package:dogwalker2/screens/components/button_factory.dart';
import 'package:flutter/material.dart';

abstract class AppBarFactory {
  static AppBar generateBack(context, title,
      {Color textColor: Colors.black, Color color: Colors.white, Color buttonColor: Colors.red}) {

    return _generateAppBar(
        _generateTitleWidget(title, textColor),
        color,
        ButtonFactory.generateIcon(
            Icons.arrow_back_ios,
            buttonColor,
            () {
              Navigator.pop(context);
            }
        )
    );
  }

  static AppBar generateDrawer(context, title,
      {Color textColor: Colors.black, Color color: Colors.white, Color buttonColor: Colors.red, Function onPressed}) {
    return _generateAppBar(
        _generateTitleWidget(title, textColor),
        color,
        ButtonFactory.generateIcon(
          Icons.menu,
          buttonColor,
          onPressed
        )
    );
  }

  static AppBar _generateAppBar(title, color, iconButton) {
    return AppBar(
      title: title,
      backgroundColor: color,
      elevation: 5,
      automaticallyImplyLeading: true,
      leading: iconButton,
    );
  }

  static Widget _generateTitleWidget(title, textColor) {
    if (title is String) {
      return Text(
        title,
        style: TextStyle(
          color: textColor
        ),
      );
    } else {
      return title;
    }
  }
}
