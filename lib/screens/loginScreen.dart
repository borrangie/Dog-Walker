import 'package:dogwalker2/resources/firebase_repository.dart';
import 'package:dogwalker2/screens/homeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseRepository _firebaseRepository = FirebaseRepository();
  TextEditingController mailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      // appBar: AppBar(
      //   backgroundColor: Color.fromRGBO(127, 64, 236, 1),
      //   elevation: 0,
      // ),
      body: loginFullPage(),
    );
  }

  Widget loginFullPage() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color.fromRGBO(127, 64, 236, 1), Colors.red],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  height: 80.0,
                  width: 80.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: Color.fromRGBO(244, 67, 54, 1),
                  ),
                  child: Icon(
                    Icons.people,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                  child: Text(
                    "Dog Walker",
                    style: TextStyle(fontSize: 40.0),
                  ),
                )
              ],
            ),

// Aca es donde estaba

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 0.0),
                    child: TextField(
                      controller: mailController,
                      decoration: InputDecoration(
                        labelText: 'Mail',
                        labelStyle: new TextStyle(
                            color: Color.fromRGBO(28, 46, 163, 1),
                            fontSize: 20),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color.fromRGBO(28, 46, 163, 1)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color.fromRGBO(28, 46, 163, 1)),
                        ),
                      ),
                      cursorColor: Color.fromRGBO(28, 46, 163, 1),
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 0.0, bottom: 25),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      cursorColor: Color.fromRGBO(28, 46, 163, 1),
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        labelStyle: new TextStyle(
                            color: Color.fromRGBO(28, 46, 163, 1),
                            fontSize: 20),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color.fromRGBO(28, 46, 163, 1)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color.fromRGBO(28, 46, 163, 1)),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, top: 10, right: 5),
                          child: GestureDetector(
                            onTap: () => normalSignIn(),
                            child: Container(
                              alignment: Alignment.center,
                              height: 60.0,
                              width: 70.0,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(28, 46, 163, 1),
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Text(
                                "Ingresar",
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 5.0, top: 10, right: 20.0),
                          child: Container(
                            alignment: Alignment.center,
                            height: 60.0,
                            width: 70.0,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                    color: Color.fromRGBO(28, 46, 163, 1),
                                    width: 2),
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Text(
                              "Olvido su Contraseña?",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Color.fromRGBO(28, 46, 163, 1)),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 20.0, right: 20, bottom: 5),
                          child: Container(
                              alignment: Alignment.center,
                              height: 60.0,
                              width: 70.0,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: FlatButton.icon(
                                  onPressed: () => performLogin(),
                                  icon: Icon(
                                    FontAwesomeIcons.google,
                                    color: Colors.red,
                                  ),
                                  label: Text(
                                    "Ingresar con Google",
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.red),
                                  ))),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 35.0, top: 50),
                    child: Text(
                      "Crear una Nueva Cuenta",
                      style: TextStyle(
                          fontSize: 20, color: Color.fromRGBO(28, 46, 163, 1)),
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

  void normalSignIn() {
    String mail = mailController.text;
    String password = passwordController.text;
    if (mail.isEmpty || password.isEmpty) {
      print("Ingrese los datos");
    } else {
      print("llego hasta aca");
      print(mail);
      print(password);
      _firebaseRepository.normalSignIn(mail, password).then((AuthResult user) {
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
    _firebaseRepository.signIn().then((AuthResult user) {
      if (user != null) {
        authenticateUser(user.user);
      } else {
        print("There is an error");
      }
    });
  }

  void authenticateUser(FirebaseUser user) {
    _firebaseRepository.authenticateUser(user).then((isNewUser) {
      print(isNewUser);
      if (isNewUser) {
        // _firebaseRepository.addDataToDB(user).then((value){
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return HomeScreen();
        }));
        // });
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return HomeScreen();
        }));
      }
    });
  }
}
