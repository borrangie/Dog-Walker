import 'dog_owner.dart';

class DogWalker extends DogOwner {
  String _dni;
  double _cost;
  bool _walkerVerified;

  DogWalker(id, name, surname, address, birthday, phone, ratingAvg, verified, this._dni, this._cost, this._walkerVerified) :
        super(id, name, surname, address, birthday, phone, ratingAvg, verified);

  String get dni => _dni;

  double get cost => _cost;

  set cost(double value) {
    if (value >= 0)
      _cost = value;
  }

  bool get walkerVerified => _walkerVerified;
}
