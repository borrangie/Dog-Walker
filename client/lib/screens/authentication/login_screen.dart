import 'package:dogwalker2/remote/firebase_repository.dart';
import 'package:dogwalker2/screens/authentication/forgot_password_screen.dart';
import 'package:dogwalker2/screens/authentication/sign_up.dart';
import 'package:dogwalker2/screens/components/button_factory.dart';
import 'package:dogwalker2/screens/components/text_field_factory.dart';
import 'package:dogwalker2/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        body: ListView(
          children: <Widget>[
            Container(
              child: Center(
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(130.0, 30.0, 0, 0),
                      child: Text(
                        "Dog",
                        style: TextStyle(
                          fontSize: 50.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(130.0, 95.0, 0, 0),
                      child: Text(
                        "Walker",
                        style: TextStyle(
                          fontSize: 50.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 30, 20, 0),
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
                  ButtonFactory.generate("INGRESAR", _normalSignIn),
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
        ),
      ),
    );
  }

  void _normalSignIn() {
    String mail = mailController.text;
    String password = passwordController.text;
    if (mail.isEmpty || password.isEmpty) {
      if (mail.isEmpty && password.isEmpty) {
        _showToast("Ingrese mail y contraseña");
      } else if (mail.isEmpty) {
        _showToast("Ingrese el mail");
      } else {
        _showToast("Ingrese contraseña");
      }
    } else {
      print(mail);
      print(password);
      FirebaseRepository.signIn(mail, password).then((AuthResult user) {
        if (user != null) {
          print("entre");
          _authenticateUser(user.user);
        } else {
          print("error");
        }
      });
    }
  }

  void _performLogin() {
    FirebaseRepository.signInGoogle().then((AuthResult user) {
      if (user != null) {
        _authenticateUser(user.user);
      } else {
        print("There is an error");
      }
    });
  }

  void _authenticateUser(FirebaseUser user) {
//    _firebaseRepository.authenticate(user).then((isNewUser) {
//      if (isNewUser) {
//         _firebaseRepository.addDataToDB(user).then((value){
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return HomeScreenPage();
        }));
        // });
//      } else {
//        Navigator.pushReplacement(context,
//            MaterialPageRoute(builder: (context) {
//          return HomeScreen();
//        }));
//      }
//    });
  }

  Container _generateGoogleButton() {
    return Container(
      height: 45,
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: Colors.black,
              style: BorderStyle.solid,
              width: 2),
          borderRadius: BorderRadius.circular(50),
          color: Colors.transparent,
        ),
        child: GestureDetector(
          onTap: () => _performLogin(),
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
          ),
        ),
      ),
    );
  }

  void _showToast(String text) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Colors.redAccent,
      textColor: Colors.white,
      timeInSecForIos: 1,
    );
  }
}
