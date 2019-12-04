import 'package:dogwalker2/remote/firebase_repository.dart';
import 'package:dogwalker2/screens/authentication/finish_sign_up_dog_owner.dart';
import 'package:dogwalker2/screens/authentication/finish_sign_up_dog_walker.dart';
import 'package:dogwalker2/screens/components/app_bar_factory.dart';
import 'package:dogwalker2/screens/components/button_factory.dart';
import 'package:dogwalker2/screens/components/logo_text_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SelectUserTypePage extends StatefulWidget {
  @override
  _SelectUserTypePageState createState() => _SelectUserTypePageState();
}

class _SelectUserTypePageState extends State<SelectUserTypePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
        appBar: AppBarFactory.generateBack(context, "Tipo de Cuenta"),
        body: SingleChildScrollView(
            reverse: true,
            child: Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  children: <Widget>[
                    LogoTextFactory.generate(context, "Tipo de", "Cuenta"),
                    Container(
                      padding: EdgeInsets.only(top: 55, left: 20, right: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          ButtonFactory.generateBig("Tengo perros", () => _setAccountType(FirebaseRepository.typeDogOwner)),
                          SizedBox(
                            height: 30,
                          ),
                          ButtonFactory.generateBig("Quiero pasear perros", () => _setAccountType(FirebaseRepository.typeDogWalker))
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

  void _setAccountType(userType) async {
    Widget widget;
    if (userType == FirebaseRepository.typeDogWalker) {
      widget = FinishSignUpDogWalkerPage();
    } else {
      widget = FinishSignUpDogOwnerPage();
    }

    Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return widget;
        }
    ));
  }
}
