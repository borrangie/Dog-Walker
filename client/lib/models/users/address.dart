import 'package:cloud_firestore/cloud_firestore.dart';

class Address {
  String _department, _description;
  int _number;
  GeoPoint _location;

  Address(this._department, this._description, this._number, this._location);

  GeoPoint get location => _location;

  int get number => _number;

  get description => _description;

  String get department => _department;
}
