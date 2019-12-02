import 'dog_owner.dart';

class DogWalker extends DogOwner {
  String _dni;
  bool _walkerVerified;

  DogWalker(id, name, surname, email, address, birthday, phone, ratingAvg, verified, this._dni, this._walkerVerified) :
        super(id, name, surname, email, address, birthday, phone, ratingAvg, verified);

  String get dni => _dni;

  bool get walkerVerified => _walkerVerified;
}
