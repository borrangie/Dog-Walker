import 'package:dogwalker2/models/walk.dart';
import 'package:dogwalker2/screens/components/text_factory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

abstract class WalkFactory {
  static Widget generateCard(BuildContext context, Walk walk, {onTap}) {
    if (onTap != null) {
      return GestureDetector(
          onTap: onTap,
          child: _generateCard(context, walk)
      );
    } else {
      return _generateCard(context, walk);
    }
  }

  static Widget _generateCard(context, walk) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
              leading: Icon(Icons.account_circle, size: 50, color: Colors.red,),
              title: Row(
                children: <Widget>[
                  TextFactory.generateText(
                      "\$" + walk.cost.toString() + "/h",
                      size: 20.0
                  ),
                  TextFactory.generateText(
                      " - "
                          + walk.dayOfWeek
                          + " - "
                          + DateFormat("HH:mm").format(walk.day)
                          + " - "
                          + DateFormat("HH:mm").format(walk.day.add(Duration(hours: walk.hours))),
                      size: 18.0
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFactory.generateText(
                      walk.dogWalker.name + " " + walk.dogWalker.surname + "",
                      color: Colors.grey
                  ),
                  TextFactory.generateText(
                      (walk.maxDogs - walk.dogsQuantity).toString()
                          + " cupos disponibles",
                      color: Colors.grey
                  ),
                ],
              )
          ),
        ],
      ),
    );
  }
}
