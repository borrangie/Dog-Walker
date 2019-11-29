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

  Future<AuthResult> signIn() async {
    GoogleSignInAccount _signInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication _signInAuth = await _signInAccount
        .authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: _signInAuth.accessToken,
        idToken: _signInAuth.idToken
    );
    AuthResult user = await _auth.signInWithCredential(credential);
    return user;
  }

  Future<bool> authenticateUser(FirebaseUser user) async {
    FirebaseUser user = await _auth.currentUser();
    // QuerySnapshot result = await firestore.collection("users").where("email", isEqualTo: user.email).getDocuments();

    // final List<DocumentSnapshot> docs = result.documents;
    // return docs.length == 0 ? true : false;

    return user == null ? false : true;
  }

  Future<AuthResult> normalSignIn(String mail, String password) async {
    AuthResult user = await _auth.signInWithEmailAndPassword(
        email: mail, password: password);
    return user;
  }

  void logout() {
    _auth.signOut();
  }

  bool resetPassword(String mail) {
    try {
      _auth.sendPasswordResetEmail(email: mail);
    } catch (e) {
      return false;
    }
    return true;
  }

  Future<AuthResult> normalSignUp(String mail, String password) async {
    AuthResult user = await _auth.createUserWithEmailAndPassword(
        email: mail, password: password);
    return user;
  }

  Future<void> addDog(dogData) {
    return firestore.collection('d').add(dogData).catchError((e){
      print(e);
    });
  }
}
