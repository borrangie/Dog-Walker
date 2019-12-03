import 'package:dogwalker2/models/users/user.dart';
import 'package:dogwalker2/remote/firebase_repository.dart';

import 'dog.dart';

class DogOwner extends User {
  String _name;
  String _surname;
  String _email;
  String _phone;
  String _photoUrl;
  double _ratingAvg;
  bool _verified;
  List<Dog> _dogs;

  DogOwner(id, this._name, this._surname, this._email, this._phone, this._ratingAvg, this._verified) : super(id) {
    _photoUrl = FirebaseRepository.generateProfilePictureUrl(id);
  }

  bool get verified => _verified;

  double get ratingAvg => _ratingAvg;

  List<Dog> get dogs => _dogs;

  String get photoUrl => _photoUrl;

  addDog(Dog dog) {
    if (_dogs == null)
      _dogs = [];
    _dogs.add(dog);
  }

  addDogs(Iterable<Dog> dogs) {
    if (_dogs == null)
      _dogs = [];
    _dogs.addAll(dogs);
  }

  String get phone => _phone;

  String get surname => _surname;

  String get name => _name;

  String get email => _email;
}
