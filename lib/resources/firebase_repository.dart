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

  getUserInfo() async{
    return  await _firebaseMethods.getUserInfo();
  }
}