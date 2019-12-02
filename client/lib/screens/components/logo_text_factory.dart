import 'package:dogwalker2/screens/components/text_factory.dart';
import 'package:flutter/material.dart';

abstract class LogoTextFactory {
  static Container generate(context, titleRow1, titleRow2) {
    return Container(
      child: Center(
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(130.0, 30.0, 0, 0),
              child: TextFactory.generateText(titleRow1, size: 50.0, weight: FontWeight.bold)
            ),
            Container(
              padding: EdgeInsets.fromLTRB(130.0, 95.0, 0, 0),
              child: TextFactory.generateText(titleRow2, size: 50.0, weight: FontWeight.bold)
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
