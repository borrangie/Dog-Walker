import 'package:dogwalker2/models/dog_owner.dart';
import 'package:dogwalker2/models/dog_walker.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Store {
  static Store _instance = Store._();
  Map<String, dynamic> elements;

  Store._();

  Store get instance => _instance;

  FirebaseUser get firebaseUser => this.elements["firebase_user"];

  set firebaseUser(FirebaseUser firebaseUser) => this.elements["firebase_user"] = firebaseUser;

  DogOwner get asDogOwner {
    if (this.elements["user"] is DogOwner)
      return this.elements["user"];
    else
      return null;
  }

  DogWalker get asDogWalker {
    if (this.elements["user"] is DogOwner)
      return this.elements["user"];
    else
      return null;
  }

  set dogOwner(DogOwner dogOwner) => this.elements["user"] = dogOwner;
}
