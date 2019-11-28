import 'package:dogwalker2/models/db_object.dart';
import 'package:flutter/cupertino.dart';

import 'breeds.dart';

class Dog extends DBObject {
  String _name;
  int _years;
  int _months;
  Breed _breed;
  Image _picture;

  Dog(String id, String name, int years, int months, Breed breed) : super(id) {
    this._name = name;
    this._years = years;
    this._months = months;
    this._breed = breed;
  }

  Breed get breed => _breed;

  set breed(Breed value) {
    if (value != null)
      _breed = value;
  }

  int get months => _months;

  set months(int value) {
    if (value != null && value >= 0)
      _months = value;
  }

  int get years => _years;

  set years(int value) {
    if (value != null && value >= 0)
      _years = value;
  }

  String get name => _name;

  set name(String value) {
    if (value != null && value.isNotEmpty)
      _name = value;
  }

  Image get picture => _picture;

  set picture(Image value) {
    if (value != null)
      _picture = value;
  }
}
