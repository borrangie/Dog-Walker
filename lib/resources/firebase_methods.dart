import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseMethods{


  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  static final Firestore firestore = Firestore.instance;

  Future<FirebaseUser> getCurrentUser() async{
    FirebaseUser currentUser;
    currentUser = await _auth.currentUser();
    return currentUser;
  }

  Future<AuthResult> signIn() async{
    GoogleSignInAccount _signInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication _signInAuth = await _signInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: _signInAuth.accessToken,
    idToken: _signInAuth.idToken
  );
    AuthResult user  = await _auth.signInWithCredential(credential);
    return user;
  }

  Future<bool> authenticateUser(FirebaseUser user) async{

    FirebaseUser user  = await _auth.currentUser();
    // QuerySnapshot result = await firestore.collection("users").where("email", isEqualTo: user.email).getDocuments();

    // final List<DocumentSnapshot> docs = result.documents;
    // return docs.length == 0 ? true : false;

    return user==null? false : true;
  }

  Future<AuthResult> normalSignIn(String mail, String password) async{
    AuthResult user = await _auth.signInWithEmailAndPassword(email: mail, password: password);
    print(user.user.email);
    return user;

  }

  void logout(){
    _auth.signOut();
  }


  bool resetPassword(String mail){
    try{
      _auth.sendPasswordResetEmail(email: mail);
    }catch(e){
      return false;
    }
    return true;
  }


  Future<AuthResult> normalSignUp(String mail, String password) async{
    AuthResult user = await _auth.createUserWithEmailAndPassword(email: mail, password: password);
    print(user.user.email);
    return user;
  }


  getUserData() async {
    FirebaseUser user = await getCurrentUser();
    return await firestore.collection('u').document(user.uid.toString()).get().then((res){
      return res.data;
    });
  }


Future<void> addDog(dogData){
    firestore.collection('d').add(dogData).catchError((e){
      print(e);
    });
  }


    
  }
  // Future<void> addDataToDB(FirebaseUser user) async{
    
  // }

  