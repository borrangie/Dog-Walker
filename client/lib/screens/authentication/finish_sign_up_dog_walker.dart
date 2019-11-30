import 'package:dogwalker2/remote/firebase_repository.dart';
import 'package:dogwalker2/screens/authentication/select_user_type.dart';
import 'package:dogwalker2/screens/components/app_bar_factory.dart';
import 'package:dogwalker2/screens/components/button_factory.dart';
import 'package:dogwalker2/screens/components/text_field_factory.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FinishSignUpDogWalkerPage extends StatefulWidget {
  @override
  _FinishSignUpDogWalkerPageState createState() => _FinishSignUpDogWalkerPageState();
}

class _FinishSignUpDogWalkerPageState extends State<FinishSignUpDogWalkerPage> {
  TextEditingController mailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController repasswordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBarFactory.generate(context, "Set up profile"),
        body: SingleChildScrollView(
            reverse: true,
            child: Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Center(
                        child: Stack(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(130.0, 30.0, 0, 0),
                              child: Text(
                                "Sign",
                                style: TextStyle(
                                  fontSize: 50.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(130.0, 95.0, 0, 0),
                              child: Text(
                                "Up",
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
                            height: 10,
                          ),
                          TextFieldFactory.generatePassword(repasswordController, "REINGRESE CONTRASEÑA"),
                          SizedBox(
                            height: 50,
                          ),
                          ButtonFactory.generate("REGISTRARME", normalSignUp),
                          SizedBox(
                            height: 70,
                          ),
                          SizedBox(
                            height: 1,
                          ),
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

  void normalSignUp() {
    String mail = mailController.text;
    String password = passwordController.text;
    String repassword = repasswordController.text;

    if (mail.isEmpty || password.isEmpty || repassword.isEmpty) {
      if (mail.isEmpty && password.isEmpty) {
        showToast("Ingrese mail y contraseña");
      } else if (mail.isEmpty) {
        showToast("Ingrese el mail");
      } else if (password.isEmpty) {
        showToast("Ingrese contraseña");
      } else {
        showToast("Reingrese contraseña");
      }
    } else {
      if (password != repassword) {
        showToast("Las contraseñas no coinciden");
        return;
      }
      FirebaseRepository.signUp(mail, password).then((AuthResult user) {
        if (user != null) {
          Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
              return SelectUserTypePage();
            }
          ));
        } else {
          showToast("Error creando usuario. Reintente luego");
        }
      });
    }
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
