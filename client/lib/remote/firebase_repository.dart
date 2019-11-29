import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dogwalker2/models/users/address.dart';
import 'package:dogwalker2/models/users/dog_owner.dart';
import 'package:dogwalker2/models/users/dog_walker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseRepository {
  static final Firestore firestore = Firestore.instance;
  static final String COLLECTION_USERS = "Users";
  static final String COLLECTION_DOGS = "Dogs";
  static final String COLLECTION_WALKS = "Walks";

  GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<DogOwner> getCurrentUser() async {
    FirebaseUser currentUser = await _auth.currentUser();
    DogOwner user;
    if (currentUser != null) {
      var userDocument = await firestore.collection(COLLECTION_USERS).document(currentUser.uid).get();
      if (userDocument.exists) {
        Map claims = (await currentUser.getIdToken(refresh: true)).claims;
        Address address;

        if (userDocument.data["address"] != null) {
          address = new Address(
              userDocument.data["address"]["department_numer"],
              userDocument.data["address"]["description"],
              userDocument.data["address"]["number"],
              userDocument.data["address"]["location"]
          );
        }

        if (claims['walker']) {
          user = new DogWalker(
              currentUser.uid,
              userDocument.data["name"],
              userDocument.data["surname"],
              userDocument.data["email"],
              address,
              userDocument.data["birthday"],
              userDocument.data["phone"],
              userDocument.data["rating_avg"],
              claims["verified"],
              userDocument.data["dni"],
              userDocument.data["cost"],
              claims["walker_verified"]
          );
        } else {
          user = new DogOwner(
              currentUser.uid,
              userDocument.data["name"],
              userDocument.data["surname"],
              userDocument.data["email"],
              address,
              userDocument.data["birthday"],
              userDocument.data["phone"],
              userDocument.data["rating_avg"],
              claims["verified"]
          );
        }
      }
    }

    return user;
  }

  Future<AuthResult> signInGoogle() async {
    GoogleSignInAccount _signInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication _signInAuth = await _signInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: _signInAuth.accessToken,
        idToken: _signInAuth.idToken
    );
    return await _auth.signInWithCredential(credential);
  }

  Future<AuthResult> signIn(String mail, String password) async {
    return await _auth.signInWithEmailAndPassword(
        email: mail,
        password: password
    );
  }

  void logout() {
    _auth.signOut();
  }

  bool resetPassword(String mail) {
    try {
      _auth.sendPasswordResetEmail(email: mail);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<AuthResult> signUp(String mail, String password) async {
    return await _auth.createUserWithEmailAndPassword(
        email: mail,
        password: password
    );
  }

  Future<void> addDog(dogData) {
    return firestore.collection('d').add(dogData).catchError((e){
      print(e);
    });
  }
}
