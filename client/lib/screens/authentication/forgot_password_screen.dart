import 'dart:async';

import 'package:dogwalker2/remote/firebase_repository.dart';
import 'package:dogwalker2/screens/authentication/login_screen.dart';
import 'package:dogwalker2/screens/components/app_bar_factory.dart';
import 'package:dogwalker2/screens/components/button_factory.dart';
import 'package:dogwalker2/screens/components/logo_text_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController mailController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
        appBar: AppBarFactory.generate(context, "Olvido su contraseña?"),
        body: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: <Widget>[
                LogoTextFactory.generate(context, "Olvido su", "Contraseña?"),
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
                      ButtonFactory.generate("Enviar", _forgotPassword)
                    ],
                  ),
                ),
              ],
            )
          )
        ),
      ),
    );
  }

  // Functions used for the log

  void _forgotPassword() {
    String mail = mailController.text;
    if (mail.isEmpty) {
      showToast("Ingrese el mail");
    } else {
      print(mail);
      bool res = FirebaseRepository.resetPassword(mail);
      if (res) {
        showSuccessToast('Se envio el mail');
        Timer(Duration(seconds: 3), () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return LogInPage();
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
