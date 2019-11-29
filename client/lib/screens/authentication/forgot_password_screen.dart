import 'dart:async';

import 'package:dogwalker2/remote/firebase_repository.dart';
import 'package:dogwalker2/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyForgotPasswordPage(),
    );
  }
}

class MyForgotPasswordPage extends StatefulWidget {
  @override
  _MyForgotPasswordPageState createState() => _MyForgotPasswordPageState();
}

class _MyForgotPasswordPageState extends State<MyForgotPasswordPage> {
  FirebaseRepository _firebaseRepository = FirebaseRepository();
  TextEditingController mailController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 5,
            automaticallyImplyLeading: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.red,
              ),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }));
                //Navigator.pop(context);
              },
            )),
        body: Column(
          children: <Widget>[
            Container(
              child: Center(
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(130.0, 70.0, 0, 0),
                      child: Text(
                        "Olvido Su",
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(130.0, 125.0, 0, 0),
                      child: Text(
                        "Contraseña?",
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 55, 20, 0),
                      child: Image.asset(
                        'assets/images/dwlogo.png',
                        width: 130,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 55, left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'No se preocupe, ingrese su mail y le enviaremos un mail para resetear su contraseña de forma rapida y segura',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Montserrat',
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: mailController,
                    decoration: InputDecoration(
                      labelText: 'MAIL',
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
                    height: 50,
                  ),
                  Container(
                    height: 45,
                    child: Material(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.red,
                      shadowColor: Colors.redAccent,
                      elevation: 7,
                      child: GestureDetector(
                        onTap: () => forgotPassword(),
                        child: Center(
                          child: Text(
                            'Enviar',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Functions used for the log

  void forgotPassword() {
    String mail = mailController.text;
    if (mail.isEmpty) {
      showToast("Ingrese el mail");
    } else {
      print(mail);
      bool res = _firebaseRepository.resetPassword(mail);
      if (res) {
        showSuccessToast('Se envio el mail');
        Timer(Duration(seconds: 3), () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return LoginPage();
          }));
        });
      }else{
        showToast("Mail Incorrecto");
      }
    }
  }

  void showToast(String text) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        timeInSecForIos: 1);
  }

  void showSuccessToast(String text) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        timeInSecForIos: 2);
  }
}
