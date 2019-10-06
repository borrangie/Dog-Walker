import 'package:dogwalker2/models/db_object.dart';

import 'dog.dart';

class DogOwner extends DBObject {
  String _name, _surname;
  List<String> _phones;
  List<Dog> _dogs;
  bool isActive;

  DogOwner(id, this._name, this._surname, this._phones, this._dogs, this.isActive) : super(id);

  List<Dog> get dogs => _dogs;

  List<String> get phones => _phones;

  get surname => _surname;

  String get name => _name;
}
