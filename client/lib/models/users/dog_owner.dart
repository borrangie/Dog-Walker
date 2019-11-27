import 'package:dogwalker2/models/db_object.dart';
import 'package:dogwalker2/models/users/address.dart';

import 'dogs/dog.dart';

class DogOwner extends DBObject {
  String _name, _surname;
  Address _address;
  DateTime _birthday;
  String _phone;
  List<Dog> _dogs;
  double _ratingAvg;

  DogOwner(id, this._name, this._surname, this._address, this._birthday, this._phone, this._dogs, this._ratingAvg) : super(id);
}
