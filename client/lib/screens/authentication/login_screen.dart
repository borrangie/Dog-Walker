import 'package:dogwalker2/remote/firebase_repository.dart';
import 'package:dogwalker2/screens/authentication/sign_up.dart';
import 'package:dogwalker2/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'forgot_password_screen.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyLoginPage2(),
    );
  }
}

class MyLoginPage2 extends StatefulWidget {
  @override
  _MyLoginPage2State createState() => _MyLoginPage2State();
}

class _MyLoginPage2State extends State<MyLoginPage2> {
  FirebaseRepository _firebaseRepository = FirebaseRepository();
  TextEditingController mailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   gradient: LinearGradient(
      //       colors: [Color.fromRGBO(252, 92, 125, 1) , Color.fromRGBO(106, 130, 251, 1)],
      //       stops: [0.05,0.4],
      //       begin: Alignment.topCenter,
      //       end: Alignment.bottomCenter),
      // ),
      child: Scaffold(
        // backgroundColor: Colors.transparent,
        resizeToAvoidBottomPadding: false,
        body: Column(
          children: <Widget>[
            Container(
              child: Center(
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(130.0, 90.0, 0, 0),
                      child: Text(
                        "Dog",
                        style: TextStyle(
                          fontSize: 50.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(130.0, 155.0, 0, 0),
                      child: Text(
                        "Walker",
                        style: TextStyle(
                          fontSize: 50.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 90, 20, 0),
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
                    height: 10,
                  ),
                  TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
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
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    alignment: Alignment(1, 0),
                    padding: EdgeInsets.only(top: 15, left: 20),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ForgotPassword();
                        }));
                      },
                      child: Text(
                        'Olvido Su Contraseña?',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: 45,
                    child: Material(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.red,
                      shadowColor: Colors.redAccent,
                      elevation: 7,
                      child: GestureDetector(
                        onTap: () => normalSignIn(),
                        child: Center(
                          child: Text(
                            'INGRESAR',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
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
                        onTap: () => performLogin(),
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
                  )
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
                  'Nuevo en DoogWalker ?',
                  style: TextStyle(fontFamily: 'Montserrat'),
                ),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SignUp();
                    }));
                  },
                  child: Text(
                    'Registrate',
                    style: TextStyle(
                        color: Colors.red,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // Functions used for the log

  void normalSignIn() {
    String mail = mailController.text;
    String password = passwordController.text;
    if (mail.isEmpty || password.isEmpty) {
      if (mail.isEmpty && password.isEmpty) {
        showToast("Ingrese mail y contraseña");
      } else if (mail.isEmpty) {
        showToast("Ingrese el mail");
      } else {
        showToast("Ingrese contraseña");
      }
    } else {
      print(mail);
      print(password);
      _firebaseRepository.signIn(mail, password).then((AuthResult user) {
        if (user != null) {
          print("entre");
          authenticateUser(user.user);
        } else {
          print("error");
        }
      });
    }
  }

  void performLogin() {
    _firebaseRepository.signInGoogle().then((AuthResult user) {
      if (user != null) {
        authenticateUser(user.user);
      } else {
        print("There is an error");
      }
    });
  }

  void authenticateUser(FirebaseUser user) {
//    _firebaseRepository.authenticate(user).then((isNewUser) {
//      if (isNewUser) {
//         _firebaseRepository.addDataToDB(user).then((value){
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return HomeScreen();
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

  void showToast(String text) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Colors.redAccent,
      textColor: Colors.white,
      timeInSecForIos: 1,
    );
  }
}
