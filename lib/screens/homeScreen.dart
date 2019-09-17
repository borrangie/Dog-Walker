import 'package:dogwalker2/resources/firebase_repository.dart';
import 'package:dogwalker2/screens/loginScreen.dart';
import 'package:dogwalker2/screens/loginScreen2.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 80.0, bottom: 80.0),
                    child: Text(
                      "Home Screen",
                      style: TextStyle(fontSize: 40.0),
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
                      child: GestureDetector(
                        onTap: () {
                          logout();
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return LoginPage2();
                          }));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 60.0,
                          width: 70.0,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Text(
                            "Log Out",
                            style:
                                TextStyle(fontSize: 25.0, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

logout() {
  print("Me voy");
  FirebaseRepository _firebaseRepository = FirebaseRepository();
  _firebaseRepository.logout();
}
