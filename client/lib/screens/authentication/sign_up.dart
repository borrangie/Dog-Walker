import 'package:dogwalker2/remote/firebase_repository.dart';
import 'package:dogwalker2/screens/authentication/select_user_type.dart';
import 'package:dogwalker2/screens/components/app_bar_factory.dart';
import 'package:dogwalker2/screens/components/button_factory.dart';
import 'package:dogwalker2/screens/components/logo_text_factory.dart';
import 'package:dogwalker2/screens/components/text_factory.dart';
import 'package:dogwalker2/screens/components/toast_factory.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController mailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController repasswordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
        appBar: AppBarFactory.generateBack(context, "Registrarse"),
        body: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: <Widget>[
                LogoTextFactory.generate(context, "Registrarse", ""),
                Container(
                  padding: EdgeInsets.only(top: 55, left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextFactory.generateTextField(mailController, "MAIL"),
                      SizedBox(
                        height: 10,
                      ),
                      TextFactory.generateTextFieldPassword(passwordController, "CONTRASEÑA"),
                      SizedBox(
                        height: 10,
                      ),
                      TextFactory.generateTextFieldPassword(repasswordController, "REINGRESE CONTRASEÑA"),
                      SizedBox(
                        height: 50,
                      ),
                      ButtonFactory.generate("REGISTRARME", _normalSignUp),
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

  void _normalSignUp() {
    String mail = mailController.text;
    String password = passwordController.text;
    String repassword = repasswordController.text;

    if (mail.isEmpty || password.isEmpty || repassword.isEmpty) {
      if (mail.isEmpty && password.isEmpty) {
        ToastFactory.showError("Ingrese mail y contraseña");
      } else if (mail.isEmpty) {
        ToastFactory.showError("Ingrese el mail");
      } else if (password.isEmpty) {
        ToastFactory.showError("Ingrese contraseña");
      } else {
        ToastFactory.showError("Reingrese contraseña");
      }
    } else {
      if (password != repassword) {
        ToastFactory.showError("Las contraseñas no coinciden");
        return;
      }
      FirebaseRepository.signUp(mail, password).then((AuthResult user) {
        if (user != null) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
                return SelectUserTypePage();
          }));
        } else {
          ToastFactory.showError("Error creando usuario. Reintente luego");
        }
      });
    }
  }
}
