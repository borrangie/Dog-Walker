import 'package:dogwalker2/resources/firebase_repository.dart';
import 'package:dogwalker2/screens/homeScreen2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyUserInfoPage(),
    );
  }
}

class MyUserInfoPage extends StatefulWidget {
  @override
  _MyUserInfoPageState createState() => _MyUserInfoPageState();
}

class _MyUserInfoPageState extends State<MyUserInfoPage> {
  FirebaseRepository _firebaseRepository = new FirebaseRepository();
  FirebaseUser user;

  @override
  void initState() {
    super.initState();
    initUser();
  }

  initUser() async {
    user = await _firebaseRepository.getCurrentUser();
    setState(() {});
  }

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
                return HomeScreen2();
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
            ),
            child: GestureDetector(
              child: Center(
                child: CircleAvatar(
                  radius: 60.0,
                  backgroundImage: NetworkImage("${user?.photoUrl}"),
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
                    // controller: mailController,
                    decoration: InputDecoration(
                      icon: Icon(
                        FontAwesomeIcons.user,
                        color: Colors.red,
                      ),
                      labelText: 'NOMBRE Y APELLIDO',
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
                    obscureText: true,
                    // controller: passwordController,
                    decoration: InputDecoration(
                      icon: Icon(
                        FontAwesomeIcons.lock,
                        color: Colors.red,
                      ),
                      labelText: 'CONTRASEÑA',
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
          FlatButton(
              onPressed: () {
                DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(1900, 1, 1),
                    maxTime: DateTime.now(), onChanged: (date) {
                  print('change $date');
                }, onConfirm: (date) {
                  print('confirm $date');
                }, currentTime: DateTime.now(), locale: LocaleType.es);
              },
              child: Text(
                'selecciona una fecha',
                style: TextStyle(color: Colors.blue),
              )),
        ],
      ),
    );
  }
}
