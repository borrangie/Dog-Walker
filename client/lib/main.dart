import 'package:dogwalker2/models/users/dog_owner.dart';
import 'package:dogwalker2/models/users/dog_walker.dart';
import 'package:dogwalker2/remote/firebase_repository.dart';
import 'package:dogwalker2/resources/store.dart';
import 'package:dogwalker2/screens/authentication/finish_sign_up_dog_owner.dart';
import 'package:dogwalker2/screens/authentication/finish_sign_up_dog_walker.dart';
import 'package:dogwalker2/screens/authentication/login_screen.dart';
import 'package:dogwalker2/screens/authentication/select_user_type.dart';
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
      theme: ThemeData(
        primaryColor: Colors.red,
        accentColor: Colors.white,
        primaryTextTheme: TextTheme(
          title: TextStyle(
            color: Colors.black
          )
        )
      ),
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
  @override
  Widget build(BuildContext context) {
    FirebaseRepository.getCurrentUser().then((user) {
      List<Widget> widgets = [];
      Store.instance.user = user;

      if (user != null) {
        if (user is DogWalker) {
          if (!user.walkerVerified) {
            widgets.add(LogInPage());
            widgets.add(SelectUserTypePage());
            widgets.add(FinishSignUpDogWalkerPage());
          } else {
            widgets.add(HomeScreenPage());
          }
        } else if (user is DogOwner) {
          if (!user.verified) {
            widgets.add(LogInPage());
            widgets.add(SelectUserTypePage());
            widgets.add(FinishSignUpDogOwnerPage());
          } else {
            widgets.add(HomeScreenPage());
          }
        } else {
          widgets.add(LogInPage());
          widgets.add(SelectUserTypePage());
        }
      } else {
        widgets.add(LogInPage());
      }

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) {
            return widgets[0];
          })
      );
      for (var i = 1; i < widgets.length; i++) {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return widgets[i];
            })
        );
      }
    }).catchError((error) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) {
            return LogInPage();
          })
      );
    });

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
