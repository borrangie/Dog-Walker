import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dogwalker2/screens/myDogs.dart';
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
                    // controller: nameController,
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
                    // controller: mailController,
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
                    // controller: phoneController,
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
                    // controller: cityController,
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
                    // controller: addressController,
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
                'Masculino',
                style: new TextStyle(fontSize: 16.0),
              ),
              new Radio(
                value: 1,
                groupValue: _radioValue,
              ),
              new Text(
                'Femenino',
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
            onPressed: () {},
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
}
