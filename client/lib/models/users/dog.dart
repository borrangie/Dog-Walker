import 'package:dogwalker2/models/db_object.dart';

class Dog extends DBObject {
  String name;
  String breed;
  double weight;
  double height;
  String info;
  DateTime birthday;
  int genre;
  bool castrado;

  Dog(String id, this.name, this.breed, this.weight, this.height, this.info, this.birthday, this.genre, this.castrado) : super(id);
}
