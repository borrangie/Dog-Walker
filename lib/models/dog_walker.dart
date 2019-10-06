import 'dog_owner.dart';
import 'dog.dart';

class DogWalker extends DogOwner {
  String _dni;
  double _cost;

  DogWalker(id, name, surname, phones, dogs, isActive, this._dni, this._cost) :
        super(id, name, surname, phones, dogs, isActive);

  String get dni => _dni;

  double get cost => _cost;

  set cost(double value) {
    if (value >= 0)
      _cost = value;
  }
}
