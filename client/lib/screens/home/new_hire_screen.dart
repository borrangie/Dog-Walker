import 'package:dogwalker2/models/users/dog.dart';
import 'package:dogwalker2/models/users/dog_owner.dart';
import 'package:dogwalker2/models/walk.dart';
import 'package:dogwalker2/remote/firebase_repository.dart';
import 'package:dogwalker2/resources/store.dart';
import 'package:dogwalker2/screens/components/app_bar_factory.dart';
import 'package:dogwalker2/screens/components/button_factory.dart';
import 'package:dogwalker2/screens/components/dog_factory.dart';
import 'package:dogwalker2/screens/components/future_builder_factory.dart';
import 'package:dogwalker2/screens/components/text_factory.dart';
import 'package:dogwalker2/screens/components/toast_factory.dart';
import 'package:dogwalker2/screens/components/walk_factory.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class NewHirePage extends StatefulWidget {
  final Walk _walk;

  NewHirePage(this._walk);

  @override
  _NewHireState createState() => _NewHireState(_walk);
}

class _NewHireState extends State<NewHirePage> {
  DogOwner user = Store.instance.user;
  Walk _walk;

  _NewHireState(this._walk);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarFactory.generateBack(
          context,
          "Contratar paseo",
          buttonColor: Colors.red
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20, right: 10, left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 10, left: 10),
              child: TextFactory.generateText("Paseador:", weight: FontWeight.bold, size: 20),
            ),
            SizedBox(
              height: 20,
            ),
            WalkFactory.generateCard(context, _walk),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(right: 10, left: 10),
              child: TextFactory.generateText("Seleccione el perro que quiere que lo paseen:", weight: FontWeight.bold, size: 20),
            ),
            SizedBox(
              height: 20,
            ),
            FutureBuilderFactory.generate(
              context,
              FirebaseRepository.getDogs(),
              (context, data) {
                return _buildListItems(context, data);
              },
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextFactory.generateText("No posee ningun perro", size: 18.0),
                  SizedBox(
                    height: 10,
                  ),
                  TextFactory.generateText("Intente creando uno", size: 16.0)
                ],
              )
            )
          ],
        )
      )
    );
  }

  Widget _buildListItems(BuildContext context, List<Dog> dogs) {
    List<Widget> widgets = [];

    for (var dog in dogs) {
      widgets.add(DogFactory.createDogCard(dog, context, selectable: true, onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return _NewHireFinalPage(this._walk, dog);
        }));
      }));
    }

    return Column(
      children: widgets,
    );
  }
}


class _NewHireFinalPage extends StatefulWidget {
  final Walk _walk;
  final Dog _dog;

  _NewHireFinalPage(this._walk, this._dog);

  @override
  _NewHireFinalState createState() => _NewHireFinalState(_walk, _dog);
}

class _NewHireFinalState extends State<_NewHireFinalPage> {
  Walk _walk;
  Dog _dog;

  _NewHireFinalState(this._walk, this._dog);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarFactory.generateBack(
            context,
            "Contratar paseo",
            buttonColor: Colors.red
        ),
        body: Container(
            padding: EdgeInsets.only(top: 20, right: 10, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                    child: TextFactory.generateText("¿Desea continuar?", weight: FontWeight.bold, size: 20)
                ),
                SizedBox(
                  height: 20,
                ),
                WalkFactory.generateCard(context, _walk),
                SizedBox(
                  height: 20,
                ),
                DogFactory.createDogCard(_dog, context),
                SizedBox(
                  height: 50,
                ),
                ButtonFactory.generate("CONTINUAR", _continue)
              ],
            )
        )
    );
  }

  void _continue() async {
    if (!(await FirebaseRepository.hireWalk(_walk, _dog))) {
      ToastFactory.showError("Error registrando. Intente luego");
    } else {
      ToastFactory.showInfo("Paseo registrado");
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }
}