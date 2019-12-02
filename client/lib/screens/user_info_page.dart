import 'package:dogwalker2/models/users/dog_owner.dart';
import 'package:dogwalker2/remote/firebase_repository.dart';
import 'package:dogwalker2/screens/components/app_bar_factory.dart';
import 'package:dogwalker2/screens/components/button_factory.dart';
import 'package:dogwalker2/screens/components/user_info_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserInfoPage extends StatefulWidget {
  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController dateTimeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  DogOwner user;
  DateTime date;

  @override
  void initState() {
    super.initState();
    initUser();
    initControllers();
  }

  initControllers() async {
    print(await FirebaseRepository.getCurrentUser());
    // TODO
//    data = await _firebaseRepository.getCurrentUser();
//    this.nameController = new TextEditingController(text: data['n']);
//    this.phoneController = new TextEditingController(text: data['t']);
//    this.cityController = new TextEditingController(text: data['l']);
//    this.addressController = new TextEditingController(text: data['d']);

    setState(() {});
  }

  initUser() async {
    user = await FirebaseRepository.getCurrentUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBarFactory.generate(
        context,
        "Mi perfil",
        color: Colors.red,
        textColor: Colors.white,
        buttonColor: Colors.white
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 20, right: 20),
        children: <Widget>[
          _generateCard(),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: UserInfoFactory.generateDogOwner(nameController, surnameController, phoneController),
          ),
          SizedBox(
            height: 20,
          ),
          FlatButton(
            onPressed: () {
              DatePicker.showDatePicker(context,
                  showTitleActions: true,
                  minTime: DateTime(1900, 1, 1),
                  maxTime: DateTime.now(), onChanged: (date) {
                print('change $date');
              }, onConfirm: (date) {
                print('confirm $date');
                setState(() {
                  this.date = date;
                });
              }, currentTime: DateTime.now(), locale: LocaleType.es);
            },
            child: _getDateFormated(),
          ),
          SizedBox(
            height: 30,
          ),
          ButtonFactory.generateOutline("GUARDAR", () {}),
          SizedBox(
            height: 15,
          ),
          ButtonFactory.generate("SER PASEADOR", () {}),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }

  Widget _getDateFormated() {
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
                'Fecha de nacimiento',
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

  Container _generateCard() {
    return Container(
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
//                  backgroundImage: NetworkImage("${user?.photoUrl}"), TODO
          ),
        ),
      ),
    );
  }
}
