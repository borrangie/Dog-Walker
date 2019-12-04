import 'package:dogwalker2/screens/components/text_factory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class FutureBuilderFactory {
  static FutureBuilder generate(context, future, itemBuilder, Widget noResultsWidget) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(backgroundColor: Colors.red),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              TextFactory.generateText("Cargando...", size: 18.0),
            ],
          );
        } else {
          if ((snapshot.data as List).isEmpty) {
            return noResultsWidget;
          } else {
            return itemBuilder(context, snapshot.data);
          }
        }
      },
    );
  }
}
