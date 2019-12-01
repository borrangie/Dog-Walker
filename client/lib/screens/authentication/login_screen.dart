import 'dart:io';

import 'package:dogwalker2/models/users/dog_owner.dart';
import 'package:dogwalker2/models/users/dog_walker.dart';
import 'package:dogwalker2/remote/firebase_repository.dart';
import 'package:dogwalker2/screens/authentication/forgot_password_screen.dart';
import 'package:dogwalker2/screens/authentication/select_user_type.dart';
import 'package:dogwalker2/screens/authentication/sign_up.dart';
import 'package:dogwalker2/screens/components/button_factory.dart';
import 'package:dogwalker2/screens/components/logo_text_factory.dart';
import 'package:dogwalker2/screens/components/text_field_factory.dart';
import 'package:dogwalker2/screens/components/toast_factory.dart';
import 'package:dogwalker2/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'finish_sign_up_dog_owner.dart';
import 'finish_sign_up_dog_walker.dart';

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  TextEditingController mailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: <Widget>[
                LogoTextFactory.generate(context, "Dog", "Walker"),
                Container(
                  padding: EdgeInsets.only(top: 55, left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextFieldFactory.generate(mailController, "MAIL"),
                      SizedBox(
                        height: 10,
                      ),
                      TextFieldFactory.generatePassword(passwordController, "CONTRASEÑA"),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        alignment: Alignment(1, 0),
                        padding: EdgeInsets.only(top: 0, left: 0),
                        child: ButtonFactory.generateLink(
                            "Olvido Su Contraseña?",
                                () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return ForgotPasswordPage();
                                  })
                              )
                            }
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      ButtonFactory.generate("INGRESAR", _logIn),
                      SizedBox(
                        height: 20,
                      ),
                      _generateGoogleButton()
                    ],
                  ),
                ),
                SizedBox(
                  height: 45,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Nuevo en DogWalker?',
                      style: TextStyle(fontFamily: 'Montserrat'),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      alignment: Alignment(1, 0),
                      child: ButtonFactory.generateLink(
                        "Registrate",
                        () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return SignUpPage();
                            })
                          )
                        }
                      ),
                    ),
                  ],
                )
              ],
            )
          )
        ),
      ),
    );
  }

  void _logIn() async {
    String mail = mailController.text;
    String password = passwordController.text;

    if (mail.isEmpty || password.isEmpty) {
      if (mail.isEmpty && password.isEmpty) {
        ToastFactory.showError("Ingrese mail y contraseña");
      } else if (mail.isEmpty) {
        ToastFactory.showError("Ingrese el mail");
      } else {
        ToastFactory.showError("Ingrese contraseña");
      }
    } else {
      try {
        await FirebaseRepository.signIn(mail, password);
        _authenticateUser();
      } catch (e) {
        ToastFactory.showError("User does not exist");
      }
    }
  }

  void _logInGoogle() {
    FirebaseRepository.signInGoogle().then((AuthResult user) {
      if (user != null) {
        _authenticateUser();
      } else {
        print("There is an error");
      }
    });
  }

  void _authenticateUser() async {
    DogOwner user = await FirebaseRepository.getCurrentUser();
    List<Widget> widgets = [];
    while (user == null) {
      sleep(Duration(seconds: 1));
      user = await FirebaseRepository.getCurrentUser();
    }

    if (user != null) {
      if (user is DogWalker) {
        if (!user.walkerVerified) {
          widgets.add(SelectUserTypePage());
          widgets.add(FinishSignUpDogWalkerPage());
        } else {
          widgets.add(HomeScreenPage());
        }
      } else if (user is DogOwner) {
        if (!user.verified) {
          widgets.add(SelectUserTypePage());
          widgets.add(FinishSignUpDogOwnerPage());
        } else {
          widgets.add(HomeScreenPage());
        }
      } else {
        widgets.add(SelectUserTypePage());
      }
    } else {
      widgets.add(LogInPage());
    }

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return widgets[0];
        })
    );
    for (var i = 1; i < widgets.length; i++) {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return widgets[i];
          })
      );
    }
  }

  Container _generateGoogleButton() {
    return Container(
      height: 45,
      color: Colors.transparent,
      child: OutlineButton(
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(50)
        ),
        borderSide: BorderSide(
          color: Colors.black,
          style: BorderStyle.solid, //Style of the border
          width: 2, //width of the border
        ),
        color: Colors.red,
        onPressed: _logInGoogle,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Icon(
                FontAwesomeIcons.google,
                color: Colors.red,
                size: 19,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Center(
              child: Text(
                'INGRESAR CON GOOGLE',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: 'Montserrat',
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}
