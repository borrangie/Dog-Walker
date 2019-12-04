import 'package:dogwalker2/models/walk.dart';
import 'package:dogwalker2/remote/firebase_repository.dart';
import 'package:dogwalker2/screens/components/button_factory.dart';
import 'package:dogwalker2/screens/components/walk_factory.dart';
import 'package:dogwalker2/screens/components/text_factory.dart';
import 'package:dogwalker2/screens/home/new_hire_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class SearchScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: <Widget>[
                ButtonFactory.generateIcon(Icons.today, () {}),
                TextFactory.generateText("Selecciona una fecha", color: Colors.grey)
              ],
            ),
            Row(
              children: <Widget>[
                ButtonFactory.generateIcon(Icons.watch_later, () {}),
                TextFactory.generateText("Selecciona una hora", color: Colors.grey)
              ],
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            FutureBuilder(
              future: FirebaseRepository.getWalks(),
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
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        TextFactory.generateText("No se encontraron resultados", size: 18.0),
                        SizedBox(
                          height: 10,
                        ),
                        TextFactory.generateText("Reduce los filtros o prueba en otro momento", size: 16.0)],
                    );
                  } else {
                    return _buildListWalks(context, snapshot.data);
                  }
                }
              },
            )
          ],
        ),
      ],
    );
  }

  Widget _buildListWalks(BuildContext context, List<Walk> walks) {
    List<Widget> widgets = [];
    for (var walk in walks) {
      widgets.add(_buildListWalk(context, walk));
    }

    return Column(
      children: widgets,
    );
  }

  Widget _buildListWalk(BuildContext context, Walk walk) {
    return WalkFactory.generateCard(context, walk, onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return NewHirePage(walk);
      }));
    });
  }
}
