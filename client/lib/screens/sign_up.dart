import 'package:dogwalker2/remote/firebase_repository.dart';
import 'package:dogwalker2/screens/home_screen.dart';
import 'package:dogwalker2/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';


class SignUp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MySignUpPage(),
    );
  }
}

class MySignUpPage extends StatefulWidget {
  @override
  _MySignUpPageState createState() => _MySignUpPageState();
}

class _MySignUpPageState extends State<MySignUpPage> {
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
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 5,
            automaticallyImplyLeading: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.red,),
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
                      padding: EdgeInsets.fromLTRB(130.0, 90.0, 0, 0),
                      child: Text(
                        "Sign",
                        style: TextStyle(
                          fontSize: 50.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(130.0, 155.0, 0, 0),
                      child: Text(
                        "Up",
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
                        onTap: () => normalSignUp(),
                        child: Center(
                          child: Text(
                            'Registrarme',
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
                  SizedBox(
                    height: 70,
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

  void normalSignUp() {
    String mail = mailController.text;
    String password = passwordController.text;
    if (mail.isEmpty || password.isEmpty) {
      if(mail.isEmpty && password.isEmpty){
        showToast("Ingrese mail y contraseña");
      }else if(mail.isEmpty){
        showToast("Ingrese el mail");
      }else{
        showToast("Ingrese contraseña");
      }
    } else {
      print("llego hasta aca");
      print(mail);
      print(password);
      _firebaseRepository.normalSignUp(mail, password).then((AuthResult user) {
        if (user != null) {
          print("entre");
          authenticateUser(user.user);
        } else {
          print("error");
        }
      });
    }
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

  void showToast(String text){
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Colors.redAccent,
      textColor: Colors.white,
      timeInSecForIos: 1
      
    );
  }
  
}
