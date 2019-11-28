import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dogwalker2/models/db_object.dart';
import 'package:dogwalker2/models/users/dog_walker.dart';

class Walk extends DBObject {
  double _cost, _radiusMeters;
  int _maxDogs;
  Timestamp _enddate, _startdate;
  int _minutes;
  List<GeoPoint> _locations;
  DogWalker _walker;
  Map _dogs;

  Walk(String id, this._cost, this._radiusMeters, this._maxDogs, this._enddate,
      this._startdate, this._minutes, this._locations, this._walker,
      this._dogs):
        super(id);

  Map get dogs => _dogs;

  DogWalker get walker => _walker;

  List<GeoPoint> get locations => _locations;

  int get minutes => _minutes;

  get startdate => _startdate;

  Timestamp get enddate => _enddate;

  int get maxDogs => _maxDogs;

  get radiusMeters => _radiusMeters;

  double get cost => _cost;
}
