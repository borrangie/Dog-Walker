import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dogwalker2/screens/components/address_component_factory.dart';
import 'package:dogwalker2/screens/components/app_bar_factory.dart';
import 'package:dogwalker2/screens/components/button_factory.dart';
import 'package:dogwalker2/screens/components/text_field_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FinishSignUpDogOwnerPage extends StatefulWidget {
  @override
  _FinishSignUpDogOwnerPageState createState() => _FinishSignUpDogOwnerPageState();
}

class _FinishSignUpDogOwnerPageState extends State<FinishSignUpDogOwnerPage> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController surnameController = new TextEditingController();

  TextEditingController addressDepartmentController = new TextEditingController();
  TextEditingController addressDescriptionController = new TextEditingController();
  TextEditingController addressNumberController = new TextEditingController();
  GeoPoint addressLocation;

  DateTime birthday;
  TextEditingController phoneController = new TextEditingController();
//  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBarFactory.generate(context, "Tengo perros"),
        body: SingleChildScrollView(
            reverse: true,
            child: Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 55, left: 20, right: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          TextFieldFactory.generate(nameController, "Nombre(s)"),
                          SizedBox(
                            height: 10,
                          ),
                          TextFieldFactory.generatePassword(surnameController, "Apellido(s)"),
                          SizedBox(
                            height: 10,
                          ),
                          AddressFactory.generateAddressContainer(context, nameController, surnameController, nameController, "S"),
                          SizedBox(
                            height: 50,
                          ),
                          ButtonFactory.generate("CONTINUAR", normalSignUp),
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
//    String mail = mailController.text;
//    String password = passwordController.text;
//    String repassword = repasswordController.text;
//
//    if (mail.isEmpty || password.isEmpty || repassword.isEmpty) {
//      if (mail.isEmpty && password.isEmpty) {
//        showToast("Ingrese mail y contraseña");
//      } else if (mail.isEmpty) {
//        showToast("Ingrese el mail");
//      } else if (password.isEmpty) {
//        showToast("Ingrese contraseña");
//      } else {
//        showToast("Reingrese contraseña");
//      }
//    } else {
//      if (password != repassword) {
//        showToast("Las contraseñas no coinciden");
//        return;
//      }
//      FirebaseRepository.signUp(mail, password).then((AuthResult user) {
//        if (user != null) {
//          Navigator.pushReplacement(context,
//              MaterialPageRoute(builder: (context) {
//                return SelectUserTypePage();
//          }));
//        } else {
//          showToast("Error creando usuario. Reintente luego");
//        }
//      });
//    }
  }
}
