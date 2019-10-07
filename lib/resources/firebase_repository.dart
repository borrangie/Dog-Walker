import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dogwalker2/resources/firebase_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseRepository{
  FirebaseMethods _firebaseMethods = FirebaseMethods();

  void logout()=> _firebaseMethods.logout();

  Future<FirebaseUser> getCurrentUser()=> _firebaseMethods.getCurrentUser();

  Future<AuthResult> signIn() => _firebaseMethods.signIn();

  Future<bool> authenticateUser(FirebaseUser user) => _firebaseMethods.authenticateUser(user);

  Future<AuthResult> normalSignIn(String mail, String password)=> _firebaseMethods.normalSignIn(mail, password);

  Future<AuthResult> normalSignUp(String mail, String password)=> _firebaseMethods.normalSignUp(mail, password);

  bool resetPassword(String mail) => _firebaseMethods.resetPassword(mail);

  getUserData() async{
    var elem =  await _firebaseMethods.getUserData();
    // print(elem);
    return elem;
  }

  String getString(){
    return "Hola que tal";
  }

  Future<void> addDog(dogData)async{
    _firebaseMethods.addDog(dogData);
  }
}