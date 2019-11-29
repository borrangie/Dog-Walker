import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dogwalker2/models/users/dog_owner.dart';
import 'package:dogwalker2/remote/firebase_repository.dart';
import 'package:dogwalker2/screens/my_dogs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddDog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyAddDogPage(),
    );
  }
}

class MyAddDogPage extends StatefulWidget {
  @override
  _MyAddDogPageState createState() => _MyAddDogPageState();
}

class _MyAddDogPageState extends State<MyAddDogPage> {
  DateTime date;
var _radioValue;

TextEditingController nameController = new TextEditingController();
TextEditingController razaController = new TextEditingController();
TextEditingController infoController = new TextEditingController();
TextEditingController weightController = new TextEditingController();
TextEditingController heightController = new TextEditingController();
FirebaseRepository _firebaseRepository = new FirebaseRepository();


  @override
  Widget build(BuildContext context) {

    
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.red,
          elevation: 0,
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return DogsPage();
              }));
              //Navigator.pop(context);
            },
          )),
      body: ListView(
        children: <Widget>[
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(70),
                  bottomRight: Radius.circular(70)),
            ),
            child: GestureDetector(
              child: Center(
                child: CircleAvatar(
                  radius: 60.0,
                  backgroundColor: Color(0xFFF9EFEB),
                  backgroundImage: NetworkImage(
                      "https://cdn1.imggmi.com/uploads/2019/10/7/4438a3feb8440f48d156aec9e93dc33e-full.png"),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 55, left: 20, right: 20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      icon: Icon(
                        FontAwesomeIcons.paw,
                        color: Colors.red,
                      ),
                      labelText: 'NOMBRE',
                      labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: razaController,
                    decoration: InputDecoration(
                      icon: Icon(
                        FontAwesomeIcons.dog,
                        color: Colors.red,
                      ),
                      labelText: 'RAZA',
                      labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: weightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      icon: Icon(
                        FontAwesomeIcons.weightHanging,
                        color: Colors.red,
                      ),
                      labelText: 'PESO',
                      labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: heightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      icon: Icon(
                        FontAwesomeIcons.ruler,
                        color: Colors.red,
                      ),
                      labelText: 'ALTURA',
                      labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: infoController,
                    decoration: InputDecoration(
                      icon: Icon(
                        FontAwesomeIcons.infoCircle,
                        color: Colors.red,
                      ),
                      labelText: 'CARACTERISTICAS',
                      labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                ]),
          ),
          SizedBox(
            height: 20,
          ),
          FlatButton(
            onPressed: () {
              DatePicker.showDatePicker(context,
                  showTitleActions: true,
                  minTime: DateTime(1900, 1, 1),
                  maxTime: DateTime.now(),
                  onChanged: (date) {}, onConfirm: (date) {
                setState(() {
                  this.date = date;
                });
              }, currentTime: DateTime.now(), locale: LocaleType.es);
            },
            child: _getDateFormated(),
          ),
          SizedBox(
            height: 20,
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 22,
              ),
              Icon(
                FontAwesomeIcons.venusMars,
                color: Colors.red,
              ),
              SizedBox(width: 15,),
              Text(
                'GENERO',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Radio(
                value: 0,
                groupValue: _radioValue,
              ),
              Text(
                'El',
                style: new TextStyle(fontSize: 16.0),
              ),
              new Radio(
                value: 1,
                groupValue: _radioValue,
              ),
              new Text(
                'Ella',
                style: new TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 22,
              ),
              Icon(
                FontAwesomeIcons.minusCircle,
                color: Colors.red,
              ),
              SizedBox(width: 15,),
              Text(
                'CASTRADO',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Radio(
                value: 0,
                groupValue: _radioValue,
              ),
              Text(
                'Si',
                style: new TextStyle(fontSize: 16.0),
              ),
              new Radio(
                value: 1,
                groupValue: _radioValue,
              ),
              new Text(
                'No',
                style: new TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          FlatButton(
            onPressed: () {
              _saveDog();
              Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return DogsPage();
                    }));
            },
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.red, width: 3),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Center(
                child: Text(
                  'Guardar',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }



  _getDateFormated() {
    if (date != null) {
      return Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 5,
            ),
            Icon(
              FontAwesomeIcons.calendarAlt,
              color: Colors.red,
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              date.day.toString() +
                  '/' +
                  date.month.toString() +
                  '/' +
                  date.year.toString(),
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      );
    } else {
      return Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 5,
              ),
              Icon(
                FontAwesomeIcons.calendarAlt,
                color: Colors.red,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                'CUMPLEAÑOS',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      );
    }
  }

  _saveDog() async{
    String name = nameController.text;
    String raza = razaController.text;
    String weight = weightController.text;
    String height = heightController.text;
    String info = infoController.text;
    

    if(name.isNotEmpty && raza.isNotEmpty && weight.isNotEmpty && height.isNotEmpty && info.isNotEmpty && date!=null){
      double w = double.parse(weight);
      double h = double.parse(height);
      DogOwner user = await _firebaseRepository.getCurrentUser();
      Map<String, dynamic> dogData = {'n'.toString():name, 'r'.toString():raza, 'p'.toString():w, 'a'.toString():h, 'ca'.toString():info, 'c'.toString():true, 'f'.toString():"", 's'.toString():true, 'e'.toString(): date,'i'.toString(): user.id};
      _firebaseRepository.addDog(dogData);
    }else{
      print('Complete the info of your dog'); 
    }
  }
}
