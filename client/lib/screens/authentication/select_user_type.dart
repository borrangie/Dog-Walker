import 'package:dogwalker2/remote/firebase_repository.dart';
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
        appBar: AppBarFactory.generate(context, "Tipo de Cuenta"),
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
                          ButtonFactory.generateBig("Tengo perros", () => FirebaseRepository.setAccountType(FirebaseRepository.typeDogOwner)),
                          SizedBox(
                            height: 30,
                          ),
                          ButtonFactory.generateBig("Quiero pasear perros", () => FirebaseRepository.setAccountType(FirebaseRepository.typeDogWalker))
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
}
