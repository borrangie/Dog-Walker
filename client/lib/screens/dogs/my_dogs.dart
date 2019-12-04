import 'package:dogwalker2/models/users/dog_owner.dart';
import 'package:dogwalker2/remote/firebase_repository.dart';
import 'package:dogwalker2/resources/store.dart';
import 'package:dogwalker2/screens/components/app_bar_factory.dart';
import 'package:dogwalker2/screens/components/dog_factory.dart';
import 'package:dogwalker2/screens/components/future_builder_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'add_dog.dart';

class DogsPage extends StatefulWidget {
  @override
  _DogsPageState createState() => _DogsPageState();
}

class _DogsPageState extends State<DogsPage> {
  DogOwner user;

  @override
  void initState() {
    super.initState();
    user = Store.instance.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarFactory.generateBack(context, "", color: Colors.red, buttonColor: Colors.white),
      body: Column(
        children: <Widget>[
          Container(
            height: 105,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(70),
                  bottomRight: Radius.circular(70)),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    FontAwesomeIcons.dog,
                    color: Colors.white,
                    size: 80,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Mis',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 40.0,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text('Perros',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 40.0,
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilderFactory.generate(
              context,
              FirebaseRepository.getDogs(),
              (context, data) {
                return ListView.builder(
                  itemExtent: 190,
                  itemCount: data.length,
                  itemBuilder: (context, index) =>
                    DogFactory.createDogCard(data[index], context),
                );
              },
              Center(
                child: Text('No hay perros creados.', style: TextStyle(color: Colors.red, fontSize: 20),),
              )
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.push(context,
          MaterialPageRoute(builder: (context) {
          return AddDogPage();
        }));
      },
      child: Icon(
        FontAwesomeIcons.plus,
        color: Colors.white,
      ),
      backgroundColor: Colors.red,
    ),
    );
  }
}
