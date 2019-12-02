import 'dog_owner.dart';

class DogWalker extends DogOwner {
  String _dni;
  DateTime _birthday;
  bool _walkerVerified;

  DogWalker(id, name, surname, email, phone, ratingAvg, verified, this._birthday, this._dni, this._walkerVerified) :
        super(id, name, surname, email, phone, ratingAvg, verified);

  String get dni => _dni;

  bool get walkerVerified => _walkerVerified;

  DateTime get birthday => _birthday;
}
