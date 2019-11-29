import 'package:dogwalker2/models/users/dog_walker.dart';
import 'package:dogwalker2/remote/firebase_repository.dart';
import 'package:dogwalker2/screens/authentication/finish_sign_up_dog_owner.dart';
import 'package:dogwalker2/screens/authentication/finish_sign_up_dog_walker.dart';
import 'package:dogwalker2/screens/authentication/login_screen.dart';
import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() => runApp(AppWrapper());

class AppWrapper extends StatefulWidget {
  // Root App
  @override
  _AppWrapperState createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.red, accentColor: Colors.white),
      title: 'Dog Walker',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // TODO: Manage offline
  void initState() {
    super.initState();
    FirebaseRepository.getCurrentUser().then((user) {
      Widget widget;

      if (user != null) {
        if (user is DogWalker) {
          if (!user.walkerVerified) {
            widget = FinishSignUpDogWalkerPage();
          }
        } else {
          if (!user.verified)
            widget = FinishSignUpDogOwnerPage();
        }
        widget = HomeScreenPage();
      } else {
        widget = LogInPage();
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return widget;
        })
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.red,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 130,
                        child: Image.asset(
                          'assets/images/dwlogo.png',
                          width: 130,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        'Cargando...',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
