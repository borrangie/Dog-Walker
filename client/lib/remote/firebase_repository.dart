import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:dogwalker2/models/users/dog_owner.dart';
import 'package:dogwalker2/models/users/dog_walker.dart';
import 'package:dogwalker2/models/users/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class FirebaseRepository {
  static final CloudFunctions _cloudFunctions = CloudFunctions.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final Firestore _firestore = Firestore.instance;

  static final String collectionUsers = "Users";
  static final String collectionsDogs = "Dogs";
  static final String collectionWalks = "Walks";
  static final int typeDogOwner = 0;
  static final int typeDogWalker = 1;

  static Future<User> getCurrentUser() async {
    FirebaseUser currentUser = await _auth.currentUser();
    User user;

    if (currentUser != null) {
      var userDocument = await _firestore.collection(collectionUsers).document(currentUser.uid).get();
      if (userDocument.exists) {
        Map claims = (await currentUser.getIdToken(refresh: true)).claims;

        var rawRating = userDocument.data["rating_avg"];
        double rating = rawRating is int ? rawRating.toDouble() : (rawRating as double);
        if (claims['walker']) {
          user = new DogWalker(
              currentUser.uid,
              userDocument.data["name"],
              userDocument.data["surname"],
              userDocument.data["email"],
              userDocument.data["phone"],
              rating,
              claims["verified"],
              userDocument.data["birthday"],
              userDocument.data["dni"],
              claims["walker_verified"]
          );
        } else if (claims['owner']) {
          user = new DogOwner(
              currentUser.uid,
              userDocument.data["name"],
              userDocument.data["surname"],
              userDocument.data["email"],
              userDocument.data["phone"],
              rating,
              claims["verified"]
          );
        } else {
          user = new User(currentUser.uid);
        }
      }
    }

    return user;
  }

  static Future<AuthResult> signUp(String mail, String password) async {
    return await _auth.createUserWithEmailAndPassword(
        email: mail,
        password: password
    );
  }

  static Future<AuthResult> signInGoogle() async {
    GoogleSignInAccount _signInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication _signInAuth = await _signInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: _signInAuth.accessToken,
        idToken: _signInAuth.idToken
    );
    return await _auth.signInWithCredential(credential);
  }

  static Future<AuthResult> signIn(String mail, String password) async {
    return await _auth.signInWithEmailAndPassword(
        email: mail,
        password: password
    );
  }

  static bool resetPassword(String mail) {
    try {
      _auth.sendPasswordResetEmail(email: mail);
      return true;
    } catch (e) {
      return false;
    }
  }

  static void logout() {
    _auth.signOut();
  }

  static Future<bool> setUpAccount(int type, Map rawData) async {
    if (type != typeDogOwner && type != typeDogWalker)
      return false;

    Map data = {
      "name": rawData["name"],
      "surname": rawData["surname"],
      "phone": rawData["phone"],
    };
    if (type == typeDogWalker) {
      data["dni"] = rawData["dni"];
      data["birthday"] = rawData["birthday"];
    }

    return _parseOutput(await _cloudFunctions.getHttpsCallable(functionName: "setUpAccount").call({
      "type": type,
      "data": data
    }), "result");
  }

  static Future<bool> setAccountType(int type) async {
    if (type != typeDogOwner && type != typeDogWalker)
      return false;


    return _parseOutput(await _cloudFunctions.getHttpsCallable(functionName: "setAccountType").call({
      "type": type,
    }), "result");
  }

  static Future<void> addDog(dogData) {
    return _firestore.collection('d').add(dogData).catchError((e){
      print(e);
    });
  }

  static bool _parseOutput(HttpsCallableResult result, String key) {
    print(result.data);
    if (result == null || result.data == null || result.data["error"]) {
      return false;
    }
    return result.data["data"][key];
  }
}
