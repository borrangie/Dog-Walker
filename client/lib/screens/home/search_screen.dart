import 'package:dogwalker2/models/walk.dart';
import 'package:dogwalker2/remote/firebase_repository.dart';
import 'package:dogwalker2/screens/components/button_factory.dart';
import 'package:dogwalker2/screens/components/text_factory.dart';
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
                  return Center(
                    child: TextFactory.generateText("Cargando...", size: 24.0, weight: FontWeight.bold, color: Colors.red),
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
