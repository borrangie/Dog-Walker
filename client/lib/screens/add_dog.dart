import 'package:dogwalker2/models/users/dog_owner.dart';
import 'package:dogwalker2/remote/firebase_repository.dart';
import 'package:dogwalker2/screens/components/app_bar_factory.dart';
import 'package:dogwalker2/screens/components/button_factory.dart';
import 'package:dogwalker2/screens/components/text_factory.dart';
import 'package:dogwalker2/screens/components/user_info_factory.dart';
import 'package:dogwalker2/screens/my_dogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddDogPage extends StatefulWidget {
  @override
  _AddDogPageState createState() => _AddDogPageState();
}

class _AddDogPageState extends State<AddDogPage> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController razaController = new TextEditingController();
  TextEditingController infoController = new TextEditingController();
  TextEditingController weightController = new TextEditingController();
  TextEditingController heightController = new TextEditingController();
  TextEditingController dateTimeController = new TextEditingController();

  var _radioValue;
  DateTime date;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarFactory.generate(context, "", color: Colors.red, buttonColor: Colors.white),
      body: ListView(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        children: <Widget>[
//          UserInfoFactory.generateAvatar(null, () {}),
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
          TextFactory.generateTextField(
              nameController,
              "Nombre",
              icon: Icon(
                FontAwesomeIcons.paw,
                color: Colors.red,
              )
          ),
          SizedBox(
            height: 20,
          ),
          TextFactory.generateTextField(
              razaController,
              "Raza",
              icon: Icon(
                FontAwesomeIcons.dog,
                color: Colors.red,
              )
          ),
          SizedBox(
            height: 20,
          ),
          TextFactory.generateTextFieldNumeric(
              weightController,
              "Peso (en kgs)",
              icon: Icon(
                FontAwesomeIcons.weightHanging,
                color: Colors.red,
              )
          ),
          SizedBox(
            height: 20,
          ),
          TextFactory.generateTextFieldNumeric(
              heightController,
              "Altura (en cms)",
              icon: Icon(
                FontAwesomeIcons.ruler,
                color: Colors.red,
              )
          ),
          SizedBox(
            height: 20,
          ),
          TextFactory.generateTextFieldNumeric(
              infoController,
              "Caracteristicas",
              icon: Icon(
                FontAwesomeIcons.infoCircle,
                color: Colors.red,
              )
          ),
          SizedBox(
            height: 20,
          ),
          TextFactory.generateTextFieldDatetime(
            context,
            dateTimeController,
            "Fecha de nacimiento",
            onDateSet: () {},
            icon: Icon(
              FontAwesomeIcons.calendarAlt,
              color: Colors.red,
            )
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
              TextFactory.generateText("Genero", color: Colors.grey, weight: FontWeight.bold, size: 18),
              Radio(
                value: 0,
                groupValue: _radioValue,
              ),
              TextFactory.generateText("El"),
              new Radio(
                value: 1,
                groupValue: _radioValue,
              ),
              TextFactory.generateText("Ella"),
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
          ButtonFactory.generateOutline("GUARDAR", () {
            _saveDog();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) {
                  return DogsPage();
                }));
          }),
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
    String name = nameController.text = nameController.text.trim();
    String raza = razaController.text = razaController.text.trim();
    String weight = weightController.text = weightController.text.trim();
    String height = heightController.text = heightController.text.trim();
    String info = infoController.text = infoController.text.trim();

    if(name.isNotEmpty && raza.isNotEmpty && weight.isNotEmpty && height.isNotEmpty && info.isNotEmpty && date!=null){
      double w = double.parse(weight);
      double h = double.parse(height);
      DogOwner user = await FirebaseRepository.getCurrentUser();
      Map<String, dynamic> dogData = {'n'.toString():name, 'r'.toString():raza, 'p'.toString():w, 'a'.toString():h, 'ca'.toString():info, 'c'.toString():true, 'f'.toString():"", 's'.toString():true, 'e'.toString(): date,'i'.toString(): user.id};
      FirebaseRepository.addDog(dogData);
    }else{
      print('Complete the info of your dog'); 
    }
  }
}
