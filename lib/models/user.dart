import 'package:dogwalker2/models/db_object.dart';

class User extends DBObject {
  String _name, _surname;
  DateTime _birthday;
  List<String> _phones;

}
