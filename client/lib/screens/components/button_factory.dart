import 'package:flutter/material.dart';

abstract class ButtonFactory {
  static Container generate(String text, GestureTapCallback tapCallback) {
    return Container(
      height: 45,
      child: Material(
        borderRadius: BorderRadius.circular(50),
        color: Colors.red,
        shadowColor: Colors.redAccent,
        elevation: 7,
        child: GestureDetector(
          onTap: tapCallback,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        ),
      ),
    );
  }

  static InkWell generateLink(String text, GestureTapCallback tapCallback) {
    return InkWell(
      onTap: tapCallback,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
          fontFamily: 'Montserrat',
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}

