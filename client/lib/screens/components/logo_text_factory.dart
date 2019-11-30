import 'package:flutter/material.dart';

abstract class LogoTextFactory {
  static Container generate(context, titleRow1, titleRow2) {
    return Container(
      child: Center(
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(130.0, 30.0, 0, 0),
              child: Text(
                titleRow1,
                style: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(130.0, 95.0, 0, 0),
              child: Text(
                titleRow2,
                style: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 30, 20, 0),
              child: Image.asset(
                'assets/images/dwlogo.png',
                width: 130,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
