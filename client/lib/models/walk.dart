import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dogwalker2/models/db_object.dart';
import 'package:dogwalker2/models/users/dog.dart';
import 'package:dogwalker2/models/users/dog_walker.dart';

class Walk extends DBObject {
  String _address;
  double _cost;
  DateTime _day;
  int _maxDogs;
  int _hours;
  DogWalker _dogWalker;
  int _dogsQuantity;

  Walk(String id, this._address, this._cost, this._day, this._maxDogs, this._hours, this._dogWalker, this._dogsQuantity): super(id);

  int get hours => _hours;

  int get maxDogs => _maxDogs;

  int get dogsQuantity => _dogsQuantity;

  DateTime get day => _day;

  String get dayOfWeek {
    switch (_day.weekday) {
      case DateTime.monday: return "Lunes";
      case DateTime.tuesday: return "Martes";
      case DateTime.wednesday: return "Miercoles";
      case DateTime.thursday: return "Jueves";
      case DateTime.friday: return "Viernes";
      case DateTime.saturday: return "Sabado";
      case DateTime.sunday: return "Domingo";
      default: return "";
    }
  }

  double get cost => _cost;

  String get address => _address;

  DogWalker get dogWalker => _dogWalker;
}
