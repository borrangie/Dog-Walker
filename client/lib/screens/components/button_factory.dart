import 'package:flutter/material.dart';

abstract class ButtonFactory {
  static Container generate(String text, GestureTapCallback tapCallback) {
    return Container(
      height: 45,
      child: MaterialButton(
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(50)
        ),
        color: Colors.red,
        elevation: 7,
        onPressed: tapCallback,
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
    );
  }

  static Container generateOutline(String text, GestureTapCallback tapCallback,
      {Color textColor: Colors.black, Color color: Colors.white, Color outlineColor: Colors.redAccent}) {
    return Container(
      height: 45,
      child: OutlineButton(
        borderSide: BorderSide(
          color: outlineColor,
          style: BorderStyle.solid,
          width: 2,
        ),
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(50)
        ),
        color: color,
        onPressed: tapCallback,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
      ),
    );
  }

  static Container generateBig(String text, GestureTapCallback tapCallback) {
    return Container(
      height: 75,
      child: OutlineButton(
        borderSide: BorderSide(
          color: Colors.redAccent,
          style: BorderStyle.solid, //Style of the border
          width: 2, //width of the border
        ),
        color: Colors.white,
        onPressed: tapCallback,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 25,
              fontFamily: 'Montserrat',
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

